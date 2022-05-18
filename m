Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C252BF92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiERQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiERQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:03:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C01170F0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:03:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so3444094wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ8x3A3SUh3hnIZHUc6rKyMmPbJB4WADynnntPJs/B0=;
        b=CFxKqA/ZOWiK2KBTxEXLxhszvMD6eEl28C9EC52rsAOz9y7u1qFvR5NbNXHFkojhXI
         L2oleUu6PJlNSNAXR+tZ40UR+65+zx3QkrDapDy9Fbqle4L55rwhjEWAEoAEhe3jnEZM
         Y+VewS4gm1Bcurjijqv5eRljKfCWFj84ltnVA5EgeJPZneEIh+cKnCHbhA/6upMndLOG
         A270E1nf9QDhDzvXKn+6Qe5xjXRcvox2oUTGuQp9wW8RsHYqdDTPRy275gqhzUd4PSFs
         Bh0VxypunuqM7GyZ1TAJKm9TPHAK3yNuRksX8fFC0GizRiIehoQbZGtSHqCYugxA8++h
         60AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ8x3A3SUh3hnIZHUc6rKyMmPbJB4WADynnntPJs/B0=;
        b=baNc+xEsBd26NOhw9UFHsBp13JNh6gS18ykghsULOZ2YudHjQqmIcZUMV5WakoqIOS
         ewayQsaLI9pVtDU97CHp1rzJ9eaH//h3OA9nSAcCqtd83KdO5cDUxsE1HX8TOEAqzq7e
         TygHc8EO2V8yUjdrLcj44U8XafNE5RdCQCHqzfzhMer15jRo9uiqEmRkHl93rWXMNXHZ
         BRWW94NhHf+jIgFbAsNPMbwcO8Mju1lCzPbPSyk45bbmCmRoQ2Vgc7Wu0ObXt6x85pug
         no93Ak7l5U+sl0snYogq9vOLNGWxSmYiaSZuNjgHhMvf7jQ80nwciWyBOo4JhQWkuC1P
         Qmmg==
X-Gm-Message-State: AOAM532Tywi/qVCJzXI+tG0AaDfP/JHaR1vwhkvba6zxAzs6y5tyZAdC
        Hmx0Wfahdr31Ll5wS+QcPb90I8tmxZyy45HOxVeW
X-Google-Smtp-Source: ABdhPJzVkBLylwaOZnnE42Ze2+ZD83Vb86r4fTxzPJH20bRDkwa1kPO33WF2FFIPJZRBjsneeGByTg/CPobPZKy0ryo=
X-Received: by 2002:a05:600c:3487:b0:397:ca9:c98b with SMTP id
 a7-20020a05600c348700b003970ca9c98bmr596753wmq.51.1652889811850; Wed, 18 May
 2022 09:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092137.141626-1-gongruiqi1@huawei.com>
 <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com> <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com>
In-Reply-To: <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 May 2022 12:03:21 -0400
Message-ID: <CAHC9VhQRPqyMrja5L+8VTb-dsUrmb1cJq+wrQ5GyA5NupPLfZg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add __randomize_layout to selinux_audit_data
To:     Gong Ruiqi <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 2:53 AM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> On 2022/05/18 9:39, Paul Moore wrote:
> > On Tue, May 17, 2022 at 9:21 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> >>
> >> Randomize the layout of struct selinux_audit_data as suggested in [1],
> >> since it contains a pointer to struct selinux_state, an already
> >> randomized strucure.
> >>
> >> [1]: https://github.com/KSPP/linux/issues/188
> >>
> >> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> >> ---
> >>  security/selinux/include/avc.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> >> index 2b372f98f2d7..5525b94fd266 100644
> >> --- a/security/selinux/include/avc.h
> >> +++ b/security/selinux/include/avc.h
> >> @@ -53,7 +53,7 @@ struct selinux_audit_data {
> >>         u32 denied;
> >>         int result;
> >>         struct selinux_state *state;
> >> -};
> >> +} __randomize_layout;
> >
> > I'll apologize in advance for the stupid question, but does
>
> Not at all :)
>
> > __randomize_layout result in any problems when the struct is used in a
> > trace event?  (see include/trace/events/avc.h)
>
> No, as least it doesn't in the testing I did. I believe we can use the
> struct tagged with __randomize_layout as normal except that 1) it should
> be initialized with a designated initializer, and 2) pointers to this
> type can't be cast to/from pointers to another type. Other operations
> like dereferencing members of the struct (as in
> include/trace/events/avc.h) shouldn't be a problem.
>
> I did a testing to the patch on a qemu vm by running the selinux
> testsuite with tracing events "avc:selinux_audited" enabled. The
> testsuite completed successfully and from the tracing log I saw nothing
> abnormal with my bare eyes. You can do more testing if you want or you
> have other ideas of how to do so ;)

That's great, thanks for verifying this.  I was aware of the other
restrictions but wasn't sure about tracing.  Now I know :)

It's too late to go into selinux/next for this dev cycle, but I'll
queue this up for selinux/next once the merge window closes.

Thanks again!

-- 
paul-moore.com
