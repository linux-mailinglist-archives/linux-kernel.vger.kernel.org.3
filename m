Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90A47D713
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbhLVSoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:44:07 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:44186 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344859AbhLVSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x09xcYis5r8NviIr0QhdgLWx6YJAJf8SoqsFoFuULR4=; b=Nn0W0ADty1g9GV97plIyhHc0UJ
        Z0LhJTtPQrXZod9cEdFj1ROxNwCY+r70X2t1EQS/1Nnuugdo3Tb0xBUOfhgzybo1KMKU1unfwLHOg
        VG5YRbdm/t89YUTmIRgJo+flfmASpVCnuBUhSuNtXGLGOoKAULCdjjT8A0LOGp+BxDE0oJp0VBUwx
        wb/LUrtDxRODmv6F/6N/kD3KyzErwSWNuOYJpf/UhAOMavAt4IemcGpetWbY4y35CfOTl+ObM1IRl
        dINNbXSbVeaMsEG0A/UJf4lqLWN/BP09fxHDkRg3GJq4xgC6um+MSaqKR07oVfUYEofeY8RcLVQbK
        ApuGmD9A==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:44088 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1n06ak-000CmX-Jc; Wed, 22 Dec 2021 18:44:00 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH v2 4/5] Add Parity Calculation to formatted write
Date:   Wed, 22 Dec 2021 18:43:39 +0000
Message-Id: <20211222184340.1907240-5-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
References: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

Altered formated write to set parity bit according to parity_write_mask

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0761c854ae3b..177f2010a490 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1972,6 +1972,10 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
 					      map->write_flag_mask);
 
+	regmap_set_work_buf_parity_mask(map, map->format.reg_bytes,
+						map->parity_write_mask, map->write_flag_mask, reg,
+						&val, sizeof(val));
+
 	trace_regmap_hw_write_start(map, reg, 1);
 
 	ret = map->bus->write(map->bus_context, map->work_buf,
-- 
2.25.1

