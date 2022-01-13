Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA62C48D197
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiAMESH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAMERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:17:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FAC061748;
        Wed, 12 Jan 2022 20:17:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so18322181edc.4;
        Wed, 12 Jan 2022 20:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=twLiFQrtbAYLfqOjLvfLPkX6xypVZRiVautRxIHyT/A=;
        b=c8Kj4oWAQVw0mFePyWCPL8+5DCzIwQn7FRB1qQbiOqJFBRyOXcYne+XDoUHL+cTrik
         JaOZBzxOaGHAFR3+Ok20jQ+CndVAgLBzwf+wxFY8f7ZWhOU6dyRZm91/mUSVwARAIQDS
         WMDxOahdIqJ3KHj3UaDZWQ4tnNT6IB8Ad+etYvZYoTewo9d2oNAWevY0qemegDbeBX1/
         fhsrMdHge5yUQhTwMeCQfb5VG5V3m6pfxjC7nI9EF2QHC0rGPqyJxzgN8DUWDnx4zJ0D
         baDttos4NNTcPvDygTxvBfUrEFEACVbgyO0yxPXdoAKAy14aW7mnL/a3coITkLT181WF
         yDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=twLiFQrtbAYLfqOjLvfLPkX6xypVZRiVautRxIHyT/A=;
        b=VpEwJlp72Q/6OLuMv5c3IulRWbFP5+XWtP+jw6pkE/LtHCW+IHnGaD/5FgLOS8PH5O
         uAAOJNnpBS9jVFucxvaY9fJj6EyfgkzD0YKSrrD2MsToLARlyBzvIEg3QZWvGStPKsK0
         nzP6BU5ocTAcKoPrYW/kxzq56DmY1ufTlO2iDSnVdEf/Zkd6Tm4Q9oizbntbjvtfTKm3
         zJReZ9VK00yw2wSI2F9CS16n1rXgbHnQlf7giFreKJKuVgdyYffYrqBruxe7pa80uzRV
         BUbdElwwkeLYXiIVNaPHsapJYQ8mowqFhd1XUiOLDf2AhCesZN3/n6wPa1vhuxPb00mP
         Qw5g==
X-Gm-Message-State: AOAM531r3sX6qE/fffT4BNf4sTPOBYn+Ay4dThqfV1mtVghqqAb6NKF1
        18AB2NkQm73sjcC32oI9lAM=
X-Google-Smtp-Source: ABdhPJwHXyyikak4mGI38dwfDFK/WiLjVYqkErNhxTzcCuRXPUx3hM6QBBqmMmKClFKZxf8S4JQkew==
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr2152409ejw.652.1642047470421;
        Wed, 12 Jan 2022 20:17:50 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id eb14sm651822edb.16.2022.01.12.20.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 20:17:50 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: minor P212/VIM1 fixups
Date:   Thu, 13 Jan 2022 04:17:43 +0000
Message-Id: <20220113041746.16040-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P212 (S905X reference board) dts is used with a number of no-name
Android boxes that follow the reference design, and users had noticed
that BT worked but WiFi did not. While investigating and adding the
missing WiFi bits to the dtsi for testing I spotted that VIM1 inherits
from the p212 dtsi and has the BT node duplicated, so we can clean that
up too. And since we're tidying things, the pwm_ef node can be moved
to maintain normal alpha sorting.

Christian Hewitt (3):
  arm64: dts: meson: add Broadcom WiFi to P212 dtsi
  arm64: dts: meson: move pwm_ef node in P212 dtsi
  arm64: dts: meson: remove Broadcom WiFi/BT nodes from Khadas VIM1

 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 19 ---------------
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.17.1

