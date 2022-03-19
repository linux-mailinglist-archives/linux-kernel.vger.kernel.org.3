Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBC4DE5C0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbiCSD7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbiCSD6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:58:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F0103BB6;
        Fri, 18 Mar 2022 20:57:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3BgIT000642;
        Sat, 19 Mar 2022 03:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=2LSpElg9eqep1ve6R13MKajEKCL9ymkAaD7aT2pb0OY=;
 b=qpO+z8cZ23KL3H4d33WAKM7H1Oyf3IEC1cuJRaaBFgHlsxKFcLLkpEtSwJPRVanr4cgF
 295qGX5dT2Vgn8Rp41UiHMEraWWtIJlfu8exR5x7wMgCSOjis0QNpONaoBqjTRCjmbuS
 Q3ptbs7Xg1IvCA3gxq793qU9BjLTrX/t8CAQMBOuscKH7l9UUXINjooDGMP/k7XMmus/
 BPAG6tcKsFW7cpM5sWXc3sa/fCARiduevQciR8Kl4K40Ll46CICkmZ6nHq2rjrW4ilqP
 PNpOg1VaqEzdA8a+s4dxopxz/dweVNOluA0De5Qv49f8hkVG6OfmN5arFdoxC48HUmMh Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72a80yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22J3v5Rw007140;
        Sat, 19 Mar 2022 03:57:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:05 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22J3v5Qc007126;
        Sat, 19 Mar 2022 03:57:05 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmn-1;
        Sat, 19 Mar 2022 03:57:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
        Wenchao Hao <haowenchao@huawei.com>,
        linux-scsi@vger.kernel.org, Chris Leech <cleech@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Mike Christie <michael.christie@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 0/3] scsi:iscsi: handle iscsi_cls_conn device with sysfs correctly
Date:   Fri, 18 Mar 2022 23:56:51 -0400
Message-Id: <164766213031.31329.2067042035707430877.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310015759.3296841-1-haowenchao@huawei.com>
References: <20220310015759.3296841-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jR7Z0HAp5jikhT8qzqGlTQTXinLUS8Jf
X-Proofpoint-ORIG-GUID: jR7Z0HAp5jikhT8qzqGlTQTXinLUS8Jf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 20:57:56 -0500, Wenchao Hao wrote:

> We found a NULL pointer dereference in iscsi_sw_tcp_conn_get_param(),
> the root reason is we did sysfs addition wrong.
> 
> The origin implement do device setup in iscsi_create_conn() which
> bind the alloc/init and add in one function; do device teardown in
> iscsi_destroy_conn() which bind remove and free in one function.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/3] scsi: iscsi: Add helper functions to manage iscsi_cls_conn
      https://git.kernel.org/mkp/scsi/c/ad515cada7da
[2/3] scsi:libiscsi: Add iscsi_cls_conn to sysfs after been initialized
      https://git.kernel.org/mkp/scsi/c/7dae459f5e56
[3/3] scsi:libiscsi: teradown iscsi_cls_conn gracefully
      https://git.kernel.org/mkp/scsi/c/8709c323091b

-- 
Martin K. Petersen	Oracle Linux Engineering
