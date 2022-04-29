Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5407E514432
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355668AbiD2Ib3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355349AbiD2Ib1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:31:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059010FC1;
        Fri, 29 Apr 2022 01:28:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so6538029plk.8;
        Fri, 29 Apr 2022 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=e7gVw1ACX8MRFP0y9DYvU3OfN0j1zNKvhnULymOWUw4=;
        b=B8G2U/XD+OnZl2u0/ebKgbM2ntBpKs+icPovwpciZZpZS5ZKwgZzjnV6AZlVNeB2Rm
         VgzXwyN11RDUhF6d6RsdIzTguVtfWpihUJ7WF6od4gUZw7l6HYjmoKw36EXwCvIFcicK
         tcWBJ8GDY+8vwMiRhyu6ufOXwsFMI770/Peeg9zmPpX6sTq/nC1Q3ExYYchbBqz6n/QS
         RHFHLgZNOht9PwuONm3LDwIciT2mtRJtShaMi5DPT/JS8Qe9TG4LfDrgmKXBxsbevDng
         69xRkT567mUdPitw5SRD2mdOMtbpCbNM0oZ4IPH56B01GMTHGgTkpmAieZrdbBMZI3US
         EuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7gVw1ACX8MRFP0y9DYvU3OfN0j1zNKvhnULymOWUw4=;
        b=kE6OuIFTNUb5hT8oPLezTJukCMeYFNJ2PmmKCpNZa8a+RrCGckIguLvOTe+cqtj4OZ
         Wnsl8A8Fk516CgRR9RKRlxKRqVPeVp1HpUd0HoLFn5s8lXEuaJ2ot5c5RYkMiNmFkiKb
         V21emTe7B3NE/ySx9tOg0xl6FN+J5KdpJSqKnkHTcThxhgAD+rb+F7RXVLi77wQ5KiNC
         hqqWA9FCTKUl25MzFoWiuwMDfb/9JNSBBcGlDodRaT+vM2eIo+4LYVaEKU++xWxHtnYa
         J5AaUTgQs4h6cx88AK2nA8AvPBPAWGj+1fYFulsNBEhXa3VfsP15ZwsfP/4OXpy+jg2a
         sidw==
X-Gm-Message-State: AOAM531AdOIdHOngw3PFo3xV+viBOBE6syqXwCbmAXrqTymDDJ7wZpxL
        W+wNC+zvVyLajgLWbvtNPKw=
X-Google-Smtp-Source: ABdhPJy2k+aX9HLf92X0bRxmDZUPYifSdsw9dcCtrioII4U5M53G96UVMO536hz2NHb0M1nAVYoxpA==
X-Received: by 2002:a17:90a:a782:b0:1d9:9998:925e with SMTP id f2-20020a17090aa78200b001d99998925emr2622990pjq.217.1651220889722;
        Fri, 29 Apr 2022 01:28:09 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm2346874pfh.84.2022.04.29.01.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:28:08 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, davem@davemloft.net,
        vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 0/2] Add driver for EHCI in Sunplus SP7021
Date:   Fri, 29 Apr 2022 16:27:54 +0800
Message-Id: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for EHCI driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  usb: host: ehci-sunplus: Add driver for ehci in Sunplus SP7021
  dt-bindings: usb: Add bindings doc for Sunplus EHCI driver

 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      |  79 ++++++
 MAINTAINERS                                        |   7 +
 drivers/usb/host/Kconfig                           |  11 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-sunplus.c                    | 289 +++++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-sunplus.c

-- 
2.7.4

