Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0467D545992
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbiFJBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiFJBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:31:20 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737832DCB04;
        Thu,  9 Jun 2022 18:31:18 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30fdbe7467cso223460067b3.1;
        Thu, 09 Jun 2022 18:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QtM5I079oW92Wgwg2Tl/xBD0OwEKunidPrcwXyQHhz0=;
        b=pTG4LteeKP1/PBqRYc/0OrHp/+6z9/Focvu1XE6w++W31L5ENHzIYzxZQkcUt5LLoT
         K6hrplmC5oEgFNunnzhHPmWQkwCSaKccOf7gsYJwbGTo2IylbU5s7UUzPlpvMsOJ32fF
         vjUK1oGKX+mYGWM/BCgkRyPIDIpSV4dxZymgRkoxwiQYgOkmBnXTSD8XUdV5zWros6D9
         MxFNHA+V4sC2kP3gleCevNcBrqc54h2NKyMbVFKmsd35Fp+AHOrlP9nAMnIQx0qN3Pkf
         VtM4E1xDzGd+j3+vKLsRyqYRPdKAtLqAEkm1/ve2bysIuZgh4r3imqciikBfnOP/bCfp
         pDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QtM5I079oW92Wgwg2Tl/xBD0OwEKunidPrcwXyQHhz0=;
        b=2NSDWBDjKTXPSP9uUGqu1Jl1HcK+AakP5AZYVJF7lMbNEMS6GN8zS0Vv1e8y7JfkAL
         meskmj1sT4T4KpM86J1jZH1YDB7/g79xBmAy3dwYpVx20YrjYwSSXQZ+bAYl6yLeYIx/
         x7penNrQS4M3rdXvdZqKk90oSQLfP+6mrKtO/Zc+uDzpHmod6udzRYS/G1UnguNQml6m
         lhkZfFzxlgoBkvjsUXSlMllob2yScf94OZ0lPj6vw0/YQEVCwT7uz6bS0aQLw1RHvKxO
         axaBxD0cohaCbttL3AFh1vGD356wb9bHfRbzQ1XRt0SpERHq3lmt6YprUBStW3aInrWt
         gzRA==
X-Gm-Message-State: AOAM533Qt1blrkYjjltgjdTGn9XOH0inH5THD4d7wGJ5+hUSnepFAL8f
        hN6RhpfYu6FdnrDXoMGYijD0uplHXi4fNjG8VBs=
X-Google-Smtp-Source: ABdhPJxEWipJhuX68SSstCa/rK40Potsjddrc5tBFBanGDfrouOVkBLxjgT9g6KVhGT6uRMMsFd4eDipt4s9SswVaAM=
X-Received: by 2002:a81:4104:0:b0:2f1:b59f:22a2 with SMTP id
 o4-20020a814104000000b002f1b59f22a2mr47507275ywa.328.1654824677609; Thu, 09
 Jun 2022 18:31:17 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Fri, 10 Jun 2022 09:32:13 +0800
Message-ID: <CAGcXWkz6UhpG9Eire3NkXSr436UHDWVh10_ScWQtHLoJavdezg@mail.gmail.com>
Subject: [PATCH v9 0/2] Add thermal control driver for Sunplus SoC
To:     krzk@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus
  dt-bindings:thermal: Add Sunplus schema

 .../bindings/thermal/sunplus,thermal.yaml          |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 139 +++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4
