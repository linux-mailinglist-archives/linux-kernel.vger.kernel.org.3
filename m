Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDB51ED1A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiEHKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiEHKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:53:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F2DEE3;
        Sun,  8 May 2022 03:49:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so21881437ejb.6;
        Sun, 08 May 2022 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUoVtZp3FHNEmRMS9sjznujtKL5i65I6AtU+XnfV9Fs=;
        b=f4GzyYd6HYtRXF6KciFTlPYaA33JK/Q6mfxs4NWdjMCwhB8jaLTYzSnL1IbMO6SnEr
         P2DdfPF+gTY15Ivc2TOYweWtXwtHa5XBaZd9s3o1AgmASjAic7jb7xxTPOlmVMj/YsKv
         ylo2SziN3IxxK5dQVknA4mtsn4hPF6E+isNPWeG3dR9o638Zw3jLXBB54SB0r5k4Gdz5
         P79L3h1nRkkw5/2kvsvA+hqLR80mpH85pzz7fDKrtfFQcDnhOln3Nt9Pf7WdkRgYuLKq
         mOC+Iu0U/jMrLHz9FH/ID/G5BPkgiNxwYvCbnE6gHRKdpYmlKgYArl6SNz+o3SA6aFFI
         okgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUoVtZp3FHNEmRMS9sjznujtKL5i65I6AtU+XnfV9Fs=;
        b=HuW+L1kvSZZQlFVTqg4zGsbO+wweJmJW9qlAHlAgW5JzE7UCKW4ic7LhwdvJTly/2N
         tBY9/gZUn6bdzJPOuNb22CTbFCg49noQ7skJQ99fSyJBnL//Ry+uayykh+SeoF8eehtx
         /Ch6oKktIIoSxnjayJWLlA48JkeUCmJRjatONiyWf/dZTYRm7U3A9J0K8srKrr2ovBwS
         GKCx6FYp29wqHDhilmDC0eZejDKxi6dfNfgef/TyJFKrXCIh9SBjQ8MWvK5EHiso/Dco
         2ymHKF58ZanA5YZCFNPl7+cDiJE9/JtClM0fApkL6+w1stZG5p9L+eUpATmVh4TWkxng
         8+uA==
X-Gm-Message-State: AOAM531y0GoqV1UvGZGyLlf1Urig1m2xEUxMwji1TvgKu400f/QBFnN8
        WfH6vgvspLUZuIaBLUmj1Ug=
X-Google-Smtp-Source: ABdhPJwHrnWeHJyOr3Un9oIgcCMs6FjPWnXqEe+cJ7EImhz7Pv1/aJG3470Sr4FeL2+qcJPvql8s7g==
X-Received: by 2002:a17:906:6bd7:b0:6f4:e6e4:1d41 with SMTP id t23-20020a1709066bd700b006f4e6e41d41mr10567723ejs.770.1652006953108;
        Sun, 08 May 2022 03:49:13 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:12 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 10/11] clk: qcom: ipq8074: dont disable gcc_sleep_clk_src
Date:   Sun,  8 May 2022 12:48:54 +0200
Message-Id: <20220508104855.78804-10-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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
2.36.0

