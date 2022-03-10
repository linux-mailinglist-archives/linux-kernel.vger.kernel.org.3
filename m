Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0094D3EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbiCJBay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:30:51 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC96101F1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:29:52 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u10so7976711ybd.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sGtGQKWCDsfpy7q5dRmvCMVZRb/ItkkfTMcTCDlwnY=;
        b=vaT9jvCkNdIj2irJAN4KCLlbED7q2bnD4fwgbJQ80prmYcRw9lduJ7xTTaThyzxT3S
         2rwoJZnXaYSAGV0W2fCrdKwc6HEP0Rj0IOAuqBxsPRKkJm9LdiraMgHztyhICLHovrjA
         AgRKDK7/862rIVw9HZoin04iQHwNO4KAlvWBGy237gZGYWzOKYbZpsyj/EmQ55AIlJiA
         ZXRP299SNLUjri8K9buQEvv2A90yPd7vYCAYAELfwUdV1rRK2JCZWPxMWiDzAvCRFPPv
         AdiDXdl5HdmKEJh35/XVod/TexgNBKcKSXgWVg0UcbPhg9AAzCdNnOoF0Q9v7cWbVHtG
         03Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sGtGQKWCDsfpy7q5dRmvCMVZRb/ItkkfTMcTCDlwnY=;
        b=H6NJqs0FOb9KFTZV/4wPOYW6Hw6a7DMQAyaEJXSfLfYP1Jhily2IhCM5LgdmsmRM4m
         mzmyRLYR6OCGvjllQLwN/O45A/hk3YkbQhyzM6yTj8b8D2AQztQB2WQN2sH46rTWk1Yz
         BsiUt7HAXbm3d04mRIDjhN2bn1GdiIryaohE1+g70Y3TXm2iqQm0gNbfw03BY3mU6kqL
         K0j6sFpCNVVUG02bftpGsLMuPeXzQP0hd97cFZtjPRYyCrzjM5Hk6GwscJpHCytKTbCI
         w8QWWYh4fFVTCSTKc4/TBJKVYUHcUeKDum2ofdb7mM1EzRjikCtkWwlkXsS/7nWd+8gI
         OxAQ==
X-Gm-Message-State: AOAM531tGFWDh+FVGvEHffigJ/+4sHpeZsvTOkw+BTNEGpkyw2BnLja5
        DrhkTq2h4gKMKwSVImjn5FwMpvr5/9vTiUL6bVadBA==
X-Google-Smtp-Source: ABdhPJzq9VLqcrspkH6SlHz0AWuAqOJ3oZdiZNZDgcgs+1R/wsd2In8qIIbvHoo7UyraGrkTQNHpQKkio5PDk94i2C4=
X-Received: by 2002:a25:da85:0:b0:629:36f:5669 with SMTP id
 n127-20020a25da85000000b00629036f5669mr2140791ybf.492.1646875791503; Wed, 09
 Mar 2022 17:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org> <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com> <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <08232117-7444-55d8-e13c-b49828c8f3e9@arm.com> <CAK8P3a3L2sfi-VQ=yjRhkGA6x6JTvCw5KyHQnBf2r348MX_avw@mail.gmail.com>
In-Reply-To: <CAK8P3a3L2sfi-VQ=yjRhkGA6x6JTvCw5KyHQnBf2r348MX_avw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Mar 2022 02:29:39 +0100
Message-ID: <CACRpkdbpV0eyFnX32RigqZbRChNhcY6n+axYSoGaF4_0Z9oUiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 5:38 PM Arnd Bergmann <arnd@kernel.org> wrote:

> Any opinion on removing CPU_ARM{7TDMI,740T,940T,946E}?

7TDMI was/is extremely prolific, it is everywhere (such as in CSR/SiRF
GPS chips, SD cards, hard disks, a lot of sensors and what not).

That said I have never seen one of these systems with enough memory
to boot a recent Linux kernel. I think with the failure to push the kernel
footprint down (due to lack of interest) they don't really have a future as
Linux targets. They all run $small_os.

Yours,
Linus Walleij
