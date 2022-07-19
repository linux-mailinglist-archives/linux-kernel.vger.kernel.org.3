Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F657A699
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiGSShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiGSShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:37:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C04D165;
        Tue, 19 Jul 2022 11:37:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so28881424ejb.4;
        Tue, 19 Jul 2022 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cmI+PQby/2CoTm1Le4E4JzH/gDv5I8DfTHHCjF+E0Yo=;
        b=bnapr9AglL7uJ+mEdePPNRjhQ+56XJg0PqREOWrSGwly5HmTo3Pf8wBgUKwYqlDXHW
         G0xrgAPoC+IUkE+p4NB18uKVhqtIj55YPPQiV+AZaYa+ExFaIttNQIEzXeY34Mc9rqDa
         M2KY6ixz2qOYzyRtUie1UGdONzvPefyYZkcdysBmO/m/Lypo2w6wgsZps5aHqI37MhcL
         c2vjJtPGHhTy5IyDXHBWjNTOYggTJNcAcbVtEOoq55h0dU1VbIB8QBq4xVequAa7PI0z
         51MubYzQIECe2InjtZ+oSxYppZGRJyA1MfqYIcHeW3cR+/USBexggDzau8yvOoa4j/Db
         honQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cmI+PQby/2CoTm1Le4E4JzH/gDv5I8DfTHHCjF+E0Yo=;
        b=wB/kUXVX7RY4s7+eXaUgNBA2peYYMbW0QgiqrveF+w7i8bMO6wASOTtZqJYDTx3PI3
         CCTIVdjcl4fN9j2dJHdOTtdpjN6YT0QRQ+ApTp3tJ55P/qqXbffXonDmVCFu7IGPKcxz
         WcYO5kvtmZ6HgHCsCvQmiHr8j05lT4OwKrI20I73QnV9KkwXZXL+CCEtox21LHNzS7vk
         Pzvzjf6lXGIG3qBYZe1E9a7XjxHQWNy/I+o9VC9MCU0Ls9JxIsi7+C+QYNH05/t+Ft5i
         dQZpPzTaqOqr6KZrFM5jpobsZuLAdCoknepTuR0/ditTpmixYtGrU9U6Nsj3K5aF3h7D
         tQZw==
X-Gm-Message-State: AJIora+9eHwxVqyfiWzRzaWa2BVS28pivkMMLPdHAhb1138JuAEiG3pC
        cDC3sRlsdbr/oo/g9bApWTs=
X-Google-Smtp-Source: AGRyM1v0H52s37VXka8PL070L/fUmtAwwIDJVKfV4hQtsMLDYV0jRrvxrpV+jaX2mNOgVIZz9/o6Zg==
X-Received: by 2002:a17:907:980d:b0:72f:2cf2:9aff with SMTP id ji13-20020a170907980d00b0072f2cf29affmr11494969ejc.165.1658255849567;
        Tue, 19 Jul 2022 11:37:29 -0700 (PDT)
Received: from kista.localdomain (86-58-13-89.dynamic.telemach.net. [86.58.13.89])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7cb4d000000b0043a5004e714sm10830602edt.64.2022.07.19.11.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:37:28 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, andre.przywara@arm.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] clk: sunxi-ng: Fix H6 RTC clock definition
Date:   Tue, 19 Jul 2022 20:37:25 +0200
Message-Id: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While RTC clock was added in H616 ccu_common list, it was not in H6
list. That caused invalid pointer dereference like this:

Unable to handle kernel NULL pointer dereference at virtual address 000000000000020c
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000004d574000
[000000000000020c] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
CPU: 3 PID: 339 Comm: cat Tainted: G    B             5.18.0-rc1+ #1352
Hardware name: Tanix TX6 (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ccu_gate_is_enabled+0x48/0x74
lr : ccu_gate_is_enabled+0x40/0x74
sp : ffff80000c0b76d0
x29: ffff80000c0b76d0 x28: 00000000016e3600 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000002 x24: ffff00000952fe08
x23: ffff800009611400 x22: ffff00000952fe79 x21: 0000000000000000
x20: 0000000000000001 x19: ffff80000aad6f08 x18: 0000000000000000
x17: 2d2d2d2d2d2d2d2d x16: 2d2d2d2d2d2d2d2d x15: 2d2d2d2d2d2d2d2d
x14: 0000000000000000 x13: 00000000f2f2f2f2 x12: ffff700001816e89
x11: 1ffff00001816e88 x10: ffff700001816e88 x9 : dfff800000000000
x8 : ffff80000c0b7447 x7 : 0000000000000001 x6 : ffff700001816e88
x5 : ffff80000c0b7440 x4 : 0000000000000001 x3 : ffff800008935c50
x2 : dfff800000000000 x1 : 0000000000000000 x0 : 000000000000020c
Call trace:
 ccu_gate_is_enabled+0x48/0x74
 clk_core_is_enabled+0x7c/0x1c0
 clk_summary_show_subtree+0x1dc/0x334
 clk_summary_show_subtree+0x250/0x334
 clk_summary_show_subtree+0x250/0x334
 clk_summary_show_subtree+0x250/0x334
 clk_summary_show_subtree+0x250/0x334
 clk_summary_show+0x90/0xdc
 seq_read_iter+0x248/0x6d4
 seq_read+0x17c/0x1fc
 full_proxy_read+0x90/0xf0
 vfs_read+0xdc/0x28c
 ksys_read+0xc8/0x174
 __arm64_sys_read+0x44/0x5c
 invoke_syscall+0x60/0x190
 el0_svc_common.constprop.0+0x7c/0x160
 do_el0_svc+0x38/0xa0
 el0_svc+0x68/0x160
 el0t_64_sync_handler+0x10c/0x140
 el0t_64_sync+0x18c/0x190
Code: d1006260 97e5c981 785e8260 8b0002a0 (b9400000)
---[ end trace 0000000000000000 ]---

Fix that by adding rtc clock to H6 ccu_common list too.

Fixes: 38d321b61bda ("clk: sunxi-ng: h6-r: Add RTC gate clock")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 29a8c710ae06..b7962e5149a5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -138,6 +138,7 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
 	&r_apb2_rsb_clk.common,
 	&r_apb1_ir_clk.common,
 	&r_apb1_w1_clk.common,
+	&r_apb1_rtc_clk.common,
 	&ir_clk.common,
 	&w1_clk.common,
 };
-- 
2.37.1

