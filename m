Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670B519749
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbiEDGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiEDGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:24:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1911C22;
        Tue,  3 May 2022 23:20:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430a43t003197;
        Tue, 3 May 2022 00:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=io17PxlLCWimwV2Nh2lqxTdERfa0awsdAaQIC6rX2zo=;
 b=Bc96s/qLHag9Wl9Wge9dxA7V7fTYnF77594mCEq0YiGKkNNbr/VgU27KGHtUxWORzJew
 wBYlybVVwKLNMRcPtvzjkO7cy2O6tCFYUXOpvm84r7M9hNs+xx/SYlPYjTMCTRMv9vkb
 8CUfYaOyZJ6n0V5GO9jK+3tIuD1eeYzNF7IxCWKtsulHUnrLamoPCEN+LXrcrd2YlSqg
 khnRBnyXTrnUjet1mqOFr2bUAJu62QqOocMio1bvz7KN+D9V0fNd7H+9NrmHfPKIR455
 5CIOFRCiioqnrmh6l+mrs0XHSiXI3wsoqWWMuN0k8tcf8ez6ANO+3yYeTgsUA9RNc//u Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oobs008895;
        Tue, 3 May 2022 00:51:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljU010389;
        Tue, 3 May 2022 00:51:56 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-17;
        Tue, 03 May 2022 00:51:56 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        Zeal Robot <zealci@zte.com.cn>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove unneeded flush_workqueue
Date:   Mon,  2 May 2022 20:51:27 -0400
Message-Id: <165153836361.24053.8662932109576640463.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220424062413.3220315-1-ran.jianping@zte.com.cn>
References: <20220424062413.3220315-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ixOQLF1ALJOdan8beO89ZFIi_DIT5pH8
X-Proofpoint-ORIG-GUID: ixOQLF1ALJOdan8beO89ZFIi_DIT5pH8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 06:24:13 +0000, cgel.zte@gmail.com wrote:

> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: qla2xxx: remove unneeded flush_workqueue
      https://git.kernel.org/mkp/scsi/c/cf97628fe1a1

-- 
Martin K. Petersen	Oracle Linux Engineering
