Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE64843C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiADOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiADOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:52:16 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC326C061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:52:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j18so76688520wrd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5F5o/W7ZL/b1Y2B+J1/KTZflK9h/hPBJOs37w3Di6g=;
        b=zPD5vIuKCKdKaLTTKckD9IWWMkuUeYnbMgNmmRBvn1IJgu29N/ZD5Pi9vm1KIa4qNz
         yxC9ZDMJ9cby6FO/633RPnTCCBrC7+G092PSd3RyRGMo5rrFvoVbds/g6ma1mmFopyS4
         WKabuz5+MM6olk/wbAQ3Sxl7gVcGHmuS9Ui1P1JhZq9M1EL8LHga5N7kDt/60Z2SfRni
         vErkJol/taJzJ6GzzmITY5fT0jNMr5T22GT8/3oaXm7h97A3q609HqTwp/gUDyjGFlDh
         DqYO+7xUA8L6XnW6s5HFm6LqEX/J+TDGyI/xMUPVwLnxTUbdAH4dyRPA4N8sWB5xGoEL
         qd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5F5o/W7ZL/b1Y2B+J1/KTZflK9h/hPBJOs37w3Di6g=;
        b=tAGaxmbF+/w4PMz2SJEpx+dnVakhpkAEmdrOI14kse4o6D5QvRa1xnNul/i2UwS6YH
         7bhjxHcATcecnhrZ6L5ZA8wpfWWQUFqyf7mmjtq9kZMYf+2/alaiQFieoqtpnUrrBHf8
         FnzEaKdy+pKFw+C+6u5FVRGq1FsUh71Ie1AUOqnj/jMR7jgILiOIvq+UlWpyXkRc+HKW
         privIqjaEC+V5a8c4fVMksr+JKbakSonZ9PWXqPFcnSJ9E/PO8tN6d/+Okj/Qz9N7T+Y
         Ou3V8L1lCtjdKGDw95kGf+PcB32vuTAb9zwlDCRN10HCCuMOSIjoz5PFu/7b61Hm3Yqv
         xiSA==
X-Gm-Message-State: AOAM532aK3ne6xyRSoRTcmemxclbvLxDIkT9SqbkPaf9YKOLz9B7YBpd
        wAgoT12VeHyrpxiIifp+GXv66A==
X-Google-Smtp-Source: ABdhPJw/715o7C1vxbbnWVHhEuOXt9DGLA4fqF9EXUXPePaBDOq2rGd+7F+ilaJHSgrNr911QzGXaQ==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr43444018wrn.378.1641307934167;
        Tue, 04 Jan 2022 06:52:14 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id s8sm44631911wra.9.2022.01.04.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:52:13 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org
Cc:     linux-oxnas@groups.io, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] dmaengine: Add support Oxford Semiconductor OXNAS DMA Engine
Date:   Tue,  4 Jan 2022 15:52:02 +0100
Message-Id: <20220104145206.135524-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adds support for the DMA engine found in Oxford Semiconductor SoCs,
notably in the OX810SE where it's heavily used for SATA transfers.

The driver was on my pipe since 2016 and a courageous person managed to get
the SATA driver work up mainline kernel with this driver, so I cleaned it up
in order to be upstreamed.

I plan to push the last patch through arm-soc when bindings is applied.

Neil Armstrong (4):
  dt-bindings: dma: Add bindings for ox810se dma engine
  dmaengine: Add Oxford Semiconductor OXNAS DMA Controller
  MAINTAINERS: add OX810SE DMA driver files under Oxnas entry
  ARM: dts: ox810se: Add DMA Support

 .../bindings/dma/oxsemi,ox810se-dma.yaml      |   97 ++
 MAINTAINERS                                   |    2 +
 arch/arm/boot/dts/ox810se-wd-mbwe.dts         |    4 +
 arch/arm/boot/dts/ox810se.dtsi                |   21 +
 drivers/dma/Kconfig                           |    8 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/oxnas_adma.c                      | 1045 +++++++++++++++++
 7 files changed, 1178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/oxsemi,ox810se-dma.yaml
 create mode 100644 drivers/dma/oxnas_adma.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.25.1

