Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A14C36EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiBXUcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiBXUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69B837C171
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645734723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2ubHgPrmh8MR1n+1PbtlqSxV6eATITrLbT20lAtpdI=;
        b=LR4ByN1DvdHjS6zRrDCufNu189MvxNNZgmYNNPYCzIBpHzuRC1uXv3ZqO4ItcW/dLxjSbz
        LA9Zme4bjMrdEVh5P5JLP8cl6CwNZSasM3mXlhsqNoOsqGopqz8Z+7rWfE5V0564+t2dtB
        9z+JG2z689l5TdrHR+SiFbaXAWCXLTE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-bvChBSdvMRKwG79ctYkeQQ-1; Thu, 24 Feb 2022 15:32:02 -0500
X-MC-Unique: bvChBSdvMRKwG79ctYkeQQ-1
Received: by mail-qk1-f198.google.com with SMTP id c19-20020a05620a11b300b00648cdeae21aso3776828qkk.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=U2ubHgPrmh8MR1n+1PbtlqSxV6eATITrLbT20lAtpdI=;
        b=OCEc8aXQ6NNRvPOetEWQ2/N7o73DglaIbNgjePRLcP5Gg/uxWdSfPv+o+B857HY1ey
         ddzsQsrO6a9ZG5XPQ5/Cy52riTyKvwMudtwj9KD8yUiT3yGsPiz4R9ZnQ6Y3n67CVwD9
         Wf2NKz3iVUtsFDX1AC0fF23LC4LkD4n9S0iedaYoPvR76skMINpS7QiE1FEWe1DwWRGt
         C23KUDf4vESEltWrF1aJTA5pA2T0b/d+FnBnbNb96iG1xuUEvovnNcK6C/OP9e6073xk
         UzOoI4dN7uyhVcpZw70X0JkZ0rS3EXep+zW/opIN92zPTVt4vNYp4Zz792odZ2Iz0z//
         jqWQ==
X-Gm-Message-State: AOAM533tVWL5fCTpaQSeFz71BrrQO1eNsT/gBZLoHKLZKvBoT4uZFPq7
        sJn1ckdFjKGpaCcsaoRoXpiw0k+vluTTzCwSiglVBujSdNKL+De8OhSJYA0bWYjHi6af9mbqFjs
        3D5Sp6QM7yjBDcf2KvEp9h0X+
X-Received: by 2002:a37:b8c4:0:b0:648:acd1:892a with SMTP id i187-20020a37b8c4000000b00648acd1892amr2863740qkf.743.1645734721579;
        Thu, 24 Feb 2022 12:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBZAAiWwgM9xRBDJPR9c9MObQMOWmvfnas6Nn+RnXCCubFUHt2i1WczB05RyF7vM4SdkJcOg==
X-Received: by 2002:a37:b8c4:0:b0:648:acd1:892a with SMTP id i187-20020a37b8c4000000b00648acd1892amr2863709qkf.743.1645734721127;
        Thu, 24 Feb 2022 12:32:01 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id c11-20020a05622a024b00b002ddb43850fdsm242436qtx.15.2022.02.24.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:32:00 -0800 (PST)
Message-ID: <7243c037f5e74fda5060f7b96d46eca547745134.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Remove the unused header file nvif/list.h
From:   Lyude Paul <lyude@redhat.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Thu, 24 Feb 2022 15:31:59 -0500
In-Reply-To: <20220223021808.GA8457@chq-T47>
References: <20220209065322.43938-1-cai.huoqing@linux.dev>
         <20220223021808.GA8457@chq-T47>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the ping!

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push this to drm-misc-next in a bit

