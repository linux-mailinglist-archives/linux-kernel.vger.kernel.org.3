Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5A4973A1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiAWRh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:37:29 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:42873 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiAWRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:37:28 -0500
Date:   Sun, 23 Jan 2022 17:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1642959445;
        bh=EG8WM13QcPrV2AZ3laZQJnqld2O70XozKuQoHTXOykA=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=no9GFqAecOd2zVW/NKbjqQ6dAkxhAnyQVsIpGamsco/5BHwbufZ584C65Y/k4QVNC
         gC1vLEs+2VpeXG3F4EKWfU4ZKpMwl6q45GE1X8CP8uJ/6qP46AttvNokVDVjBzrGjV
         23pJqhjXzQQ/EsMvnOe7VGQBYY9A2fAHyoPFJr9U=
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Caleb Connolly <caleb@connolly.tech>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>
From:   Caleb Connolly <caleb@connolly.tech>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 0/6] Add support for the SHIFT SHIFT6mq
Message-ID: <20220123173650.290349-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for the SHIFT6mq. SHIFT are a sustainably
oriented device manufacturer who aim to build repairable devices with long
lifespans.

The SHIFT6mq is a Snapdragon 845 based device, it features a 1080p OLED pan=
el,
8GB of RAM, 128GB of UFS storage and display port alt mode. The device also
ships with secure-boot off, potentially allowing end-users to modify usuall=
y
inaccesible parts of the device like the bootloader. They've been keen to s=
ee
their devices supported upstream kernels!

This brings up initial support for the device, with all core features worki=
ng:

* Display / GPU / touch
* WIFI
* Modem (sms and mobile data are supported with ModemManager)

- Caleb

Alexander Martinz (1):
  arm64: dts: qcom: sdm845: add device tree for SHIFT6mq

Caleb Connolly (5):
  dt-bindings: input: touchscreen: add bindings for focaltech,fts
  input: touchscreen: add focaltech FTS driver
  dt-bindings: display: visionox-rm69299: document new compatible string
  drm/panel: visionox-rm69299: support the variant found in the SHIFT6mq
  dt-bindings: vendor-prefixes: add vendor prefix for SHIFT

 .../display/panel/visionox,rm69299.yaml       |   4 +-
 .../input/touchscreen/focaltech,fts.yaml      |  78 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 736 +++++++++++++++
 .../gpu/drm/panel/panel-visionox-rm69299.c    | 281 ++++--
 drivers/input/touchscreen/Kconfig             |   9 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_fts.c     | 870 ++++++++++++++++++
 9 files changed, 1921 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/foc=
altech,fts.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
 create mode 100644 drivers/input/touchscreen/focaltech_fts.c

--
2.34.1


