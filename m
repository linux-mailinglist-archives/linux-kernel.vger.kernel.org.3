Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158D7586393
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiHAEkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHAEkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:40:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBF13E12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:40:06 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220801044003epoutp0437aafe20b2cd8d756e04266870db1037~HHsFaJEsT1022510225epoutp04l
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:40:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220801044003epoutp0437aafe20b2cd8d756e04266870db1037~HHsFaJEsT1022510225epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659328803;
        bh=hzbhYOqkA0ybVjCJXM7h/bXExcppfaT3rHZaniOrLxw=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=aNXycnH/j+wLhJf8VcZHc0w8lW51psbMR+xmQum32mTx2jyqjMKQqRhnuORMsZfGc
         VqUrl3P8FY31eV+npfYxvguVcsMcTmfVyFe68LQKPdc6MIybAza0+KRsMeY5iyaplE
         DT9x5l4gLQOoRU+V5nVwQGBiEGI0S78521NAX/48=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220801044002epcas2p25ff9d7be2d3e639947b880e93769a660~HHsEydK4h1270312703epcas2p2f;
        Mon,  1 Aug 2022 04:40:02 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Lx55G3gZWz4x9QZ; Mon,  1 Aug
        2022 04:40:02 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-ce-62e7592258dc
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.C5.09666.22957E26; Mon,  1 Aug 2022 13:40:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: remove device type check for direct IO
Reply-To: eunhee83.rho@samsung.com
Sender: Eunhee Rho <eunhee83.rho@samsung.com>
From:   Eunhee Rho <eunhee83.rho@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220801040607epcms2p82da0594039ba5f1ed77c451e2d13c965@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220801044002epcms2p5a832b87ab1e6c8f0391d8d26f33c042c@epcms2p5>
Date:   Mon, 01 Aug 2022 13:40:02 +0900
X-CMS-MailID: 20220801044002epcms2p5a832b87ab1e6c8f0391d8d26f33c042c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmha5S5PMkgzmzJC1OTz3LZPHykKbF
        k/WzmC0uLXK3uLxrDpsDq8emVZ1sHrsXfGby6NuyitHj8ya5AJaobJuM1MSU1CKF1Lzk/JTM
        vHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoK1KCmWJOaVAoYDE4mIlfTubovzS
        klSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMI68TCxawV/ya/4W5gfED
        axcjJ4eEgInE1jPvWLoYuTiEBHYwSny+fYi9i5GDg1dAUOLvDmGQGmEBB4kTUzczgdhCAkoS
        fw/eZ4KI60pM2TKJEcRmE9CWuHK8nRVkjojAQ0aJD0e2MUEs4JWY0f6UBcKWlti+fCtYA6eA
        n8SyrodQNRoSP5b1MkPYohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLiExN2NLWwQdr5E
        z5OjUDMrJHauuApVoy9xrWMj2A28Ar4Sn45OAJvPIqAqsWfNHqhdLhKb5rwHm8MsIC+x/e0c
        ZlA4MAtoSqzfpQ9iSggoSxy5xQLzVcPG3+zobGYBPomOw3/h4jvmPYG6Rk1i8ccF0CCXkbix
        4T7TBEalWYiAnoVk7yyEvQsYmVcxiqUWFOempxYbFRjCozY5P3cTIzj5abnuYJz89oPeIUYm
        DsZDjBIczEoivHdcnicJ8aYkVlalFuXHF5XmpBYfYjQF+ngis5Rocj4w/eaVxBuaWBqYmJkZ
        mhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCUamASk5vSddz9fiif9pYWgadGzjv/Bqs9
        U7/ntKfqy5G9zevvPHh/9eHVB9MLv/g+Zk9/KnJt8Uoz9i/nf4Rv9ks40N0dfKTsXW+gmQ93
        yps5gdEd9bzpC9boLqsQPWAwp4L5/IRO79uJHnG5kzPueFwtnhEU5bvsQ1/wL9viFbnnJZgy
        fJ4kMTsyt+/hFDmhsaxQdOOyea4Ls2u/3KoWm6J2/JHJ6lMX1GSq1/aw+jdsbXGUnvOD+6jD
        kqBSc58Pmgty7e4ox62tKnS1Wft5DY81/9cq/2t1X3Kb/RhfTI9MmLshNT5O/NORbxZNJyvC
        M2ZV3ua+IVdaz/g5863W0p2nbb7zMaXLmPmzNjrHGCmxFGckGmoxFxUnAgDxZxfnBwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729002517epcms2p35eed262c3349287436c1848ab350c2d4
References: <20220801040607epcms2p82da0594039ba5f1ed77c451e2d13c965@epcms2p8>
        <YuXZSTw4reBDtLgk@google.com>
        <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
        <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure serialized IOs, f2fs allows only LFS mode for zoned
device. Remove redundant check for direct IO.

Signed-off-by: Eunhee Rho <eunhee83.rho@samsung.com>
---
 fs/f2fs/f2fs.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ecd870e5d6da..ca9354746eec 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4496,12 +4496,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	/* disallow direct IO if any of devices has unaligned blksize */
 	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
-	/*
-	 * for blkzoned device, fallback direct IO to buffered IO, so
-	 * all IOs can be serialized by log-structured write.
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		return true;
+
 	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
 		if (block_unaligned_IO(inode, iocb, iter))
 			return true;
-- 
2.25.1

