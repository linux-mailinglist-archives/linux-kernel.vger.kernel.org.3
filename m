Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1554DBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359480AbiFPHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359421AbiFPHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 796539FDD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hr4e1znqmVeiTafw89/474qbn3xK26P9gUPjx4RV8LA=;
        b=Qx3TgaJmPicXHvPvF9nxN0jqeYZFfGVe1e/EqPUH3QseKZNxTaKY6AT5Cxs4F+858fHZA5
        sa+NJVlhFpP3spKObk/9Z4f7or81TrBLSxHw3Y9bpntF+OrRQBxsmG5DOv0N576CJKYEtD
        Z4SGO++yhOKZ/IVpZZ1IuCybjU/2pkM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-lXt_jxFDM26K1RTpsQqfvg-1; Thu, 16 Jun 2022 03:34:47 -0400
X-MC-Unique: lXt_jxFDM26K1RTpsQqfvg-1
Received: by mail-wm1-f72.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so283172wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hr4e1znqmVeiTafw89/474qbn3xK26P9gUPjx4RV8LA=;
        b=m03iXdc8DfoZhzPYqUnj1jGOgsiGxz5/5QIDApn0552kSQm6IQ7kgrl41lMWR7fFPA
         SJHnP86yMf5JCqkdUSLvJTc2aAxYv8w9uWVJ0pLfBTZVWE/cXLNh+JrjQ+ALosrlFsVn
         +vp1Bnv1pi/RSVqExvstvQttva0mT0qCBinclJWua26F0ED/caZZJH7e58vdfNgGXlLc
         GESVGAqUhwvmiJefGKKvWccOTB0EMe6cOW1MZwEtgr7By7Cx8Z/KrezimDiygv4Y1RHi
         mB/E//bk19vKc4qJROZxN4ZFC+EwaOsqcde/llIWQ+Ogw16VgYupgOMP0rqbGZpz6VZD
         TgJA==
X-Gm-Message-State: AOAM532WvnRF1wKLfmcQ6cYmnIBn58ngKKV9vI6r0xewi+lBArJHCebM
        mvOo3Q75D/zZPPfs0abjBxK7rxKRZh6vyCHl1fkgBL8L4/2IXs3YueH5ngyWepyZxybpm/MjAeh
        cQNynfhD1j+VpTGeefv8ttcF32N4oGDfRJUARxUMkOnMj8ypLa+djITy9jhIuU0xOJmPKwLlmEt
        Y=
X-Received: by 2002:a1c:f701:0:b0:39c:5539:cc4f with SMTP id v1-20020a1cf701000000b0039c5539cc4fmr14202516wmh.163.1655364885841;
        Thu, 16 Jun 2022 00:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZaYmtdTxixSdESWg4J3KGaahW/29PTeNO15EdWNRND7mtSBl9nc3Bi6nMIb0USzq23S41CA==
X-Received: by 2002:a1c:f701:0:b0:39c:5539:cc4f with SMTP id v1-20020a1cf701000000b0039c5539cc4fmr14202484wmh.163.1655364885463;
        Thu, 16 Jun 2022 00:34:45 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0020fdc90aeabsm1020123wrt.82.2022.06.16.00.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:34:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 0/3] remap: Some fixes for bulk read/write callbacks in regmap_config support
Date:   Thu, 16 Jun 2022 09:34:32 +0200
Message-Id: <20220616073435.1988219-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains fixes for a few issues found while testing the recent
support for drivers to define bulk read/write callbacks in regmap_config.

I tested this with drivers/gpu/drm/solomon/ssd130x-spi.c, by converting it
to use this new API instead of defining its own regmap bus for bulk write.

Patch #1 and patch #2 are fixes for regresions introduced by that commit
and patch #3 adds regmap_config provided bulk write support to functions
regmap_noinc_write() and regmap_bulk_write(), that were missed.

Best regards,
Javier


Javier Martinez Canillas (3):
  regmap: Re-introduce bulk read support check in regmap_bulk_read()
  regmap: Make regmap_noinc_read() return -ENOTSUPP if map->read isn't
    set
  regmap: Wire up regmap_config provided bulk write in missed functions

 drivers/base/regmap/regmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.36.1

