Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E45ACDAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiIEIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiIEIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:23:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A62AF8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:23:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l65so7964814pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nUCnbO2absdQrtuWPadW3KdoRD67th+lOoHZlFDSG0w=;
        b=aWNl+LDCwjT4MllzwLAjGBRtqoB6fZkiMJQ/HvqlnAEhfYabxJ9+lZ3yEqT0LN2G1W
         0VtCs/zaBeO2fygStYLMjLOYtPZs26i6XVMRpIWsn/R+EvG5WqNAoew5+eItYMxiv5Hf
         qUJbChc0iv9noh/D7033VQ/eBI9wB/zGzGylA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nUCnbO2absdQrtuWPadW3KdoRD67th+lOoHZlFDSG0w=;
        b=D119ywLyahAqEb2KZmdg2r57RaAOtAk6Fr57p/iJXwvvIQob+YJwCOU/WVBlYiO6eY
         2kWBrE+nuUxZ/1XkvzNsh22uNDF/RJWfRcvOk/5ghscH7rQgvmtJkUDz63S4I/E49dNe
         YeNQfSIAMgcW1EW+I62xKDog3EQmx/ZpsCWL6cTYxpHbhxiVgPRWft4hdam6sPuNvRdg
         +kuXK9lzCrb2qV882BWQp6n321miMNGQoZyjaLphAZHF90DWubNg09bUVpK/dU7SWXTE
         X78Q5w3GgkaLy+/rrikV11YWUwTu/BMNjBmD7JMxCL3xbv8OsEc3nQB/YwZx7MFOl6uU
         LvHQ==
X-Gm-Message-State: ACgBeo2Tv+uQC1p55nz+LyNlCpwxEj2ZuHoyIet2E41DsIgWj2cgcuPl
        6k24OrHoCJWTcHK4WvhlmzcZanxbrvMdNA==
X-Google-Smtp-Source: AA6agR4nHkQjA2Q96hRzWMzbFe/tamyeNKFnpMQI/uo6RzB7V4qAkIgp41HXHw9pfG97iYm1ecnLCg==
X-Received: by 2002:a63:4503:0:b0:430:48ac:6046 with SMTP id s3-20020a634503000000b0043048ac6046mr20266544pga.74.1662366209571;
        Mon, 05 Sep 2022 01:23:29 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm6807093plf.30.2022.09.05.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:23:28 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 0/7] zram: Support multiple compression streams
Date:   Mon,  5 Sep 2022 17:23:16 +0900
Message-Id: <20220905082323.2742399-1-senozhatsky@chromium.org>
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

