Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1557691B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiGOVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGOVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:41:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E487215;
        Fri, 15 Jul 2022 14:41:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so4232150plo.10;
        Fri, 15 Jul 2022 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mbp4ZJOvfAyNjZhg4VKTSXbGmuQMrwZMn7tyXOtsqps=;
        b=Mj3GeEFDab6IFnYHd8VsEJrDLwuaAKZayt58TYiHkejpIxRzRfjkcdBslUM+Aw0XLZ
         ms5Fked8kiaBZGBKGnfixlJP4MA8uvMHxWz7RodmJHvJiHaQ+nwuxtuCfrEEGjobrrj5
         nx3MeVP0kafBs7skAm1ElyUpuQ2AjZywt6onmxlRSDvX00aH09LnuDLx9mI9Nsg/PqS6
         rwFPlGMp1TKXC1Z0it/5BbAhHzMXZST+zErGgDp7UIcTUfKIFKdZRjcLtttavQ9W03Zk
         GcYZ0PG2yPy6Q69+cwxe8We5t/KP5DUUt7xGqMV+zWa/nEAUnTCmp2GRflzDlZecrctD
         JHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mbp4ZJOvfAyNjZhg4VKTSXbGmuQMrwZMn7tyXOtsqps=;
        b=ZbMJcL7VskH9Op22fSXbx+GElLXT4+GXYn0BQM9rLAjUA/MwXGXuKyyjTfrrkZghrY
         dvkSk8tKR6M46mNNUEBMjWdHdTAV1I00Dnq9si2XBDC+oCPJsTYv3osMJYaOUNvIDaQT
         yG0rpSEfoNInWK3SKuPTZyDmdyLnYBfobkWxzRLHqtm6tIPp3m5emBD2d2e4C7COoXUC
         +LxAxsd8nHDIit1aQZFdlJqzDn4vT+r5vTLkvfTi90pJdvWOADUHBd9UpdviH/Uf/jmm
         XWGF828ck3wJs8QidrXkuNH5iOAjbID7inmUd4MQeApB3Fo8Tcp9IDbAgExQijl838CL
         ExCA==
X-Gm-Message-State: AJIora/0/MMCb+sjaVqelZ6Z/M23NseOpsDDzRsMs6B0ruz6OacbqLBS
        +HWfyksu12yl7x2QoyURsBb60IwTPNo=
X-Google-Smtp-Source: AGRyM1vAoes8mwHF3YEA0ACdkABUCtMDq2XrqMKU/ST7Ht0hVwKslFpfzJROnb0J7Q0BS67X6goTfw==
X-Received: by 2002:a17:902:e750:b0:16c:761:6e96 with SMTP id p16-20020a170902e75000b0016c07616e96mr15757900plf.0.1657921316080;
        Fri, 15 Jul 2022 14:41:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9-20020aa797a9000000b0052add461d2esm4289975pfq.103.2022.07.15.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:41:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] MIPS: BMIPS: Improved early panic support
Date:   Fri, 15 Jul 2022 14:37:45 -0700
Message-Id: <20220715213747.111321-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This patch series adds support for cfe_die() which can be used during
early platform initialization when we do not yet have a valid DTB to
infer an earlycon console from. This is useful while bringing up new
platforms/DTBs as well.

Thanks!

Changes in v2:

- ensure that we do not break multi-CPU builds by reading the CPU's PrID
  to perform the appropriate XKS01 disabling before handing over to CFE

Florian Fainelli (2):
  MIPS: CFE: Add cfe_die()
  MIPS: BMIPS: Utilize cfe_die() for invalid DTB

 arch/mips/Kconfig                      |  1 +
 arch/mips/bmips/setup.c                | 14 +++++-
 arch/mips/fw/cfe/cfe_api.c             | 68 +++++++++++++++++++++++++-
 arch/mips/include/asm/fw/cfe/cfe_api.h |  2 +
 4 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.25.1

