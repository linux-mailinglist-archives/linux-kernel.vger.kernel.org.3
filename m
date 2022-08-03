Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178F55885D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHCCfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:35:01 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8781EAC0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:34:57 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220803023451epoutp02adf635c87f9182558b0b62062327869a~HtRV_Go_D1758917589epoutp02S
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:34:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220803023451epoutp02adf635c87f9182558b0b62062327869a~HtRV_Go_D1758917589epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659494091;
        bh=T5VoLQpBcRJo92C2lV7/m8DkQiN/Co1igRSrZP3ut6k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dQwFsqKZzAlLkGcTlBkKB1Q8oPSFKqxwpvUdceKqG1dW9EVXx6S1qB9uME7zjZX4Q
         jmMp+6KEvJL1YyCPU+aYGx+gKDRFDTbh238nYrgD+Pin8ASPqw5ZIUKPStDHN1l1w6
         segL42wjHhkgaO3Yh8nhKiyBV5GFUxNTIUdq9n+4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220803023451epcas1p4bef07360d1c599a2c2da0bc634829db1~HtRVgqxGR3091330913epcas1p4n;
        Wed,  3 Aug 2022 02:34:51 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LyGCt5Xx6z4x9Ps; Wed,  3 Aug
        2022 02:34:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.DE.09633.ACED9E26; Wed,  3 Aug 2022 11:34:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3~HtRT_BUNs2254422544epcas1p4c;
        Wed,  3 Aug 2022 02:34:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803023449epsmtrp174cf5728076bd9e7ce9959424629ea3d~HtRT9XqWP2673726737epsmtrp1s;
        Wed,  3 Aug 2022 02:34:49 +0000 (GMT)
X-AuditID: b6c32a36-075ff700000025a1-0e-62e9deca3170
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.1C.08802.9CED9E26; Wed,  3 Aug 2022 11:34:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.247]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220803023449epsmtip172e1d9b7dead092cb5252dd3e06a8c47~HtRT1ZRlc0481204812epsmtip1r;
        Wed,  3 Aug 2022 02:34:49 +0000 (GMT)
From:   Jaewook Kim <jw5454.kim@samsung.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        junbeom.yeom@samsung.com, youngjin.gil@samsung.com,
        Jaewook Kim <jw5454.kim@samsung.com>
Subject: [PATCH] f2fs: do not allow to decompress files have
 FI_COMPRESS_RELEASED
