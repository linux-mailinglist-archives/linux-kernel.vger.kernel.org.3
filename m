Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9842F54B71E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbiFNRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiFNQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:59:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7DC2183F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:59:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u12so18355075eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2tjO3wB6SuKT2q2VheL81s3vpLWkHWnd7v7Vj0VbC4=;
        b=ce0ba2mehJGzXws79rmY+x6vpadfpFRwhY33iknuRZUfnb7GJ4KhFxGm9oaErVZY1O
         pJcVlbrGyer4sNDn7eJ5P1hexJDYoYw5HCdLwFcdt1DKZqLHPMnXb1CpeK3L59KNcMMj
         dTvMcuM2Jk3/g0QOlfAn5mVcsdePxF85B3vlPWhI8z2vWwX+V1XKC9AooT7EVoecMBkz
         CxunB0iGIwPfj2iLWSBQvR2DCAESx7TmgqmFZ3zqHicQEyE9JQBNIpb5yjtrYjK3I4oL
         PdPaCgUI0lvA6M+4qCrroQ/MT1Rf5STraSLG4x9uhtowK4VfidDUA0u1LSDCHCSv1b7O
         iPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2tjO3wB6SuKT2q2VheL81s3vpLWkHWnd7v7Vj0VbC4=;
        b=tz/F7/JQOeXjgFbiCdZsSeVYhM5mBlL8wplEw4hDDNrte5/tkTCsl9TBOMPlqYkS+Q
         E29S8fcp1LFAf30tJgYtMCysD1fEK/v+oPBlmanQfF3qPRbkrPOiM6Sf6sDLwvR4i+he
         pdzAPS2nHOw9ocUmvQiag1YwGxwbzpV8N5lhgeBj7RJbB77ckv89uLmG06M/sswgjZbP
         wFhn+nqAEXnfId2yRBTbIkmaJXeQ4eLD78LxThpBRogEGeMr24G63EIViQBfBV/fZAVb
         +hBtHcFRbhlLD5Qug2cQX2jn7+Z2kYuWTEU44tz3l21aBDXjIFakB1LPZ0lwOEzE3HAJ
         FSCQ==
X-Gm-Message-State: AOAM533NwgpXMFGXl7OBRnb1c3PFiVrtM9WK36Hv5kTdjz0BFf2/6U9J
        KIlj68QkIkS+sq8PdxXU4Nf+2PX2wp6gtnu+
X-Google-Smtp-Source: ABdhPJySTXEk1fKYWKedu40U9nzEgtggOebhMLsTyoQlLqpJIjEWC8rNZ/xGA2ArM6cmbkztZqZuqw==
X-Received: by 2002:a17:906:6946:b0:70e:e904:8e87 with SMTP id c6-20020a170906694600b0070ee9048e87mr5091697ejs.629.1655225978073;
        Tue, 14 Jun 2022 09:59:38 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm7616375edc.29.2022.06.14.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:59:37 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/3] regulator: userspace consumer DT support
Date:   Tue, 14 Jun 2022 18:58:57 +0200
Message-Id: <20220614165901.1084639-1-Naresh.Solanki@9elements.com>
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

Naresh Solanki (1):
  dt-bindings: regulator: add bindings for userspace-consumer

Patrick Rudolph (1):
  regulator: userspace consumer: Add Notification support

 .../regulator/userspace-consumer.yaml         |  66 ++++++++++++
 drivers/regulator/userspace-consumer.c        | 100 +++++++++++++++++-
 include/linux/regulator/userspace-consumer.h  |   1 +
 3 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/userspace-consumer.yaml


base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.35.3

