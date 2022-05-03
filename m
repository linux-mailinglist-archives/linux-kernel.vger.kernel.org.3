Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F247518F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiECUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiECUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:42:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BCF22511;
        Tue,  3 May 2022 13:39:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MkbAd018676;
        Tue, 3 May 2022 00:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=WIoVTgq0vIEZvmnR+NEgL1XkmCDUTNJpZDr6GzvN/kc=;
 b=U0SpwCyy8dC27IPsfbkPvqS0fqmLoYUhJ1e8+yJpvu5h1d7JtzTSjHphkVRrBc0HzQ5v
 3p3l9vv8D+vDV/08aERL4G8v/amn5J5MRvXZMmlQ/gxUSpZgQ2Vb334zCl/D9W1C4wjY
 SMfpcC2b382skaKqJHNzXty+T1ree5hwA6Nsd/7jFv0NWIFTUS5zNwX+Orm9Bu/CJzdP
 QjEcYBE0o4Xx31r/KdoWv1JCslyHi2RDRNcJecBX5PXxskbHp1p41fSn6irGq7Rn3JWK
 dToYT0MAGi8oFPsVQ73OboV5y50/Ta1NlJcICPAjVMfy2RX13AX2eJ9B1IA65o0BgVqw YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt4kx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430opOY008941;
        Tue, 3 May 2022 00:52:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljg010389;
        Tue, 3 May 2022 00:52:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-23;
        Tue, 03 May 2022 00:51:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: core: Refine how we set tag_set NUMA node
Date:   Mon,  2 May 2022 20:51:33 -0400
Message-Id: <165153836362.24053.7061141693570031456.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1648640315-21419-1-git-send-email-john.garry@huawei.com>
References: <1648640315-21419-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0SWjchfUlf8QrgHUKMczPIsYukTmH39J
X-Proofpoint-GUID: 0SWjchfUlf8QrgHUKMczPIsYukTmH39J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 19:38:35 +0800, John Garry wrote:

> For SCSI hosts which enable host_tagset the NUMA node returned from
> blk_mq_hw_queue_to_node() is NUMA_NO_NODE always. Then, since in
> scsi_mq_setup_tags() the default we choose for the tag_set NUMA node is
> NUMA_NO_NODE, we always evaluate the NUMA node as NUMA_NO_NODE in
> functions like blk_mq_alloc_rq_map().
> 
> The reason we get NUMA_NO_NODE from blk_mq_hw_queue_to_node() is that
> the hctx_idx passed is BLK_MQ_NO_HCTX_IDX - so we can't match against a
> (HW) queue mapping index.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: core: Refine how we set tag_set NUMA node
      https://git.kernel.org/mkp/scsi/c/973dac8a8a14

-- 
Martin K. Petersen	Oracle Linux Engineering
