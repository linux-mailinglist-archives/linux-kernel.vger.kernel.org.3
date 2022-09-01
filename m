Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F315AA3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiIAXxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIAXxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:53:23 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8267168
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:53:22 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k66so467791vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JkNclvaS3dEaK7C/wj5z3iXIskLCR3t4anfEhUEM03I=;
        b=qsLJIurYFSjrzq0BDiDHr9/q2bJvVh9i/7hy/0e9tfsRqYPViyhjfNveXHcvrKrRpT
         oDpO6JSMkEFfLWxvFa4+yrVGcSqFl9dDOmMJCTOa57uDpPwCWyLvLuvhnhPalZA18Bbu
         217gHiyXr7oaSPfO/1e0NlKuMhXIZukKF2Lu4ehPo/S7fgPP5QrE4sE+WUGUbdsrpSIA
         +BiyvlGQzWjScu7/thL7usKj/+40FCxvkNRZH53Brbfp2yDq0d5VSAcpKX3AdKpkaSBT
         RdF9Xij9EnpBPLHvNeav8gaUobhZLtQzKOatkRkUOmEKD4YW/bHN/gYJNMBGZYoJWlMq
         SxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JkNclvaS3dEaK7C/wj5z3iXIskLCR3t4anfEhUEM03I=;
        b=u5t0zoo+Z+mBGvqIHLxv6Jqfda/iRb1YKeeHvrqSOYldcey60aeIoYzBeq1BtbTxlF
         jWD+FgLRF+K01uWfG22HE7KjcytiARHzNzbDHELKTI+dqH/UKgemNGictz9tSRa2CW5h
         jh/3yrGvVFq0KnEgMCBWw+EGUn2RD0hjTj1sC4dP9aoaDzJND59+aTNGDPFhh3bWDf5E
         w1bMDNsmRt39Bd/6J1QvCxizu7MHw0oSvNWzeD4u52LgjK5+oC7abvI6DBilDyTFZUNw
         DMLQI/nrotfLIceQ/hWIV7YwZf3Q7DfVTLhy0wGMsRLTW/hsBt23wiY8q7vvxjpmxHpO
         i8Nw==
X-Gm-Message-State: ACgBeo281NElnxgk4PPhF10nPZyu0u/dnU3u5/gO/wIQOWIU4F7D9RT8
        lXwjWWut3B9/b5cmiO1glCQN/Yq9UTVEZpQDe5GV1Q==
X-Google-Smtp-Source: AA6agR7vbCVYfSQxCrup2K2FkhwtMdAlc4/BglwR3vlaPdCukjUKh6Rj1XMkjiT+zWF2r3QDDoR1jSvPwD7MJ8ZkKkU=
X-Received: by 2002:a67:e04f:0:b0:390:e8a9:90a6 with SMTP id
 n15-20020a67e04f000000b00390e8a990a6mr7818312vsl.71.1662076401001; Thu, 01
 Sep 2022 16:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220824041933.822838-1-joefradley@google.com>
 <CABVgOSki72Yqb1DBSCgi-qk+FbNniL4GX+19MXwq=K9VEzAyoA@mail.gmail.com> <cb8b16a1-a7d6-1b04-c748-3f2d802b54e5@linuxfoundation.org>
In-Reply-To: <cb8b16a1-a7d6-1b04-c748-3f2d802b54e5@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 2 Sep 2022 07:53:09 +0800
Message-ID: <CABVgOS=HdQ08=kR0eLAm3=f2_vX4_UWV2=bF1+7uVnjJtQK1Dw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add new "test" taint to kernel-chktaint
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Joe Fradley <joefradley@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 2, 2022 at 2:57 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 8/23/22 22:41, David Gow wrote:
> > On Wed, Aug 24, 2022 at 12:19 PM Joe Fradley <joefradley@google.com> wrote:
> >>
> >> Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
> >> added a new taint flag for when in-kernel tests run. This commit adds
> >> recognition of this new flag in kernel-chktaint.
> >>
>
> What happens without this change? It isn't clear what this change is
> fixing.
>

Without this patch, running ./tools/debugging/kernel-chktaint against
a kernel tainted due to loading/running an in-kernel test (KUnit,
kselftest, etc) will not describe the reason for the taint:

Kernel is "tainted" for the following reasons:
For a more detailed explanation of the various taint flags see
Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources
or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
Raw taint value as int/string: 262144/'G                 '

With this change (which should've been introduced along with the new
taint flag), the 'N' taint is printed correctly, along with an
explanation:

Kernel is "tainted" for the following reasons:
* an in-kernel test (such as a KUnit test) has been run (#18)
For a more detailed explanation of the various taint flags see
Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources
or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
Raw taint value as int/string: 262144/'G                 N'

> >> Reviewed-by: David Gow <davidgow@google.com>
> >> Signed-off-by: Joe Fradley <joefradley@google.com>
> >> ---
> >> Changes in v2:
> >> - based off of kselftest/kunit branch
> >> - Added David's Reviewed-by tag
> >>
> >
> > This still looks good to me.
> >
> > Unless anyone objects, I guess we'll take this through the KUnit
> > branch (which, after all, is where the taint was originally added).
> > I've added it to the list for 6.1, but it technically could be
> > considered a fix for 6.0 as well.
> >
>
> I can definitely take this for Linux 6.0 with additional information
> on the problems seen without this change.
>

Yeah, basically the output from kernel-chktaint is incomplete (and, in
the case of the taint string, I'd argue wrong).

Not a disaster if this doesn't land for 6.0, but given 6.0 c an
generate the new taint flag, it makes sense to decode it correctly if
possible.

Cheers,
-- David
