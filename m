Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5A4D6FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiCLQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCLQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:16:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF658E68;
        Sat, 12 Mar 2022 08:15:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c11so10022282pgu.11;
        Sat, 12 Mar 2022 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9CbMZvtOfJ3n4M+E2dtBWDEfEEf3yzdNF+4NVPhNito=;
        b=Vd4rzCgwzqxuQSR6ljlnIWkFJzGYJdXRTFD+Fhi4v+SHG0LV18OAFPnzOhrvhcsmYO
         Q/Xc9O+VvuzJzntlNoBHk33jrmBB3FfOuYF6ygBCwCeodJLRt1CfQmWR+3N9T0vtpdsw
         nK3p8tzQOwAF17s5dYedF9z4BL0KMN0JCEOAtI30j9pYdegpjODHqNR/m1pSnF2/G+n1
         oDlXoSV779a/oBM52bXJnauykJdOYXQVoEYA88g8RXGJilpmf6YTJhVIXDNPuPKLKAt/
         /kK6N3j33fXK4r33UWujuZG1Zbh8uo+PIU5iksiFYsnC1EbO/iiox2Nc+nbMqvW4r77V
         5stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9CbMZvtOfJ3n4M+E2dtBWDEfEEf3yzdNF+4NVPhNito=;
        b=3B1oAJg+XW4P1S7nnu0gY17r8mycgbTpkUNfEc+UAu/LNv/NDvqmUZS/uk+F2Sm9QP
         BgnzKVfGhf2ZQnizCMbx1qS+CMejN5hznIHHlY3iIGBcoQrS8lxxPAxaUFLibqXar4/q
         mF9XXtVOpq6ll//HDORfJgeZ7PBYTODKp9lez4q3taDR4dF1soE3Nr2DIKDa9KUCzKvY
         E5/e9a2IlnuxQHBASk1heMSzBfpeocc53tH31Rvgd2CUV69Guv9mpsekmzJcHJo8GDxC
         KgRncg6u6t43xluhFMPW5Bi08vDPg+PqbYhqWnTstdNvH92/kp7nggsyHlevw6faTkqh
         oy+w==
X-Gm-Message-State: AOAM5326rSkrOX/JFlTcNmLEFwoXC5vaf2vLtoaUzLXYzptVBaDO7L84
        nbf064lFT2GJCzlkIThVJTk=
X-Google-Smtp-Source: ABdhPJztY7lT2vmDBJ5ZpV/C9faTm2OZGGUx60BHZismJEGnbnxYZrHMZep1mkqn/G9k/vXHPtXgEg==
X-Received: by 2002:a05:6a00:16d3:b0:4f7:68db:5e17 with SMTP id l19-20020a056a0016d300b004f768db5e17mr15584573pfc.6.1647101750474;
        Sat, 12 Mar 2022 08:15:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id js15-20020a17090b148f00b001bfc8614b93sm9735079pjb.1.2022.03.12.08.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Mar 2022 08:15:49 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com
Cc:     wells.lu@sunplus.com, tony.huang@sunplus.com,
        Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: [PATCH v11 0/2] Add iop driver for Sunplus SP7021
Date:   Sun, 13 Mar 2022 00:16:03 +0800
Message-Id: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iop driver for Sunplus SP7021 SOC

This is a patch series for iop driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-bindings: misc: Add iop yaml file for Sunplus SP7021
  misc: Add iop driver for Sunplus SP7021

 .../devicetree/bindings/misc/sunplus,iop.yaml      |  78 ++++
 MAINTAINERS                                        |   6 +
 drivers/misc/Kconfig                               |  23 ++
 drivers/misc/Makefile                              |   1 +
 drivers/misc/sunplus_iop.c                         | 411 +++++++++++++++++++++
 5 files changed, 519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/sunplus,iop.yaml
 create mode 100644 drivers/misc/sunplus_iop.c

-- 
2.7.4

