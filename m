Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB84CB173
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiCBViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiCBViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:38:05 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C64B67
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:37:21 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so3552705ooi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFoBwGzYxG06VqMrwANucJbCVjfifnyESi4CFIqSN1M=;
        b=nNmzwVxiWRwKwN4k4KLmSPlj1rv5VnF1B49cvukbQeWS67WDJ9QAg2++oDNyT57RI+
         i3D/z3/XivykP7cyczWy6+V9jzG+nkqBPJ62f/HjrMdvkBuC87pk/VGRN9t8zWS6Y2EM
         KyJpZ4YIOm3TVLwg7kxxYIi87jCvCuIRJXmgF8Pf34HDKyVwwfh9DCgR22gZKlNLpy8N
         r00TjoZ2DT80BdXz+b8w2yoD3T7MByJS8lJq19ZEgoJHozGvZzMmcd4PfV3HO15XbCZn
         J1YFY+bYn7SzI7WmIKBHHCBSct2mNdLtbf8N8y/EQXk/EdkFpF71tW+JZpmmHpIm/4D5
         u5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFoBwGzYxG06VqMrwANucJbCVjfifnyESi4CFIqSN1M=;
        b=w7AoDExB9frjDWm/5eECGYs1te+7fTEXG/21hWNN9KGvf6QlZRA4u18y8O8j5FvrNp
         +vrUiBfKd5oKAdoGt/T45PgZI8xB6YSr2OuSJtDmZcrN/z8/nMBKqnKqhwBOnxZVs9VO
         Qk5l3p/eRxQRg7mjhjGlr1pe7rlbpD6j4pZSXvHwSFYGZ30HKnCH0qeFaf71ej/473m4
         jfaEPiwb5K0uDO1B5aMczUjHnlMrUT6n+2LIAO7onjHFsQLp6hOli+4V9z5AXuzo52d0
         bRgc0uwz1Z2WeaYsNj0qa3JajQURFnqyoSwJK8GK58/yW7Z8ZaMRkNeTGQ6otYnSNai/
         bDpw==
X-Gm-Message-State: AOAM533BoRyjiccT1PMOxkKPEKAugGFL+LFReKinCvWHHtmSJFyelAI6
        /d5Rh8pUnb1Vm0X+zHcdcIs=
X-Google-Smtp-Source: ABdhPJy6tfwEOrcQ5ol2+uAric46RZz/5NMzYCGjrl0bET88DJqM5wvmKMOPttH7p4qIgAgYHzs5RA==
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id gk24-20020a0568703c1800b000d722ed20b0mr1549165oab.32.1646257040662;
        Wed, 02 Mar 2022 13:37:20 -0800 (PST)
Received: from localhost.localdomain ([181.23.87.56])
        by smtp.gmail.com with ESMTPSA id s12-20020a0568302a8c00b005b010d92dadsm69132otu.69.2022.03.02.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:37:20 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 0/2] staging: vc04_services: address W=1 warnings
Date:   Wed,  2 Mar 2022 18:36:34 -0300
Message-Id: <cover.1646255044.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set comprises two patches that fix two "no previous prototype"
warnings in vc04_services.

Gaston Gonzalez (2):
  staging: vchiq_arm: make vchiq_platform_get_arm_state() static
  staging: vchiq_arm: add prototype of function vchiq_platform_init()

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.35.1

