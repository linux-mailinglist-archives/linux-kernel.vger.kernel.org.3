Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3B536F41
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiE2ECC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiE2ECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:02:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A66CF43;
        Sat, 28 May 2022 21:01:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y1so7735397pfr.6;
        Sat, 28 May 2022 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OFG+5Ru/guQtZ8zj0xxp4wzhZULYpILD025xDdNT3DE=;
        b=YLMHpRk3Jrlr2oZnPAvFnWIjwzUzeWc1HdexI3s1WVHnorypnohZlYWGNoSCdlooFy
         8n1Rt93jdmmy5AUGrye2yuSCCWVL5DvTK7K739/vv7rfxDQIwOO8llxhPb7mOBRuAcmZ
         HWxC+6Z2spVfyV5w9OMdJt42LzKunupbhfHO7+Su674mI8GxivnyoLpZTQeUsWYcWGa+
         AZerMZCHN1Wo7Fm8edFX2M3bJYK/XJu/aTyXC5xwgRsELipPVthQZQ2diCocnqUo5YZe
         acByJrYrU4ggt1QyYNa9whrYpDdUsJO4jSJ0X1J9wYhCFaC1HhqHVeAFtMbmBl0IvtV3
         YoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OFG+5Ru/guQtZ8zj0xxp4wzhZULYpILD025xDdNT3DE=;
        b=48FdkcpG/0p0dcsMqhHWrcnWrcf/YkMcsmb9bJ/pnVAm604NAXBi8DeRzf6QL4f7yq
         HIb/OFHeL6ktI9kCByG+yqKMOIyb2mlBSrv+vNI10E3IwC2CtaB/4YQlCIU3wM8Bdksw
         UFCKWwBowcB6kSMoD/VrrIrIVKiK18WvjbM3Me0Ch6RRrRzt+cpwLvdiie45K1S3z3ju
         G4aGkR9jLJkmOhpNO8LXmjMFhbWBWE21feBIV7AOXPG18Ez6t6CN86r1DwPEUJgf6Q/B
         xVEA6NJrqI07m36bo5ceE0+lS8/0ru2NQPKgeJ1E/QvrNoAZOHyMoxaXCW/GybibhQIx
         T+qg==
X-Gm-Message-State: AOAM531CnxEPjWQ6ClghaZkEfn+o/DNPeOYfnr2hGl+yG7r7DC3/e/SM
        f8dz4mpQ6LNKr4R639Hdq20=
X-Google-Smtp-Source: ABdhPJzWpGl5EWit0E+euLynC6pDrJ65fw+PQXhqMKcy1tiBx2H5RyTkg0c/HruFUWehFaO/K4a1QA==
X-Received: by 2002:a05:6a00:1588:b0:518:8ce2:7753 with SMTP id u8-20020a056a00158800b005188ce27753mr37101136pfk.51.1653796917777;
        Sat, 28 May 2022 21:01:57 -0700 (PDT)
Received: from localhost.localdomain ([115.99.139.145])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b003fbfe88be17sm377581pga.24.2022.05.28.21.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 21:01:57 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] iio: Add single and double tap events support
Date:   Sun, 29 May 2022 09:31:51 +0530
Message-Id: <20220529040153.4878-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new event type for tap called gesture and direction
is used to differentiate single and double tap. This series adds single
and double tap support for bma400 accelerometer device driver.

Jagath Jog J (2):
  iio: Add new event type gesture and use direction for single and
    double tap
  iio: accel: bma400: Add support for single and double tap events

 Documentation/ABI/testing/sysfs-bus-iio |  19 +++
 drivers/iio/accel/bma400.h              |  11 ++
 drivers/iio/accel/bma400_core.c         | 186 ++++++++++++++++++++++--
 drivers/iio/industrialio-event.c        |   5 +-
 include/uapi/linux/iio/types.h          |   3 +
 tools/iio/iio_event_monitor.c           |   8 +-
 6 files changed, 221 insertions(+), 11 deletions(-)


base-commit: c321674386d8d5597831cbf980f566df8c98d4c1
-- 
2.17.1

