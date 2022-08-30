Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EA5A5AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiH3Er4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiH3Erq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D40AC24D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f12so9809893plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Z/mBY2jgNDkWQ3lEWcoeCOwOWescKqJwUlwqGO5KuJY=;
        b=lcMsqLdRZBsh1/gE+Om6+9NNv+3cxCzdFy+52mewdqx7Myu1GG270U5wm/uWxmaAuB
         bWUyMzYKZgd6KlAwoDeIWNg/ySRIt9WJLvEfij3ceJRNNf6FJDFc6jKyvi32loU214Kd
         IIp/l3Knw5x7Ah35ABT0IwTSW/liiduLwdAAXtja8YQkgP/Cf3cuYnSsJkC4cnA3ZNXT
         7ddhs9HdHwOrX6T6yvjR7DbXmj74a7o3JiqyOxf/GBJinx6X49Hl3/sPm9ZtcqrOoAZQ
         +g/+qaQORJ5sxzPgivFlwGU5UnqGYennizwRUcSB+4xjsRr5yb9H/LGB/qd7HqiM4Gfj
         oLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Z/mBY2jgNDkWQ3lEWcoeCOwOWescKqJwUlwqGO5KuJY=;
        b=RJMEeJI7w2K9FTNKSd2ebbA1AhcW/V8YNmOdZUkMeZo9HYwdxoZ1JL0RRF8YOB8TyY
         WB2sTIe+n+cX2PvCpP8yPa/TIwUZA/W0uaO9nXDV01S8QPSjqlBObl1A/CFxUQeIPa5G
         gnPhEZnVBd8j2QG5/N8+B1V2A2Leow6FUVJBwr7gAsdca0fXLv1luM7NOaKhVv1JitxA
         g1ix7Qw9n8oVfPoakN7N/PxOz41MKfF94gqnHfyTHaFEyF6XbwAx6RsLR+UrWsMJUTgk
         4uC1bxir4odVRdvRHtWaeOf4sOltMkikhsu4ZebRCrqy+TP6fXWrBWfCjtQlokIJLhBH
         wd+A==
X-Gm-Message-State: ACgBeo3yPiB0Da5/XfWy9y4jcaysx1MzxfEgIgFnfNUJA9QYjLZMeV9J
        +4fY/gC7ySLXAfD1QSoBtbKaxg==
X-Google-Smtp-Source: AA6agR6XrkfmOxoBKob/nJpRXtmL+AzNaaiMBZH+BzRQYeIJ3CiaTKVwkXr2+cFUppJYxY/R+NLzhA==
X-Received: by 2002:a17:90b:4a82:b0:1fd:9c58:daff with SMTP id lp2-20020a17090b4a8200b001fd9c58daffmr13582124pjb.48.1661834865182;
        Mon, 29 Aug 2022 21:47:45 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.23])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0041cd5ddde6fsm592240pga.76.2022.08.29.21.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:47:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 4/4] RISC-V: Enable PMEM drivers
Date:   Tue, 30 Aug 2022 10:16:42 +0530
Message-Id: <20220830044642.566769-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830044642.566769-1-apatel@ventanamicro.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com>
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

