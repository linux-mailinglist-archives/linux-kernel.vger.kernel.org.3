Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B258490D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiG2AZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiG2AZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:25:23 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E89FFA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:25:22 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220729002519epoutp02b05fd230c969192259dc8c5b57f27736~GJRz09DkF2755027550epoutp02K
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:25:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220729002519epoutp02b05fd230c969192259dc8c5b57f27736~GJRz09DkF2755027550epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659054319;
        bh=koeQxC1CaOa4b7/9eLTD8KByAFxytDocEf6VI8T3VaY=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=aFerxI/GjYtOUusWSxc1D7ZQDDWuH2rQoF/q9VJICNS1sohQMRsUJe+ZsMjIsp56J
         0zqj2crhyKac8YJ1lBi67cJb1YZnebtUOWYXdqshtOPe9dvuQF2QUoY7psaiedVmxF
         KMCQHj5iAH13lbckKgTzy1jzQt1tpQGNnuaIn7E4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220729002518epcas2p462b8f60cd410cdfbe5e811bd5e1586ec~GJRzjMA8O2734727347epcas2p46;
        Fri, 29 Jul 2022 00:25:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lv7Zk3DN6z4x9Q3; Fri, 29 Jul
        2022 00:25:18 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-8b-62e328edb123
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.79.09666.DE823E26; Fri, 29 Jul 2022 09:25:17 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v0] f2fs: allow direct read for zoned device
Reply-To: eunhee83.rho@samsung.com
Sender: Eunhee Rho <eunhee83.rho@samsung.com>
From:   Eunhee Rho <eunhee83.rho@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eunhee Rho <eunhee83.rho@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
Date:   Fri, 29 Jul 2022 09:25:17 +0900
X-CMS-MailID: 20220729002517epcms2p35eed262c3349287436c1848ab350c2d4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmue5bjcdJBk8v61ucnnqWyeLlIU2L
        n0862CyerJ/FbHFpkbvF5V1z2BzYPDat6mTz2L3gM5NH35ZVjB6fN8kFsERl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVZSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcbpjDWnCYraLl
        3G2WBsYVrF2MHBwSAiYSV2a6djFycQgJ7GCUaD6wiBkkzisgKPF3h3AXIyeHsICNxMbma+wg
        tpCAksTfg/eZIOK6ElO2TGIEsdkEtCWuHG9nBZkjIjCRSeLAznesIAkJAV6JGe1PWSBsaYnt
        y7cyQtgaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxUjaDEg5+7oeISEnc3trBB2PkSPU+O
        MkHYFRI7V1yFqtGXuNaxEWwvr4CvxOv5fWA2i4CqxJw7nVD3uEjs/joXrJdZQF5i+9s5YL8z
        C2hKrN+lDwkeZYkjt1hgPmnY+Jsdnc0swCfRcfgvXHzHvCdQ16hJLP64ABoKMhI3NtyHintI
        NC3ewDqBUXEWIqBnIblhFsINCxiZVzGKpRYU56anFhsVGMKjNjk/dxMjOA1que5gnPz2g94h
        RiYOxkOMEhzMSiK8CdH3k4R4UxIrq1KL8uOLSnNSiw8xmgJ9P5FZSjQ5H5iI80riDU0sDUzM
        zAzNjUwNzJXEeb1SNiQKCaQnlqRmp6YWpBbB9DFxcEo1MMWYlL438Z/v9ewwm3GlMNcNVo3n
        lrF5ZR9u8smvy7sh9dfnkjgLYyJruq9Dwo2wX790lJu/HlfesFtsz0GNjNx/B3XXhJe+rTum
        471Kct0mPv+qysipU+9fWdbwIuZdx/k/dxYIhf5eFtmTyGOjfSLOeUPgNHMOdUFVy52Gl69H
        zpKsX979/qWJkM3ZFYc1ZrlGy8dHVjAEGl/evbJrioD9jXUTzeZ9dVi+rHJNYMPDsJZ1GfwO
        E8JCXDluPl7AdPKZlwz7Jo/EH17+GllHtnf1KZtsN//96NXZBU556+3rdMPcEpo6Kq1zmuwq
        fz5kWBfeyZ9toN5d8KM0oYp3ioDV/7ivz0pqD60wdbmoxFKckWioxVxUnAgA16imRwwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729002517epcms2p35eed262c3349287436c1848ab350c2d4
References: <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For zoned devices, f2fs forbids direct IO and forces buffered IO
to serialize write IOs. However, the constraint does not apply to
read IOs.

Signed-off-by: Eunhee Rho <eunhee83.rho@samsung.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d0f428aef34b..f69731f17402 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4471,7 +4471,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi))
+	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE))
 		return true;
 	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
 		if (block_unaligned_IO(inode, iocb, iter))
-- 
2.25.1

