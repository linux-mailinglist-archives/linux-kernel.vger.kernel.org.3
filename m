Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8FD4EB63B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiC2W4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiC2W4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:56:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDDBA33A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:54:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so38004005ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zd9bA/vVsUljfZ2zHhaCGxU4BtZMVvpzyOofaCZaWSI=;
        b=jk/9TmsoatIgO07065kxR/5mB1wQ8q4FUWIvnM39nXT7UfRE+1LkZl/noVHNBe5oT3
         GH7nAcSb6gtqiNbisLO2gWbXMx8YcXx6uQ2Lyyj+sNMuf1JFkbhUscK/ZZK/njpz1XgI
         HlWL7fwMMn2nk+x+Rdox8d8O8cyRaBtZFgTT8AOObpFDivUSvnkz++BBkIZWHrJCMdEV
         LbmUlyzSAzIJrNbAm3a2J7dv/cypv+lwBYSxsEClhOFnBWXtN7J1Zlj11np+Wf7zGT2B
         vzxftyArV2jMUz4zQrAQ/+lu4yjtPE8xV29c0K6DeI1RQB+t8L20MwR4HS2IpJ7r9IgB
         bnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zd9bA/vVsUljfZ2zHhaCGxU4BtZMVvpzyOofaCZaWSI=;
        b=sQAhvUukHppPxMXJl7Qg8G65ZplTF35Tbbx9MTeBOAF93npdV0vR19spuBPM5Ufc37
         KknvucTCOtXC0r1isz/W65baNi1OrJuIegSSP+rZAqECvoZMvxarjen2u1RTnZ6G8EK1
         q+92yXfWlSBmUxdyBkONjkGOVZzAjk6uzosvNDBsBBMYRv/xl9HZLd1T1hOe6NOyODd1
         wR9x6ZYpqiU3W2Gg7C6hFXfCD8xoRKwXXpq81bGj0DWFdd2s8hOJOzBhOP21hOkhYsNV
         WTY+A2Ayv4ZpJGhCdBy+OBysXRs1d2kpJZTS5f1LiKxu/tEgRZ3dCorvToBmEvO3vv+g
         WCOg==
X-Gm-Message-State: AOAM530f6YGXlbvjY5lJ1d1T3u6LVKtZcmVGmouPBu3/UQlMb1H5e5MW
        5XgVkLC8iQQuDO2RbB0ZPe619Mx+PygsBQ5FELGCbg==
X-Google-Smtp-Source: ABdhPJxwwDVBkhAhwsoFm6aYbSMA/hHzkmazRu/kdl9EQO+9cGUdq6cPt2m4qwpklWi6AbAZ/G+JEZ1xcJeV2qm3IGs=
X-Received: by 2002:a17:907:1622:b0:6df:d1a2:d4a3 with SMTP id
 hb34-20020a170907162200b006dfd1a2d4a3mr35715153ejc.542.1648594460875; Tue, 29
 Mar 2022 15:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220329103919.2376818-1-lv.ruyi@zte.com.cn> <CAGS_qxpCHgp7ToQV9UALPy-4nyHDcdpWOCCd3duz-L6EgYPpOg@mail.gmail.com>
In-Reply-To: <CAGS_qxpCHgp7ToQV9UALPy-4nyHDcdpWOCCd3duz-L6EgYPpOg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 29 Mar 2022 17:54:09 -0500
Message-ID: <CAGS_qxr1VZz+Tzxpwzcx_HtPhWxSONPYEshPNyf=diUw2X6VDg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add null pointer check
To:     cgel.zte@gmail.com
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 2:29 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Mar 29, 2022 at 5:39 AM <cgel.zte@gmail.com> wrote:
> >
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> >
> > kmalloc and kcalloc is a memory allocation function which can return NULL
> > when some internal memory errors happen. Add null pointer check to avoid
> > dereferencing null pointer.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > ---
> >  lib/kunit/executor.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 22640c9ee819..be21d0451367 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
> >
> >         /* Use memcpy to workaround copy->name being const. */
> >         copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> > +       if (!copy)
> > +               return NULL;
>
> While this is technically correct to check, in this context it's less clear.
> If we can't allocate this memory, we likely can't run any subsequent
> tests, either because the test cases will want to allocate some memory
> and/or KUnit will need to allocate some for internal bookkeeping.
>
> The existing code (and by extension this patch) "handles" OOM
> situations by silently dropping test suites/cases.
> So I sort of intentionally figured we should let it crash early in
> this case since that's probably more debuggable.
>
> This code does check for NULL returns earlier on in the call chain, i.e.
>
> first in kunit_filter_suites()
>    158          copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
>    159          filtered.start = copy;
>    160          if (!copy) { /* won't be able to run anything, return
> an empty set */
>    161                  filtered.end = copy;
>    162                  return filtered;
>    163          }
>
> and second in kunit_filter_subsuite()
>    107          filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
>    108          if (!filtered)
>    109                  return NULL;
>
> The first kmalloc_array() is our first allocation in this file.
> If we can't handle that, then things are really going wrong, and I
> assumed there'd be plenty of debug messages in dmesg, so silently
> returning is probably fine.
> The second one also felt similar.
>
> So I think that
> * it's highly unlikely that we pass those checks and fail on these new
> ones (we're not allocating much)
> * if we do fail, this is now harder to debug since it's partially
> running tests, partially not
>
> Should we instead rework the code to more clearly signal allocation
> errors instead of overloading NULL to mean "no matches or error?"

More concretely, I'm thinking something like this:

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 22640c9ee819..a5c29a32a33a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite,
const char *test_glob)

        /* Use memcpy to workaround copy->name being const. */
        copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+       if (!copy)
+               return ERR_PTR(-ENOMEM);
        memcpy(copy, suite, sizeof(*copy));

        filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
+       if (!filtered)
+               return ERR_PTR(-ENOMEM);

        n = 0;
        kunit_suite_for_each_test_case(suite, test_case) {
@@ -106,14 +110,16 @@ kunit_filter_subsuite(struct kunit_suite * const
* const subsuite,

        filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
        if (!filtered)
-               return NULL;
+               return ERR_PTR(-ENOMEM);

        n = 0;
        for (i = 0; subsuite[i] != NULL; ++i) {
                if (!glob_match(filter->suite_glob, subsuite[i]->name))
                        continue;
                filtered_suite = kunit_filter_tests(subsuite[i],
filter->test_glob);
-               if (filtered_suite)
+               if (IS_ERR(filtered_suite))
+                       return ERR_CAST(filtered_suite);
+               else if (filtered_suite)
                        filtered[n++] = filtered_suite;
        }
        filtered[n] = NULL;
@@ -166,6 +172,8 @@ static struct suite_set kunit_filter_suites(const
struct suite_set *suite_set,

        for (i = 0; i < max; ++i) {
                filtered_subsuite =
kunit_filter_subsuite(suite_set->start[i], &filter);
+               if (IS_ERR(filtered_subsuite))
+                       return filtered; // TODO: how do we signal this?
                if (filtered_subsuite)
                        *copy++ = filtered_subsuite;
        }

> Or maybe just adding some pr_err() calls is sufficient.
