Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13D52E186
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiETBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiETBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:08:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE491566;
        Thu, 19 May 2022 18:08:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0Inm9015725;
        Fri, 20 May 2022 01:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qUf6SntwpxUIUfDhqhudgTCwuMcOgaLEEb6rtV4+Hm8=;
 b=dpLtFLrKiGUUfCMSlYip+Xxzfn7aT2jZjR0oVPDP8ZSD5oOy/QlZc934PQJULwfbJEc1
 usijH8DGVYWvZHePA2ECcoYJiEWlqBQDWL0hzLjqiH3q7KKWXf+ImkPXe/rRvHFcH9qN
 RUaYQoDG7MAzZXPeua6QKJ9F/X4fIn5el9afQnS2G2PMaLhUhlfEi95KfT1/PR+JDwm8
 /yhyOj79YdYGEyZQUqUj7hZV/U6u2IOiM4fU1meujL3jsD1omMU/gRL6O7sVN5cQtS9Q
 Iqs8hZYNcjXUsjXQ+mYLGca7RD6EvszgMokkko2zkAr2sUVa4+EgzlI1F6j69EvTqJtX nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2372612h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:08:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15svO027876;
        Fri, 20 May 2022 01:08:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5yxp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:08:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K188j0034914;
        Fri, 20 May 2022 01:08:09 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v5yxn5-1;
        Fri, 20 May 2022 01:08:08 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     avri.altman@wdc.com, Daejun Park <daejun7.park@samsung.com>,
        jejb@linux.ibm.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        bvanassche@acm.org, beanhuo@micron.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: Fix referencing invalid rsp field
Date:   Thu, 19 May 2022 21:08:06 -0400
Message-Id: <165300887555.11381.15197000918916648694.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
References: <CGME20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612@epcms2p8> <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cObOaScLb2VDQvWGfhOcQ4dxieWBDeJl
X-Proofpoint-ORIG-GUID: cObOaScLb2VDQvWGfhOcQ4dxieWBDeJl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 15:05:29 +0900, Daejun Park wrote:

> This is a patch for fixing referencing sense data when it is invalid.
> When the length of the data segment is 0, there is no valid information in
> the rsp field, so ufshpb_rsp_upiu() is returned without additional
> operation.
> 
> 

Applied to 5.18/scsi-fixes, thanks!

[1/1] scsi: ufs: Fix referencing invalid rsp field
      https://git.kernel.org/mkp/scsi/c/d5d92b644084

-- 
Martin K. Petersen	Oracle Linux Engineering
