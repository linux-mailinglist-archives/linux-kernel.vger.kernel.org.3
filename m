Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0998529235
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiEPVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348999AbiEPVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:04:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA565BE4D;
        Mon, 16 May 2022 13:40:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hh4so12958863qtb.10;
        Mon, 16 May 2022 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRyYZy7MUY9Z/ZyS1jq+AuFFP7q0GxQUZ1g6iG97tyM=;
        b=jRAPfAxvk37A+4zg3JePp6ctoOo27aHfPQzvPO/cLLDVov8JMSdbL5Goe5mzQ1GHVI
         e1KgC/HsHj91CoO2A327UT8DcApUlzJIiPG5K38EJXtL5Vs+JLfh4mAoXfQQ/873B7EG
         AIrLk+0G9EcwbbiYW2BGLPLYVFzo1g70p+B64FCCRYzTi6CCMkyQzG4rFAtzMZskHrUa
         g238LZVFMqIHDDcFq8qJOGTvvMVmCyVIsDi3iLIy6iqzK0x4ZHwVnxSDwBlPpA6Uh9JR
         ZrcCXwJZoMI0V4RLN5EVsFxxHRyuf5sTNC13xv4Btbgo37b+APRDSSp/tmoo+p5j77jI
         XjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRyYZy7MUY9Z/ZyS1jq+AuFFP7q0GxQUZ1g6iG97tyM=;
        b=dauOcV08lfg+FmpNJVDRRO8fSs+d84+shxfrDnp4ivITeRiV8UCqPcSJxFtAEg7Jeb
         auX5gyubBlHAUEol/ZGEPt0VBpajoBBDJS/kZg4PmKFe8bjgIvanl/6kX++cGqZ5saOB
         gzGjJX1FSL/9oJ4ILeNVf1pzZl9O3n52p/qEi9QPy1qfJLPnShH+31Mwo5khhAgsb15m
         qxrj/qD6GCkagXcz8V7ICEnE3Ver0tNv36bGaqaRdZ77FhcL9VhS0IzGK9ULcSEs8PL4
         Wz0MqytTKvy59hku2KdkHZQ5iNQ0svKO+poE6NbajJr1ZBnGC5DxJh/MiByy46mTCJQP
         ys5w==
X-Gm-Message-State: AOAM530TKNeJaPaP3d9xGRTzPywbINb51XmygLXLGNMdR1bH/3r9x4Cg
        L/TRUfr9E6Ag/NB5jdMnBw7A9RmVXqd9FA==
X-Google-Smtp-Source: ABdhPJzxCGqOh+bB58fssYdqVlJzJSN0fs2Z5kI37E/iSL/1fO8Hyo71gRgar0YDeHHlg4FAjH1MeA==
X-Received: by 2002:a05:622a:19a2:b0:2f3:cb4d:d4d9 with SMTP id u34-20020a05622a19a200b002f3cb4dd4d9mr16554824qtc.245.1652733599224;
        Mon, 16 May 2022 13:39:59 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id k67-20020a378846000000b006a00fabde68sm6364016qkd.10.2022.05.16.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:39:58 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: stm32: Fix ADC IRQ handling on STM32F4
Date:   Mon, 16 May 2022 16:39:37 -0400
Message-Id: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Changes to the STM32 ADC irq handling broke the STM32F4 platforms
These two patches bring it back to a working state.

Changes:
 * Removed spurious IRQs detection
 * Updated comments and commit messages

Yannick Brosseau (2):
  iio: adc: stm32: Fix ADCs iteration in irq handler
  iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs
    message

 drivers/iio/adc/stm32-adc-core.c |  7 ++++++-
 drivers/iio/adc/stm32-adc.c      | 10 ----------
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.36.1

