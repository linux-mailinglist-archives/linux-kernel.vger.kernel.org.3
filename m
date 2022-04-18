Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916CA505A94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiDRPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDRPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:08:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46B8FE62;
        Mon, 18 Apr 2022 07:00:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so8850632wmn.1;
        Mon, 18 Apr 2022 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6x/x31zD6jdr7v3jc1uXumCewA6SO4UbVpg60xKCXk=;
        b=MzV3Dc04CvwAAiwc8eYESy/kUaiawkJiTKLqHR78r064hc0eGHjL0wY8jaNT6CT5u7
         aCZsjaiV/ws6ZL/JvWYudvnvWAvGUfJJlxJ4Hb48PqzawA817UQTH3dsQKlPAWtkvFsj
         Ih67M4YTAfVmXn4I2pee+/ksFZ5deFcTkONGa04NQt+PZ/j0UhBcY0BM34E8tJ5kzEdS
         D4yCc3nSVc87XqniZVIvrb7MPFYr4rB/N5hydMUpF1gcWlilGGpa/plQeImgOjuVeQTw
         EsICi6rN5bmvq/V+Z/aYb4kN6Pm808V2chgU+Zd/+k5ll2oQfbiAFEJv9J+FM8QdH+b3
         yqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6x/x31zD6jdr7v3jc1uXumCewA6SO4UbVpg60xKCXk=;
        b=AsEKwQBOMXBTscgTf4dqiOhvhAVxGHuVKBzwmbhtcH8LTtgAyOc1+j1x7yD1DT9d0n
         UT6BheX5yytyDbZEEO3NrxptY7zKCRwa4Ub62aciKbyIE7lOQasMfPHFT49lz6SPsIES
         WKwlQ2iqy5D7aDXvCLf1HpGi/GyA6Y8ZCJn0zlb7d41OX79c1f84HWmyoPqPGimX7whb
         uF0Nz/z2egHX0Hl01r2cJRMjMFXS7NZjKTYP9yvHdXDnNqhxEr77uzAjk8+nkKPCxCJy
         NeUVYHh5AQu9DU1QWtBJ5yyXFmq3xGRar+Fq6iMcwXm7F9+7G+B3NqGR4kzzjNofG2vS
         ZUaQ==
X-Gm-Message-State: AOAM530J7svxk9O6cjwZL/Y7cQBhhbyXqEaP01LinIcOwG7fmutxnhxp
        DuQ9JN3c7awxSkPZzExrPzI=
X-Google-Smtp-Source: ABdhPJymwRgSS/QTCpphJK2gWO5fWNVAensdOd5debCCtyT1eqh6vN7nhxp1YqM5axzZBxB5ViUQIA==
X-Received: by 2002:a05:600c:34c5:b0:38f:fbcb:e45 with SMTP id d5-20020a05600c34c500b0038ffbcb0e45mr15309073wmq.66.1650290439536;
        Mon, 18 Apr 2022 07:00:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0038ecb2d2feasm12977678wms.4.2022.04.18.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:00:39 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] fs/ntfs3: remove redundant assignment to variable vcn
Date:   Mon, 18 Apr 2022 15:00:38 +0100
Message-Id: <20220418140038.82843-1-colin.i.king@gmail.com>
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

Variable vcn is being assigned a value that is never read, it is
being re-assigned again in the initialization of a for-loop.  The
assignment is redundant and can be removed.

Cleans up clang scan build warning:
fs/ntfs3/attrib.c:1176:7: warning: Value stored to 'vcn' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e8c00dda42ad..fc0623b029e6 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1173,7 +1173,7 @@ int attr_load_runs_range(struct ntfs_inode *ni, enum ATTR_TYPE type,
 {
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
-	CLST vcn = from >> cluster_bits;
+	CLST vcn;
 	CLST vcn_last = (to - 1) >> cluster_bits;
 	CLST lcn, clen;
 	int err;
-- 
2.35.1

