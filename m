Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FBE54EF46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379684AbiFQCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbiFQCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:22:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A585764D15;
        Thu, 16 Jun 2022 19:22:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0M5VH032718;
        Fri, 17 Jun 2022 02:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=yH76RWNg3lCfuOvFoykQtMswr1892H91uz8/IAVneDk=;
 b=LXGuYYkmxTKfTcYBkazqmWo7yn5FHDkzPZGZGhr7Klwm4eyrZxptyS9gggaDt0QrXEd2
 SEWCzW4o9ZLCrkHhfcUmxYeanwuWyFVTuJySTVu93oO8W44gbp242+jj8XUlaP3y+KcW
 HvXXJIXfBDILoHedLiieZIYsWr1tZpRDtbpI9RAONuBqCccw6CPqWeYDUFj0LXvkw7ku
 yaE0dfcCK+JuQMfjqfAkGfrbL+9VmLl1hYuocHak3OBgG9KqYryJMUgYCKcASmWdgkiE
 m1M3gkxoGYd8QVsupKB9Me8IYHoJxCcgBfYX2xFK5O79amMPssSkojIPBPcwJmVDV1S/ Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2vv2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H2G6uU029033;
        Fri, 17 Jun 2022 02:21:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:21:44 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25H2LejL040352;
        Fri, 17 Jun 2022 02:21:43 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr27jd7c-4;
        Fri, 17 Jun 2022 02:21:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: target: iscsi: Fix NULL pointer dereference in iscsi_conn_auth_required()
Date:   Thu, 16 Jun 2022 22:21:37 -0400
Message-Id: <165543243409.26207.6588379308154527648.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220613014321.107045-1-yang.lee@linux.alibaba.com>
References: <20220613014321.107045-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nk7pKNFSbovfbbs3MM2Akz8t7o2Y-Hln
X-Proofpoint-ORIG-GUID: Nk7pKNFSbovfbbs3MM2Akz8t7o2Y-Hln
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 09:43:21 +0800, Yang Li wrote:

> Fix following coccicheck error:
> ./drivers/target/iscsi/iscsi_target_nego.c:831:13-26: ERROR: se_nacl is
> NULL but dereferenced.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: target: iscsi: Fix NULL pointer dereference in iscsi_conn_auth_required()
      https://git.kernel.org/mkp/scsi/c/35bf020bd8ab

-- 
Martin K. Petersen	Oracle Linux Engineering
