Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E5523E14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbiEKTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347327AbiEKTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:54:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFE9C2FC;
        Wed, 11 May 2022 12:54:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id F06951F42CF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652298897;
        bh=mb8FI9cn+BTWOJjO46oabe4cMLSOl4wn8hXjvFvCuoc=;
        h=From:To:Cc:Subject:Date:From;
        b=dpQiAjZI6Jhhxfs09HDMi10UTpbhdgj5qfUkzPgXjjmC7MFCoRAkXh2kPf8Zj/b6n
         a31L8+kgqyxzLRD2bCYy1OcJv7Xh50hv++mdnTyw+xaxVCcjwvSq37pBLJhzNuJ7zp
         k8XTHxEU/cPaEhoMXKQTkDl+FkDPjVMgyCBA5HJLq2VQr2UlfS/pmTkE6U1Q/t0XdC
         rvdJV/8mEr7YgwsBJDPdQE+Lbaj+wFTdrOWFrfm7YiVivvmtDv/wgAnfiDQ7lg0pwF
         thV44tjSbn8ZL6xGxPObQWwaig4gYkbUK5SwTP2Xs9pWcvs5UWS9lG4KSYBN2rLw73
         9IwJ0Y27HprkA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v5 0/2] Mediatek SCP dt-binding tweaks
Date:   Wed, 11 May 2022 15:54:50 -0400
Message-Id: <20220511195452.871897-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Two simple patches for the Mediatek SCP dt-binding. The first fixes the
reg/reg-names property while the second adds a new optional
memory-region property.

v4: https://lore.kernel.org/all/20220506213226.257859-1-nfraprado@collabora.com
v3: https://lore.kernel.org/all/20220503211114.2656099-1-nfraprado@collabora.com
v2: https://lore.kernel.org/all/20220502192420.2548512-1-nfraprado@collabora.com
v1: https://lore.kernel.org/all/20220429211111.2214119-1-nfraprado@collabora.com

Changes in v5:
- Made l1tcm optional for mt8192/mt8195
- Greatly simplified the constraints override in the if:then:

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

 .../bindings/remoteproc/mtk,scp.yaml          | 47 +++++++++++++------
 1 file changed, 33 insertions(+), 14 deletions(-)

-- 
2.36.1

