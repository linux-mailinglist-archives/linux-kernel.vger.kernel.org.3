Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9574827BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiAAODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 09:03:02 -0500
Received: from fallback14.mail.ru ([94.100.179.44]:41552 "EHLO
        fallback14.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiAAODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 09:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DiWUKuSkGF6p5mizZhXlR2tJ1F0K9PMZt5QJC+2hB6I=;
        t=1641045781;x=1641651181; 
        b=gmh5RLmIBirhY5Qa5//RXrSb1UhcFCs3p2DHxWODSMlQaQmxTZHzoC4trYgsq5w3Hekg/r2g6+1uYRnn1Alb4TlyEVBpm0/1w2wC5ETvp6uQw3oXvGAhmIXmja7VxARBzsoIa3k4mGl0iosF19U/Yu5NJRSRB59k6+a87UqRl/U=;
Received: from [10.161.55.49] (port=40210 helo=smtpng1.i.mail.ru)
        by fallback14.m.smailru.net with esmtp (envelope-from <gtk3@inbox.ru>)
        id 1n3eyK-0001lG-39
        for linux-kernel@vger.kernel.org; Sat, 01 Jan 2022 17:03:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DiWUKuSkGF6p5mizZhXlR2tJ1F0K9PMZt5QJC+2hB6I=;
        t=1641045780;x=1641651180; 
        b=Me+9HNvYeN8+FTwQb776Kbh+2zRV2vMIUlGdJBlGMKhPPQMSsgVbRfZyYZkTc6HgBLBK0xoQ1qntDUB58vtNhQK5mHu+qaWojuRGNkJRTmc0SMFO7oi7a9DyfSojNkV/t/0sWha4ixC+eIeiKd53s/CiZ4v9LSXYDdY01MRKWzVqupHueyb/eUNVM338c8mN6RFDrl/ylLCRKxcsrfdToGvkDqPKjqZgWQ545tekeKakjxuu8D/mFQ3b0noljE4KPDw2QrEOg4ZAOdfuY1b89X0cFjc8caN5yCCe1RdT8ouf8eZKqFPZ5KNHZdXe0jGLBq3yK2FqzUJSHjgJZOVc1g==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <gtk3@inbox.ru>)
        id 1n3eyD-0008TK-VI; Sat, 01 Jan 2022 17:02:54 +0300
From:   Maxim Kutnij <gtk3@inbox.ru>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Maxim Kutnij <gtk3@inbox.ru>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: mediatek: add smp bringup code for MT6582
Date:   Sat,  1 Jan 2022 19:01:36 +0500
Message-Id: <20220101140140.4119-1-gtk3@inbox.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: dda186e0-38e0-4061-f60e-e297441d9fed@gmail.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9059F52CFE4D0B70A3182EAA8D6D52E873A1994A0A58B3679182A05F5380850404C228DA9ACA6FE2770EC1BE4B0A9857E6979F502FE3FB0810B0C6E9BC1DBE2F1CDD3A89687622077
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FEAC828D2BF6EC3CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF58BB58AE3180708638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B23F8FE78000A35E1E6A61D05692D1EF6F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCAE9A1BBD95851C5BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18F04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B670D51CA322917D6D089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C357A67C6196E73BD052C76992E68C5BDF63D558AFC78F3309C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EF15519F706774CB6A699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34F1257DC9690AEBA17DC4691ABE95C32262CB4E95B1B5458B3626551DB270B2E3082DB3A08A46D8311D7E09C32AA3244CC9A9B1F89D90A51834130A1DDE7519F781560E2432555DBB8D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzdjxcBf1eR7IaHzwSrR3VA==
X-Mailru-Sender: 689FA8AB762F739339CABD9B3CA9A7D6877C163FC9F125F2BF1B4592C9EB3CE68F8182784CE3FA142B2697F7A04D759B04FC54F637BA925032C609A2DC06202998FD9B05CC386A12349DB15C680E247222B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B458EAA7E4B0EE0F09C028C005AD0BCC4E3E30073B5499037368F3CF0E9FE49B6998B3DD7178ECBFFC7D936F73A3C51E669E8B0398FC2CA7A659818E1134944E0E
X-7FA49CB5: 0D63561A33F958A5C324D9B9381A94A34E896A30D56601F345D0C3F982A662FACACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637987F95F28AE5935D389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC88ADF99E4698B9BE8F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE72CA115C55BEA7BA6731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C357A67C6196E73BD4D9E77D27E0759BA11930786214ECB289C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzdjxcBf1eR5ytVVKGqdftg==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SMP support on the MediaTek MT6582 quad-core Cortex-A7 SoC.
And also enable GPT6.

Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
---
 arch/arm/mach-mediatek/mediatek.c | 4 +++-
 arch/arm/mach-mediatek/platsmp.c  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index e6e9f93a1..aefeb6614 100644
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
index 16a4ee6c9..e1c7ad52f 100644
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
2.33.1

