Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DD5280F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiEPJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiEPJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:42:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E18F31DFE;
        Mon, 16 May 2022 02:42:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A064D1F427AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652694148;
        bh=c1ydz49i6C3IsJ96xkSmOp1z24weTIOHYM24+DkxGaU=;
        h=From:To:Cc:Subject:Date:From;
        b=THpfRNpOqui6zvR+BYZmkkqsaw+HmfKIjK2d64FkVNdSUzpMVw63wqDSxFaC+OJra
         klxciMwyLwKGQ4fYzMgWlLs/e/phiHKepxmPw+Elh00bIY1U7h60uFRN5nEaFEKCKy
         X1FDAuQFO0dpAcvPvPWP8pyeQXh7DVhjKS+l4u1VTp8GVVapxyvaqCqHM5GcUz3hy2
         OedzLWz2OHGtO2y8v6DXA4aknaD9TTWVfSQyCfqr2yeAoIFlGOKXmjIw1WnnXaogWL
         mCiqn5t/s6uWtQJOJRJmwau05eDgz65PUZ5edK+EWtHuam5cIeHsXk0zvEoyEk4ZPC
         EQ1N10/H/fP4w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/3] leds-mt6323: Make driver flexible and cleanups
Date:   Mon, 16 May 2022 11:42:19 +0200
Message-Id: <20220516094222.30414-1-angelogioacchino.delregno@collabora.com>
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

MT6323 is not the only PMIC that has a LEDs controller IP and it was
found that the others do have a compatible register layout, except
for some register offsets.
The logic contained in this driver can be totally reused for other
PMICs as well, so I can't see any reason to keep this specific to
the MT6323 part.

This series brings meaningful platform data to this driver, giving
it flexibility and making it possible and straightforward to add
support for other (older, or newer!) PMICs.

AngeloGioacchino Del Regno (3):
  leds: leds-mt6323: Specify registers and specs in platform data
  leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
  leds: leds-mt6323: Drop MT6323_ prefix from macros and defines

 drivers/leds/leds-mt6323.c | 258 ++++++++++++++++++++++++-------------
 1 file changed, 166 insertions(+), 92 deletions(-)

-- 
2.35.1

