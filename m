Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865752B56A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiERIz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiERIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:55:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622D13B8FF;
        Wed, 18 May 2022 01:55:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t6so1696239wra.4;
        Wed, 18 May 2022 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCEO+iL8PzcVcziic8Uodsq5+0pyHWr11hT8on+eWZ4=;
        b=gFBh5Nf3KOSLsXC5/R9dO3VK6UrYrkWgVeOW12JiCAkUSNZOeAhn3Jh8gvAebC+xFz
         aTw2U1NwsFCHRtIYCMISIIzg6sBB/JCIK6e+A7pDK6ZVmp4WvTr2lwHeCxjhp8QX4OjQ
         kyONU/gXHGsOYK5whNQuAwVko9+r93bLV6HyMZ6aIRDeT23GcSGk01N80HWhoMMLKcvF
         LFlBo7xViunwknipyEARQ7/skDBOLxpZrhBNd5GjfrCGy4b5khijeXCIPrfJDQkrntul
         WayVmdD2qeWEY+bknZSqBzECSswhyuBUro0hzkcqTmuSRw6/i7BPYSX2sHoC7B89x0S8
         a2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCEO+iL8PzcVcziic8Uodsq5+0pyHWr11hT8on+eWZ4=;
        b=60H3BaMAzq+Wx0E/hxOb3It4oJF4uMs+KzfAjicuZ5bJzYAIfWNyhx+hq+MlKQ6+3P
         DNbyDSmvfbniRbxrUmWHygLCMtNwJhZ0QPXBzIIAMelt81VVMsh173nSxkeDmUkTuqDY
         R/tPDgT6tR/8xE4ixKSRGUwbabkKvASL/IpKhWImqLQMo9r+It2TP8L9x3GOcKqN79Hg
         0XHLJA2ZP9mAvWrzw34IoKE1C3uIFOxi9oUQRyqOfCzxrpgsm+8xIpx2/gRJjPDPb7XZ
         kn7ly/c0h9YQblWWcKYWA42tyHK1DI2f+lS4f6fdi1o4CMKusbjmq/SlJvcC9k21rGoI
         53lg==
X-Gm-Message-State: AOAM530Dax4MhzjgHfRySQ4rOdpze+FnN3GZykm6UN2s3FsvjLVltYyT
        1Q7xLsaAHJPbg9MaAthXrUxPMGjd2vV4P0PD
X-Google-Smtp-Source: ABdhPJwKra1tYkJP29iu9Ix2hAARIM9jf8t+ktsW+NhHHwzVbJmrFTptuDqdfpAd/A9Whq8jrU79FA==
X-Received: by 2002:a5d:6c65:0:b0:20c:5230:f145 with SMTP id r5-20020a5d6c65000000b0020c5230f145mr21454248wrz.337.1652864109461;
        Wed, 18 May 2022 01:55:09 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600002c300b0020c547f75easm1579622wry.101.2022.05.18.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:55:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: remove redundant variable ino
Date:   Wed, 18 May 2022 09:55:08 +0100
Message-Id: <20220518085508.509104-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable ino is being assigned a value that is never read. The variable
and assignment are redundant, remove it.

Cleans up clang scan build warning:
warning: Although the value stored to 'ino' is used in the enclosing
expression, the value is never actually read from 'ino'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 00c3de177dd6..20197f05faec 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -437,7 +437,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 	ceph_decode_32_safe(p, end, sets, bad);
 	dout("got %u sets of delegated inodes\n", sets);
 	while (sets--) {
-		u64 start, len, ino;
+		u64 start, len;
 
 		ceph_decode_64_safe(p, end, start, bad);
 		ceph_decode_64_safe(p, end, len, bad);
@@ -449,7 +449,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 			continue;
 		}
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, ino = start++,
+			int err = xa_insert(&s->s_delegated_inos, start++,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-- 
2.35.1

