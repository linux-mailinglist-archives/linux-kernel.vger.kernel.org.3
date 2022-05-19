Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E852E093
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiESXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343547AbiESXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:31:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A019B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so6347169pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwSe3k1WPpGsspS4spL40+hi/N9R/s/rEIUUeadVkxs=;
        b=h4OusNuHqPUQpoVF2RG6X/w4hFrTovEvLuqCMhOgFNgc1dKMlXpEFMsPzzmGGLkXO2
         p0vSLnuoFhsUgtOXDqz08Dj3qVigVMTgiyTEVkY1v5yQw8ayF0fe6epDiNPQz8C63Nvm
         IOJyHfrgvcJJ895hAR2SdMXm6G89qdWotEOVutrkKhZXjv012+mi4BFkIJCNBWN6IEnW
         dUKNBV0gUnbWYasQPNehgQa9QKQGLVoOotvGt6tlpFMr69zyFvhdyOnsrGR6eJIXa9hI
         dKALv/qiAqhAADiykg7LC4Qqw2F3NorK2s4N7n6Q3JKgfscq90DZgzcKiuEopyb/SEhM
         DMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwSe3k1WPpGsspS4spL40+hi/N9R/s/rEIUUeadVkxs=;
        b=4VE2Ld7j2QvtQUMhS92mIhtQPHO36/OT45zbJYUT1aScibY6f8UEn5oNCblzCCTP9K
         GCxHeU/Gtfr0wnmfCs0P3pyFAm1xmQXeL6h96wbk3K7edR39qsmmPWDzjw5ha3CG+RO8
         rb/xxyqQx5pQZnxs7mjLKn2nMhbfI0cLP0Z7S7TTnfHEhZG79OaQv7bVjILNGs8F73Ti
         n/YSOZYQZuvAtnJpkO/rJ2fWOWiEAzsxi8o7A2CsDkkET6nqxMQxOef2uPlsbYdtTeaQ
         pPXTXrOSIefEf0jamVPVXeEdTy3hNtEz0letSIk53gKGG6Z14Snp7s7gRc1+DXY4h50D
         8kjw==
X-Gm-Message-State: AOAM532Oz3ekA2U84ZZXqZm7hnPmoqLrbwZoSmvU6XQ6H8JS+1LlNasS
        fad19t6YplP+5iVLf2HgxChc6Q==
X-Google-Smtp-Source: ABdhPJxj2U30Zk4ivxs5JFJMe9XGvLYF30IQhKqgQ7xK2vz7DEWxOPG1m3Qs8Lc7OhZm2/odGBvGWg==
X-Received: by 2002:a63:d57:0:b0:3f2:6b20:e00d with SMTP id 23-20020a630d57000000b003f26b20e00dmr6022132pgn.624.1653003101230;
        Thu, 19 May 2022 16:31:41 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b0016191b843e2sm4331249plr.235.2022.05.19.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:31:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 0/2] Fix splice from random/urandom
Date:   Thu, 19 May 2022 17:31:35 -0600
Message-Id: <20220519233137.20415-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
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

Hi,

We recently had a failure on a kernel upgrade because splice no longer
works on random/urandom. This is due to:

6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

which already has more than two handful of Fixes registered to its
name...

Wire up read_iter handling and then hook up splice_read for both of
them as well.

v2: rebase on random git tree

-- 
Jens Axboe


