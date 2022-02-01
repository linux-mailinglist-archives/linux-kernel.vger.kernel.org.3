Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4C4A6557
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiBAUFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:05:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiBAUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:05:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id ADEA21F4240F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643745916;
        bh=AyfVJQW9DRmB9ufTRdq5z/1frnMUP3lGd87YN4EEpQY=;
        h=From:To:Cc:Subject:Date:From;
        b=M10Rvuv64xK1qFIqe1D8fYjcnSutzi9kMLIIyvjll67CdNBwxmHKkA3pDI9X3E7d0
         fq4lad8vkOatQs+uR4xArJXL75CUWPsL9bTxDNLQ8/tJH8MkXsiB8vYxvGkRgR4BS6
         qAN5oGh4CfLi7+i6XNNq3tpdq5XSS1wRmPl2ULxrEUM0VCPEl0nXMk2YF9Du8TwghU
         EfzvxAnIOdjhF3F5Oobf3krmzfQ7y4ghKvvwoxXpta6ngwOYiF1jb4S6SJkzuD78a5
         ZapVaSSV2lfJqKyisk6RpiL2Vp9fGJ8ED/aujdL82Jwzy8feao7oLynbLgPK6gyTV4
         ggu9rSkPatTNg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Adam Ford <aford173@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sameer Pujar <spujar@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: defconfig: Enable multimedia clocks on SC7180
Date:   Tue,  1 Feb 2022 15:05:02 -0500
Message-Id: <20220201200504.854917-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device trees for SC7180 Trogdor machines are enabling DPU1 and Venus, but
these are never getting up due to missing clock drivers; after a test, it
was discovered that both of them are fairly ok, except for the Venus
encoder, which doesn't seem to work fine, but it's anyway not introducing
any unstability (the device won't crash), so there is no reason to keep
them out of the game.

Since both of these clock drivers aren't boot-critical and can be inserted
later, it's proposed to enable them as module: this will avoid increasing
the kernel image size, which is especially important to keep lower loading
times (from the bootloader).

v1: https://lore.kernel.org/lkml/20211013105613.250450-1-angelogioacchino.delregno@collabora.com/

Changes in v2:
- Rebased and fixed conflicts

AngeloGioacchino Del Regno (2):
  arm64: defconfig: Add SC7180 GPUCC and DISPCC as module
  arm64: defconfig: Add SC7180 VIDEOCC as module

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.35.1

