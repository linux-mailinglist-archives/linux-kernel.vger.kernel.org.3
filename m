Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF9587102
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiHATFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiHATE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:04:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF441D17;
        Mon,  1 Aug 2022 12:03:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271HsHW9025312;
        Mon, 1 Aug 2022 19:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=BbFNxr6tjxw9VIW8unVKeDr44rwjxC/Z2yvXUqJcDCw=;
 b=ueQ0b6ffvGNY0WKaKAxOYt7xHvUnMs4Z4jovAwWFIKcaJJoeKF7jKVyTRzC6FgpXWTlk
 +hNLSa3leeiSHZDYo0ow2K3IIyYOan2TNg4f4VhO9b4eQ17/HQWZbDdbF3NR+2B7szCH
 Pb4hEJaMqw6sSJZbkFwJLsSQl1+D0JuKdgmYgOI/qAofPmaflhwHyvmu9lGl0IRCvXJk
 p8xcUYGciwjbXfsBoRL6uy7RIGOOOwzOoRsjqoNcMFTDxy2Y7XWOFzl1Zx7kGEEFbuve
 08kZI5xUBCP9U/4mrNN/xsbM7yCwZvTJ+xUfLv6/NrJswP9f/3Rnj/X6soSL30RxiEeo 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tcmpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:03:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271I3ag3001480;
        Mon, 1 Aug 2022 19:03:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57qg2c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:03:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 271J3CoW023542;
        Mon, 1 Aug 2022 19:03:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3hp57qg2bh-1;
        Mon, 01 Aug 2022 19:03:12 +0000
From:   Sherry Yang <sherry.yang@oracle.com>
To:     djwong@kernel.org, dchinner@redhat.com,
        allison.henderson@oracle.com, chandanrlinux@gmail.com,
        bfoster@redhat.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH v1] xfs: initialize error in xfs_defer_finish_one
Date:   Mon,  1 Aug 2022 12:03:11 -0700
Message-Id: <20220801190311.65703-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010095
X-Proofpoint-GUID: uNFatD76gB1qiLt5X6VLMjIai8QjcPJx
X-Proofpoint-ORIG-GUID: uNFatD76gB1qiLt5X6VLMjIai8QjcPJx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Path through non-void function 'xfs_defer_finish_one' may return error
uninitialized if no iteration of 'list_for_each_safe' occurs. Fix this
by initializing error.

Fixes: bb47d79750f1 ("xfs: refactor xfs_defer_finish_noroll")
Cc: stable@vger.kernel.org
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 fs/xfs/libxfs/xfs_defer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 5a321b783398..3188712ff34e 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -468,7 +468,7 @@ xfs_defer_finish_one(
 	const struct xfs_defer_op_type	*ops = defer_op_types[dfp->dfp_type];
 	struct xfs_btree_cur		*state = NULL;
 	struct list_head		*li, *n;
-	int				error;
+	int				error = 0;
 
 	trace_xfs_defer_pending_finish(tp->t_mountp, dfp);
 
-- 
2.31.1

