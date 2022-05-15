Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6262527A47
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiEOVBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiEOVBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:01:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBDDB86A;
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dk23so25243590ejb.8;
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npYBdm+Z3JK/AAr8Gk9MHyCf99zBDnSXIOh7phMrfJA=;
        b=arQwpoazmz7KmsnEl3pcO9LHJ0Bfpaygrjd7lLfmYESy9dpYb90nS920fw+kXVE6Fs
         vE4Y3+4mdj6MuCD9Rj/7vgYJLCakQAtd3Evos72Ii7fZXHn5oRtVLi5sOU4hQLhwdRho
         GBTE6ERUpFwY1diX3WjYnk3sG2ArDJMqFNZin/ZjCNxTnPqqj4zJkWwAzWWWdOuI4q77
         QwS6OIKg8WM9KxVYOoRrFYO3UWtAwmsxZGgH9ukDRm4mCOroOV4cgUpQumMHR5e2G6t2
         CKuLoBJlZqlvI6TnXNIQ9P3dtycG0bmYXOVo0U0Wt0u05pQk+rS9A3tthI0tPgWU8qWZ
         iJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npYBdm+Z3JK/AAr8Gk9MHyCf99zBDnSXIOh7phMrfJA=;
        b=7BKDKwY8XT/bfoDjZBMGxImesqgUEIai5ngAs5IFk2UFUtHrfBRxcOIZFstOh2WzlN
         LtO20d4W0/WASQ33w8z5XGLLWdiplgXV8bs9NM+ZSuIleNqLdq3ARwiyATJejzwCdJz+
         uzU4PeaPm6D8/WJwLXyL5ispekZSXejCDjJe8PNt5OnNvwdzyvh9mzqiZGtOlNB/DpQi
         lir6v+wp+QuxXTzZq/sEdpa8QEn166+FF91ot8qcFbBv/Dl4kQSnZSJYQVZG5+8UJ6kJ
         zeZtEcg9PdHkxfwl3XySoC7iVF2nM1g3aJ77GiD+W/otI+JvlGXBUTMXlwp6LP8xZ+IU
         oQZA==
X-Gm-Message-State: AOAM533EArcsLC05sNCxrj7JuIQI048nxuDGav1T34TRODmE5PZ+rbOl
        2Ktya1ifdNe68eLkd6M06N4=
X-Google-Smtp-Source: ABdhPJwMamDJlumEP9BSNN49y5AS3ZIgyvSZDNir9lKs5LPCrlE+SWzSAeUCeesO4f2kz1kihUL4qg==
X-Received: by 2002:a17:907:7d89:b0:6f3:ef24:ddd2 with SMTP id oz9-20020a1709077d8900b006f3ef24ddd2mr13166520ejc.550.1652648462001;
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:01:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 10/11] clk: qcom: ipq8074: dont disable gcc_sleep_clk_src
Date:   Sun, 15 May 2022 23:00:47 +0200
Message-Id: <20220515210048.483898-10-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the usb sleep clocks are disabled, clock framework is trying to
disable the sleep clock source also.

However, it seems that it cannot be disabled and trying to do so produces:
[  245.436390] ------------[ cut here ]------------
[  245.441233] gcc_sleep_clk_src status stuck at 'on'
[  245.441254] WARNING: CPU: 2 PID: 223 at clk_branch_wait+0x130/0x140
[  245.450435] Modules linked in: xhci_plat_hcd xhci_hcd dwc3 dwc3_qcom leds_gpio
[  245.456601] CPU: 2 PID: 223 Comm: sh Not tainted 5.18.0-rc4 #215
[  245.463889] Hardware name: Xiaomi AX9000 (DT)
[  245.470050] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  245.474307] pc : clk_branch_wait+0x130/0x140
[  245.481073] lr : clk_branch_wait+0x130/0x140
[  245.485588] sp : ffffffc009f2bad0
[  245.489838] x29: ffffffc009f2bad0 x28: ffffff8003e6c800 x27: 0000000000000000
[  245.493057] x26: 0000000000000000 x25: 0000000000000000 x24: ffffff800226ef20
[  245.500175] x23: ffffffc0089ff550 x22: 0000000000000000 x21: ffffffc008476ad0
[  245.507294] x20: 0000000000000000 x19: ffffffc00965ac70 x18: fffffffffffc51a7
[  245.514413] x17: 68702e3030303837 x16: 3a6d726f6674616c x15: ffffffc089f2b777
[  245.521531] x14: ffffffc0095c9d18 x13: 0000000000000129 x12: 0000000000000129
[  245.528649] x11: 00000000ffffffea x10: ffffffc009621d18 x9 : 0000000000000001
[  245.535767] x8 : 0000000000000001 x7 : 0000000000017fe8 x6 : 0000000000000001
[  245.542885] x5 : ffffff803fdca6d8 x4 : 0000000000000000 x3 : 0000000000000027
[  245.550002] x2 : 0000000000000027 x1 : 0000000000000023 x0 : 0000000000000026
[  245.557122] Call trace:
[  245.564229]  clk_branch_wait+0x130/0x140
[  245.566490]  clk_branch2_disable+0x2c/0x40
[  245.570656]  clk_core_disable+0x60/0xb0
[  245.574561]  clk_core_disable+0x68/0xb0
[  245.578293]  clk_disable+0x30/0x50
[  245.582113]  dwc3_qcom_remove+0x60/0xc0 [dwc3_qcom]
[  245.585588]  platform_remove+0x28/0x60
[  245.590361]  device_remove+0x4c/0x80
[  245.594179]  device_release_driver_internal+0x1dc/0x230
[  245.597914]  device_driver_detach+0x18/0x30
[  245.602861]  unbind_store+0xec/0x110
[  245.607027]  drv_attr_store+0x24/0x40
[  245.610847]  sysfs_kf_write+0x44/0x60
[  245.614405]  kernfs_fop_write_iter+0x128/0x1c0
[  245.618052]  new_sync_write+0xc0/0x130
[  245.622391]  vfs_write+0x1d4/0x2a0
[  245.626123]  ksys_write+0x58/0xe0
[  245.629508]  __arm64_sys_write+0x1c/0x30
[  245.632895]  invoke_syscall.constprop.0+0x5c/0x110
[  245.636890]  do_el0_svc+0xa0/0x150
[  245.641488]  el0_svc+0x18/0x60
[  245.644872]  el0t_64_sync_handler+0xa4/0x130
[  245.647914]  el0t_64_sync+0x174/0x178
[  245.652340] ---[ end trace 0000000000000000 ]---

So, add CLK_IS_CRITICAL flag to the clock so that the kernel won't try
to disable the sleep clock.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 3204d550ff76..42d185fe19c8 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -663,6 +663,7 @@ static struct clk_branch gcc_sleep_clk_src = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
-- 
2.36.1

