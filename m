Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAD468C9F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhLESUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbhLESUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:20:03 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB55C061714;
        Sun,  5 Dec 2021 10:16:36 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id t8so8075984ilu.8;
        Sun, 05 Dec 2021 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7hPh5mvYUUQHhkNNfoyCMD5i8ZznhnbU9nW0aRlESc=;
        b=cmpP6hAnfSA5CEdGDnS04nX/ONCTYoYT50LViDGS8fK2PSD/NeynRzFthz1B5u+skM
         QjWeeDp39fs2dDsVddhPiqzf0Ur3P+3mDHVo/sBOf+K6lPmwwTik7Y99N9AQeAeva9Vt
         1RY3TxyDPVOcIVmxDbjDROtrZPB3ejjY09s/hC7cK6QtZ54dXzohEcN7U9M5KcR+DTCX
         G1T8bmkQG+IoL+IiKoVbpe5XsnuzXFBcgrCakoO44sd1U6O9YSf/jHVLBe0P/C64BU0D
         ysxHUI+y5+mY7uoVfCrQIEukijEybRXcTo5NsE7ooj1maicuFdbGVmqkBm75/WLg4SD/
         Wvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7hPh5mvYUUQHhkNNfoyCMD5i8ZznhnbU9nW0aRlESc=;
        b=xhHy8l/IIMICQlQNCutRheAQpIlqI8fa6pnDOepvAzgHRfDmPmeeW1L9g/134ur8+1
         I4wbjyWnjTzFg2T9iVmro6hWzktd0WDJI2T4lZWbZdguLjyKYuvha4SeEdC5SXcq6Yly
         46TQ7/v37nDo+h5OiXe6XarZ3PS+UM5IuSVPqhC+oyOfWDePGGmqvY1JWf77F3cqKOl/
         A6OEdI0Yvj33z7NznMIZAgANI1SriN7pxfLJ+lyJhTeg5khtTEjdU7CVrwOkEHyFb0vl
         0tJnU3sQumJQ7Jl4s9VUk/NxI5quhAVArM9XzzxOjzitB70VQtkWoTdGg8VygyZ2ZIyq
         WQEQ==
X-Gm-Message-State: AOAM5300gBFA/3wKjUxE2J6Fj4ZAKjggTGmTnO3FzZJhZA/znteKdPLu
        T8K4SZUEniy2Qf7DkA7U56+36jQgBPu7iQ==
X-Google-Smtp-Source: ABdhPJyHMiqyQNSp4p0YcCTauDSHb7YDwtcIhgnq+pwoSX0gBorVeEiMc6bRja2+eWJlJbWpI6vdiQ==
X-Received: by 2002:a05:6e02:1a08:: with SMTP id s8mr6025833ild.158.1638728195036;
        Sun, 05 Dec 2021 10:16:35 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9ea0:bb99:b16a:6159])
        by smtp.gmail.com with ESMTPSA id z12sm5808164ilu.27.2021.12.05.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:16:34 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        nicolas@ndufresne.ca, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC 0/5] Split iMX8MQ Hantro VPU into G1 and G2 with blk-ctrl support
Date:   Sun,  5 Dec 2021 12:16:13 -0600
Message-Id: <20211205181618.1041699-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in reality, it's
two IP blocks called G1 and G2.  There is initialization code in VPU code to
pull some clocks, resets and other features which has been integrated into
the vpu-blk-ctrl for the i.MX8M Mini and a similar method can be used to make
the VPU codec's operate as stand-alone cores without having to know the details
of each other or the quirks unique to the i.MX8MQ, so the remaining code can be
left more generic.

This series was started by Lucas Stach, and picked up by me so some patches have
his s-o-b and mine where I might have changed a few minor items.  It's in an RFC state
because the G2 VP9 operations appear to hang, but the parent code from which I started doesn't
appear to show VP9 support, and it looks like it should.

since the g-streamer and media trees are in a constant state of change, this series is based on
git://linuxtv.org/hverkuil/media_tree.git for-v5.17e

Adam Ford (2):
  media: hantro: split i.MX8MQ G1 and G2 code
  arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl

Lucas Stach (3):
  dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl

 .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
 drivers/soc/imx/imx8m-blk-ctrl.c              |  67 ++++++++++
 drivers/staging/media/hantro/hantro_drv.c     |   4 +-
 drivers/staging/media/hantro/hantro_hw.h      |   2 +-
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
 include/dt-bindings/power/imx8mq-power.h      |   3 +
 7 files changed, 205 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml

-- 
2.32.0

