Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F515086F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378074AbiDTL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiDTL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:29:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550385F5E;
        Wed, 20 Apr 2022 04:26:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id EF9941F4375C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650453989;
        bh=rX1tVK7ElPPUIHgX3PTzATWhJeReOOFh/dlM7zKsaWc=;
        h=From:To:Cc:Subject:Date:From;
        b=Adw6DJNbRcKHqoz0H3Lu9eOX3fdVCGVjjHt3kQE0hRV0VjBG2JeTAsxe0cTPyfoN/
         OXdvNv35FZIxave1Ur61fp7YzsWmaPfLxE+H4QwQjdlxzXZc/Bc+4Q5iw9RvimBW0q
         ZvCaRQPDE8MDuaKlpZVqpsX8u9w8v+XpLzoJjMz5KT/+aRDrHMwQZCYXHOTZNng8Qb
         9ULogIQpQzBI7vfGIcNrKtIeZwDmEmzJ2LwudB7ruPZziwzCnlqADvUe6Sfy1wvWW3
         SFBzK6DEDQeGyxlG/8lJOZO3hoX3IvuRxDdQDKH5T2JCo/d46cwEC1eek7VzjCN6+w
         sywogCirFVrKA==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 0/2] iio: stk3310: Export near level property for proximity sensor
Date:   Wed, 20 Apr 2022 13:25:38 +0200
Message-Id: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
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

Userspace tools like iio-sensor-proxy need to be instructed the value from
which they should consider an object is "near". This threshold can be
exported through the sysfs ABI based on the "proximity-near-level"
device-tree property.

This patchset implements this property for the stk3310 driver and adds the
necessary bits to export its value to userspace. It is based on similar
changes applied to the vcnl4000 and ltr501 drivers.

Changes in v2:
  - drop zero-assignment as the variable won't be modified if DT property
    is missing

Arnaud Ferraris (2):
  dt-bindings: iio: light: stk33xx: Add proximity-near-level
  iio: stk3310: Export near level property for proximity sensor

 .../bindings/iio/light/stk33xx.yaml           |  6 +++++
 drivers/iio/light/stk3310.c                   | 25 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.35.1
