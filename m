Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468F5ACD83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiIEIQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiIEIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834B27CE8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so4019533pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RUYURRnuSvq4NT9sTSJkuNMIMv1250uZHq66s+BflcY=;
        b=G9CyBAGR0bkiQTupvpx/COu7sAEq+idFHL56EGyRChnlFH9hO3qv0An9jOfeYHmwC9
         RYUiKs3MRQxpEjyhyD8AOosQpaW0SJ2YGBr9lw8m5AE6LAHwHcubtym968taJV2YOFsi
         sqdhNS3Xp6KljIYPCCzTQhtbmF8nuzhwEGA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RUYURRnuSvq4NT9sTSJkuNMIMv1250uZHq66s+BflcY=;
        b=547cq6pu7imYpFO22SHpCwzaGrNYQqw+WvMy2xOKhfOIXReg6fwLjx/UCTWjOBTdzA
         jfTaJnWttrCOUZrFIhSGWMddQJ6j4WUx3ueGgf+r808GKAzgqulLvRGBWep5/tf6cH2q
         BF1Qe5z4n18QoidN2FjndjDS8kAvjeYPEwRncbjKK0fItbEzcC9UWbav3SW0FZcs81sk
         UIzkgDm2iEC0z66++uLkrgRE4e0iihfWUWn2sF3pu5YjpKuU08sIaAiovB/xY7JgyFdw
         oXIR93QWdFiCc3wCkqdqr+I4ckloKkKAXd1ClvktY2BNhvEvhvlNF42hUsYMHgm6Cy/r
         Y9/Q==
X-Gm-Message-State: ACgBeo1hUIYLzvR7YPDp0c16x5bCgBSWjYlpe2QEf3lulPVoozM9QHg2
        CPM243ob8rBE5BtYAJTsMjdmNQ==
X-Google-Smtp-Source: AA6agR4KuIMlqoNshNHLtk8PkCAoUWto2+pwOemnkdYiczYkaWFTB+6fYFnJFqawp1GEJA7eAWbNPA==
X-Received: by 2002:a17:902:b098:b0:176:86b4:68d4 with SMTP id p24-20020a170902b09800b0017686b468d4mr9821254plr.161.1662365762385;
        Mon, 05 Sep 2022 01:16:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:01 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 0/7] zram: Support multiple compression streams
Date:   Mon,  5 Sep 2022 17:15:42 +0900
Message-Id: <20220905081552.2740917-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	RFC series that adds support for multiple (per-CPU)
compression streams (at point only 2). The main idea is that
different compression algorithms have different characteristics
and zram may benefit when it uses a combination of algorithms:
a default algorithm that is faster but have lower compression
rate and a secondary algorithm that can use higher compression
rate at a price of slower compression/decompression.

	There are several use-case for this functionality:

- huge pages re-compression: zstd or defalte can successfully
compress huge pages (~50% of huge pages on my synthetic ChromeOS
tests), IOW pages that lzo was not able to compress.

- idle pages re-compression: idle/cold pages sit in the memory
and we may reduce zsmalloc memory usage if we recompress those
idle pages.

	User-space has a number of ways to control the behavior
and impact of zram recompression: what type of pages should be
recompressed, size watermarks, etc. Please refer to documentation
patch.

Sergey Senozhatsky (7):
  zram: Preparation for multi-zcomp support
  zram: Add recompression algorithm sysfs knob
  zram: Factor out WB and non-WB zram read functions
  zram: Introduce recompress sysfs knob
  documentation: Add recompression documentation
  zram: Add recompression algorithm choice to Kconfig
  zram: Add recompress flag to read_block_state()

 Documentation/admin-guide/blockdev/zram.rst |  64 ++-
 drivers/block/zram/Kconfig                  |  51 +++
 drivers/block/zram/zcomp.c                  |   6 +-
 drivers/block/zram/zcomp.h                  |   2 +-
 drivers/block/zram/zram_drv.c               | 432 +++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  15 +-
 6 files changed, 504 insertions(+), 66 deletions(-)

-- 
2.37.2.789.g6183377224-goog

