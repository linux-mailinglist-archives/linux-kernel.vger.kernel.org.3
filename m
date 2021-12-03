Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B214680BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354393AbhLCXpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354148AbhLCXp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:45:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCEC061751;
        Fri,  3 Dec 2021 15:42:05 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id de30so5242652qkb.0;
        Fri, 03 Dec 2021 15:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzp86XPX2kW/kV6occNAL8wfs1hQn3/ET8LFdxMxKJI=;
        b=iEwP66hquh5xRMsUyCE0sOSZy0Fit76MzKhzNpKFWSvdb7a6ugQYDJsfPUYBwFog4w
         Cc1eb3tXW0Z6K1ApsX4C/KpXK7Cx5fpPQjocxBbk/kCfPU00S3kVT0cCOW8Fj8ecLcTy
         ofnILoKFL3C6Ju63wDkm5qKXhQcmmUnftSBvyvqkcfVu8vxuYC3CYEU6a1MK95Vfokoe
         VYDBiQOQYXh/ffKmwOE6L5KZr6SJSnaZGgYz0JjxJfi9fBYIV7GaGELjJHBiiC5wQpi9
         KwwUIGyt29u6ueDbTFxA++LTYE9TUOM2xiVopqM/Of7xoqq5y2duiNYM1FO1oF7SXb6R
         YZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzp86XPX2kW/kV6occNAL8wfs1hQn3/ET8LFdxMxKJI=;
        b=VA6GDxXrAteNmKuSN1kn5JA4aqvqSp7EhpQIUW68Oct5Dn6NAOTurSSMmvZZgRAgXj
         OTFXGPSHSVkr7dtM0ZKl5jczJ563wqVWoyJjoKUdqKq/U2Zd4FIVbYqpL6GjBNbTsa75
         SSOROS8YoCpDGTJe8ovdmQkNrx45doOyxkIFbCEbOk3vZOgj7y9bdFymAtX8lkyikGh8
         Mx8ZoK2afLT2fuG2w+NKa8AbhESh0sQ2/lneqcOCN++jReMmOQv2ip0AfTGpGfXfiUcJ
         DGLL8ioY7Q4tPPCv0Orav/1ckOCY8QQxWK33miLlN944WAo1oW+f/15n7k44I++H2pLd
         0d6g==
X-Gm-Message-State: AOAM533NnZrsdMfKBpP+4n/ocxZSKmr9gh8IuAFHb/Ra1gYwcr3u196b
        RANeAG9ZW+Z5bJZTvrOG0AdspodWNTY=
X-Google-Smtp-Source: ABdhPJwwRseXLAdKZxWot5CI4xILtt5LFTnCQvHPxEhS5ZchC/ailDs/or2cbrzZMLW1Z8+y6nYf0Q==
X-Received: by 2002:a05:620a:4116:: with SMTP id j22mr20932530qko.410.1638574924189;
        Fri, 03 Dec 2021 15:42:04 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d15sm3495111qtd.70.2021.12.03.15.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:42:03 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: [PATCH v1 0/3] mmc: Add LiteSDCard mmc driver
Date:   Fri,  3 Dec 2021 18:41:52 -0500
Message-Id: <20211203234155.2319803-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  63 ++
 MAINTAINERS                                   |   2 +
 drivers/mmc/host/Kconfig                      |   6 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 677 ++++++++++++++++++
 5 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

