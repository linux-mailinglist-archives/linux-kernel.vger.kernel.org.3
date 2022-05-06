Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A189951E120
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444497AbiEFVgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444485AbiEFVgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:36:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D25DBEC;
        Fri,  6 May 2022 14:32:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9E66A1F46F11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651872752;
        bh=Feax7TqOjAak8vTxXHyo5w7ldHLoCzV9bRYJ4gdOnQg=;
        h=From:To:Cc:Subject:Date:From;
        b=g741dTAEheu8gAyBHmVs9pPhsTV8SLjFD/30iAXzEMsv5dlyqXfxA5pU3Os51NBoC
         +76a4ARigQobUXpXAw8ofmdCAZZbTTLRkRx/2J4wi5CG/dzclT+Pz1/JCxJaQt5OcF
         qFTHxF2f4bfgjETuXod5jHS0Fc9yjfN6HbeDFbLO9jCEZq7Dna+FIvBappQJswuCMt
         Gqk+/+5ax1Qh3bjl2SPrWZOF3nX+0rlUmaSxsy0NbKZT6OHvUkrzzEn7+PlTIhHELi
         vPQx1G/8HvFaaIdkVAWuSqh1H+zSrBAsPs+EEnmgu4/lJcV2VE/Q2sClu0k3+Cqn6b
         jAnyejeU3VJmw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 0/2] Mediatek SCP dt-binding tweaks
Date:   Fri,  6 May 2022 17:32:24 -0400
Message-Id: <20220506213226.257859-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


Two simple patches for the Mediatek SCP dt-binding. The first fixes the
reg/reg-names property while the second adds a new optional
memory-region property.

v3: https://lore.kernel.org/all/20220503211114.2656099-1-nfraprado@collabora.com
v2: https://lore.kernel.org/all/20220502192420.2548512-1-nfraprado@collabora.com
v1: https://lore.kernel.org/all/20220429211111.2214119-1-nfraprado@collabora.com

Changes in v4:
- Reworked presence of l1tcm reg to be if:then: based and present only
  on mt8192/mt8195

Changes in v3:
- Made the cfg reg required again. After looking again into the mtk-scp
  driver, only l1tcm is optional.

Changes in v2:
- Dropped type and description from memory-region since it's a
  well-known property
- Set memory-region maxItems to 1

Nícolas F. R. A. Prado (2):
  dt-bindings: remoteproc: mediatek: Make l1tcm reg exclusive to mt819x
  dt-bindings: remoteproc: mediatek: Add optional memory-region to
    mtk,scp

 .../bindings/remoteproc/mtk,scp.yaml          | 72 ++++++++++++++-----
 1 file changed, 53 insertions(+), 19 deletions(-)

-- 
2.36.0

