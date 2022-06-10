Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1723546601
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiFJLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiFJLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:51:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472C13FB1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:51:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so23674687pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMxaR75bMLqsc01B37cpOfJUFHy3I5/nYs6WI9mLzUo=;
        b=KOSz7myazA2D0C8jKdoQ3ZquFUftWAHlSztDoc8GslLWaWmLeJf/MCJZEi46mWVv7L
         B5ZASCdjgQHMjKVghYHMr9xMi3P5avl5tusqae3L3KiDSENzMN2xzXKY8CbywjKGBVOC
         gDiTIBjj9CJBVH3YJ0gCM0Y5YLYUb44UmGPdrF2VVID0uwV8s+6+ArVSYd/DYIVwkZTD
         yQEE2Xt+m/sBKcVvpls7V1lMbZUQOHL/vT/Q9V3u6yeyG2953qlbaRIxA3TJZiXmLC0O
         IjA/0ln0opDPB0hMOoeFjM77vESQVrmHcVG6apqsKZoa1OmXuD/9pp+6OS1AG6II4T3k
         bg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMxaR75bMLqsc01B37cpOfJUFHy3I5/nYs6WI9mLzUo=;
        b=J/zL2Kju1XnLd3yDr6vuCNGbGFz8T09LyooUhsl5BlAhuWF1/1JDIhWQ8FoZ3sDTB9
         1MCYH3AijQqr0jkdjJgh1UAcneXptYH+zWNh+TTwOHQNHGEXxSYInhG3uI10R8vuRAl/
         SaXA+KsNMVrtFXy/tBiNxvcgaz1aItjTfsPmcb/bGRkFcLOchGYgQ5cyb5f0OtGKTadF
         AfFDiPUcMhdse5tcutr/hpiGTXl4jQIUq2O+6/OCUdH9OVhKVXxE2C1yM+vfyEPAs5OY
         f9yXTNqfB3sKifqTUartRtFvghw0nNVNRJ93Os7SGfIrWZA6sxHiHANnKN4VtbJ6e8Li
         J+Dg==
X-Gm-Message-State: AOAM531b+D1DJpaNt2DDp1n3Rm8+sETKBlAdJJpsYRDGN8a2Fo7dZj7R
        G7vShnnGBMHJR0PCs8bP53WhGKIrs2Gcag==
X-Google-Smtp-Source: ABdhPJzPAUYYA0AU5BeDMJM9MmENXl6bglZtNCS+OMuuXD4Uw7j4NdLnb5u72lz/DvJhCf1LYyA92A==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr45554895pfj.83.1654861891110;
        Fri, 10 Jun 2022 04:51:31 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001616723b8ddsm12638302plc.45.2022.06.10.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:51:30 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Fri, 10 Jun 2022 19:46:45 +0800
Message-Id: <20220610114646.162764-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- David pointed out that virt_to_kpte() is broken(no pmd_large() test
  on a PMD), so drop this API in this patch, walk kmap instead.

v1 -> v2:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM 

v1:
- check KPTE to avoid to unpoison hardware corrupted page

zhenwei pi (1):
  mm/memory-failure: don't allow to unpoison hw corrupted page

 mm/memory-failure.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

-- 
2.20.1

