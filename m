Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DF4F6B93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiDFUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiDFUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:49:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7473221DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:05:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qh7so6165155ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVR1WiZiDN1kb7YdBQvF0QqeZSGem3zHMrQcF73X4Lc=;
        b=qLl81TqYj7KzL7UIqJKrovWynPv9i9YvrVVkvOnoxFVlUcwG/sjbdtihwTOe+I6x0J
         AvYqxznOHCH4/ucJ4CilN4lN5sdk71M9YhTMRg+MedHuhoY0VVWAkFK+M4DOw06geXcM
         OHeJE+ydwDEU9HQX4v/Maz5qOgnt62yz5qb28yyldCNFBOBg/sDSC6Jlff1PlnIk6Onq
         HQHiBU0Y2UgnZ80NhbgVgpMiw238blT+ZIj0vzf9cE8r4RoEd3BaaQTsRwFwpEpFz4X8
         1Vu2KbY/K3ByXSx8GQmQAcF1jWtUidYyxJkp5WRKP/G3WhzhZ7jPDJTmv96CcykdZkEI
         TjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVR1WiZiDN1kb7YdBQvF0QqeZSGem3zHMrQcF73X4Lc=;
        b=CT9NcRtDHDmztj2Grxrr4vbIALC59u9ejvWuVR4TrhKg+mL9P7S8j4GGcd2RqrLyax
         LW9iVVtTDiuGokzYVG1hQdW9J+h6hX0JYIxJvTfT+MvGdnER3eS0CrCRq3acVxeWhvrN
         OMqimiLBOCyf5jkofxNzlBdJhs37pguhYM8iJPhLLBhPaAnNkvkn7tEmWA+SjxaArJO6
         l/qRPZOQyjaS5HvkLILiMs6N26knEs7ESabDV4dLVamhIc0ny5bAZtUHq7FXyyUJSSjT
         lOqSgitZ3JY4QUX1m9H1WrEPo4J76VUACzoAKCpwzTv+KbUYcvEWAh3NcLmsaLNoCsF3
         0U/A==
X-Gm-Message-State: AOAM531Ifd3Yq7TnjqPfvbTpr5Gkn2wUbCaeaY6xxWubX6H1qHyaP23A
        FdNjIhtxG2EL8deGFEHnoG/RBQ==
X-Google-Smtp-Source: ABdhPJzA8EL6/H38z0G1KGmEQjtYeR2zbJjBAKFQ3Wa+amzYg2FhNhCv8dTdSSlXd3LPMZPUAJa9/g==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr9525912ejj.431.1649271904122;
        Wed, 06 Apr 2022 12:05:04 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm6919876ejy.37.2022.04.06.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:03 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/3] DRBD fixes for Linux 5.18
Date:   Wed,  6 Apr 2022 21:04:42 +0200
Message-Id: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assortment of more relevant fixes for DRBD to go into 5.18.

Christoph Böhmwalder (1):
  drbd: set QUEUE_FLAG_STABLE_WRITES

Lv Yunlong (1):
  drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
  drbd: fix an invalid memory access caused by incorrect use of list
    iterator

 drivers/block/drbd/drbd_int.h          |  8 ++---
 drivers/block/drbd/drbd_main.c         |  7 ++---
 drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
 drivers/block/drbd/drbd_state.c        | 18 +++++------
 drivers/block/drbd/drbd_state_change.h |  8 ++---
 5 files changed, 45 insertions(+), 37 deletions(-)

-- 
2.35.1

