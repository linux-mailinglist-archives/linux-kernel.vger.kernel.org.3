Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CA581E12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbiG0DPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiG0DPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:15:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE513F62;
        Tue, 26 Jul 2022 20:15:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2mNsn009617;
        Wed, 27 Jul 2022 03:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=p1J/T+eovKmuGZBQuEJYAAtFQ40C1shADFbCfowq4TM=;
 b=gofWotcDifPlnhB3VnPe6UhlCTo2Uy4zdYCBnpKSDSTRYXbUmv0Jf/5ms7l5MoGU968F
 bS1FCx6M/e/r856qhHmPwzE5vlwnJ22atghJcUPemKtxOYju8A+gDZYvnlKUxA7hWcYj
 W/rIKRl7AId0htJvIBjo91hEBVswkuFC3eQNx1Ef2ocIZFpBP1hsR6BynuUUxFcOz5vS
 WmvJE7aPLsZdbJZIHPfEfTzONGAQSU34xAgwSwaO1Fr5IkRMsvKWtYLk7DvaX2ZmENlk
 UnyP0VnZ9ux8mShs9n1SvED8AlB6WhOsBOljPvP9xgbT+YmMBo6cKWhnGTVTmunSaV8x RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4r86k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:15:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2sDnU019820;
        Wed, 27 Jul 2022 03:15:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh638mktv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:15:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R3Dx7b005078;
        Wed, 27 Jul 2022 03:15:16 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hh638mkrj-4;
        Wed, 27 Jul 2022 03:15:16 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.vnet.ibm.com, Jason Yan <yanaijie@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+d44b35ecfb807e5af0b5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, bvanassche@acm.org, hch@lst.de,
        hare@suse.com
Subject: Re: [PATCH v2] scsi: fix WARNING in scsi_alloc_sgtables
Date:   Tue, 26 Jul 2022 23:15:13 -0400
Message-Id: <165889169551.689.5999254456807328126.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025120.3226770-1-yanaijie@huawei.com>
References: <20220720025120.3226770-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=859 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270009
X-Proofpoint-ORIG-GUID: sqkbZ2s0EbxubCWWlPX-fOyY3z1eoFrP
X-Proofpoint-GUID: sqkbZ2s0EbxubCWWlPX-fOyY3z1eoFrP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 10:51:20 +0800, Jason Yan wrote:

> As explained in SG_IO howto[1]:
> 
> "If iovec_count is non-zero then 'dxfer_len' should be equal to the sum
> of iov_len lengths. If not, the minimum of the two is the transfer
> length."
> 
> When iovec_count is non-zero and dxfer_len is zero, the sg_io() just
> genarated a null bio, and finally caused a warning below. To fix it,
> skip generating a bio for this request if dxfer_len is zero.
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] scsi: fix WARNING in scsi_alloc_sgtables
      https://git.kernel.org/mkp/scsi/c/d9a434fa0c12

-- 
Martin K. Petersen	Oracle Linux Engineering
