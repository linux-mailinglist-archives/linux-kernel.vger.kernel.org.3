Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609B2546BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbiFJRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiFJRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:45:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E463562D9;
        Fri, 10 Jun 2022 10:45:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AEONKW006817;
        Fri, 10 Jun 2022 17:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qy6xaM4c9k8GHDIeOJB2CNTWmIPmnsiOo79l09vf+qA=;
 b=NCT5ojSsRkdZupPJFhL8EU9RGjkqZKrWZJ1zCMj0h8dvStBKvvDrNPbLGWQwk/UTIlbM
 q3vTgu3/jrYEGqZF02OIwVNUUTi+I4ZEJNe+++T9BQqgxsYyxyI/wVk193/v3EF3g75J
 0idSDo8ZZ3VEQOOYGrmXbWaCespr9gFHjH+iuIdwvO69/Qi2Yi3xMe+yG71NLz3MuNVz
 AzfQ4Ti1aNd38iCOtQFo6cMNPEnCDYU1WKIdD14/HC2nwZydGtFLMuFaX2RhUKggt41N
 L2eNJ32yEfVH3TrMDnLDmYeyMazc9RuGhz1/o7QK2bMoM2R8fJuVxveIOX/lMnbmfeAK Lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekp6x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 17:45:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25AHFMx4034947;
        Fri, 10 Jun 2022 17:45:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwudaupv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 17:45:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25AHcugj012397;
        Fri, 10 Jun 2022 17:45:12 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwudaunq-2;
        Fri, 10 Jun 2022 17:45:12 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, cleech@redhat.com,
        open-iscsi@googlegroups.com, lduncan@suse.com,
        linux-kernel@vger.kernel.org, keliu <liuke94@huawei.com>,
        jejb@linux.ibm.com, michael.christie@oracle.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] drivers: scsi: Directly use ida_alloc()/free()
Date:   Fri, 10 Jun 2022 13:45:09 -0400
Message-Id: <165488292963.17199.2741130090390033654.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220527083049.2552526-1-liuke94@huawei.com>
References: <20220527083049.2552526-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g4foTtVNoAI6-Ak9diqR8UK2Axx4YXDT
X-Proofpoint-ORIG-GUID: g4foTtVNoAI6-Ak9diqR8UK2Axx4YXDT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 08:30:49 +0000, keliu wrote:

> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] drivers: scsi: Directly use ida_alloc()/free()
      https://git.kernel.org/mkp/scsi/c/3fd3a52ca672

-- 
Martin K. Petersen	Oracle Linux Engineering
