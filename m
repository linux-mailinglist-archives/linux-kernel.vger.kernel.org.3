Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34061478BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhLQM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:58:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51194 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhLQM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:58:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51547B827E8;
        Fri, 17 Dec 2021 12:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC4C36AE2;
        Fri, 17 Dec 2021 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639745882;
        bh=Nl95m/EeW5ofxMEobM/4Y8KhAbs4dXGHygHTzo3tlH8=;
        h=From:To:Cc:Subject:Date:From;
        b=Hkf99pin5NXyGXe5j4BuO4gnmHi4A5l3Gm/wLjKeGw8IgxNj4lNQH9VqbXtWlIyq8
         Dzl7Q9uiW1cj23JZUC08R0sOPAgVIngrGdMLka2H38c19tYWD23NJu4UrEpWfHdhbq
         dAyzfyMSc1sfUCGALYrVRdRvUXLI8t6M3Ce1vGNLbm9ijvXHBMMYJCyKCMZx2kmUJa
         IYF7Ixv8GehV8ElPuzB4nWm505d5j4/hHGXSDxDsco1on1WmgyOkzmVrnCRUok2W1H
         6vNvve1kTRiB6h0Qsr3d9KBsudUTF1YI6zN5Q8gcZX6/BJE5ymOkpQNHUgsBLhnexc
         Itf2wwRMj8INA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable framebuffer for Surface Duo
Date:   Fri, 17 Dec 2021 14:57:55 +0200
Message-Id: <20211217125757.1193256-1-balbi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

Hi folks,

I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
through some internal docs, it came to my attention that the bootloader
will fill up the framebuffer address and size to a memory node names
splash_region. Adding the node, I can see the address of the
framebuffer. Creating the relevant framebuffer device using
simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
of=/dev/fb0 and fb-test. None of which manage to get rid of what's
already on the screen, put there by the bootloader (platform Logo).

Wondering if any of you have seen a behavior such as this and how did
you manage to get framebuffer working on SM8150 (I see at least Sony
Xperia has the node).

Felipe Balbi (2):
  arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
  arm64: boot: dts: qcom: surface duo: add minimal framebuffer

 .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.34.1
