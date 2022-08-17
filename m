Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA89596AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiHQH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiHQH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:58:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F64B82
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:58:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay12so6328193wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=TE0ddFHD8LfA9CzLOTfOGrUsW93MtNgghHykEJcQeAU=;
        b=UF89YNB5Ar+Cv8g2RRMKZXOxWN0RV3h0JNk+/fqlVOJ8jGUn8lkS8TAnVggtWV8+Ww
         vh9irmA8T214aXUnBSDvyht4IQU9Wb/e3260kmgPCq2hr4BQ9tq03KuQpKMi/CMy7mVL
         O4Bc2iYmEGSgWj95uLe1MUIGg1+vymK48Y29iFg7ahGZNsLYS+i4PLFeGrvW8HhIF6Hj
         B1Jg/VJulwfImuC8otOrbKAC3ka76t3sPTiCEuTGBaC49iwMY1IQfTWLOQF082ssmMoq
         wg5iWj0Zxes3vGnHVkdGV5jsynGeak+7NRkIALPe5p/O7vJ9PjNmd6Q1kHB5f+2j6G9F
         fgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=TE0ddFHD8LfA9CzLOTfOGrUsW93MtNgghHykEJcQeAU=;
        b=DTslX5NhElvMYpTxAJdrnSyL/q8GdLvy4y7wWUhYxCCzBxJwwhCSFeLWn7AhYqwYCb
         Z+U8/edr5gicqdwihKJO+c6VtD9TxZXIsLrMujIYAjRsRIV/FWYnjnWK0mM6LRx9ZJQC
         5Cb5/78lwoQiYz8K5PB3YeTRi8J+jbLap0x5jp0V7ZUQQe6vBemPl1T8ueh8M3GO3kOT
         lQw2RBOU3fM10TPCK2JKI70fzMoCgAlC7/xAYST9stz3KBcd0tJMyZKdFMAdLpXvGM6p
         nzQcrbVdF5L0rIs5SQqnu2ktbZc2iJJu60E7WepvanOLr2n51j1kfmpL56w4p7dnpw0i
         h4PQ==
X-Gm-Message-State: ACgBeo0DHhxdgb4b9bfrekgX5C+BCfMFlCpiSovJHPTwexR0GKxB2J16
        KvHiaK5Q2qJMiXib41Lq0kc9zcCVmpw=
X-Google-Smtp-Source: AA6agR7E7ug/296BAxhWlugRSAMAIHNivornn5qMdNgpgoK493MzgzZui1FRNDO3yeML19DHIePL9Q==
X-Received: by 2002:a05:600c:a08:b0:3a1:9319:ab78 with SMTP id z8-20020a05600c0a0800b003a19319ab78mr1251613wmp.158.1660723085928;
        Wed, 17 Aug 2022 00:58:05 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05600c1e1d00b003a5fa79005csm1345809wmb.11.2022.08.17.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:58:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Aug 2022 09:58:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <Yvyfi9XC8bu0cOG+@gmail.com>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvybq+hYT4tG/yAg@gmail.com>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > +void mce_set_mcip(void)
> > +{
> > +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x1);
> > +}
> > +
> > +void mce_clear_mcip(void)
> > +{
> > +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x0);
> > +}
> 
> Instead of naming new APIs after how they are doing stuff, please name them 
> after *what* they are doing at the highest level: they disable/enable MCEs.
> 
> Ie. I'd suggest something like:
> 
>      mce_disable()
>      mce_enable()
> 
> I'd also suggest to at minimum add a WARN_ON_ONCE() if MSR_IA32_MCG_STATUS 
> is already 1 when we disable it - because whoever wanted it disabled will 
> now be surprised by us enabling them again.

Also, Boris tells me that writing 0x0 to MSR_IA32_MCG_STATUS apparently 
shuts the platform down - which is not ideal...

Thanks,

	Ingo
