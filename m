Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6B484DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiAEGD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:03:59 -0500
Received: from box.trvn.ru ([194.87.146.52]:55879 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236299AbiAEGD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:03:57 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id CA02A403F1;
        Wed,  5 Jan 2022 11:03:53 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641362635; bh=0AK0sJT4llPAlmM503xOe/kxnJz+trGyjkDwN14mYGk=;
        h=From:To:Cc:Subject:Date:From;
        b=su4oHd98ySITA8xqDt7pLPqqHdXYW1XCIvfyEnwYTzsqk6vTB9gqCU6/Jl/iGrdfF
         feRVfrO3DflH0NHeu/DAjy2kqT+QRIXT3CDHaYN85hdlC3/ahDYIe3W2T4BCXnZ1Kd
         X2TeAYI3xbHY7gVHm4JBprG6+WVdDoLjmoxm4WaB7/oKcknKgMorIviitVl6NlsDNP
         P/n6nmzIxk5iLdhwFhD7H2VHa8X87a6LZTXec8POYRiawXvIkaKqgs+bWkvmDa0LWY
         WZOvRzdp7i4bUGPVFejz5E+zzTLsnsyKV4mcFIp/ffLlEop7YVpa9mvjcVjPW1FxE1
         KIsUssWvWtkPw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/6] Add touch-keys support to the Zinitix touch driver
Date:   Wed,  5 Jan 2022 11:03:17 +0500
Message-Id: <20220105060323.7928-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the touch-keys that can be present on some
touchscreen configurations, adds the compatible for bt532 and fixes a
small race condition bug in the driver probe function.

I also pick up the series that converts the dt bindings to yaml
initially submitted by Linus Walleij in [1].
I made some minor changes to those patches:
 - Fixed dt_schema_check error
 - Adressed the review comments from Dmitry on the original series

[1] https://lore.kernel.org/linux-input/20210625113435.2539282-1-linus.walleij@linaro.org/

Changes in v2:
- Use input.yaml in the dt binding for the touchkey
- Add missing le16_to_cpu()

Linus Walleij (2):
  dt-bindings: input/ts/zinitix: Convert to YAML, fix and extend
  Input: zinitix - Handle proper supply names

Nikita Travkin (4):
  input: zinitix: Make sure the IRQ is allocated before it gets enabled
  input: zinitix: Add compatible for bt532
  dt-bindings: input: zinitix: Document touch-keys support
  input: zinitix: Add touchkey support

 .../input/touchscreen/zinitix,bt400.yaml      | 125 ++++++++++++++++++
 .../bindings/input/touchscreen/zinitix.txt    |  40 ------
 drivers/input/touchscreen/zinitix.c           | 101 +++++++++++---
 3 files changed, 209 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zinitix.txt

-- 
2.30.2

