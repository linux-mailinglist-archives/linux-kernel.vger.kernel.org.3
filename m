Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315804F1E64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbiDDVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379469AbiDDRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:11:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8E13D16;
        Mon,  4 Apr 2022 10:09:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id p10so18475000lfa.12;
        Mon, 04 Apr 2022 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=gwfWMGKfVs8N4QDtqO/np4tSwyUv3PJ9EpKeZ9+Gmts=;
        b=iYGYvS4JUYRKeQVLHnI6WjDuv2/uD5+Hux77BOMXCf+m6zchU8QfKW+oePlxqttUZ6
         IsZ6aozT0IWKNLzLj9dzNjnGXMOn6NvCZ+uh7bfenLfhi4gt0+4niGSY6BjbDAR0nfF2
         Y02Hh2qPh62Ac7xFbNOBaU3AMGJNzZZlIOJ0qIrVngJ5Vhldxgz36rnEbQsoGtzP+nYE
         mteSKaDdgLYnMZBt/d85T2UaaM1UU2bSW1len+ZGmYoapr4Qsofq9/u5xpZ8rWzB8yKi
         bTvy4m13FDOTzVLG6D4ZzQ32fA3FeCZxXdii3P/Gp9p15lXpmLa+g9Q5CggHfp8sk7FI
         036w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=gwfWMGKfVs8N4QDtqO/np4tSwyUv3PJ9EpKeZ9+Gmts=;
        b=pfm9p5ZaAwelSPQzFssxKnZLVbiSu8SzCO7NkLEegboeIauOQqkiXRAFdFTI7VvqT6
         8Uoutw2ArKSm/u7t5WsMT8wKaAbIHJ7e/zf5QmWPFgymRx2t6dNfVDkZaFDOlAHVgF5N
         ewBV4H/YV3csDrMyZOQY9QvX3iJsKBVQDs4LqiTKOY7RzrZSmA11xvvxGBq/fX918SxC
         OLBl5cPE+lWdfWCDnHIM5d4avgAkMWBN8S2xlMxRiAUFwf0wKE09kbpxQwagX57Skkw4
         8B0695XxUcPuk8HZACZK7CLpJmADBTA3CwPWqwiakGduzI95NFqSwT29r0J1BedfKms5
         lFqg==
X-Gm-Message-State: AOAM531JwdiyrSLCiXfrE1XODoCP7fjD6mOV9tLpgkmRIsTX+x5XKA5u
        nBW6kG8ui7XsB5wgShWK0Ig=
X-Google-Smtp-Source: ABdhPJymPq1jnMf+wQecstTGdV1RK252ztorAixRVQDiZYwqgawOyGxf5Bq24+2Usv9dC1mnBao0rA==
X-Received: by 2002:a05:6512:3b90:b0:450:829f:6047 with SMTP id g16-20020a0565123b9000b00450829f6047mr321971lfv.418.1649092173442;
        Mon, 04 Apr 2022 10:09:33 -0700 (PDT)
Received: from mainframe.localdomain ([118.137.7.161])
        by smtp.gmail.com with ESMTPSA id d9-20020a193849000000b0044a54c2ed94sm1189857lfj.300.2022.04.04.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:09:32 -0700 (PDT)
Date:   Tue, 5 Apr 2022 00:09:20 +0700
From:   Ketsui <esgwpl@gmail.com>
To:     akihiko.odaki@gmail.com
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rafael.j.wysocki@intel.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] Revert "ACPI: processor: idle: Only flush cache on
 entering C3"
Message-ID: <Yksl5f4J5S8RWINS@mainframe.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403062322.3168-1-akihiko.odaki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that this reversion fixes a very similar issue I have with kernel
5.17 (only difference is resume always fails on my desktop), here's the bisect
log:

# bad: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
# good: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
git bisect start 'v5.17' 'v5.16'
# bad: [22ef12195e13c5ec58320dbf99ef85059a2c0820] Merge tag 'staging-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 22ef12195e13c5ec58320dbf99ef85059a2c0820
# good: [9bcbf894b6872216ef61faf17248ec234e3db6bc] Merge tag 'media/v5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 9bcbf894b6872216ef61faf17248ec234e3db6bc
# good: [208dd45d8d050360b46ded439a057bcc7cbf3b09] tcp: tcp_send_challenge_ack delete useless param `skb`
git bisect good 208dd45d8d050360b46ded439a057bcc7cbf3b09
# bad: [c288ea679840de4dee2ce6da5d0f139e3774ad86] Merge tag 'gpio-updates-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad c288ea679840de4dee2ce6da5d0f139e3774ad86
# bad: [5c947d0dbae8038ec1c8b538891f6475350542ee] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 5c947d0dbae8038ec1c8b538891f6475350542ee
# bad: [a229327733b86aa585effdb0d27a87b12aa51597] Merge tag 'printk-for-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
git bisect bad a229327733b86aa585effdb0d27a87b12aa51597
# bad: [bca21755b9fc00dbe371994b53389eb5d70b8e72] Merge tag 'acpi-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad bca21755b9fc00dbe371994b53389eb5d70b8e72
# bad: [af8fefd7444480bb8fd8d74f977dbac4693ac3ed] Merge branches 'acpi-x86', 'acpi-pmic' and 'acpi-dptf'
git bisect bad af8fefd7444480bb8fd8d74f977dbac4693ac3ed
# good: [b659ea768ae372e2f82c6346120f2e7272a42ac9] Merge branches 'acpi-scan', 'acpi-pm', 'acpi-power' and 'acpi-pci'
git bisect good b659ea768ae372e2f82c6346120f2e7272a42ac9
# bad: [5847d2d2efaab724b7ab374b6fca105e24509c92] Merge branches 'acpi-ec' and 'acpi-processor'
git bisect bad 5847d2d2efaab724b7ab374b6fca105e24509c92
# good: [c793570d8725e44b64dbe466eb8ecda34c5eb8ac] ACPI: EC: Avoid queuing unnecessary work in acpi_ec_submit_event()
git bisect good c793570d8725e44b64dbe466eb8ecda34c5eb8ac
# bad: [8120832d8f82aa7316c578fbccf11e385a5b3601] ACPI: processor: thermal: avoid cpufreq_get_policy()
git bisect bad 8120832d8f82aa7316c578fbccf11e385a5b3601
# good: [0e6078c3c6737df7d0bd0c890fbadf24a27fffbb] ACPI: processor idle: Use swap() instead of open coding it
git bisect good 0e6078c3c6737df7d0bd0c890fbadf24a27fffbb
# bad: [87ebbb8c612b1214f227ebb8f25442c6d163e802] ACPI: processor: idle: Only flush cache on entering C3
git bisect bad 87ebbb8c612b1214f227ebb8f25442c6d163e802
# first bad commit: [87ebbb8c612b1214f227ebb8f25442c6d163e802] ACPI: processor: idle: Only flush cache on entering C3
