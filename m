Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDB4D5764
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbiCKBeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbiCKBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:34:14 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432CF4071
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:33:10 -0800 (PST)
Date:   Fri, 11 Mar 2022 01:32:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646962388;
        bh=or5Z9XQTnZe/TfwjOEmbt6cnCyypwWzc2e6b6BZ37x4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=rfemLG9F0YBb9Vah2je7PZjNX/3vX3mCsL9oEFA6YCNZd8O3A1p/I/y4jP1UGVmNr
         vzX/zUlxu+gJqzSxAB21SXEB+SjkXFrETGwegaVuSsCM3DeRYM6swGaLyswKZfffpq
         ulVOCbLV6PPd1tdA4wctQXU1iXw7h5SaIl04rKS+OrqA3qQCdkxvBtJPya3qz6ImkY
         i/sihzagyo/xC2K/574FRz+VIEjbTuxagfKjUZaEC8IdBCBgdYpOB0xdS1oHbysvkk
         wHpLUUU2rNFg7pHMw6U1I2jXG8ifOxh3T3QbuzritLrhLE+T9PNgYapgnB9j3NsUDE
         yg2kw1F8ODFXQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
Message-ID: <20220311013238.3387227-2-pobrn@protonmail.com>
In-Reply-To: <20220311013238.3387227-1-pobrn@protonmail.com>
References: <20220311013238.3387227-1-pobrn@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this patch is to add a type-safer, lightweight
wrapper around the currently available `list_head` facilities
existing in the kernel. It is named "tlist", which may or
may not stand for "typed list".

The type-safe(r)ty is achieved by storing compile-time metadata
in the list head:

  * the type of the objects ("value type"), and
  * the offset of the `list_head` member ("member offset")

These only appear at compile-time, and do not affect the actual
generated executable code. (They might show up in debug info, etc.)

The underlying idea is to define each list head using an anonymous struct:

  #define TLIST(T, member)
  struct {
    struct list_head head;
    char _member_offset[0][offsetof(T, member) +
                           BUILD_BUG_ON_ZERO(!__same_type(struct list_head,
                                                          typeof_member(T, =
member)))];
    T _type[0];
  }

Arguably, this is an abuse of multiple features of GNU C. However,
it is nothing new. The currently existing `__STRUCT_KFIFO_COMMON()` macro
uses the same underlying idea to store type and size information
in the type, like a C++ template.

Note, that the `member` in `T` must be a `struct list_head` object,
it is not possible to specify a non-list-head member by accident.

Let us assume we have a tlist:

  struct wmi_block {
    struct wmi_device dev;
    struct list_head list;
    ...
  };

  TLIST(struct wmi_block, list) wmi_block_list =3D ...;

Note, that the items in the list still only embed a `list_head`
object. Only the head of the list has a different type.

In this scenario, the value type can be retrieved using:

  typeof(*wmi_block_list._type)

and the member offset:

  sizeof(*wmi_block_list._member_offset)

Looking at the `__STRUCT_KFIFO_COMMON()` one might ask:
why aren't pointers used? Why zero-length arrays?
The answer is const-correctness - that is, a const tlist
can only be iterated with a `const value_type *` -, which
I believe is nice to have.

With the previous type and offset primitives, it is easy to
implement a type-safe insertion macro:

  #define __tlist_ptroff(base, offset, T)
          ((T *) (((uintptr_t)(base)) + (offset)))

  #define tlist_item_to_node(list, item)
          (__tlist_ptroff((item), tlist_member_offset(list), struct list_he=
ad) +
           BUILD_BUG_ON_ZERO(!__same_type(*(item), tlist_value_type(list)))=
)

  #define tlist_push_back(list, item)
          list_add_tail(tlist_head(list), tlist_item_to_node((list), (item)=
))

Note, `tlist_head()` is a macro which simply expands to the underlying
`list_head`.

The real type checking is done inside the `tlist_item_to_node()` macro
which does two things:

  * get a pointer to the embedded `list_head` object using the
    known member offset, and
  * check if `item` matches the value type of the tlist

Note, that the existing `list_head` facilities can still be used
since the head of a tlist can be easily retrieved and the list items
only include a `list_head` object.

All in all, for insertion, a tlist completely elliminates the
possibility of inserting an object with the wrong type or
wrong `list_head` member. (Of course, assuming the appropriate
wrappers are used.)

