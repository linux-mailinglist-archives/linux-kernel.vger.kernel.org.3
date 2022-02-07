Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B54AC39F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380436AbiBGPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443938AbiBGPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:16:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E71C0401C5;
        Mon,  7 Feb 2022 07:16:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y9so5515773pjf.1;
        Mon, 07 Feb 2022 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3UF/9F8voePpBuq13dZu3EgVY3zNbO9hjbJPlJawoXE=;
        b=SjNMaEiI/bHcioMCC0Nyx29bXJneEdEQKjS43Etv6vmX5yJJReYxm2Gct1aaVTWxkv
         QCPT3iNtYZ4QYJYQoZy9QbZvtMUtd0zf5MvWhw7jjEn+nLhfoN4VLtHJ3HSkOKKRR2HL
         xZZMxZ8RfFOgTUacQF2YCItvGv1Edwh4dLxm1V4RiCRkGMCqBOsHzdimETLo9w/t563J
         2N8TCv1gj0VywTir7AnQ7rhmrnzMbvckYRUnk1axaUA62+uK2xQB1J/n9/qBEE2ngwQ4
         krDwlW5xiKQH6INoTDV+JkKSNC6pkB6A5TksYGptsAZ/0JUP1DVxd42P2XGCiDLnTwp4
         +tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UF/9F8voePpBuq13dZu3EgVY3zNbO9hjbJPlJawoXE=;
        b=U87xTdt3cH6LY6a3zAXwEFUHyllN/dGcMN04WMgvBfGegZhC7tLZoqBQtxFOW0l/IY
         rutyjoiE25qnI8H9a0TaHeZoQV6PWy73bj4+cDfcv/8RulKDBzPjHJuc4Je1S6SNN0dZ
         7Ydot1uzcXHFzX3BPL02X3O2R4SXuoXz6jY7i0MRRMWIMQHzbmgazca5X1Xb9zcSlDeH
         4JchsQLdm9sGG5UTKR+jxhn87CafLtS+78wVGJoaeSbwE+1ZAeZIyw0pEm2f/B310DcV
         4imA0HlW0NyYKDuq2Xk6l/WXYSEe82mksIFodWOPdF+vsHfrBwsEun4BH+mJPrk8gTUI
         LW/w==
X-Gm-Message-State: AOAM53091WCcHkGCfYsRwf3TQ1Mh7ahD+J96Tb3w7ydw9xG9IkyaHRA9
        ox13sK1Uwyx5LSjpFOlYIw7Xjfx3AJw=
X-Google-Smtp-Source: ABdhPJyNXeJ7QsTD2peaZUIsoMCUFV6WD/3pQIRFjec4ID2wuEhHPStdg9XV18nTJTDx6RUy9ToZeQ==
X-Received: by 2002:a17:902:710c:: with SMTP id a12mr16740868pll.13.1644246977804;
        Mon, 07 Feb 2022 07:16:17 -0800 (PST)
Received: from localhost.localdomain (1-171-11-6.dynamic-ip.hinet.net. [1.171.11.6])
        by smtp.gmail.com with ESMTPSA id f2sm11896172pfj.6.2022.02.07.07.16.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:16:16 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com
Subject: [PATCH v3 0/2] Add Richtek RT1719 USBPD controller support
Date:   Mon,  7 Feb 2022 23:16:08 +0800
Message-Id: <1644246970-18305-1-git-send-email-u0084500@gmail.com>
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
 drivers/usb/typec/rt1719.c                         | 970 +++++++++++++++++++++
 4 files changed, 1068 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
 create mode 100644 drivers/usb/typec/rt1719.c

-- 
2.7.4

