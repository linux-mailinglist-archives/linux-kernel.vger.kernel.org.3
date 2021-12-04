Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47D3468780
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhLDUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhLDUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:44:54 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDC8C061751;
        Sat,  4 Dec 2021 12:41:28 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id m192so7301204qke.2;
        Sat, 04 Dec 2021 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4wio9mhnl+MlwdkQlum2dK1xXAcJhYay2PVxS3uez4=;
        b=RVyCAhmq1vSyDDEtRmnL+fZOHrPhVJ2Vq6nc3ZAbD5i7RlGUGxkr0+N6hqyTFU2tN8
         agbHyGEXZW6GINl/ZXQSjTA6kO778tUXdyjK97oZTmGk9iIyzHCVyy7lwjJioojNq6mz
         8sSaHpxzntsGzwlyvWvrChQ21S8LtvKNn1ug0Q2IwS8uiq5qZu0qtujeRtq4HGIoHi+j
         /NFPpEWoxaaquo5V2uqF0pmMZyVcCIC2GJr4EwOyuWj+qGsiFVblRT5zDWfCmGAozNjc
         LDoUZqjkaq2+4dYFjsiKgrUsY8Ztr7tzsJ4jfMwLaRSxs5ZAKZPtOvzYhF6TKlI2Mc8L
         Zblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4wio9mhnl+MlwdkQlum2dK1xXAcJhYay2PVxS3uez4=;
        b=noip3lc5nfue7GtjhUTCIdf2APdOmY7J/1dc3xGjlY5NnQ8QWcMRnUnZl+Sve3dSs4
         PmG1yPn2FckGpyGShrBwojysJUhT40j4ARlyc/fAtkxtYiMwo8prbyZXdFWV1duATQ2K
         7IdD+bb5cQf3VewUKY8UG8IyntYwq90juy1Qk+F1GLa1jEJkNnPcOnovMho9zDRp3LMP
         SJUhxmppvI+r5Kq1RkmragMlx2a2uscb7ksFRsnTqVBmsN1Idu82PO18L4kvbs43omuu
         cE/Zj9t+tzjENPcUbV+KctwlHkqznsOXf/gUzi2Es2DoCu/lBY+P5zzQ+HiL5hHnvU3G
         YqIA==
X-Gm-Message-State: AOAM530sB1FcCjR3S7m9ydIJ9kz/+zpcozOTlDPEf3sBJM2JPvY1oMir
        6kzQfnv5ws51QSocdhkMGLPfPmTVW36kQQ==
X-Google-Smtp-Source: ABdhPJxSHk3BgpMzf5OOYDgcwljEQixmNDGV0JIZ3yhCuGjkVuIQcqTtEWlFgNIDMn0QpBvMatrPqA==
X-Received: by 2002:a05:620a:4092:: with SMTP id f18mr23458179qko.629.1638650487752;
        Sat, 04 Dec 2021 12:41:27 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id c22sm4862480qtd.76.2021.12.04.12.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:41:27 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v2 0/3] mmc: Add LiteSDCard mmc driver
Date:   Sat,  4 Dec 2021 15:41:18 -0500
Message-Id: <20211204204121.2367127-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LiteX SD-Card device, LiteSDCard.

LiteSDCard is a simple SD-Card interface available as part of the LiteX
environment, used with various RISC-V and other FPGA based SoCs.

New in v2:
  - reword info message in litex_set_clk()
  - streamline code in litex_map_status()
  - fix typos in Kconfig (thanks Randy Dunlap <rdunlap@infradead.org>)
  - improvements suggested by Stafford Horne <shorne@gmail.com>
    - allow COMPILE_TEST in Kconfig
    - use read_poll_timeout() when waiting for cmd/data/DMA
      xfer completion
  - include interrupt.h (thanks kernel test robot <lkp@intel.com>)

Gabriel Somlo (3):
  MAINTAINERS: co-maintain LiteX platform
  dt-bindings: mmc: Add bindings for LiteSDCard
  mmc: Add driver for LiteX's LiteSDCard interface

 .../devicetree/bindings/mmc/litex,mmc.yaml    |  63 ++
 MAINTAINERS                                   |   2 +
 drivers/mmc/host/Kconfig                      |   7 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/litex_mmc.c                  | 670 ++++++++++++++++++
 5 files changed, 743 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c

-- 
2.31.1

