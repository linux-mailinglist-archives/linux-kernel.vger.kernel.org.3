Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D44DE9ED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiCSSLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:11:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505EA8FE5F;
        Sat, 19 Mar 2022 11:10:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s72so4678566pgc.5;
        Sat, 19 Mar 2022 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LtEYFIhXvvOvbebGSgHoPGrz8Zle3hfcrZFN/0LxkpU=;
        b=a2/ipdQsDvhPI0UOcDkGgwuuCpw4QIJ5bRBz40eCL6hK/YbShxPAVUtP4LScDf9IMf
         86nKDx//mXWzY6LVURNDkQQ5Kew0nF590eaFPt3ndUOP7UZWDBrsL9+IGH2B9ewGqAWM
         kgZ2MN9uXpf8Zyrax+pqJzC0wmwxB1Mz5HpOjkJm2FH/6MvA+30dNcoKB0RS9VkJCb7X
         30K6Stp6++6/phd5YGDYcXTwKjUxYRJMxxfF9YaF/x4w418T8hYxAMoqHGiipvmG1AKx
         jsPawUq3YvF9rIQcVg9ok8c7n+Ab7S4nBTPogZYemf78qEM0I25wDuImuNJcJFXBYHXE
         1qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LtEYFIhXvvOvbebGSgHoPGrz8Zle3hfcrZFN/0LxkpU=;
        b=LjvKlnXya+SvgVwzx1iV2WRGA5om0Gxh+IyMErP9+7ijb8UCSk3/VTY+Hoe8ohAFRQ
         5fzXaQtJwrusHvBruC9tQUqp21e39HdblL9gYJYiFnWFAMUlukHik2w56eBNTQ08ovy4
         ChDLrbUZ5z/hAQsz399/5OpDzSaZ8WnYtoufDc8BABhslHEBTm88SiJd2jMHUph7OWlD
         76W6Izn48GtWg/PudEsKxmtMBgCNqUGcZyUVKQyZhD9R29w/QAQc2XMFXSgNnxNKDfc4
         L6Bshx/C96nIjZN81RpDNGr+i15A/UyMe+D1jVpbirmqTWwsItOAquYIhkSQEruG2xob
         KtLA==
X-Gm-Message-State: AOAM53029E5SVbOXIrgiw9YJIpHYbeDnqiXpcdB3UXPc+uPvvGeOD294
        dTXD1iEegKimo8c5O0YB+Q8=
X-Google-Smtp-Source: ABdhPJzL+VvGk+vdzMYdGs8VJnd7U/7/3SXXPNH6iUlgZv2OrGz4wVE+uv/xlrBteZ1dqZsdh+yOkQ==
X-Received: by 2002:a63:6a41:0:b0:37c:53a1:b5b6 with SMTP id f62-20020a636a41000000b0037c53a1b5b6mr12312954pgc.245.1647713428798;
        Sat, 19 Mar 2022 11:10:28 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:28 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] iio: accel: bma400: Add support for buffer and step
Date:   Sat, 19 Mar 2022 23:40:18 +0530
Message-Id: <20220319181023.8090-1-jagathjog1996@gmail.com>
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

This patch series adds trigger buffer support with data ready interrupt,
separate channel for step counter and an event for step change interrupt.

Jagath Jog J (5):
  iio: accel: bma400: conversion to device-managed function
  iio: accel: bma400: changing scale min and max macro values
  iio: accel: bma400: Add triggered buffer support
  iio: accel: bma400: Add separate channel for step counter
  iio: accel: bma400: Add step change event

 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma400.h      |  19 +-
 drivers/iio/accel/bma400_core.c | 315 +++++++++++++++++++++++++++++---
 drivers/iio/accel/bma400_i2c.c  |  10 +-
 drivers/iio/accel/bma400_spi.c  |  10 +-
 5 files changed, 304 insertions(+), 52 deletions(-)

-- 
2.17.1

