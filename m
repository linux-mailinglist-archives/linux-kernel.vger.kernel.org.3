Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2B5119D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiD0N0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiD0N0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:26:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF7286E0;
        Wed, 27 Apr 2022 06:23:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7CFA81F4470F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651065815;
        bh=EqjX82GXjqOFhq0gUXw4CciC7Vh5NdYSqj0fE42uX6o=;
        h=From:To:Cc:Subject:Date:From;
        b=bSxZLmiNzzvmXvS/G0LxIU/onl0isc+fFq4malUf2KNMqo23k4kNwVDTtuflJ/w4J
         HarckUhk1BL8we8qLtMgp3haKnf/itziBU9PrNASD+/GJXpm6aLc3D57RJhXzb9Riy
         l37/ujoD9a9pdwCCC0APr4XvDovBW8AS2b5t4H+Fxv7sEZou6YXG+oX7qPTrAMKnA4
         3aWqVdivsu4IRy/5xbiGPti8eMVdRII8HAUoCjwfOWrVCQV4keFlrXQBnxJcEObmne
         Xft18vwjFIOwH3yjSNJ8DUvD1zgCney2xR9Msf+rhkaBmnlRcciKHFsLVAtaackZHb
         VJryDVrVaoGxg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MediaTek 8250 UART: fixes and improvements
Date:   Wed, 27 Apr 2022 15:23:25 +0200
Message-Id: <20220427132328.228297-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the UART IP on MTK platforms is 16550A compatible, some
registers are not at a "standard" offset. In order to allow full
functionality of the flow control features and to make Linux able
to fully and properly reconfigure the UART IP, eventually allowing
communication at high speed after a full IP reset, some register
offset fixes have been done.
While at it, even though this bit is always set, also paranoidly
make sure that the "new register map" feature is enabled, as that's
done with just one writel() at probe time, introducing no overhead.

This has been tested on multiple Chromebooks featuring different
SoCs, and a MT6795 Xperia M5 smartphone.

AngeloGioacchino Del Regno (3):
  serial: 8250_mtk: Fix UART_EFR register address
  serial: 8250_mtk: Make sure to select the right FEATURE_SEL
  serial: 8250_mtk: Fix register address for XON/XOFF character

 drivers/tty/serial/8250/8250_mtk.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.35.1

