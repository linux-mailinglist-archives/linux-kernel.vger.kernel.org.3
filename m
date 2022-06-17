Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65E54EF41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379751AbiFQCV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379607AbiFQCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:21:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4B64D0E;
        Thu, 16 Jun 2022 19:21:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GJUUq0022342;
        Fri, 17 Jun 2022 02:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=YKNA3in4Ez0zbPFqCd0pus5nrix323YYU4486R+hf2o=;
 b=c0gOxB+GED4BQPk45jxo5C3+u7znLbsxVP3QQeSxR9D301gCyorR9DpMtiaPvFuaFKx8
 SQ7OGVxFeUx27ObZhdIOJGnBLJTL6LVCaCPwqWNbU/UBGexhho5wBCR+E/kkEGbg4hYq
 vrffxgVs9NmX2i9yEXV5xd1E4ElJkWxn/y2eeDUX5PieZYIBruQo3kAP6//uGypDmZWL
 /PvlLfT4HYvlsmswagQyM4LmgbkzS+WfFNnwtht6FLwbI48yaHvzwahMBMAarDkR5Rvt
 XnsBKVi6kHSrJ+5ESndAg0fnGCHjTMbkkWSPTySglBKydPsun9Pk1BK1nCtykTonuDdm 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcvkwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H2G65w029054;
        Fri, 17 Jun 2022 02:21:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25H2LejJ040352;
        Fri, 17 Jun 2022 02:21:42 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd7c-3;
        Fri, 17 Jun 2022 02:21:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        Xiu Jianfeng <xiujianfeng@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND --next] scsi: lpfc: Use memset_startat() helper in lpfc_nvmet_xmt_fcp_op_cmp
Date:   Thu, 16 Jun 2022 22:21:36 -0400
Message-Id: <165543243410.26207.3021312479446319369.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220613021851.59699-1-xiujianfeng@huawei.com>
References: <20220613021851.59699-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DJ1_i4Jy9qXyjGD2ObMamwRI_oJU72JU
X-Proofpoint-GUID: DJ1_i4Jy9qXyjGD2ObMamwRI_oJU72JU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 10:18:51 +0800, Xiu Jianfeng wrote:

> Use memset_startat() helper to simplify the code, no functional change
> in this patch.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: lpfc: Use memset_startat() helper in lpfc_nvmet_xmt_fcp_op_cmp
      https://git.kernel.org/mkp/scsi/c/e733f8a894e6

-- 
Martin K. Petersen	Oracle Linux Engineering
