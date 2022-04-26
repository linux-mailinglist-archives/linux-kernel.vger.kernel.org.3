Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF2510348
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345975AbiDZQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbiDZQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:27:23 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E54170344;
        Tue, 26 Apr 2022 09:24:15 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v59so20995072ybi.12;
        Tue, 26 Apr 2022 09:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRoS0e78MQ3Aw94WaIb6fXl1gKLeuGuUg52q3sQRmzY=;
        b=5eWtFbfJHZ8B/YJsY/hQi40pNOdAvkl45eDJTGHQSEW5CDLKdJcf0dWyySuFPhBa2e
         5GyLcZCBv78OHa8No3GT412AhWT9WS07XDInbOZJ5SFITX88w7h11GeG04LwBgeDdvTu
         yy88roMGmEH9pb/tFRrJxClTYa+KAcW4B7cfgc3Q4EgdbUoHIS7qHYNVaDEEcQsXzS8n
         c/eOoDvbO2AwSJjlU9uOVjsDJlHkroJpT77RaKQq2pNxIF6IwYTbyS2qjO9ADePZ4YYf
         SyFXUGfmQlUIhXwLpurvb1s0s7FRI42XRar5Vvpo0QE2ENjN70UKX6CFoXkFqnY0Zocg
         8Bbw==
X-Gm-Message-State: AOAM533PGa4dWwo+baV7OO3+FZBuXkWqIoJX2OaPlgpcufSzJ24A6MpD
        LsZKvvweuWKYd/m8i6OmyjwUhD18Q8jdymVA4bF8tcbR
X-Google-Smtp-Source: ABdhPJwx/0sG065EFEG6R3FAqY53TNDROIzT+SSV1rhw4vfnS5Bq5793FT0nC8rO8MYbenwgZB7rlOBFIPJrRMSrcRY=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr20762254ybs.365.1650990255156; Tue, 26
 Apr 2022 09:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220423182410.1841114-1-matthieu.baerts@tessares.net> <YmgOP1FFmidS9ecJ@zn.tnic>
In-Reply-To: <YmgOP1FFmidS9ecJ@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Apr 2022 18:24:04 +0200
Message-ID: <CAJZ5v0gzvOagiYsMxznksrjmtZFV873DaLAiOo4YHkoUq5qTTA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/pm: fix false positive kmemleak report in msr_build_context()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 5:22 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Apr 23, 2022 at 08:24:10PM +0200, Matthieu Baerts wrote:
> > diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> > index 35bb35d28733..bb7023dbf524 100644
> > --- a/arch/x86/include/asm/suspend_64.h
> > +++ b/arch/x86/include/asm/suspend_64.h
> > @@ -14,9 +14,13 @@
> >   * Image of the saved processor state, used by the low level ACPI suspend to
> >   * RAM code and by the low level hibernation code.
> >   *
> > - * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
> > - * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
> > - * still work as required.
> > + * If you modify it before 'misc_enable', fix arch/x86/kernel/acpi/wakeup_64.S
>
> Why does before misc_enable matter?
>
> arch/x86/kernel/asm-offsets_64.c computes the offsets and there is a
> member like saved_context_gdt_desc which will get moved after your
> change but that's not a problem because the offset will get recomputed
> at build time.
>
> Hm?

So can the comment be dropped entirely?
