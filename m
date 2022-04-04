Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE334F113A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDDIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiDDIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B6E3B556;
        Mon,  4 Apr 2022 01:47:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8BFF21F452D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649062057;
        bh=3UIISyiLSZ8K6gmvRQuDQuLFelVg3UGlVkHow3UoeQk=;
        h=From:To:Cc:Subject:Date:From;
        b=enBFx/JaBuPKXI7wDee99Ze+TGz2rPTKEAqnfVK5YW9Zi9XhnCBSEYnkDF5CVemF9
         1a+5Rt5gu5Aza2sXAaF0gQ5nU+fqqs0pcMePAsEd4qTfW8XOuvgn8beZcmt1khZnSg
         xaa5cQMaipAwpb6HoZcjuXMTZt+qy4D+sHgfyO7o3dj7VnmNn6Jyrq7iMmOvibxlyH
         ExGoDVfK7pok3sg0nCVDLYWMkTO84V7UdOa1eAYNo6WRd0A+AlydrB0OToA92FaODT
         pTU6GaGMPJxSdm5tfmV07hEENI8i+IIikNjvkz1SOoWA9JQ8yc0nfV9yciCuIjYkz+
         ATw86AmN4sSyQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com, krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/2] Allow syscon to use spinlocks with regmap fast_io
Date:   Mon,  4 Apr 2022 10:47:30 +0200
Message-Id: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for enabling the regmap's fast_io configuration
option for SoCs featuring very fast MMIO operations, for which mutexes
are introducing a lot of overhead / latency.

This has been tested locally on some MediaTek Chromebooks (but, of course,
that requires devicetree patches that are not included in this series).

Changes in v2:
- Reworded dt-bindings fast-io description to remove references
  to regmap, making it generic, as per Krzysztof's suggestion.

AngeloGioacchino Del Regno (2):
  mfd: syscon: Allow using spinlocks with regmap fast_io
  dt-bindings: mfd: syscon: Add support for regmap fast-io

 Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
 drivers/mfd/syscon.c                              |  4 ++++
 2 files changed, 19 insertions(+)

-- 
2.35.1

