Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03B47B378
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhLTTIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:08:55 -0500
Received: from aposti.net ([89.234.176.197]:34338 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240694AbhLTTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:08:52 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] mmc: ingenic: Support bi-directional DMA channel
Date:   Mon, 20 Dec 2021 19:08:38 +0000
Message-Id: <20211220190840.108061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

This patchset adds support for using a single DMA channel for both RX
and TX operations, instead of using separate DMA channels for each
operation.

As some older Ingenic SoCs offer only a handful of DMA channels,
supporting bi-directional channels allow more hardware to use the
channels that would otherwise be used for the MMC/SD operation.

Note that the Device Tree binding for the DMA controller has been
updated in a (already merged) patchset, so that it accepts a 3 cells
(#dma-cells == 3) instead of just 2. It was merged in the DMA tree, so I
am not sure the autobuilders will like this YAML - but it was checked
without errors.

I also removed the descriptions of the "dmas" property in the YAML, as
they really weren't adding anything and were getting in my way.

There are patches touching the driver file merged in the PM tree (the
ones that use the new PM macros) but I expect no problem here, they
touch different parts of the file.

Cheers,
-Paul

Paul Cercueil (2):
  dt-bindings: mmc: ingenic: Support using bi-directional DMA channel
  mmc: jz4740: Support using a bi-directional DMA channel

 .../devicetree/bindings/mmc/ingenic,mmc.yaml  | 37 ++++++++++++++++---
 drivers/mmc/host/jz4740_mmc.c                 | 19 +++++++++-
 2 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.34.1