On Wed, 2022-02-23 at 10:18 +0800, Cai Huoqing wrote:
> On 09 2月 22 14:53:19, Cai Huoqing wrote:
> > The nouveau driver depends on include/linux/list.h instead of
> > nvif/list.h, so remove the obstacle-nvif/list.h.
> > 
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> Ping :)
> >  drivers/gpu/drm/nouveau/include/nvif/list.h | 353 --------------------
> >  1 file changed, 353 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/nouveau/include/nvif/list.h
> > 
> > diff --git a/drivers/gpu/drm/nouveau/include/nvif/list.h
> > b/drivers/gpu/drm/nouveau/include/nvif/list.h
> > deleted file mode 100644
> > index 8af5d144ecb0..000000000000
> > --- a/drivers/gpu/drm/nouveau/include/nvif/list.h
> > +++ /dev/null
> > @@ -1,353 +0,0 @@
> > -/*
> > - * Copyright © 2010 Intel Corporation
> > - * Copyright © 2010 Francisco Jerez <currojerez@riseup.net>
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaining
> > a
> > - * copy of this software and associated documentation files (the
> > "Software"),
> > - * to deal in the Software without restriction, including without
> > limitation
> > - * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice (including the
> > next
> > - * paragraph) shall be included in all copies or substantial portions of
> > the
> > - * Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > SHALL
> > - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > OTHER
> > - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > ARISING
> > - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > DEALINGS
> > - * IN THE SOFTWARE.
> > - *
> > - */
> > -
> > -/* Modified by Ben Skeggs <bskeggs@redhat.com> to match kernel list APIs
> > */
> > -
> > -#ifndef _XORG_LIST_H_
> > -#define _XORG_LIST_H_
> > -
> > -/**
> > - * @file Classic doubly-link circular list implementation.
> > - * For real usage examples of the linked list, see the file test/list.c
> > - *
> > - * Example:
> > - * We need to keep a list of struct foo in the parent struct bar, i.e.
> > what
> > - * we want is something like this.
> > - *
> > - *     struct bar {
> > - *          ...
> > - *          struct foo *list_of_foos; -----> struct foo {}, struct foo
> > {}, struct foo{}
> > - *          ...
> > - *     }
> > - *
> > - * We need one list head in bar and a list element in all list_of_foos
> > (both are of
> > - * data type 'struct list_head').
> > - *
> > - *     struct bar {
> > - *          ...
> > - *          struct list_head list_of_foos;
> > - *          ...
> > - *     }
> > - *
> > - *     struct foo {
> > - *          ...
> > - *          struct list_head entry;
> > - *          ...
> > - *     }
> > - *
> > - * Now we initialize the list head:
> > - *
> > - *     struct bar bar;
> > - *     ...
> > - *     INIT_LIST_HEAD(&bar.list_of_foos);
> > - *
> > - * Then we create the first element and add it to this list:
> > - *
> > - *     struct foo *foo = malloc(...);
> > - *     ....
> > - *     list_add(&foo->entry, &bar.list_of_foos);
> > - *
> > - * Repeat the above for each element you want to add to the list.
> > Deleting
> > - * works with the element itself.
> > - *      list_del(&foo->entry);
> > - *      free(foo);
> > - *
> > - * Note: calling list_del(&bar.list_of_foos) will set bar.list_of_foos to
> > an empty
> > - * list again.
> > - *
> > - * Looping through the list requires a 'struct foo' as iterator and the
> > - * name of the field the subnodes use.
> > - *
> > - * struct foo *iterator;
> > - * list_for_each_entry(iterator, &bar.list_of_foos, entry) {
> > - *      if (iterator->something == ...)
> > - *             ...
> > - * }
> > - *
> > - * Note: You must not call list_del() on the iterator if you continue the
> > - * loop. You need to run the safe for-each loop instead:
> > - *
> > - * struct foo *iterator, *next;
> > - * list_for_each_entry_safe(iterator, next, &bar.list_of_foos, entry) {
> > - *      if (...)
> > - *              list_del(&iterator->entry);
> > - * }
> > - *
> > - */
> > -
> > -/**
> > - * The linkage struct for list nodes. This struct must be part of your
> > - * to-be-linked struct. struct list_head is required for both the head of
> > the
> > - * list and for each list node.
> > - *
> > - * Position and name of the struct list_head field is irrelevant.
> > - * There are no requirements that elements of a list are of the same
> > type.
> > - * There are no requirements for a list head, any struct list_head can be
> > a list
> > - * head.
> > - */
> > -struct list_head {
> > -    struct list_head *next, *prev;
> > -};
> > -
> > -/**
> > - * Initialize the list as an empty list.
> > - *
> > - * Example:
> > - * INIT_LIST_HEAD(&bar->list_of_foos);
> > - *
> > - * @param The list to initialized.
> > - */
> > -#define LIST_HEAD_INIT(name) { &(name), &(name) }
> > -
> > -#define LIST_HEAD(name) \
> > -       struct list_head name = LIST_HEAD_INIT(name)
> > -
> > -static inline void
> > -INIT_LIST_HEAD(struct list_head *list)
> > -{
> > -    list->next = list->prev = list;
> > -}
> > -
> > -static inline void
> > -__list_add(struct list_head *entry,
> > -                struct list_head *prev, struct list_head *next)
> > -{
> > -    next->prev = entry;
> > -    entry->next = next;
> > -    entry->prev = prev;
> > -    prev->next = entry;
> > -}
> > -
> > -/**
> > - * Insert a new element after the given list head. The new element does
> > not
> > - * need to be initialised as empty list.
> > - * The list changes from:
> > - *      head → some element → ...
> > - * to
> > - *      head → new element → older element → ...
> > - *
> > - * Example:
> > - * struct foo *newfoo = malloc(...);
> > - * list_add(&newfoo->entry, &bar->list_of_foos);
> > - *
> > - * @param entry The new element to prepend to the list.
> > - * @param head The existing list.
> > - */
> > -static inline void
> > -list_add(struct list_head *entry, struct list_head *head)
> > -{
> > -    __list_add(entry, head, head->next);
> > -}
> > -
> > -/**
> > - * Append a new element to the end of the list given with this list head.
> > - *
> > - * The list changes from:
> > - *      head → some element → ... → lastelement
> > - * to
> > - *      head → some element → ... → lastelement → new element
> > - *
> > - * Example:
> > - * struct foo *newfoo = malloc(...);
> > - * list_add_tail(&newfoo->entry, &bar->list_of_foos);
> > - *
> > - * @param entry The new element to prepend to the list.
> > - * @param head The existing list.
> > - */
> > -static inline void
> > -list_add_tail(struct list_head *entry, struct list_head *head)
> > -{
> > -    __list_add(entry, head->prev, head);
> > -}
> > -
> > -static inline void
> > -__list_del(struct list_head *prev, struct list_head *next)
> > -{
> > -    next->prev = prev;
> > -    prev->next = next;
> > -}
> > -
> > -/**
> > - * Remove the element from the list it is in. Using this function will
> > reset
> > - * the pointers to/from this element so it is removed from the list. It
> > does
> > - * NOT free the element itself or manipulate it otherwise.
> > - *
> > - * Using list_del on a pure list head (like in the example at the top of
> > - * this file) will NOT remove the first element from
> > - * the list but rather reset the list as empty list.
> > - *
> > - * Example:
> > - * list_del(&foo->entry);
> > - *
> > - * @param entry The element to remove.
> > - */
> > -static inline void
> > -list_del(struct list_head *entry)
> > -{
> > -    __list_del(entry->prev, entry->next);
> > -}
> > -
> > -static inline void
> > -list_del_init(struct list_head *entry)
> > -{
> > -    __list_del(entry->prev, entry->next);
> > -    INIT_LIST_HEAD(entry);
> > -}
> > -
> > -static inline void list_move_tail(struct list_head *list,
> > -                                 struct list_head *head)
> > -{
> > -       __list_del(list->prev, list->next);
> > -       list_add_tail(list, head);
> > -}
> > -
> > -/**
> > - * Check if the list is empty.
> > - *
> > - * Example:
> > - * list_empty(&bar->list_of_foos);
> > - *
> > - * @return True if the list contains one or more elements or False
> > otherwise.
> > - */
> > -static inline bool
> > -list_empty(struct list_head *head)
> > -{
> > -    return head->next == head;
> > -}
> > -
> > -/**
> > - * Returns a pointer to the container of this list element.
> > - *
> > - * Example:
> > - * struct foo* f;
> > - * f = container_of(&foo->entry, struct foo, entry);
> > - * assert(f == foo);
> > - *
> > - * @param ptr Pointer to the struct list_head.
> > - * @param type Data type of the list element.
> > - * @param member Member name of the struct list_head field in the list
> > element.
> > - * @return A pointer to the data struct containing the list head.
> > - */
> > -#ifndef container_of
> > -#define container_of(ptr, type, member) \
> > -    (type *)((char *)(ptr) - (char *) &((type *)0)->member)
> > -#endif
> > -
> > -/**
> > - * Alias of container_of
> > - */
> > -#define list_entry(ptr, type, member) \
> > -    container_of(ptr, type, member)
> > -
> > -/**
> > - * Retrieve the first list entry for the given list pointer.
> > - *
> > - * Example:
> > - * struct foo *first;
> > - * first = list_first_entry(&bar->list_of_foos, struct foo,
> > list_of_foos);
> > - *
> > - * @param ptr The list head
> > - * @param type Data type of the list element to retrieve
> > - * @param member Member name of the struct list_head field in the list
> > element.
> > - * @return A pointer to the first list element.
> > - */
> > -#define list_first_entry(ptr, type, member) \
> > -    list_entry((ptr)->next, type, member)
> > -
> > -/**
> > - * Retrieve the last list entry for the given listpointer.
> > - *
> > - * Example:
> > - * struct foo *first;
> > - * first = list_last_entry(&bar->list_of_foos, struct foo, list_of_foos);
> > - *
> > - * @param ptr The list head
> > - * @param type Data type of the list element to retrieve
> > - * @param member Member name of the struct list_head field in the list
> > element.
> > - * @return A pointer to the last list element.
> > - */
> > -#define list_last_entry(ptr, type, member) \
> > -    list_entry((ptr)->prev, type, member)
> > -
> > -#define __container_of(ptr, sample, member)                            \
> > -    (void *)container_of((ptr), typeof(*(sample)), member)
> > -
> > -/**
> > - * Loop through the list given by head and set pos to struct in the list.
> > - *
> > - * Example:
> > - * struct foo *iterator;
> > - * list_for_each_entry(iterator, &bar->list_of_foos, entry) {
> > - *      [modify iterator]
> > - * }
> > - *
> > - * This macro is not safe for node deletion. Use list_for_each_entry_safe
> > - * instead.
> > - *
> > - * @param pos Iterator variable of the type of the list elements.
> > - * @param head List head
> > - * @param member Member name of the struct list_head in the list
> > elements.
> > - *
> > - */
> > -#define list_for_each_entry(pos, head, member)                         \
> > -    for (pos = __container_of((head)->next, pos, member);              \
> > -        &pos->member != (head);                                        \
> > -        pos = __container_of(pos->member.next, pos, member))
> > -
> > -/**
> > - * Loop through the list, keeping a backup pointer to the element. This
> > - * macro allows for the deletion of a list element while looping through
> > the
> > - * list.
> > - *
> > - * See list_for_each_entry for more details.
> > - */
> > -#define list_for_each_entry_safe(pos, tmp, head, member)               \
> > -    for (pos = __container_of((head)->next, pos, member),              \
> > -        tmp = __container_of(pos->member.next, pos, member);           \
> > -        &pos->member != (head);                                        \
> > -        pos = tmp, tmp = __container_of(pos->member.next, tmp, member))
> > -
> > -
> > -#define list_for_each_entry_reverse(pos, head, member)                 \
> > -       for (pos = __container_of((head)->prev, pos, member);           \
> > -            &pos->member != (head);                                    \
> > -            pos = __container_of(pos->member.prev, pos, member))
> > -
> > -#define list_for_each_entry_continue(pos, head,
> > member)                        \
> > -       for (pos = __container_of(pos->member.next, pos, member);       \
> > -            &pos->member != (head);                                    \
> > -            pos = __container_of(pos->member.next, pos, member))
> > -
> > -#define list_for_each_entry_continue_reverse(pos, head,
> > member)                \
> > -       for (pos = __container_of(pos->member.prev, pos, member);       \
> > -            &pos->member != (head);                                    \
> > -            pos = __container_of(pos->member.prev, pos, member))
> > -
> > -#define list_for_each_entry_from(pos, head, member)                    \
> > -       for (;                                                          \
> > -            &pos->member != (head);                                    \
> > -            pos = __container_of(pos->member.next, pos, member))
> > -
> > -#endif
> > -- 
> > 2.25.1
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