Date:   Wed,  3 Aug 2022 11:34:31 +0900
Message-Id: <20220803023431.30214-1-jw5454.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmge6pey+TDK6u17Y4PfUsk8WT9bOY
        LQ5eOcJosfLKbxaLS4vcLS7vmsNmseXfEVaLGfufsjtweGxa1cnmsXvBZyaPvi2rGD0+b5IL
        YInKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukJJ
        oSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSY
        kJ3x+t85toJt/BWvlz5nb2C8x9PFyMkhIWAicb75CmsXIxeHkMAORonJr0+zQDifGCWezZjB
        DOF8ZpS4MWk5E0zLpu+PoFp2MUqs7P7BAld14stURpAqNgEtiTPtv8A6RATUJU5NWsoCYjML
        7GOUePWzHsQWFgiWmL/lDFicRUBV4vT/g+xdjBwcvALWEkuO6EAsk5dYveEA2BUSApvYJQ58
        bIO6wkVixrQbrBC2sMSr41vYIWwpiZf9bVB2tkT7q0ksEHaBxOYdd5lB5ksI2Eu8v2QBYjIL
        aEqs36UPUaEosfP3XEaIK/kk3n3tYYWo5pXoaBOCKFGROH5nBQvMonUPtzJC2B4Sv7o2s4GU
        CwnESnzYKzSBUXYWwvwFjIyrGMVSC4pz01OLDQuM4FGUnJ+7iRGcrLTMdjBOevtB7xAjEwfj
        IUYJDmYlEd47Ls+ThHhTEiurUovy44tKc1KLDzGaAgNrIrOUaHI+MF3mlcQbmlgamJgZmVgY
        WxqbKYnzrpp2OlFIID2xJDU7NbUgtQimj4mDU6qBKfQiw/bKF02C3kY/ns/cWLD2jM1WXrYN
        V6XbJIxVD5mnn9Z+tvDYh9LrSV/KP8zuf9R0hGFjZuIuEVbfnsw7u5MOrFkSw3+sL6n+pm6u
        m5S1hjz/O6tZf7P/OO/1jc5IN+RptNhszr7na+/hYNmJ57qz/licO7Rn+p/PEYK1L5M3pm+c
        lro8snaHALOCW9fqfSc27/ouVWnyZmOTpvmlg6+v3eJUVz7xefNsaakvnILPHj+cXrbhYu6c
        J290DzIv5b39QGLzDOsq7Q4P9+evp8T52O595rTwi6Dx5MZVrJc96xuLqs2DLxZ9kDartmqU
        FH3+dEPppojcW0u+fzx0WC3BYdH20p2mZx/M2xiq26bEUpyRaKjFXFScCAAla9Cv3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSnO7Jey+TDI4elbQ4PfUsk8WT9bOY
        LQ5eOcJosfLKbxaLS4vcLS7vmsNmseXfEVaLGfufsjtweGxa1cnmsXvBZyaPvi2rGD0+b5IL
        YInisklJzcksSy3St0vgynj97xxbwTb+itdLn7M3MN7j6WLk5JAQMJHY9P0RaxcjF4eQwA5G
        ifYFK9ghElIS6zcsZ+pi5ACyhSUOHy6GqPnIKLH8RQsTSA2bgJbEmfZfYLaIgKbEkc6Z7CBF
        zAJHGCVmPO5mBUkICwRKPD6zBWwoi4CqxOn/B9lBhvIKWEssOaIDsUteYvWGA8wTGHkWMDKs
        YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDiEtrR2Me1Z90DvEyMTBeIhRgoNZSYT3
        jsvzJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYtFui
        1q0UutKXPd1mrY1+zHXNcyXMDOwah+yX/0k+tO3XSwWGXdLaIu9meCQ8V3+vffdld0Fl57sl
        73rPb9t4tPqBX7n830s5zXLGdpbihqsCkz8H82yueKGs+PvI76VKSa0sK6a0pzLa2zF1vb7d
        JlRt/2HxPsddR/i7rOR7E6tSfMV0Knq2hm2825GR1GLXpO478cQ9bT3lJedqzyWfOtasPDXE
        4qaMvbj23+iNapICK0498f68pU8qrSA4xS9skUfw8wido78zk/m+Fzzr+PXjxr7kM44fFkQL
        8dZb3ZzZfdd069YDLMVs/L/X8BpMtJt8r2xFyxbdY37mz/ddKKsIrQnQtHixzjTj/HIlluKM
        REMt5qLiRADyrdjqkAIAAA==
X-CMS-MailID: 20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3
References: <CGME20220803023449epcas1p4a9b09cdc73878c8ee40ae10523279dc3@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file has FI_COMPRESS_RELEASED, all writes for it should not be
allowed. However, as of now, in case of compress_mode=user, writes
triggered by IOCTLs like F2FS_IOC_DE/COMPRESS_FILE are allowed unexpectly,
which could crash that file.
To fix it, let's do not allow F2FS_IOC_DE/COMPRESS_IOCTL if a file already
has FI_COMPRESS_RELEASED flag.

This is the reproduction process:
1. $ chattr +c ./file
2. $ dd if=/dev/zero of=./file bs=4096 count=2000 oflag=append conv=notrunc
3. $ sync
4. $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE
5. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS
6. $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE again
7. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS again

You can find compr_blocks has a negative value.

Fixes: 5fdb322ff2c2b ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")

Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Jaewook Kim <jw5454.kim@samsung.com>
---
 fs/f2fs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b1b030830ca..a4713b7e12cb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3945,6 +3945,11 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out;
@@ -4012,6 +4017,11 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out;
-- 
2.17.1

