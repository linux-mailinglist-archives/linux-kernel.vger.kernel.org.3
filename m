Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3330754C450
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbiFOJH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbiFOJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D813EF0B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:07:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me5so21944757ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ES8ASp7atEPV2ulQuffz5wC8BUs7nXi4Sw5qO8jhvkg=;
        b=AcdJ49b0Bi29z4k9WIs/umbQSn3hzG3IsZWY5xWa1HzJ5MxJX9T3aaatXtRE9W7K0v
         M5EnWr6tivapFjV/mHmCvTkriyYlxDO4JwpyPIb1OPPZLQgthj/OIqM3pvGw+6nLQ7FF
         uHA6JoRaL9Y4X1TKkHWHFBPbQGmhzvHvqgt7CtEhnq+ZDtqoGlfbJnfwtS7g4vJgPkqH
         8m9VYik8RGygFcbAGu9uhrG3A+DNsfcuBpVTE1gMM1lPw0G45wegt0LWCndnvoAGsqWY
         T1j5+HZZxJeLf7rZI2DM9ulnWVKD3CiYaMIA9PHEV91j+VAEg6ZagNQhgJ7s918qxTiz
         +Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ES8ASp7atEPV2ulQuffz5wC8BUs7nXi4Sw5qO8jhvkg=;
        b=K0Hm0ns5686nlGAiWwSliWrS4xNCrMkTTjvsyyrlvEME0e4+thu38d6z1gUk0MEevj
         zqpUIAZ+lL0wTrWqBLlfwUKW8B+rmqSJTvYipm0JW59qQpIlcbRS3Zs3wugscTTxFDVM
         XNpNS5tREaXQ+cOZtoRRufxaTHAF5oFmcqQBGPw7rUcY+ux1skWoaHK4MtenrvpRyh4v
         QfJeU/NcgWGsr5exuQRH2sdmfPXR9mm41vSSKB7t7x2O7N8k+DKUpWUF/jCFTlBTnIlw
         pTVE41+v5DwZp2VuGM3uQHmdRsTyCcY4GHxmEpmhzEGLe7Gqrc5BIC1aFAQlfCNOwvzJ
         RE1A==
X-Gm-Message-State: AOAM533vPWgBMFwUBnR3KDJzuRy7jRjZBxLQzlFs+1Whi/RU6CdhvdvI
        yLMLfcdefhHZlV2pRJ88bhqQ+p2M4oRjPKBu
X-Google-Smtp-Source: ABdhPJy1F3MwoqOMBRMVhok5B3EpdVQ/7BYT8NMJ1xgK7RnqhIkziS7hSSA8KuSUyhhETgfadL47bg==
X-Received: by 2002:a17:907:dab:b0:711:d56b:4eb5 with SMTP id go43-20020a1709070dab00b00711d56b4eb5mr7720308ejc.93.1655284033514;
        Wed, 15 Jun 2022 02:07:13 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z22-20020a50e696000000b0042e032164a4sm9085602edm.61.2022.06.15.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:07:13 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 0/2] regulator: userspace consumer DT support
Date:   Wed, 15 Jun 2022 11:07:08 +0200
Message-Id: <20220615090710.1697151-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support of the regulator driver userspace-consumer.
The supply names for this driver is provided through DT properties
so that proper regulator handle can be acquired.
Also add support for notification to userspace of regulator events.

This is useful to interact with regulator from userspace.
Also use sysfs notify to catch regulator events into userspace
application.
This enables userspace application to monitor events in regulator &
handle them appropriately.

Laxman Dewangan (1):
  regulator: userspace-consumer: Add devicetree support

Patrick Rudolph (1):
  regulator: userspace consumer: Add Notification support

 drivers/regulator/userspace-consumer.c       | 100 ++++++++++++++++++-
 include/linux/regulator/userspace-consumer.h |   1 +
 2 files changed, 99 insertions(+), 2 deletions(-)


base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
-- 
2.35.3

