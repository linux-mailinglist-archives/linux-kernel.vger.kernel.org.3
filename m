Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710854EEE81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbiDANxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiDANw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:52:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A871C60F9;
        Fri,  1 Apr 2022 06:51:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C7F6E1F41ACC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648821063;
        bh=sQBT1nOGAS5f3qWyG27bCf0tVzLDuIZ4Dbng+BOtF9c=;
        h=From:To:Cc:Subject:Date:From;
        b=MI3Oc71fKUUdQd+OT25LDfxtxevGSQwW/GJsgMRt7sulhGBXWFUvVKph0aP1ZLdCi
         mQtsqnkHbpEEneizGW+JPkwYF5RHGebPPpDifolJ3BVgZwLFtqKc0ct6bnBRqN4Nm3
         z5xEgpmwyL+iU/RX3ULFqpgxeRaXGnD7SjdYM3KrAsLzpQy8ocj/H+u/ZP2Cgrqu5P
         36Xzw48F4+ayx+E03cJhJsVpnZFALeCxiUKKKL20nY8qI2kA359BZQdTWsctaQs8ql
         WIMdfdOTK4GtYyFjgC8nxNLn0NRLj472tWwa8FNOtGlQIUspcEpWPwO00ZWHy+3EnA
         StA2faYBr++WQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] Allow syscon to use spinlocks with regmap fast_io
Date:   Fri,  1 Apr 2022 15:50:46 +0200
Message-Id: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (2):
  mfd: syscon: Allow using spinlocks with regmap fast_io
  dt-bindings: mfd: syscon: Add support for regmap fast-io

 Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
 drivers/mfd/syscon.c                              |  4 ++++
 2 files changed, 19 insertions(+)

-- 
2.35.1

