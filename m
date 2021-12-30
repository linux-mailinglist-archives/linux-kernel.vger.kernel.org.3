Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC1481C37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbhL3MwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:52:08 -0500
Received: from fallback15.mail.ru ([94.100.179.50]:51494 "EHLO
        fallback15.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbhL3MwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Mr3OPbGfdZv2acimE3GKBnV6ABp9DngLyItpAMsR1EM=;
        t=1640868727;x=1641474127; 
        b=STJCy7oef57pqRaWGe75Qpliy8gAl9D+b6Q6cMTyOO2tyL/x0zXJwl6I6p3pFW9n2UZB74O2MS92HMfpfLJnNpWG8I8wgGNI2CBnG1ootZzg38dYOgc7kFHRySBuJEziFH4VHToB5bT7pPEsfpEvY/Tho6wAlzAUfHFK6N9kYwk=;
Received: from [10.161.100.15] (port=33038 helo=smtpng3.i.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <gtk3@inbox.ru>)
        id 1n2uub-0002zu-6b
        for linux-kernel@vger.kernel.org; Thu, 30 Dec 2021 15:52:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Mr3OPbGfdZv2acimE3GKBnV6ABp9DngLyItpAMsR1EM=;
        t=1640868725;x=1641474125; 
        b=nDPVBAfMzhrc3JveVXg9UpEMYLdgEa7DJgteDUlNvisliDMlRZyIH2qakXXbRUioC7kl+2GzTap0h2EAldP25t60M7cRXHJxPatV27NKE3q6uxQqEJuTnwjcegGzkNqAP/qKsCTcOv8C/vOEfPzFq/HfdrHzpdu2TZ0sdJxNL/8xfPngD8LTCiHrr2OyNY1gGQOtNzJYCCMQxZrl/i3M8vu5peKhL4qBJIVRtkFyN5gYL5RAsUdHMiopJ6iBLYeURuic27M3rFRGqmZvK1E/UhtM8mZdGbljP2Ltvv1rrI4LswIr/zuJ6VumU0pKF0zWbS0VEiytdP8owUarH1wmNQ==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <gtk3@inbox.ru>)
        id 1n2uuS-0001Tn-EK; Thu, 30 Dec 2021 15:51:56 +0300
From:   Maxim Kutnij <gtk3@inbox.ru>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Maxim Kutnij <gtk3@inbox.ru>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: mediatek: add smp bringup code for MT6582
Date:   Thu, 30 Dec 2021 20:51:50 +0500
Message-Id: <20211230155152.48715-1-gtk3@inbox.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A67C325213A5E2C0E449CAC477A2A6F0E15182A05F538085040D44ECFBC32F42193FB61FBFD3B931568476AF814F00C598CF5EC25122E9958EF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AD2F2D6F6013FF7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE77C1346FE4B18DC51EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BEBC5CAB6D411FFA6A698B691B9FCA0A4BAC9B3D349B4D65E20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493B89ED3C7A628178125A4AB119743A3B3C4224003CC83647689D4C264860C145E
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C98DCDA00E0158592B3D8AC402627D226E8F6AC43113E6A989C2B6934AE262D3EE7EAB7254005DCED179A508CD82A26DD1E0A4E2319210D9B64D260DF9561598F01A9E91200F654B069F8FEF10F1C2C2993EDB24507CE13387DFF0A840B692CF8
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D340A58BF0C7EAC340FAA0F38CA127064085198DA8F6EC469BD3EE52C4A9FB55682F99958E839884D7F1D7E09C32AA3244C2187BB0E0678AD2A76948ABE2D29758655E75C8D0ED9F6EE8D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1qmHCAeuKqOjkqr2/CpP9A==
X-Mailru-Sender: 689FA8AB762F739339CABD9B3CA9A7D6AF8F064E25D51A3A2A58C97B59C27E9F8F8182784CE3FA142B2697F7A04D759B04FC54F637BA925032C609A2DC06202998FD9B05CC386A12349DB15C680E247222B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B458EAA7E4B0EE0F091F699F171BAE8DC5C4CB748AE0B6147568F3CF0E9FE49B69F7F4223F437ECD802F90BEEDBDD38C63B9CA2E9B4F4A49948E179B1FF3A7EDCE
X-7FA49CB5: 0D63561A33F958A5DF5865EFD90953628A1DC8D8DB70230EDCCD59224EA3BDE3CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637987F95F28AE5935D389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC88ADF99E4698B9BE8F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE70740AD75FEDF3C08731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C98DCDA00E0158592E889EF9C3A881A9CAEF6B1BC15EC81FC9C2B6934AE262D3EE7EAB7254005DCED179A508CD82A26DD699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1qmHCAeuKqNBwWmzl2bMUQ==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support SMP on MediaTek MT6582 Cortex-A7 quad core SoC.

Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
---
 arch/arm/mach-mediatek/mediatek.c | 4 +++-
 arch/arm/mach-mediatek/platsmp.c  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index e6e9f93a1f0..aefeb661405 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -20,7 +20,8 @@ static void __init mediatek_timer_init(void)
 {
 	void __iomem *gpt_base;
 
-	if (of_machine_is_compatible("mediatek,mt6589") ||
+	if (of_machine_is_compatible("mediatek,mt6582") ||
+	    of_machine_is_compatible("mediatek,mt6589") ||
 	    of_machine_is_compatible("mediatek,mt7623") ||
 	    of_machine_is_compatible("mediatek,mt8135") ||
 	    of_machine_is_compatible("mediatek,mt8127")) {
@@ -38,6 +39,7 @@ static void __init mediatek_timer_init(void)
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt2701",
+	"mediatek,mt6582",
 	"mediatek,mt6589",
 	"mediatek,mt6592",
 	"mediatek,mt7623",
diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 16a4ee6c959..e1c7ad52f77 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -49,6 +49,7 @@ static const struct of_device_id mtk_tz_smp_boot_infos[] __initconst = {
 };
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
+	{ .compatible   = "mediatek,mt6582", .data = &mtk_mt7623_boot },
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
 	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
 	{ .compatible   = "mediatek,mt7629", .data = &mtk_mt7623_boot },
-- 
2.34.1

