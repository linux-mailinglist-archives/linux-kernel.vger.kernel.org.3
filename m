Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFFE5AEE63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiIFPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiIFPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:11:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC948E0C9;
        Tue,  6 Sep 2022 07:25:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b5so15726468wrr.5;
        Tue, 06 Sep 2022 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=SgtOK7Fn4Mn363pk9vnglySkFAC3yWrEKhbc32lNaz8=;
        b=YlVnWF4LgR3y6Snjsvnp04yzajW/gwUKlwo2+XX/q0Ea7VAIevZwQ8sFDh4ZHiwvUc
         kHvEagoYzB36/BpNKOLar8DqVaw3THj8NmY0MaxFnnR7FTiZKpy/8NCMPwWuQ6cnXHi8
         xa7I7l9fS8K/S8NvDmRTsndMZpp2SI0IUJgYRzsqgBbOz6mi/j4TGt/0FixOeuQ8NaBk
         OvUxJ/J1lNJMdjCsfpWRvxvwrx+uH7WpSerL41we3LUv09QAZKx5X9sm9Y55XCxgUWet
         hz5mAbIdp3j/varJBXAR/OVSRBVVcBZ7ckAgLAG+Ad+VGW9zaw/iU5HzriZhOdU8m/ER
         wqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SgtOK7Fn4Mn363pk9vnglySkFAC3yWrEKhbc32lNaz8=;
        b=v6taoyKq9fKoypYtrH9Eax7smQU59ARcJVaYef+04++0A30Ypl4oof/MsmzopiLJdN
         +f5Dox/LGEyNo3Rtl1/YELKnWA30m+q0Pam2wc3IDVBln4foXTSUT6igNsfbjONqQWnr
         yHH4ssIEANyyJzp2sosHMocTn8NUZl3dtqsnJginxpsT9fjnJPYb1+Kbbd7J4f+XYMdP
         OYTHin3Yq08ODSMpW5nsIqzZW/qfQ5KmT83rKnm0Zhfd9cPrpZdL0ryxcMgo5tq1OmsT
         HRGNqMVdXXT6Q8U8FSBTnSjqdf8XxIxQC5HQolhydZ76h275+ZMg6j940SwXbmzhupDZ
         KwSw==
X-Gm-Message-State: ACgBeo2lQZgvCvVRDkonWkZZLWiJTNjVeOECwpaupjLuS5o9VZSMUQ+Q
        lVrp829LcnVfJAFR+B3o8rA=
X-Google-Smtp-Source: AA6agR7gHjucsKxwTur3SuarsEltaanUAYG1Nve9kz4+jV7e28o9DzXbkUmxKJcJWkQtvBwr7hMTpA==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr23452887wri.388.1662474204810;
        Tue, 06 Sep 2022 07:23:24 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003a5c7a942edsm22880578wmc.28.2022.09.06.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:23:24 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:23:22 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Message-ID: <YxdX2l88PSFGe1r4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of riscv, s390, csky, alpha and loongarch allmodconfig have
failed to build next-20220906 with the error:


drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
  311 | static int pci1xxxx_gpio_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
  295 | static int pci1xxxx_gpio_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~


git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
