Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9259159E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiHLSsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHLSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:48:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2340B3B19
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:48:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r22so1488836pgm.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=u3cX3V4C08o1FpO9MAv/b+S+sjNV8qNmxFj3U4ZhQzI=;
        b=NT2KQmbTFWOke3awul9uq3uDyN1FDvcnLQZ9gBslwdywXAehGi8QNf5rm4zu1AWynr
         87JfHD59jiyXJ0QOdbl6vlJ7GnfCBrF9rweTNjsDuINbV9lSXA0cV5qkB6mYpzdgo3fQ
         j35sHmXlQr0ofv6/BN5F0IhzEFC6RtGmjAagg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=u3cX3V4C08o1FpO9MAv/b+S+sjNV8qNmxFj3U4ZhQzI=;
        b=n66cFQe5IcSGe8wbC90TnmQIKQcPfcRJhqrPDtBo51sPalQefDWiiWrFCkWZMzyjD5
         SEwHLDZnGF8KuMNTlicxu89eK7hfOY3Pwo1EFoPFlXn/mBx/DK1Km9f3q5nI942WhWoh
         coYaH7Aw8aaKsWQpmLtV6ikRO0wRWccWkc4zwn4nqXJKYui8FLwEnean1p6cFZOfVrP0
         2XCmeafoo7X5qjdApF3Kx8lPtJcMBRhR2/KwO43lSDUoo5L3DdE+vmeA8WIHnHubKxRJ
         FUGQNcs4Tgi0/6UWs5iMdFQ2MhvYbrNADWyhkPXDFTvsL5u31w3bfxTbU2KXZNE3D1Ww
         omuA==
X-Gm-Message-State: ACgBeo0tF5eSMw0K3pwDnV1NDEljbvw/RKfN7M6mEX9FKKJBK5AKzxWr
        W9jYun3cqxeL9n8KyVcz01kGpw==
X-Google-Smtp-Source: AA6agR5eIyIedFGrOWHTupoJII5kD/rWypvQABWbaiDJkx2YQtRnG6HHLHbM4SDG/EDOmp36e5dBRQ==
X-Received: by 2002:a63:5064:0:b0:41b:b1db:cb61 with SMTP id q36-20020a635064000000b0041bb1dbcb61mr4072810pgl.67.1660330118055;
        Fri, 12 Aug 2022 11:48:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b0016d9b94ddfasm2054031plw.145.2022.08.12.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 11:48:37 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:48:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Message-ID: <202208121146.9E4A98B@keescook>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
 <202208091551.6879CADA0@keescook>
 <d4ded816-ec34-ae1e-b8ee-a7d87c924f1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ded816-ec34-ae1e-b8ee-a7d87c924f1b@oracle.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:25:17AM +0200, Vegard Nossum wrote:
> 
> On 8/10/22 00:56, Kees Cook wrote:
> > On Tue, Aug 09, 2022 at 08:52:29PM +0200, Vegard Nossum wrote:
> >> Creating a new user namespace grants you the ability to reach a lot of code
> >> (including loading certain kernel modules) that would otherwise be out of
> >> reach of an attacker. We can reduce the attack surface and block exploits
> >> by ensuring that user namespaces cannot trigger module (auto-)loading.
> >>
> >> A cursory search of exploits found online yields the following extremely
> >> non-exhaustive list of vulnerabilities, and shows that the technique is
> >> both old and still in use:
> >>
> >> - CVE-2016-8655
> >> - CVE-2017-1000112
> >> - CVE-2021-32606
> >> - CVE-2022-2588
> >> - CVE-2022-27666
> >> - CVE-2022-34918
> >>
> >> This patch adds a new sysctl, kernel.ns_modules_allowed, which when set to
> >> 0 will block requests to load modules when the request originates in a
> >> process running in a user namespace.
> >>
> >> For backwards compatibility, the default value of the sysctl is set to
> >> CONFIG_NS_MODULES_ALLOWED_DEFAULT_ON, which in turn defaults to 1, meaning
> >> there should be absolutely no change in behaviour unless you opt in either
> >> at compile time or at runtime.
> >>
> >> This mitigation obviously offers no protection if the vulnerable module is
> >> already loaded, but for many of these exploits the vast majority of users
> >> will never actually load or use these modules on purpose; in other words,
> >> for the vast majority of users, this would block exploits for the above
> >> list of vulnerabilities.
> > 
> > We've needed better module autoloading protections for a long time[1].
> > This patch is a big hammer ("all user namespaces"), so I worry it
> > wouldn't actually get used much.
> > 
> > Here's a pointer into a prior thread, where Linus chimed in[2].
> > I replied back then, but I'm not sure I agree with my 2017 self any
> > more. :P
> > 
> > It really does feel like the loading decisions need to be made by the
> > userspace helper, which currently doesn't have enough information to
> > make those choices.
> > 
> > -Kees
> > 
> > [1] https://github.com/KSPP/linux/issues/24
> > [2] https://lore.kernel.org/kernel-hardening/CA+55aFxiDKfe6VCM+aV2OgnkzMpP+iz+rn2k25_Qa_QLex=pPQ@mail.gmail.com/
> 
> Thanks for the pointers, I didn't have any of this context.
> 
> I would still argue for my patch with the following points:
> 
> 1) As you said, it's been almost 7 years since the discussion you linked
> and apparently it's still a problem (including those 5 privilege
> escalation CVEs from my changelog); this relatively simple patch
> provides a mitigation _today_
> 
> 2) it can be layered with any other future mitigations if they do show up
> 
> 3) it's not as big a hammer as completely disabling unprivileged user
> namespaces, which seems to be the next best thing currently in terms of
> protecting your users (as a distro)
> 
> 4) both the implementation and the user interface are fairly simple in
> my patch, which means it's not a huge long term maintenance burden like
> block-/allowlists or capabilities based on whether modules are
> maintained or not (I would also argue that "maintained or not" is not a
> great proxy for whether there are security issues in the code)
> 
> 5) it resembles other sysctls like unprivileged_bpf_disabled or
> perf_event_paranoid, or even modules_disabled
> 
> 6) it's opt-in by default, and even then, if you run into problems with
> containers that don't work or whatever, the solution is extremely
> simple: just load the modules you need before starting your container
> (the module names are printed in the kernel log so it shouldn't be
> difficult to track down issues)
> 
> What's the downside..?

I agree, it'd be nice to have. I'm just trying to predict what kind of
push-back there may be.

Can you address the build failures noted on the thread, and send a v2? I
note that after this patch it looks like all module loading from a userns
gets logged, regardless of the setting. Is that intended?

-Kees

-- 
Kees Cook
