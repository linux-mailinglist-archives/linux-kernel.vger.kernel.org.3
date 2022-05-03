Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0E5188EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbiECPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiECPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:48:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B331DF7;
        Tue,  3 May 2022 08:45:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430a43s003197;
        Tue, 3 May 2022 00:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=2tMXzFKtYB1Ka8zEzGtnUkCLUCD5m7cpkfp8tz9wj1Q=;
 b=chZ3Pa5AHZrUQ5Ppd06RHOkZ/kmLToarkvZ8ffpytha6m9P/0bEtjoMjay4/TfvFm1nb
 Orawo+cu6WhOJXMk1aKAT1I7u0cY3+ieh2RIb4/byCKVp4neIBJLoNV2uHBk7MUrQJdb
 QZ8hlIdPvWbY90xJ93TEE8GhtSXIlj4VMDavfjGSXU7dVtSwGVjP+iW6vyg3YqNeCs5d
 e17/QUPmyNeQ4FBCdvjUTqD3ayuabLWs00SeSs240u5qY398Zzd23wNg+Ca208Pg3R+6
 jO7nvrK1Ptnm/SbEKpihwfQt0j0NHHH1hiTxNcV1MT3pllRX0/tRtC9Znp4gYWuGbcXT JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430ooba008887;
        Tue, 3 May 2022 00:51:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljO010389;
        Tue, 3 May 2022 00:51:54 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-14;
        Tue, 03 May 2022 00:51:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     anil.gurumurthy@qlogic.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        Zeal Robot <zealci@zte.com.cn>, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: remove unneeded flush_workqueue
Date:   Mon,  2 May 2022 20:51:24 -0400
Message-Id: <165153836361.24053.1864207484794019663.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220424061845.3218774-1-ran.jianping@zte.com.cn>
References: <20220424061845.3218774-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uzfbBu2mTR9XnuBeXcxpYIcmev4PVRlw
X-Proofpoint-ORIG-GUID: uzfbBu2mTR9XnuBeXcxpYIcmev4PVRlw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 06:18:45 +0000, cgel.zte@gmail.com wrote:

> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: bfa: remove unneeded flush_workqueue
      https://git.kernel.org/mkp/scsi/c/4c0df601e150

-- 
Martin K. Petersen	Oracle Linux Engineering
