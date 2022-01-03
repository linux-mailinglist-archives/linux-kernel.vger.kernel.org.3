Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE713483461
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiACPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiACPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:46:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09931C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 07:46:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso167141pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 07:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f89L4lDDyyfgV9BW7/wlPt0i6sDhOq7O3gmzWno2cA=;
        b=IvqSkjlWZcvybkvlIWnL3uClSTdDiK8bPkfylDj9xj+vMmaLM2naAdseWeApUK9Ow4
         DsWzrO2BunjCu8HchtYwIT5ptHgOc0yCt7XTgZkT2RX+gZLcn7/5uCi8WkutxealSqSw
         s0jm/fLWRaT3aBuUA788Anv01qzMdnYfAcGMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f89L4lDDyyfgV9BW7/wlPt0i6sDhOq7O3gmzWno2cA=;
        b=CoJKavXt11Qp9AUAsmNe6QGkPf5HYGHiE8k+Mso5cLMUn7kwS+7YEAfbCtydXDUutY
         dx/oVlsYPPUf7zxbBOJvvCx/BZP+TrDv+xOWeytmaLrtkrRXPAoll3aAL0rVycR15PaD
         4aWFZUx6W9wzdvikfx4ZD0UHaTlcFoIgFARlBRW5PPooSRnyUDFbjI2WLlIvQ3SlNvNW
         oVYjUhmBD0u+nfZzx5YF7ZMzHteEpO4B9FZ4+Db3iRQbdjC7mEZWzg7MhHEx9p34glHz
         5LXeHhk8P1RGKrhhm3CBcvv8gJtqw+Y7OLATbO+KcBr90rH6zspo+MzM6OFf9IIvbBy1
         DZZQ==
X-Gm-Message-State: AOAM532Ly3ms8Ax3b4WrTMyj7j4FYvNB6Z25AfOkBYKkASWo+ViZCeev
        dCCbe/GEGoCSZkflI0fsiJPPDg==
X-Google-Smtp-Source: ABdhPJwOyrLU/3kwDGjaTKXC5fxZO4SAgn7ljMYiD0avj9CxtKC51+rVxhsZfvMH5uYg5Hi1YYfOkQ==
X-Received: by 2002:a17:902:7ecf:b0:149:956a:c2c7 with SMTP id p15-20020a1709027ecf00b00149956ac2c7mr25496283plb.40.1641224811350;
        Mon, 03 Jan 2022 07:46:51 -0800 (PST)
Received: from localhost.localdomain (lfbn-idf1-1-1088-186.w82-125.abo.wanadoo.fr. [82.125.191.186])
        by smtp.gmail.com with ESMTPSA id l2sm41080153pfc.42.2022.01.03.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:46:50 -0800 (PST)
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     linux-amlogic@lists.infradead.org
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] meson-g12: add pwm and uart pin muxing options
Date:   Mon,  3 Jan 2022 16:46:13 +0100
Message-Id: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds a few pin muxing options needed for our HW platform (to
be submitted soon).

1- pwm_f: adding missing both GPIOZ_12 & GPIOA_11 options
  -> tested GPIOA_11 as mipi display backlight
  -> order for this patch is not alphabetical but follows doc order (to
match current order)
2- uart_ao_b: adding both options for ao_b uart + its rts/cts pins
  -> tested on custom hw too

Let me know if you have any questions.

Regards,
Gary

Gary Bisson (3):
  pinctrl: meson-g12a: add more pwm_f options
  arm64: dts: meson-g12-common: add more pwm_f options
  arm64: dts: meson-g12-common: add uart_ao_b pins muxing

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 43 +++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  6 ++-
 2 files changed, 48 insertions(+), 1 deletion(-)

-- 
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
-- 
2.34.1