Iteration is also possible in a very convenient manner:

  #define tlist_node_to_item(list, node)
          __tlist_ptroff((node), -tlist_member_offset(list), tlist_value_ty=
pe(list))

  #define tlist_begin(list)
          tlist_node_to_item((list), tlist_head(list)->next)

  #define tlist_end(list)
          tlist_node_to_item((list), tlist_head(list))

  #define tlist_item_next(list, item) \
          tlist_node_to_item((list), tlist_item_to_node((list), (item))->ne=
xt)

  #define tlist_for_each(list, iter)
          for (tlist_value_type(list) *iter =3D tlist_begin(list);
               iter !=3D tlist_end(list);
               iter =3D tlist_item_next(list, iter))

  ...

  tlist_for_each(&wmi_block_list, wblock) {
    if (guid_equal(&wblock->gblock.guid, &guid_input)) {
      if (out)
        *out =3D wblock;
      return AE_OK;
    }
  }

Note, the iterator is defined in the scope of the for loop,
reuse after the loop is not possible by accident. Also note,
that neither the type, nor the name of the correct `list_head` member
need to be known (or specified) when iterating over a tlist.

The "safe" iterations are also easily implementable (see this patch)
without even needing to explicitly name/create the secondary iterator.
Reverse iteration is naturally also implementable.

Removal from a tlist is possible using the already existing
`list_del()`, etc. facilities, or there is the newly added

  #define tlist_remove(list, item)
          list_del(tlist_item_to_node((list), (item)))

This macro also does type-checking and selects the correct
`list_head` member based on the known offset.

There are, however, certain limitations of the tlist wrapper.
The biggest of which is that they cannot easily be
passed from/to functions since every tlist has a distinct
type from every other type because they are anonymous structs.
Furthermore, when declaring a tlist, the value type must be
complete, otherwise e.g. the `offsetof()` would not work.
Thus it is not possible to have a list of nodes which has
no "separate" head.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 include/linux/tlist.h | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 include/linux/tlist.h

diff --git a/include/linux/tlist.h b/include/linux/tlist.h
new file mode 100644
index 000000000000..ad68de9d74fa
--- /dev/null
+++ b/include/linux/tlist.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TLIST_H
+#define _LINUX_TLIST_H
+
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/container_of.h>
+#include <linux/list.h>
+
+#define TLIST(T, member) \
+struct { \
+=09struct list_head head; \
+=09char _member_offset[0][offsetof(T, member) + \
+=09=09=09       BUILD_BUG_ON_ZERO(!__same_type(struct list_head, \
+=09=09=09=09=09=09=09      typeof_member(T, member)))]; \
+=09T _type[0]; \
+}
+
+#define TLIST_DEFINE(T, member, name) \
+=09TLIST(T, member) name =3D { LIST_HEAD_INIT((name).head) }
+
+#define tlist_value_type(list) \
+=09typeof(*(list)->_type)
+
+#define tlist_member_offset(list) \
+=09sizeof(*(list)->_member_offset)
+
+#define tlist_head(list) \
+=09(&(list)->head)
+
+#define tlist_init(list) \
+=09INIT_LIST_HEAD(tlist_head(list))
+
+#define tlist_is_empty(list) \
+=09list_empty(tlist_head(list))
+
+#define __tlist_ptroff(base, offset, T) \
+=09((T *) (((uintptr_t)(base)) + (offset)))
+
+#define tlist_item_to_node(list, item) \
+=09(__tlist_ptroff((item), tlist_member_offset(list), struct list_head) + =
\
+=09 BUILD_BUG_ON_ZERO(!__same_type(*(item), tlist_value_type(list))))
+
+#define tlist_node_to_item(list, node) \
+=09__tlist_ptroff((node), -tlist_member_offset(list), tlist_value_type(lis=
t))
+
+#define tlist_begin(list) \
+=09tlist_node_to_item((list), tlist_head(list)->next)
+
+#define tlist_end(list) \
+=09tlist_node_to_item((list), tlist_head(list))
+
+#define tlist_remove(list, item) \
+=09list_del(tlist_item_to_node((list), (item)))
+
+#define tlist_push_back(list, item) \
+=09list_add_tail(tlist_head(list), tlist_item_to_node((list), (item)))
+
+#define tlist_item_next(list, item) \
+=09tlist_node_to_item((list), tlist_item_to_node((list), (item))->next)
+
+#define tlist_for_each(list, iter) \
+=09for (tlist_value_type(list) *iter =3D tlist_begin(list); \
+=09     iter !=3D tlist_end(list); \
+=09     iter =3D tlist_item_next(list, iter))
+
+#define __tlist_for_each_safe(list, iter, next_iter) \
+=09for (tlist_value_type(list) *iter =3D tlist_begin(list), *next_iter; \
+=09     iter !=3D tlist_end(list) && (next_iter =3D tlist_item_next(list, =
iter), 1); \
+=09     iter =3D next_iter)
+
+#define tlist_for_each_safe(list, iter) \
+=09__tlist_for_each_safe((list), iter, __UNIQUE_ID(tlist_next_))
+
+#endif /* _LINUX_TLIST_H */
--
2.35.1


