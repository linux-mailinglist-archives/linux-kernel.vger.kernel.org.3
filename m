Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173FA539F12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiFAILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiFAILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:11:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81164D0A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:11:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gd1so1324987pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwQWkZi2pg7O8jKrGZkaBlu9bUDXqeDf9Lr3Nkf0Bv4=;
        b=bxANLQcj4jVmquv8Az4f04vsk+Dn42H+3pDj+SX0btmuN2EwwWXNVE7AJOyPni0KL3
         Z1JrSTk5yfHuFuh8dKwQjxXhlVYPHAs0b4vHw05sHhfOYEgp/MVR5AOTuaJw5aRsBb4e
         RkYj5oqT+s1rODXRvtYWmFy7fEDmdlrz1UMfiT/F5tBgYr0cP64NQq6iigf913Tu1doN
         CfFhyHvSR1LjKWsY93W4IBf+lypbwW1GkZLAr3mQv63Gc4SOqdwPFYL0ESrGQ0kLS+q9
         BK7xlwKfcGfN8FJzs3HfdQMFShJ85nY3nZxdzx1IEAmTW4JU/vHQLmqDqLmcGAVGTWVv
         g2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwQWkZi2pg7O8jKrGZkaBlu9bUDXqeDf9Lr3Nkf0Bv4=;
        b=c+FGiamrfMfUTSmggce+FE8zKohPSbdwvAMRi2zER++9dpVTZxGHQIIuQDzWuUlD/g
         X6Y8NrkE2t3j89c6JRUO+X/b2oXW3VvklcBRlrGVPoDtkppIWyeNwWL52lmExK+PneM6
         efVz70gCTNLFbqZYTbXXtplFVqMmf9H2UclJoqPOtxxo9O8LNKOCMj1RL0wmk0CMnq0j
         3gL8MAinSW4qrrwGpkxxn0gG8BXDU8NKecEWtyTmEx8xz03O8ud9uh1fM/FBOsLsEsXG
         5JpCnkps0A3LlN71HL5r/wTyA0abJmpm3N/4vyZp42n28JYY+oPl3EHCtmwyWOnRSm2j
         S4fA==
X-Gm-Message-State: AOAM533KgOwSqqcAMsZZPaiFjFM0ViLF0XmtojcHbigJpxDGHrt4KST3
        urslOYPDt5PcAKlwgnL8eGs=
X-Google-Smtp-Source: ABdhPJyqmMwhwES5MxkmWLZNvaPZUYEmVipycdBm9/b3biOPV1PQPFuI2+Oy8pX+m1Agg2yD1S+bfQ==
X-Received: by 2002:a17:903:1c3:b0:166:303e:124a with SMTP id e3-20020a17090301c300b00166303e124amr569042plh.7.1654071077376;
        Wed, 01 Jun 2022 01:11:17 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090ad0c100b001e2f3831102sm792288pjw.17.2022.06.01.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:11:16 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bert Vermeulen <bert@biot.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 0/6] irqchip: Fix some refcount leaks
Date:   Wed,  1 Jun 2022 12:09:24 +0400
Message-Id: <20220601080930.31005-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset fix some refcount leak bugs in irqchip.
The cause of the bugs are missing post handling of some APIs
——of_find_node_by_phandle(),of_find_matching_node_and_match(),
of_get_child_by_name(). 
These APIs returns node pointer with refcount incremented.
and should use of_node_put() to release it when not needed anymore.

I've sent patch#1 and patch#2 separately before, I move them into 
one series for better management. the content of them don't change.

related link:
1. patch#1: https://lore.kernel.org/r/20220526074348.23972-1-linmq006@gmail.com/  
2. patch#2: https://lore.kernel.org/r/20220517111710.37753-1-linmq006@gmail.com/

Miaoqian Lin (6):
  irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
  irqchip/apple-aic: Fix refcount leak in build_fiq_affinity
  irqchip/apple-aic: Fix refcount leak in aic_of_ic_init
  irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
  irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
  irqchip/realtek-rtl: Fix refcount leak in map_interrupts

 drivers/irqchip/irq-apple-aic.c    | 2 ++
 drivers/irqchip/irq-gic-realview.c | 1 +
 drivers/irqchip/irq-gic-v3.c       | 7 +++++--
 drivers/irqchip/irq-realtek-rtl.c  | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.25.1

