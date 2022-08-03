Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB55888E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiHCIyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHCIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:54:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3312608
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:54:08 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220803085403epoutp019e7577efbe27f986c22d477189e00333~HycbOZtGv2355423554epoutp01C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:54:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220803085403epoutp019e7577efbe27f986c22d477189e00333~HycbOZtGv2355423554epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659516843;
        bh=mwN72SokuOWa7+Q4macxm26JHzmXheVlO0sKudZpGr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekA4WzUbcl2XZ+jLWFXf/WCSGWZ7m0LRyI5g/9oI6E/YEE5BF0qDFwsgZmfZ4KKl9
         8N1qbneSODV0cAFqE0AdvoNRqJUMIpfNRxwsQExN+mxsexE0FzlOr/aMTH7TQ8gGys
         GVcMsc6z8v3fr37LZOy/VtBFAC6MdQ0OS0twsUa0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220803085402epcas1p312ee9ac397b1be17fbb426fad7c38ff8~Hycay2IgI0647806478epcas1p3w;
        Wed,  3 Aug 2022 08:54:02 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LyQdQ4K4rz4x9Pr; Wed,  3 Aug
        2022 08:54:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.0D.09678.AA73AE26; Wed,  3 Aug 2022 17:54:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8~HycaL7VrM2105221052epcas1p2-;
        Wed,  3 Aug 2022 08:54:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803085402epsmtrp117a45ad3c5cc414187ff9e51c35f7dcd~HycaLMQlZ2535225352epsmtrp1t;
        Wed,  3 Aug 2022 08:54:02 +0000 (GMT)
X-AuditID: b6c32a39-e67ff700000025ce-89-62ea37aadd3d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.20.08905.AA73AE26; Wed,  3 Aug 2022 17:54:02 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.247]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220803085402epsmtip10afa9e5a862cac0790cbb4ffaec2e2ae~HycaColiK0334803348epsmtip1Y;
        Wed,  3 Aug 2022 08:54:02 +0000 (GMT)
From:   Jaewook Kim <jw5454.kim@samsung.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        junbeom.yeom@samsung.com, youngjin.gil@samsung.com,
        Jaewook Kim <jw5454.kim@samsung.com>
Subject: [PATCH v2] f2fs: do not allow to decompress files have
 FI_COMPRESS_RELEASED
Date:   Wed,  3 Aug 2022 17:53:58 +0900
Message-Id: <20220803085358.3963-1-jw5454.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <25e501d8a6eb$84cf4090$8e6dc1b0$@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmru4q81dJBj2rFS1OTz3LZPFk/Sxm
        i4NXjjBarLzym8Xi0iJ3i8u75rBZbPl3hNVixv6n7A4cHptWdbJ57F7wmcmjb8sqRo/Pm+QC
        WKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZAhUm
        ZGesOuVQcEqwYu+f4AbGTXxdjJwcEgImErPenmHrYuTiEBLYwShx6skqFgjnE6PEjH/dzBDO
        N0aJKavWMsK0zDw4hR0isZdRYueBDqiWz4wSRxseMYNUsQloSZxp/8UEYosIqEucmrSUBcRm
        FtjHKPHqZz2ILSwQJvFn62k2EJtFQFViT/cTMJtXwEriwJVVzBDb5CVWbzgAZnMCxT9umgS2
        WULgFLvE8d4+FogiF4mPx5azQ9jCEq+Ob4GypSRe9rdB2dkS7a8mQdUXSGzecRdoKAeQbS/x
        /pIFiMksoCmxfpc+RIWixM7fcxkhTuaTePe1hxWimleio00IokRF4vidFSwwi9Y93AoNHw+J
        I03XoeHTyyjx+ucS9gmMcrMQNixgZFzFKJZaUJybnlpsWGAKj6/k/NxNjOA0pmW5g3H62w96
        hxiZOBgPMUpwMCuJ8N5xeZ4kxJuSWFmVWpQfX1Sak1p8iNEUGHYTmaVEk/OBiTSvJN7QxNLA
        xMzIxMLY0thMSZx31bTTiUIC6YklqdmpqQWpRTB9TBycUg1Mcu6zXc+2a3iHvVtvVWW2vdfQ
        0iFE65P81+p31/jFdu4QWlKW+mhzaI/ueyvNi7J6kXd6ei0rupUUFTbtldv/+ro9h0266dmP
        OgemPdqkyHl1t+YsljOSGiF7Ixb+sPzdG3HnQMTeP0uZzwrLXXn902HK/e0+fKdu2ERXcN3c
        dozT52+JXFeB3bJuudtNCmlTk5m21qbv0LXQze16Jya3Rz7XZHcKc9WTWZrH2mczJ68sP+/k
        5NB+OevuNNZJRap9bA26emHLzTwP9HBIahS+1svz6iydvMljCXMr94eWR1f+5PXk7wgR+Nn4
        KVEn34H/Vn0bkxOza12IIcfkswGffM57BH1n/zHt0fG7Z5VYijMSDbWYi4oTAUCrRdLsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSnO4q81dJBu2t/Banp55lsniyfhaz
        xcErRxgtVl75zWJxaZG7xeVdc9gstvw7wmoxY/9TdgcOj02rOtk8di/4zOTRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGatOORScEqzY+ye4gXETXxcjJ4eEgInEzINT2EFsIYHdjBKXnwVC
        xKUk1m9YztTFyAFkC0scPlzcxcgFVPKRUaLp+C4WkBo2AS2JM+2/mEBsEQFNiSOdM9lBipgF
        jjBKzHjczQqSEBYIkdjy5DHYAhYBVYk93U/YQGxeASuJA1dWMUMsk5dYveEAmM0JFP+4aRI7
        yGIhAUuJz6cEJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxsWpo7GLev
        +qB3iJGJg/EQowQHs5II7x2X50lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MGXukJ7S9HTFhwuW2yUW3XarnXZZRiTXPzpXQ1zd9I3leau92XqzbI9N
        jlTJEp9kN0vw9KI/hQ+mhngsKxdIuL8tekl9pdSkAys+Bm8PuJBjohHqeFfYRdunJjrYLk6B
        qWFW7brtC2Q+r/nBc3XZgvjIXV/tz3lO/tFyyOdH4ea56Ty1fzKfP1169d0ly6zjVl1239f9
        52VeczDQr7d76sG7h18lp5/QerLQbfVL7sWvpVcoqj1+NXeDlPjzeR+YAm9tFFX/sto/fO/0
        awV9Dh8Vd01f9GD145PfvWcdzq2rmbfY6n7ypYO35VXfZaxlsTGcv1Tic7+l0Ge1a/0TucK4
        W3eXBFaaRWVfjdj1zvq5EktxRqKhFnNRcSIANUwfvqUCAAA=
X-CMS-MailID: 20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8
References: <25e501d8a6eb$84cf4090$8e6dc1b0$@samsung.com>
        <CGME20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
1.  $ touch ./file
2.  $ chattr +c ./file
3.  $ dd if=/dev/random of=./file bs=4096 count=30 conv=notrunc
4.  $ dd if=/dev/zero of=./file bs=4096 count=34 seek=30 conv=notrunc
5.  $ sync
6.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE
7.  $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS
8.  $ release ./file          ; call F2FS_IOC_RELEASE_COMPRESS_BLOCKS
9.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE again
10. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS again

This reproduction process is tested in 128kb cluster size.
You can find compr_blocks has a negative value.

Fixes: 5fdb322ff2c2b ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")

Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Jaewook Kim <jw5454.kim@samsung.com>
---
v2:
 - Fix reproduction process and add test enviroment

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

