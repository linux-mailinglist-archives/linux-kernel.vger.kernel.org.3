Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B64C4B12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbiBYQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243222AbiBYQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876475207;
        Fri, 25 Feb 2022 08:43:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEE261C1A;
        Fri, 25 Feb 2022 16:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBE0C340E7;
        Fri, 25 Feb 2022 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645807381;
        bh=APXY3EnRpsBOupquCiWiXnjHHke28N5/pcJDyEoZ/UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=U/Ibm/gp6t9I+K0zJ8pjRvlOOUkTCoRp4vLm3L/rDBwerli1baLd0g/ZdU88LPdBy
         RZ4d7Y2jBu/del2aMnr10HRGLH5u8IOuIW9/5AMzEudVp3LwC3U8mkSqyAjDgXMvON
         HBPz0nA6WcKBDsnZO32sKJ2K7Xg6pULjiaRhDJETda0LhPM1KGZVg5aIQnKMW1JPSY
         UHr+6AE2mSRh9IXr/b1zi1Rcbo13RxP7hGp0F3KFLBA3fycHF6yEFBsRZIkzP/y30g
         KKzqGiqxA8eL3nSmc806TYft/Qv9BSCbsKVvrIxu94EfNCuaA3eHdzzkpzhOTA9ElV
         Bq99ghUu2qnwA==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Allen Chen <allen.chen@ite.com.tw>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Date:   Fri, 25 Feb 2022 16:42:31 +0000
Message-Id: <20220225164231.904173-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the drm tree, today's linux-next build (x86 allmodconfig)
failed like this:

lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x10b: call to do_strncpy_from_user() with UACCESS enabled
lib/strnlen_user.o: warning: objtool: strnlen_user()+0xbb: call to do_strnlen_user() with UACCESS enabled
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c: In function 'receive_timing_debugfs_show':
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3077:23: error: array subscript 4096 is outside array bounds of 'u8[200]' {aka 'unsigned char[200]'} [-Werror=array-bounds]
 3077 |  u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
      |                       ^~~
/tmp/next/build/drivers/gpu/drm/bridge/ite-it6505.c:3076:5: note: while referencing 'read_buf'
 3076 |  u8 read_buf[READ_BUFFER_SIZE];
      |     ^~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  b5c84a9edcd418 ("drm/bridge: add it6505 driver")

I have used the drm tree from yesterday instead.
