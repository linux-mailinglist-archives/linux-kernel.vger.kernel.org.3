Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14D4A4D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381015AbiAaRcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:32:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35134 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380421AbiAaRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:32:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 3461C1F42B0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643650371;
        bh=3keo3SN6yo4gkfUH+WWtNNksuWRneNUjZEsX1PVRq5w=;
        h=From:To:Cc:Subject:Date:From;
        b=kFNyWG8gg19RTkgyHYko3sGmA4yvP+8fVbEBBQfikYMt6B8uTKaqcnm2rwC52T2QM
         ljrVF87tji1LoXYEuJ8VpFZZzMYeVH1rM9ocufPfqknVIS9LA6eH6aCWsos+ZzfOw4
         ZspSfh6MkuJ5OtdltOjEY0lLOy6F3XniH0l3zU/t7pUAVDdWfvUcpRwSEQt7OiV+1d
         moK4UHEOVtM5BmUwFP5bz5TUw2SIPLHGFeDqkGgUWbkXkW04/3XMuUFe02ePbPZF9P
         ORdZdSLk1u32ngOzGSus7+TWOQ1uP30XaS6eKWWldtsVwMyeCANwv3oKVxnDdWzmJ3
         JFxSmQc+/ZnYw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Adam Ford <aford173@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Fabio Estevam <festevam@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com,
        agx@sigxcpu.org, nm@ti.com, andrey.zhizhikin@leica-geosystems.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH v2] arm64: defconfig: Enable SC7180 interconnect driver
Date:   Mon, 31 Jan 2022 12:32:23 -0500
Message-Id: <20220131173223.567303-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On SC7180 device trees, almost all of the nodes are declaring
interconnect properties, including the QUP nodes: at least on
some machines, leaving this configuration option disabled, or
as a module, the kernel appears to hang while initializing the
QUP node containing the UART device.

To solve this issue, enable the interconnect driver for this
SoC as built-in.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: "kernelci.org bot" <bot@kernelci.org>
Acked-by: Georgi Djakov <djakov@kernel.org>
[rebased on top of mainline]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Just rebased and fixed conflicts

v1: https://lore.kernel.org/lkml/20211011154003.904355-1-angelogioacchino.delregno@collabora.com/T/#u

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..68913a575784 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1191,6 +1191,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
+CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
-- 
2.35.1

