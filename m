Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905F56924A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiGFS7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiGFS7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:59:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B31EAD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:59:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so14676156eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmtXzNK0QKaLTy/xaBocgtQlDX9HlPA1KQpwpropMCo=;
        b=b+/fBPGFSwT3fTByFaFmq1vUnY1YN20ZJL4D7woKTixjp87gj2Q0XJuU092Qz2RBrM
         uX366HHMKn9HzWqBGSr2xCjzdTcY+XsULr4SDFoCsyuUkETKVtHOOifv6L3+9HlkhhJq
         pFJGyHh8w2O4IzmVKjHRLRyVfZLA/VSBI9yNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmtXzNK0QKaLTy/xaBocgtQlDX9HlPA1KQpwpropMCo=;
        b=q3ZLLZAtOFNuZ2e+07I8q6G4Jlfi/6CgC2zPK6VIaKjlhaN5aA6Jj2JyIBRokpFphr
         Eml/ZzsWAgIlvQimynCIyJyqBEylYhh8umd+nf+1cXWFKRevNoNjeML4n4RZvQCASry7
         e0w9MAryjftEINt3reosKuUaSXdKmPgpkByOAspaNopSx6Ynq1xpVg91vUKNCByw7vCp
         dVnLOXlpQB5f8nH8wP/VyMJbevN95sWw4jcEfXOUEr6phNsw/YGN58qqWJIThd7mRvs+
         x8AmxuaQPDFCoozbWIe+UhzjeKwInq2vcRZYI9i96rQbTwWlteSyRB5A7guVa5vcUeT2
         op7A==
X-Gm-Message-State: AJIora8t9vTYCNg2wcrdNVFgKbns7RLnGEU1UHzpvH3vZ3IxiJI/VpKR
        SYM1YTebR+PiKqbhL6ItB/j1HE8u31hFSYYH
X-Google-Smtp-Source: AGRyM1u605wwGkzvG42vdoMlccrQkMFQmnVEh47L0jR3IRVaOAOAI4wGK1zJCR0sYSwPCIdUVd56uA==
X-Received: by 2002:a05:6402:3690:b0:43a:83f8:93bf with SMTP id ej16-20020a056402369000b0043a83f893bfmr9010981edb.49.1657133961163;
        Wed, 06 Jul 2022 11:59:21 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090666cc00b007041e969a8asm17799005ejp.97.2022.07.06.11.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 11:59:20 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so9473533wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:59:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:3a1:68bf:d17a with SMTP id
 g12-20020a05600c4ecc00b003a168bfd17amr88108wmq.154.1657133959887; Wed, 06 Jul
 2022 11:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <272584304.305738.1657029005216@office.mailbox.org>
 <CAHk-=wivGGgs9K_TfQYTW4RzH_C-JVfLZKNA5+hKQU0eNFBeiw@mail.gmail.com>
 <MN0PR12MB61015A04C6E4202B2E8E08A9E2819@MN0PR12MB6101.namprd12.prod.outlook.com>
 <72419963.329229.1657096948079@office.mailbox.org> <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
In-Reply-To: <8ee1bc75-3ecd-9d87-b7cc-37ba15133026@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Jul 2022 11:59:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfSg1FNFJXv9QfXXnWFO71YufsoTs9S8sYzonfwjm4XA@mail.gmail.com>
Message-ID: <CAHk-=whfSg1FNFJXv9QfXXnWFO71YufsoTs9S8sYzonfwjm4XA@mail.gmail.com>
Subject: Re: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Tor Vic <torvic9@mailbox.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 11:21 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Wild guess, I'm not involved at all in any of the following, I just
> noticed it and thought it might be worth mentioning:
>
> I heard Fedora rawhide added this patch to solve a boot problem that
> sounded similar to yours:
> https://patchwork.freedesktop.org/patch/489982/

Yes, this looks likely, and matches that "starts in 5.19-rc5" since
the offending commit came in as

  ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
removing conflicting FBs")

so that does look like a likely cause.

              Linus
