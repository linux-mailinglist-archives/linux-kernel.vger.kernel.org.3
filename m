Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21F4DE5BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiCSD6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbiCSD6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:58:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC05103B98;
        Fri, 18 Mar 2022 20:57:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J1Va7b017423;
        Sat, 19 Mar 2022 03:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ZzqC69aMNoybtc6rTubeedjbC2mkw8ISGSTNmgrTWnI=;
 b=hrxa6sH2Ta7p/wl67EsXVPMiPsMiim+/w5q7oVElh0Z8EY1nlZAoyDYshwtlv5eEP+hh
 55TvEXw1RclpoGUYjgX9mwgRl183aHOC5Tt8cj17QRf3+WOpgMAMlQ6rIgtYobdBicF/
 bh08kRxFMdM+/cmIPKD83HJZP4vKYoYMmTBpUl2qUaFbU3ZWmHl6bpEQiW4929P2vtMD
 fic2/0YPMFobRanDv/mIVF4ePe9e3424WFfLackSblb1a9s7z3Vp4kVSVfvSSI2Q+IOo
 llzDbegObog1TrQ3HFzHEFrG5RGDoJGPdL/JAQe62ag2Ho5f1vb6U7vepstggD2QZRcH JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcg2ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22J3v8HY007190;
        Sat, 19 Mar 2022 03:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22J3v5Qo007126;
        Sat, 19 Mar 2022 03:57:15 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmn-7;
        Sat, 19 Mar 2022 03:57:14 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        James Smart <james.smart@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 4/6 v2] scsi: lpfc: use kcalloc
Date:   Fri, 18 Mar 2022 23:56:57 -0400
Message-Id: <164766213032.31329.7586542683502803593.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313141847.109804-1-Julia.Lawall@inria.fr>
References: <20220313141847.109804-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1oryhxHHBOkg7RQi_PlwBT-2J3zOXQuV
X-Proofpoint-ORIG-GUID: 1oryhxHHBOkg7RQi_PlwBT-2J3zOXQuV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 15:18:47 +0100, Julia Lawall wrote:

> Use kcalloc instead of kmalloc + memset.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[4/6] scsi: lpfc: use kcalloc
      https://git.kernel.org/mkp/scsi/c/dc2646417d54

-- 
Martin K. Petersen	Oracle Linux Engineering
