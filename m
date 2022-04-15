Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DAD502719
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiDOIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351534AbiDOIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:53:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3886B8236;
        Fri, 15 Apr 2022 01:50:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id 6CF7B1F4024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650012631;
        bh=97YXroeyDkQDT1z2Pkh9zbKqmO8YB3LrWCRnc+QZ/pM=;
        h=From:To:Cc:Subject:Date:From;
        b=R2iZCUxGUtu51GfEP0us/6f4qXcMLzQUz4z5gsV+kZcoCX6/2/MGpifOLm+uACjDc
         iIFgc3f2RBhEAbES2LCrGBnvZ//5oGNxGm43lQgQq4RMUkdRoscVKdcJ+A98raArmf
         nFoHcIIpWCYW8S4mzAVaJuribMeSFM26QCk33nhlQtnkCwdUVIRj0+pDW5PLtB1oGT
         PmQLHI2AWzUNEiPKkyTJ5luYBJXBgoEA3G2/IHZI9dY7lZ7/3Jnupyohr/T+I+jKcz
         wqfiynzKAea2LTqmj1H9DJ50JlCJigOmF/w+7MKgXrH/z9DXyKsX4Ga3/F+VNkySLL
         RFO9WmNBN2S8g==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/2] iio: stk3310: Export near level property for proximity sensor
Date:   Fri, 15 Apr 2022 10:50:16 +0200
Message-Id: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
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

Userspace tools like iio-sensor-proxy need to be instructed the value from
which they should consider an object is "near". This threshold can be
exported through the sysfs ABI based on the "proximity-near-level"
device-tree property.

This patchset implements this property for the stk3310 driver and adds the
necessary bits to export its value to userspace. It is based on similar
changes applied to the vcnl4000 and ltr501 drivers.

Arnaud Ferraris (2):
  dt-bindings: iio: light: stk33xx: Add proximity-near-level
  iio: stk3310: Export near level property for proximity sensor

 .../bindings/iio/light/stk33xx.yaml           |  6 +++++
 drivers/iio/light/stk3310.c                   | 26 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.35.1
