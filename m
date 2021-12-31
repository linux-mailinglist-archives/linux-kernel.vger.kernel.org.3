Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1548226F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbhLaGRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLaGRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:17:30 -0500
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Dec 2021 22:17:29 PST
Received: from resqmta-a1p-077720.sys.comcast.net (resqmta-a1p-077720.sys.comcast.net [IPv6:2001:558:fd01:2bb4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 22:17:29 -0800 (PST)
Received: from resomta-a1p-077059.sys.comcast.net ([96.103.145.240])
        by resqmta-a1p-077720.sys.comcast.net with ESMTP
        id 3BAPnk5l5IUDU3BBpnFPcc; Fri, 31 Dec 2021 06:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1640931297;
        bh=B8RJ34LocrDqPDwZMnx/NOtlAthCdFGYGjocIeA+vIk=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=FY5av+ONgK5OAVhD1kJvwQbEykaWOUNNcyl5AQk7ie7G/TFU/APNCb8X4Fhe7385s
         R5wwrRfT81BmQ/OPwwJ8WHPYH6u9WinXe2/45VNtTBEZVdKOvhML16sStqIsLC78kx
         S2ubMjZYsT1gCDD3SYFfxwwhyKV59S+Tr/03n92n+V3cSOnKil0gckeUx7rVVGRttW
         UdG6xSFhAr7tt3k8CEcnNc5LhKV/uX1mAWEf9EYr90DyKLLr+/4vDQEoi9mDJbP0bi
         yRUTHRTTlzXrCUvGzanc9Ft0V+va6EdVtrlSWPrLCi4lYeXiu+IMknQRT9UhL3Ou02
         0zODKSYvI+Sjw==
Received: from w6rz.silicon ([IPv6:2601:647:4700:284:9d56:573c:4e75:fa6c])
        by resomta-a1p-077059.sys.comcast.net with ESMTPA
        id 3BBFnSy4GhrTt3BBNnq2cX; Fri, 31 Dec 2021 06:14:32 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Ron Economos <w6rz@comcast.net>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Ron Economos <w6rz@comcast.net>, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sifive unmatched: Add gpio poweroff
Date:   Thu, 30 Dec 2021 22:11:06 -0800
Message-Id: <20211231061110.89403-1-w6rz@comcast.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is required for the following commit to work.

commit f2928e224d85 ("riscv: set default pm_power_off to NULL")

Signed-off-by: Ron Economos <w6rz@comcast.net>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 6bfa1f24d3de..c4ed9efdff03 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -39,6 +39,11 @@ rtcclk: rtcclk {
 		clock-frequency = <RTCCLK_FREQ>;
 		clock-output-names = "rtcclk";
 	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &uart0 {
-- 
2.25.1

