Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ADB4CB1C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiCBWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbiCBWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:45 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA449911
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:08:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s25so4270164lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IlbQWXqli0bmJJpEgImJp1eEsIqn79OOyyTrciOKiU=;
        b=ZEZMRswskOjswx6tJdzOvd++uDOMnhizQ9xgMMjRdj2BFHJllPm9AMgDZ8dtNx2AE4
         lstU8jkmYtaE4AJOYbLN9mzvDZkWEVRfNSoJx2hjNTCBMYYjABkC9jPrQEc3TSTQGotl
         WetlPAt5KoS7AZpTnWofwgwyxQvdkqsf6AkbgPXNnHlMTH+a9SN1E093aSV4gY7YKM/Y
         JKNiYiBqBO4+4Gbxo2eolwv2M4Yofo6Di41Wkj/TIBtGyh/RCOYExF7X+dQlfIMO/CsI
         TtyNhQWqOjdRHlrkhjeKImuKiFcJmE6cQ2yYT83Gh/SGdxPKbE3VTLJB6qCdrdCv9Dyw
         FUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IlbQWXqli0bmJJpEgImJp1eEsIqn79OOyyTrciOKiU=;
        b=8G/vodnTA1I6K6O8/Pp88iREzyJEfkScyhn2ozp2fJ5oo8Vv6J2PoPr+d8+kt3Zo5l
         pyAHmBP2G4ThCIyg2OLYlBCJQX/ZYCYB+Wsah9NBKgC5i4phgoR4gmg6NxGJRoN/x+GV
         xCRhwtJBPpDu8p+x4tFClL9PLxKD1FMlNkcHoObgkpbGlEE7xJvv7vi45JMybbWGybCn
         IusuUyAPJIFAsG1Kcrj0+wdqfkpaL26tUeZ6N5rr8cpSzFQ+d5VJ8C+q1Q0nWcjKEhgE
         TrwrlsII8ryMy0MbREsda+1+RKHwZQsemsQw2Syd2833n+r+0Nprx2wa/ciGkZOZFzfQ
         fC4A==
X-Gm-Message-State: AOAM531quKfL+TGSVJk+EkNQS/I8yJqgBSQdcF0KPEzTeCNw4vwb/xVF
        58x5ifYoJf+h17oQEcw5tTQQ57T5SB/z5RU08TCuXw==
X-Google-Smtp-Source: ABdhPJxvXZVvpAwnwfaWp0w0zI5ONop0YB93AcJksBmO2Pv9KbxT0bwVjHz9OXE1PXZZorxAK0BiXEmEYwJy2rrxEA0=
X-Received: by 2002:a05:651c:1542:b0:233:8ff5:eb80 with SMTP id
 y2-20020a05651c154200b002338ff5eb80mr21217835ljp.352.1646258876867; Wed, 02
 Mar 2022 14:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20220224145138.952963315@infradead.org> <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
 <Yh+dMJsH+ZMPfqwD@thelio-3990X> <CAKwvOdmouBTe5pH3JoP6EEfwNT5=6WvX3oCEZRxO0Dkf38S14w@mail.gmail.com>
 <Yh/egU1LZudfrgVy@dev-arch.thelio-3990X>
In-Reply-To: <Yh/egU1LZudfrgVy@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Mar 2022 14:07:45 -0800
Message-ID: <CAKwvOdkN+pT_og0QjX+MM1dDL8-CMzt8i73tXoguB49Qza3zJA@mail.gmail.com>
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 1:15 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 11:18:07AM -0800, Nick Desaulniers wrote:
> > I'd be much more amenable to that approach.
>
> Sounds good, tentative patch attached, it passes all of my testing.
> There is an instance of $(LLVM) in tools/testing/selftests/lib.mk that I
> did not touch, as that will presumably have to go through the selftests
> tree. I can send a separate patch for that later.

LGTM!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
