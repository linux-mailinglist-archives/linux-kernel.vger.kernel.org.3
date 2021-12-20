Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA65C47A8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhLTLl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLTLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:41:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F88C061574;
        Mon, 20 Dec 2021 03:41:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so9391071wmb.0;
        Mon, 20 Dec 2021 03:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+APpeoKhDxfIDLxqqUhi/yBHXd+T8k6EjYFLlkpSWDE=;
        b=NuDJJ40PYFDBZ6roE7XKqECjMLTT/8j5qgEc07KyyxuXRBbaPjI/BRpnC122yVGL36
         YYlNMJTTN+tMvgQcNvtCsE8ZeSTCo2xVW4Xmf2jJ3o6i5QzzINEUreKNDtHQWr3UDggp
         7W6GfKTS8Q7hiXpWAeialPGQrLosFXGkcAgaLq8UaXZag6ppsYxIU+MIuoHVcGDSR916
         T28zWQixTRAn28fIZ1/hKAQCam9APOJorB/xOnb7UToQjfOmNLY1mov4TPM/kjSsoolx
         0MUZP4VI9zWTZhPIE5z28soKgjqvXpYR+jORCKPtMM5HVr/uNLn2bz9uyQf5Fb3oA9F+
         sc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+APpeoKhDxfIDLxqqUhi/yBHXd+T8k6EjYFLlkpSWDE=;
        b=fiXiogUp3DqZVZNsAnn9aT/V4I+olxP6/cGlYuog8BgvDlI52RRFvM9ynb8m40q5Nl
         moYQDTUfPqUSQxRkq4RzjlUbMoo6e6PRqMLQyoqcDvSfMTFv7aI4O0k+r80L7cQWCYyl
         8JFzykWX248hBu3Grc0165YDr04aGnA/gJNtynzVYf//+3SUvuFzxrrCCdt1ntfVYEnx
         stLZuw2tA6FkqJhw9ftyNzFu7eCJAinSBaudalOUcHSOHvpRAt4fjBtix6NaDz0Xn0/K
         Lyw118IEjjUMf7nHnMXOKCKW9QKv7UGKHkn/OUXDbubqQXATCx/nyB6MDlmoiK5bGITT
         A4rw==
X-Gm-Message-State: AOAM531vutc05rw0ljfNz7dcFiHyVVa1XSzm93nw3RFBog3H73rUadYh
        POYD7MJdMzSkfHwc4wJwL4c=
X-Google-Smtp-Source: ABdhPJziJMBn81RVkYDCPmrm8A8K5lUg88KemQiLIrzcfvHVdMWQtIyvYlpVWSD1ofE8GTew6W6F9w==
X-Received: by 2002:a05:600c:3d06:: with SMTP id bh6mr20540211wmb.40.1640000483863;
        Mon, 20 Dec 2021 03:41:23 -0800 (PST)
Received: from fedora.. (cpezg-94-253-144-135-cbl.xnet.hr. [94.253.144.135])
        by smtp.googlemail.com with ESMTPSA id j32sm16116680wms.40.2021.12.20.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:41:23 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, sivaprak@codeaurora.org,
        speriaka@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2] clk: qcom: ipq8074: fix PCI-E clock oops
Date:   Mon, 20 Dec 2021 12:41:19 +0100
Message-Id: <20211220114119.465247-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix PCI-E clock related kernel oops that are caused by a missing clock
parent.

pcie0_rchng_clk_src has num_parents set to 2 but only one parent is
actually set via parent_hws, it should also have "XO" defined.
This will cause the kernel to panic on a NULL pointer in
clk_core_get_parent_by_index().

So, to fix this utilize clk_parent_data to provide gcc_xo_gpll0 parent
data.
Since there is already an existing static const char * const gcc_xo_gpll0[]
used to provide the same parents via parent_names convert those users to
clk_parent_data as well.

Without this earlycon is needed to even catch the OOPS as it will reset
the board before serial is initialized with the following:

