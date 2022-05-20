Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3640852E189
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbiETBKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbiETBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F3129EE2;
        Thu, 19 May 2022 18:09:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0JMNK023992;
        Fri, 20 May 2022 01:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=kEFQtJRMEccpxF9OIT3uMAX389Ymhk+oZPYiGQiq0Gg=;
 b=BpiwDMNKV46h4gbbnkQmuhvOElGbOOOhPe5SBPMyyAZXbwC7ZzpWqMxbo06Pj/i6XfPX
 konVvHCGjDE5PvQ5d83QRo0+/EZ3q23W0rmwjEOEqZgJqTPF9Y33eG+YlmPOcX15TLtl
 7zVJOifGwSW5oZrMpOTtLUVyAUQm4Pfqk0AOALec5JNpYaOSIx9aHoZBrxwYhTU9sWch
 qjsveboW6V0OTgkLTwHiOltEV30PFh48+uMK99BcHuk1sskhzYI+0VlqVLiVOPPcdw+r
 wB8BMkFGucdydi+soqiiCc3az4KQLG7irs/BfWTpuSPDm9+aCRDFtTbNyVTfIK/fC9dn pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aanetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nct020193;
        Fri, 20 May 2022 01:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKK030710;
        Fri, 20 May 2022 01:09:27 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-9;
        Fri, 20 May 2022 01:09:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        target-devel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] scsi: elx: efct: Remove redundant memset statement
Date:   Thu, 19 May 2022 21:09:08 -0400
Message-Id: <165300891231.11465.13719817919284255142.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220505143703.45441-1-harshit.m.mogalapalli@oracle.com>
References: <20220505143703.45441-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KuHCq16Bdj9tTnf2M-7-6mQ0UsMnqqJP
X-Proofpoint-GUID: KuHCq16Bdj9tTnf2M-7-6mQ0UsMnqqJP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 07:36:57 -0700, Harshit Mogalapalli wrote:

> As memset of 'bmbx' is immediately followed by a memcpy where 'bmbx'
> is the destination, memset is redundant.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: elx: efct: Remove redundant memset statement
      https://git.kernel.org/mkp/scsi/c/e79aaa9cc02d

-- 
Martin K. Petersen	Oracle Linux Engineering
