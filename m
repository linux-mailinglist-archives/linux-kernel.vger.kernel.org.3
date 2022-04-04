Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056B4F1837
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355913AbiDDPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378523AbiDDPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:24:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B63E5E3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:22:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y10so9277078pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyDte6u49XuZOEDhbioS92IXz+R+MU1mBAkIHexEyo8=;
        b=FI5XYFXXfXWe79T9qLsB6oiy2Bkf+dsXAJ1igK83khhqqLP2t3ELJRa06GFl0sDWKi
         VfcyzNTleGdnCa+/S2thk88pRmxjYBqC/ERN9xUKYMHzZq6jA+4hGdCEAfS5cC/NZ9pU
         LfRkGXbMG8YodiJzxbPPPidNkjKCU5j3IldHeadEOboyGo4/mJ1sSQsRsFUAseGOKwpJ
         cNoAVwtsd1VdYFaKnb7QjGvD7qAOmlFOqk8nwniOrLKqM4HhDIiwCGME/jRLXP4niJFs
         V4Q4+JFO81ladTPCvBbGPIzI9HYaDhdvi+8f0UbO9+dk8E/rY7SGSlWgHD3txVZATu7B
         twqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyDte6u49XuZOEDhbioS92IXz+R+MU1mBAkIHexEyo8=;
        b=kjm1PmMYw7QpKGuePitm0cjmkjGykqXXFZRtSLErWD/ft815+Cd3nbCkIr1WBJtgbo
         qmUzHu7a6wKsUNJMLpV4n2iALhXXEL+3FT+VWrCXv5CuCKtNWwbIsthtlET0lpB3Dhag
         JB0D9I4K9B7ksSrOyi1ZLBTLJhpIpP+T/2kpbrVx+KhmrCOTbq77sxE/kgLp4/uKUvYZ
         drzslIKud2vHBJnnEoRnSXtO3RlxHIxRnu5kjipxMqoI/ekKehOJPdnCBSk9mZjOCZtT
         J8LCA3F4d5oB3+xcaqrGdtrFI26nJcE7oSlpjiuhxjNNDBCIQVIVFSdp2b0jilMJnILC
         WGPA==
X-Gm-Message-State: AOAM530VIIQZ3MpeU2fIyantKHQFy49UpAAa6xym7/DVKJ29NwA/vxMU
        HZket5rqzq/13xccqTwnknBbkw==
X-Google-Smtp-Source: ABdhPJyuEOrM3uDz7VUMJ+shlo4iDFFBC7PYOBsACm3opqHftv1Rgh5WDiCiU4V6mAm84QapvgrW9g==
X-Received: by 2002:a05:6a00:1581:b0:4fa:e6d4:c3e6 with SMTP id u1-20020a056a00158100b004fae6d4c3e6mr94158pfk.84.1649085773408;
        Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm11079971pjf.32.2022.04.04.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: remove unnecessary code in __mb_check_buddy
Date:   Mon,  4 Apr 2022 23:22:43 +0800
Message-Id: <20220404152243.13556-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

When enter elseif branch, the the MB_CHECK_ASSERT will never fail.
In addtion, the only illegal combination is 0/0, which can be caught
by the first if branch.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 fs/ext4/mballoc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e5d43d2ee474..eba650b31870 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -576,13 +576,10 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 		for (i = 0; i < max; i++) {
 
 			if (mb_test_bit(i, buddy)) {
-				/* only single bit in buddy2 may be 1 */
+				/* only single bit in buddy2 may be 0 */
 				if (!mb_test_bit(i << 1, buddy2)) {
 					MB_CHECK_ASSERT(
 						mb_test_bit((i<<1)+1, buddy2));
-				} else if (!mb_test_bit((i << 1) + 1, buddy2)) {
-					MB_CHECK_ASSERT(
-						mb_test_bit(i << 1, buddy2));
 				}
 				continue;
 			}
-- 
2.20.1