[    0.232279] Unable to handle kernel paging request at virtual address 0000a00000000000
[    0.232322] Mem abort info:
[    0.239094]   ESR = 0x96000004
[    0.241778]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.244908]   SET = 0, FnV = 0
[    0.250377]   EA = 0, S1PTW = 0
[    0.253236]   FSC = 0x04: level 0 translation fault
[    0.256277] Data abort info:
[    0.261141]   ISV = 0, ISS = 0x00000004
[    0.264262]   CM = 0, WnR = 0
[    0.267820] [0000a00000000000] address between user and kernel address ranges
[    0.270954] Internal error: Oops: 96000004 [#1] SMP
[    0.278067] Modules linked in:
[    0.282751] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.15.10 #0
[    0.285882] Hardware name: Xiaomi AX3600 (DT)
[    0.292043] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.296299] pc : clk_core_get_parent_by_index+0x68/0xec
[    0.303067] lr : __clk_register+0x1d8/0x820
[    0.308273] sp : ffffffc01111b7d0
[    0.312438] x29: ffffffc01111b7d0 x28: 0000000000000000 x27: 0000000000000040
[    0.315919] x26: 0000000000000002 x25: 0000000000000000 x24: ffffff8000308800
[    0.323037] x23: ffffff8000308850 x22: ffffff8000308880 x21: ffffff8000308828
[    0.330155] x20: 0000000000000028 x19: ffffff8000309700 x18: 0000000000000020
[    0.337272] x17: 000000005cc86990 x16: 0000000000000004 x15: ffffff80001d9d0a
[    0.344391] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000006
[    0.351508] x11: 0000000000000003 x10: 0101010101010101 x9 : 0000000000000000
[    0.358626] x8 : 7f7f7f7f7f7f7f7f x7 : 6468626f5e626266 x6 : 17000a3a403c1b06
[    0.365744] x5 : 061b3c403a0a0017 x4 : 0000000000000000 x3 : 0000000000000001
[    0.372863] x2 : 0000a00000000000 x1 : 0000000000000001 x0 : ffffff8000309700
[    0.379982] Call trace:
[    0.387091]  clk_core_get_parent_by_index+0x68/0xec
[    0.389351]  __clk_register+0x1d8/0x820
[    0.394210]  devm_clk_hw_register+0x5c/0xe0
[    0.398030]  devm_clk_register_regmap+0x44/0x8c
[    0.402198]  qcom_cc_really_probe+0x17c/0x1d0
[    0.406711]  qcom_cc_probe+0x34/0x44
[    0.411224]  gcc_ipq8074_probe+0x18/0x30
[    0.414869]  platform_probe+0x68/0xe0
[    0.418776]  really_probe.part.0+0x9c/0x30c
[    0.422336]  __driver_probe_device+0x98/0x144
[    0.426329]  driver_probe_device+0x44/0x11c
[    0.430842]  __device_attach_driver+0xb4/0x120
[    0.434836]  bus_for_each_drv+0x68/0xb0
[    0.439349]  __device_attach+0xb0/0x170
[    0.443081]  device_initial_probe+0x14/0x20
[    0.446901]  bus_probe_device+0x9c/0xa4
[    0.451067]  device_add+0x35c/0x834
[    0.454886]  of_device_add+0x54/0x64
[    0.458360]  of_platform_device_create_pdata+0xc0/0x100
[    0.462181]  of_platform_bus_create+0x114/0x370
[    0.467128]  of_platform_bus_create+0x15c/0x370
[    0.471641]  of_platform_populate+0x50/0xcc
[    0.476155]  of_platform_default_populate_init+0xa8/0xc8
[    0.480324]  do_one_initcall+0x50/0x1b0
[    0.485877]  kernel_init_freeable+0x234/0x29c
[    0.489436]  kernel_init+0x24/0x120
[    0.493948]  ret_from_fork+0x10/0x20
[    0.497253] Code: d50323bf d65f03c0 f94002a2 b4000302 (f9400042)
[    0.501079] ---[ end trace 4ca7e1129da2abce ]---

Fixes: f0cfcf1a ("clk: qcom: ipq8074: Add missing clocks for pcie")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Use clk_parent_data
* Convert other clocks utilizing the same parents to clk_parent_data
---
 drivers/clk/qcom/gcc-ipq8074.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 108fe27bee10..b09d99343e09 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -60,11 +60,6 @@ static const struct parent_map gcc_xo_gpll0_gpll0_out_main_div2_map[] = {
 	{ P_GPLL0_DIV2, 4 },
 };
 
-static const char * const gcc_xo_gpll0[] = {
-	"xo",
-	"gpll0",
-};
-
 static const struct parent_map gcc_xo_gpll0_map[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0, 1 },
@@ -956,6 +951,11 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
 	},
 };
 
+static const struct clk_parent_data gcc_xo_gpll0[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &gpll0.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_pcie_axi_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(200000000, P_GPLL0, 4, 0, 0),
@@ -969,7 +969,7 @@ static struct clk_rcg2 pcie0_axi_clk_src = {
 	.parent_map = gcc_xo_gpll0_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pcie0_axi_clk_src",
-		.parent_names = gcc_xo_gpll0,
+		.parent_data = gcc_xo_gpll0,
 		.num_parents = 2,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1016,7 +1016,7 @@ static struct clk_rcg2 pcie1_axi_clk_src = {
 	.parent_map = gcc_xo_gpll0_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pcie1_axi_clk_src",
-		.parent_names = gcc_xo_gpll0,
+		.parent_data = gcc_xo_gpll0,
 		.num_parents = 2,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1330,7 +1330,7 @@ static struct clk_rcg2 nss_ce_clk_src = {
 	.parent_map = gcc_xo_gpll0_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "nss_ce_clk_src",
-		.parent_names = gcc_xo_gpll0,
+		.parent_data = gcc_xo_gpll0,
 		.num_parents = 2,
 		.ops = &clk_rcg2_ops,
 	},
@@ -4329,8 +4329,7 @@ static struct clk_rcg2 pcie0_rchng_clk_src = {
 	.parent_map = gcc_xo_gpll0_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pcie0_rchng_clk_src",
-		.parent_hws = (const struct clk_hw *[]) {
-				&gpll0.clkr.hw },
+		.parent_data = gcc_xo_gpll0,
 		.num_parents = 2,
 		.ops = &clk_rcg2_ops,
 	},
-- 
2.33.1

