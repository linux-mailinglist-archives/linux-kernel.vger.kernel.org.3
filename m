Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5951C473
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381565AbiEEQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiEEQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:04:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED6205CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:01:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7c57ee6feso53738397b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcrivyRXvs78RFPsaHX0wtRuc37eGonVpkZc+fBUUp4=;
        b=SWulOcJxmVeZWRUP1r6ihWVnsx4vTmwi4LLMgKz74yg3+KJ+ewPEUGHzph6ZBsR7QZ
         haxC8UhbOAPhatpgkvmR/Z0HRRx55tsMFnC7gxS2LGQXN7HnykS4CwtaRiK942O3wUKs
         qq7RDt1iU7ye3njrHkDpfcGYzJOBhIvjlCrLcHN2SxElDLdjKCX5+N9AQDaeLr+h6/Hf
         TF8MWUYRetgCTAH5kOeSGpj1SY3scjUUziOdTuetbjph81XA+lyZc07zWmOfjgZ8vZFf
         waw0UDrA/7G20XsiZcN9b6KVrkqZAiOyy6KeEVEWmIIe3q5I8FjCPuxlZkcbx449hoV+
         +rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcrivyRXvs78RFPsaHX0wtRuc37eGonVpkZc+fBUUp4=;
        b=fmJG15FWWL21rmu2psxT72McOguVdnYMl7YRACIEQhywH5a3G9vJfUBmlez+cM8pIV
         OhUB+T6ectifylyAcC63aep3O4260FbOgOHf1/SpvnC/vlIeIVYlIkKI0rb27NoaxoV6
         +UYmawhvy4gQzlpOdEgcyhjK522zUi000swkjORFAf1ezj3xKy2bdK+QucrBh3tINmXo
         JFmeTRygarhfoiif2hO+auq72NxqsscfzCKim1MXGtSZDeYc178M69HIGal8esEjq6Go
         4HsylgfWlAEXJEBFuGyv/o+ik/zFQy8wlpHi3jBAXNcmHeYrM02nhXt04i739AhcIQ7g
         GvhQ==
X-Gm-Message-State: AOAM531uPzVHv0e7Evy2WSMCCM2tPiN2heKx/en1rAkyEkjeP98C9HR7
        ORhVux0N+FT97Pk/6jYBymF9f49YPRilSTGeO/u4jw==
X-Google-Smtp-Source: ABdhPJyeRJ1A9AX0DmoDqRxo1/DLQHUcof5m2XXSj8lNypY3bHNmQWOqrUEnbss0WuBMSpwMGU3MP94Rte1iYZrYks8=
X-Received: by 2002:a81:8d02:0:b0:2f8:c9f7:4041 with SMTP id
 d2-20020a818d02000000b002f8c9f74041mr24674320ywg.117.1651766475264; Thu, 05
 May 2022 09:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <YnKnLyyXPJl5Llc0@FVFF77S0Q05N> <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
 <CABCJKuc-6daZd8N6hQV6i_TtCtVpfzxJ2UW6xwxC2vxTmJ2deg@mail.gmail.com> <YnPEzeab/R270gAZ@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <YnPEzeab/R270gAZ@FVFF77S0Q05N.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 5 May 2022 09:00:39 -0700
Message-ID: <CABCJKuced3-MoZoBdpL+=h1PC32C-5C12HZH96+dfEp43dJwaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
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

On Thu, May 5, 2022 at 5:36 AM Mark Rutland <mark.rutland@arm.com> wrote:
> FWIW, a `-DLLVM_ENABLE_ASSERTIONS=ON` build also seems to work for me when
> building a kernel with CONFIG_CFI_CLANG=y. It's much slower than a regular
> Release build, so I'm still waiting for that to finish building a kernel, but
> it has gotten much further through the build without issues.

Thanks for confirming. This issue should be fixed here if you want to
give it another try:

https://github.com/samitolvanen/llvm-project/commits/kcfi

Sami
