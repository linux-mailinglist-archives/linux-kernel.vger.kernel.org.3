Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822A24860FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiAFH3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:29:05 -0500
Received: from box.trvn.ru ([194.87.146.52]:49533 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235567AbiAFH3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:29:04 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 1AB59403F5;
        Thu,  6 Jan 2022 12:28:59 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641454140; bh=TvlVE4dI9WEBj581zwnNdCah3wxwBT9PbDqHEmE8NBk=;
        h=From:To:Cc:Subject:Date:From;
        b=RzmkYWk0wWeg1IAf3hZhyj7KcXjbWRzFA/u7yqxtCJS0AelnUnag9KMCHJCiC5FKG
         +/YQEMih/D2atQM552NGGSYz9ac1BoK62MJiWh4wMOQB1iclWlTZnJ5xhopKeaH5Ra
         /lQw7H+WBW45Z8PIQhEsU1G8YX3OilnTIbia9HJsmbQwqxBHGAnP0Z6eEqUWfDAX5d
         7vkuIBzdPXwMpi+Fc3KicN5AsOGb71/zUPmF1WIDz39I+gg56rBtgW5mlihiKmSMtv
         D2kpJYqRsVr2Bojr1pNhbwA3cGKefmNj7hGUL0BOErcme/uEETgcDk7/I7JV08Oroq
         VrxAPww+67q4g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/6] Add touch-keys support to the Zinitix touch driver
Date:   Thu,  6 Jan 2022 12:28:34 +0500
Message-Id: <20220106072840.36851-1-nikita@trvn.ru>
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
Changes in v3:
- Add yet another missing le16_to_cpu()

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

