Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169034864B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiAFNAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiAFNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572CC061245;
        Thu,  6 Jan 2022 05:00:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m13so2410749pji.3;
        Thu, 06 Jan 2022 05:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGq3ShW2TTQdgs+pbYsqrAkWXmM8JdNsZZVvPiYmWKw=;
        b=S5GuvVdSsndX1HCvgu99dl1b0+yb/LWHzBknETYeUEwz5SNpj1WvKZsPiU/oFfqqAJ
         z2w+uLuO2Fktgt0CqKXRBVmo7821oc+ZFHO7BpJ28MmMcXtHdVwJZoblMJ8wjaB4HC3N
         GdeuDC3ER/8CmeCFExawkuYuHVIVQ3fI8I0m3ZUp31STGaFn7clxn0D4/rFo7e8xgDl4
         N13/GJTQHBNR2/FBBNdT/qfUCMSn5gWXD+2G7rYHmnwr/pSvTNcf8684knxJHQ2d0wue
         VPzR1afnhCYhc/l7IWNOQJBaVfbLQKp4LJm2P1Em6QU9mCEXecNc12XgnNNDNcodO7G+
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGq3ShW2TTQdgs+pbYsqrAkWXmM8JdNsZZVvPiYmWKw=;
        b=5URJ9NQrzg8XCIbTILY02yPjT7NKyAEs9H5AimqpRZrwckwVNeizl+1626B9vFT6cQ
         Mh0V3pppcGIxml5i3EEq0e5UeYWTrwGHHbeCb6PaqZFu0j69Urf1XvFd57VMD8U+pdu/
         xbMZYbYl2P0Kq0gjI2z5z/pBtzGV15G9eEHmlxwlIPEbpjpbnEinPwakcqh49M03P22F
         wwoWZGfBX1MZzrXrG0bfULKUKU40yutvWphvOp9Hxc4RluQXFpmFSY9AKIthRpQdYB0k
         +jh8lQZNjWKjI3xaPMjRz64Ok4eobk0+59pnk8McpJE+aYYwSy3c0NNjdcy3Z79jknHa
         QKlA==
X-Gm-Message-State: AOAM53024tTKMJBk0aJYftaqJNpemPBqyQbcRgKi+ZdE1ae40EmQh79h
        XaswpQ299hAUnqrKcO/9xFVUQIXJqyjsCQ==
X-Google-Smtp-Source: ABdhPJzrWLCKt28CCVACH5wx3Z9oJR6uXcvKjjwKNC2oMisaqwnXkajkF6v2W8QWOFDARz1vweDSWg==
X-Received: by 2002:a17:903:191:b0:148:e4d3:e8a9 with SMTP id z17-20020a170903019100b00148e4d3e8a9mr57994598plg.101.1641474010037;
        Thu, 06 Jan 2022 05:00:10 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:09 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] iio: adc: sc27xx: adjust structure and add PMIC's support
Date:   Thu,  6 Jan 2022 20:59:40 +0800
Message-Id: <20220106125947.139523-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

this patchset add a sc27xx_adc_variant_data structure
and add sc272*,sc273* and ump9620 PMIC support.
also add ump9620 PMIC suspend and resume pm implement.

Cixi Geng (7):
  dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
  iio: adc: sc27xx: fix read big scale voltage not right
  iio: adc: sc27xx: structure adjuststment and optimization
  iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
  iio: adc: sc27xx: add support for PMIC sc2730
  iio: adc: sc27xx: add support for PMIC ump9620
  iio: adc: sc27xx: add Ump9620 ADC suspend and resume pm support

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  19 +
 drivers/iio/adc/sc27xx_adc.c                  | 767 +++++++++++++++++-
 2 files changed, 759 insertions(+), 27 deletions(-)

-- 
2.25.1

