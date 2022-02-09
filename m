Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C924AF385
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiBIOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiBIOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:02:40 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD0C0612BE;
        Wed,  9 Feb 2022 06:02:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x3so2289296pll.3;
        Wed, 09 Feb 2022 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=J542ENssTjaGGW4CVV2vnDWua5d5FY//rGPfnPmL/oY=;
        b=nXH6+i8Ii06LAgl6pIr3JPZBPHZZ3B62MXT95LBsvTlgA0izpO9apIHSoIjyEI8cFg
         pVYu5RhsCLUuCewp6SNkiiM52AGofKrT9oZ/wmNUUohLMEn33QyJZwugGe68x9khpAvh
         LMh26rcuC/QggARFUli5/ebC8/DBQxrs5D6hHW6Dnuycs7GBQ9ayk98r6QuQcsS3jcuI
         gsv4DCNMGX6UR+f0Nj+e9jarpS1ClpYUHwl+DsT2luOR7Enk78OUxRLXDfxWhJrus4o6
         E3iGV0JlKxuAoSiHCh8KkyYkKqia+5y526za6Baiz6NzWEhEFacPluQSWkWMb4dlwFzM
         2e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J542ENssTjaGGW4CVV2vnDWua5d5FY//rGPfnPmL/oY=;
        b=rgyNfEIm6QEEnj4ahEaGjdmZ4dAHZ9aNOfymYCDo26l5auBVKj1YjANv6+bVl/EdcY
         fu4JBcjl7p08WiOVRMCgjML5ZgdpgUPvzJy9txKSSQ0kcToOhBXMLA6OMdlSesMz7H6t
         I95DT/GMORwYGvVTxikRJXpMK+bzrBVk55ZGMwfxPZf4JIlo+IHfxvtHAskAvT5mBBCi
         A2nlu1g3jj+1N1EiuPuZc9Gp2Ao/jG1yQRL4gEMRkbm/8jLwwzMYP6j3E+uxMZo8cNMc
         VbSZ7pdUkPu6L75/mRakMQPTKMKZgzNLZBm2k9HjNPSMJH0pRDPdR22tCjrRi/V3U8iF
         9BLw==
X-Gm-Message-State: AOAM5313AgZ85BsNNC6fQE98hUVCa9Lrx85VenMWo5U5UkxGblBB/WuU
        tQJiY0J/GuxE54LyxE7Qkb8=
X-Google-Smtp-Source: ABdhPJw6RBG3nG0UiqpUixEVJCO3iIQFduZrk1e2LovUPiP0ysQjwpiYRCN1rNDzEwXqlABwnQlSAQ==
X-Received: by 2002:a17:902:a512:: with SMTP id s18mr2178777plq.51.1644415362450;
        Wed, 09 Feb 2022 06:02:42 -0800 (PST)
Received: from localhost.localdomain (1-171-21-84.dynamic-ip.hinet.net. [1.171.21.84])
        by smtp.gmail.com with ESMTPSA id j8sm6177178pjc.11.2022.02.09.06.02.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:02:41 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, cy_huang@richtek.com,
        will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
Date:   Wed,  9 Feb 2022 22:02:33 +0800
Message-Id: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Since v4:
1. Add Reviewed-by in dt-binding patch.
2. Remove fw_devlink_purge_absent_suppliers.
3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.

Since v3:
1. Fix checkpatch.pl consistent space error in line 332.
2. Refine some error codes to more appropriate one.
3. In psy_set_property, except prop VOLTAGE_NOW, directly return -EINVAL.
4. Use devm_kasprintf to replace devm_kzalloc and snprintf in psy_register function.

Since v2:
1. Fix below kernel test robot build warning.
>> drivers/usb/typec/rt1719.c:492:65: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
     492 |                                  RT1719_EVALMODE_MASK | src_sel + 1);
         |                                                         ~~~~~~~~^~~

ChiYuan Huang (2):
  dt-bindings: usb: rt1719: Add binding for Richtek RT1719
  usb: typec: rt1719: Add support for Richtek RT1719

 .../devicetree/bindings/usb/richtek,rt1719.yaml    |  85 ++
 drivers/usb/typec/Kconfig                          |  12 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/rt1719.c                         | 961 +++++++++++++++++++++
 4 files changed, 1059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
 create mode 100644 drivers/usb/typec/rt1719.c

-- 
2.7.4

