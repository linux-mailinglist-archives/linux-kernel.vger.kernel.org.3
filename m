Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22F4A6558
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiBAUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:05:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiBAUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:05:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 00F491F4241A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643745918;
        bh=QlhrY4Za7hJL/D+ZgwoyhK/wE4i1pxFBvtUIYsu/bFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POUDQqM5EaR4vokLGFjoS7vcNVv2OARP1j9sR7u7GvwJCWGMYd8RZFnqJg+IrMx7M
         sJi3D5k39EGaXA7XbKb+bJwvx1loKybmDDnwKN0q/dS7DAxz8FI/w06b2kDVf8myyY
         gq8b04x5AQsl2hbLxGBnkFFApKCmdg5h8T+VcGIBzP+NxTgbmnV1qhzpukjIMKmpLx
         Id2n7msCnpQ0lF3Q6cBWxZq1hD13+DTGiX67u7JDTDgz+CRC5uf2XXNO/iF0Wi+tqe
         SB2m2Yz+Ma3V4CDkfyivjZipT42W1ilS40v7VU/lCmWcG5WsyfUQ4XTFnaaLCgT4wG
         oHu8tY91mSxPQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Adam Ford <aford173@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sameer Pujar <spujar@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: defconfig: Add SC7180 GPUCC and DISPCC as module
Date:   Tue,  1 Feb 2022 15:05:03 -0500
Message-Id: <20220201200504.854917-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201200504.854917-1-nfraprado@collabora.com>
References: <20220201200504.854917-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

SC_DISPCC_7180 and SC_GPUCC_7180 are not boot-critical clock
controller drivers, but these are required in order to get
DPU1/display support (so, to allow probing DRM_MSM) and Adreno
GPU support, which are modules as well.

This is being done as there are SC7180 device trees enabling
support for this hardware, but not being probed due to these
drivers not being built.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: "kernelci.org bot" <bot@kernelci.org>
[rebased and fixed conflicts]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Rebased and fixed conflicts

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 68913a575784..dbdb634a3d4c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1003,7 +1003,9 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SC_DISPCC_7180=m
 CONFIG_SC_GCC_7180=y
+CONFIG_SC_GPUCC_7180=m
 CONFIG_SC_GCC_7280=y
 CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GCC_845=y
-- 
2.35.1

