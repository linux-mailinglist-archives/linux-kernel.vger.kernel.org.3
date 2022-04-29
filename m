Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1829515931
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381870AbiD3AAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381866AbiD2X75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:59:57 -0400
Received: from mail-il1-x163.google.com (mail-il1-x163.google.com [IPv6:2607:f8b0:4864:20::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467C3DDE8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:56:35 -0700 (PDT)
Received: by mail-il1-x163.google.com with SMTP id r17so4946831iln.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:content-transfer-encoding;
        bh=rhWp1AKBOyqcG3QjLO4nWaJXvvyqXsoLu/c9Xuqgxf4=;
        b=RSDgpDWo+RSjrZBYxLZTRVspT/5zgtu8p2xJK3rCMfv0+Sb/NBUAsSfsR0QeNybNuz
         8aO6OnzngGYTgUcsIZiT1FDYkDhLD6bfxM0d/rBsrSMJS9acIoiTNb9sumSIhaWg51eG
         L2Xh2lhwheI96K0DnNTmtkZlYkWABimrrO8MaRKyEpIzfdpefTQVNFeyp2AtHvKg4k6/
         +m/r3aM+on2cUW+MbPTFjLGvZSh5jwQ6XZY0AFfvI2ayfseHyfjBWokJuwpsnvD3+UXA
         nSLSQY6OFGrXEEUTH1ZWF3ETtP4EybmIN//ncQ5ODHJSOuJOxU+sC6JzDPsXeLrJT1VW
         lHMg==
X-Gm-Message-State: AOAM532s9y2lBQWm2q22KkUPZFUYux/YbKxw23XFya/pMNsnWbDm+J1L
        fly76uc3Gm5z3JEHDE/Mc96AOLTavotWZ1Fmpb0CLURVsWrw
X-Google-Smtp-Source: ABdhPJxAayWgz3tZPEUuIHsUOIZfNThDXu/GbVfddf4sHIZaslnH/EGHTdkX1w8JoBMbbmcLLpl59JjhogjM
X-Received: by 2002:a05:6e02:1c45:b0:2cd:95dd:ae1a with SMTP id d5-20020a056e021c4500b002cd95ddae1amr701931ilg.100.1651276595115;
        Fri, 29 Apr 2022 16:56:35 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [54.193.82.35])
        by smtp-relay.gmail.com with ESMTPS id a7-20020a056638164700b0032b3a7363f6sm235056jat.20.2022.04.29.16.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 16:56:35 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.70.41])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 2D1CA3045064;
        Fri, 29 Apr 2022 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1651276594;
        bh=rhWp1AKBOyqcG3QjLO4nWaJXvvyqXsoLu/c9Xuqgxf4=;
        h=From:To:Cc:Subject:Date:From;
        b=o4iJMhSMeeqwukInPgtCBAav5GBwiKBq4YBQxSYpINNXybYE3dNsSH2nBiDWetj5Q
         9huzeLWStt2Yh/qUvoBEvZKegxKs8NzLoFnK0N27kAbq230EJ3QKCoNFR5HL77wCHc
         N7Oy74d3ymAVp8hSsgzY65yTWmK/dVbD3VMLbSpMz1fZPBVjvGN/k909n57ICGqDoq
         ijOYjejoCZ/vTeCkc144dWzX9biyOT4xC2OgnHwwdaxF11EQbjheUibmKZrf85eIyH
         mYflXpTndSTs7Da6KV8zhE8PPMmM3ab+jzTxpRRrfmfIx9a7LcMxKOqfoMIr1MWX0l
         yJsYIxYZXasAg==
Received: from kevmitch by chmeee with local (Exim 4.95)
        (envelope-from <kevmitch@chmeee>)
        id 1nkaTN-0003Sm-TX;
        Fri, 29 Apr 2022 16:56:29 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
Cc:     kevmitch@arista.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Takuma Ueba <t.ueba11@gmail.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] igb: skip phy status check where unavailable
Date:   Fri, 29 Apr 2022 16:55:54 -0700
Message-Id: <20220429235554.13290-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

igb_read_phy_reg() will silently return, leaving phy_data untouched, if
hw->ops.read_reg isn't set. Depending on the uninitialized value of
phy_data, this led to the phy status check either succeeding immediately
or looping continuously for 2 seconds before emitting a noisy err-level
timeout. This message went out to the console even though there was no
actual problem.

Instead, first check if there is read_reg function pointer. If not,
proceed without trying to check the phy status register.

Fixes: b72f3f72005d ("igb: When GbE link up, wait for Remote receiver status condition")
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 34b33b21e0dc..68be2976f539 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5505,7 +5505,8 @@ static void igb_watchdog_task(struct work_struct *work)
 				break;
 			}
 
-			if (adapter->link_speed != SPEED_1000)
+			if (adapter->link_speed != SPEED_1000 ||
+			    !hw->phy.ops.read_reg)
 				goto no_wait;
 
 			/* wait for Remote receiver status OK */
-- 
2.35.1

