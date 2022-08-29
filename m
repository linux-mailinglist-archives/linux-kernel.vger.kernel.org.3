Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587355A4CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiH2NCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiH2NBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:01:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535F4BA6A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:53:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 69so5965397pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Z/mBY2jgNDkWQ3lEWcoeCOwOWescKqJwUlwqGO5KuJY=;
        b=ZrXS+/PN7MjuqSu/+/xHyffxoijmukarDdtB/3TARKB7q3BLr1Vx7T/fs09i5kfugF
         IG3pbHjIj1TI+B5S/YOQM445Su0v1nateqtk6N7kYtOhsP3V5tr1fuC+doi9JHoSs3ip
         QKkcw0r9fSo7tD6i5+VV/UT9qzWyi4mPSrbcxqH2ufl8dvCiPGhUvpmgRKa6iB0pXDMj
         wPAwssvvOlhxuGtBoT0Z3eXyd53o0ZUdJUVSVQ3ClJse3sXsB0IY+smFNWvdap+CgkGt
         L4Tvs1C2aAVcXZTcyF1QbyeHX6DffONomhBO7oBimH0a3kUfzDwEM6K+5M6x7M5nKj6W
         gVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Z/mBY2jgNDkWQ3lEWcoeCOwOWescKqJwUlwqGO5KuJY=;
        b=mHccEuqtAX4qBuWBpvQy8TFqUpdUF6SZEPg3xt/yRb8xcZMCUA+9gzJB3iME5dMTWm
         mIamnKPpb9wFpmfkdHPiZ7NBZO91BGj3OaPnZ6YlUmvBsts+62XlEto5aPnHJAIldCA9
         OioIOJ3nUL9beak/SczCSlmETztiy36Ig4grQmW8NH5qCXy+AJDyM5x7XhfrZbrPjNnk
         F5q54tqyMzMxLq2q17ajlpBTNi735kP/T0dqQBg3CHZijP57O/alyFQ5ebcBZ6MA10oO
         jSFVVvuuoAC7dYXew8u571CTX1oPHFPwY6zgZvwguY01hDRJbCoSQg7Q3dT4Z5CpK4xn
         WDKw==
X-Gm-Message-State: ACgBeo0wvyITS6IPP57WsJaoBUS80QTubl3Kv/YhjBTGzbcQUYp2w0SM
        9V6058s7F4AUyMBhGbU7XXq59w==
X-Google-Smtp-Source: AA6agR7EiSZno8PJhvukHxS/VfWScLMZXn5Vlfkr+Zp9Me2vZrYE8Ww3BqQJI+4eSdeYl9Ih2996hA==
X-Received: by 2002:a65:6d0b:0:b0:42a:19dc:e76e with SMTP id bf11-20020a656d0b000000b0042a19dce76emr13623850pgb.6.1661777587046;
        Mon, 29 Aug 2022 05:53:07 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.110])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7517607plh.170.2022.08.29.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:53:06 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 4/4] RISC-V: Enable PMEM drivers
Date:   Mon, 29 Aug 2022 18:22:26 +0530
Message-Id: <20220829125226.511564-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829125226.511564-1-apatel@ventanamicro.com>
References: <20220829125226.511564-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have PMEM arch support available in RISC-V kernel so let us
enable relevant drivers in defconfig.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index aed332a9d4ea..010b673ebd11 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -159,6 +159,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
+CONFIG_LIBNVDIMM=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.34.1

