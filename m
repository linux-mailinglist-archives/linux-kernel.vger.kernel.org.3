Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0234C61F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiB1Dod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiB1Do1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:44:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07463C48B;
        Sun, 27 Feb 2022 19:43:45 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMWjOV008194;
        Mon, 28 Feb 2022 03:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=FkL5/zsuRBEvC3ZeADE9UQn/O+zBdg3TWhs3Q9D3QqE=;
 b=xl0HAL7h/NXdMosLgJB6BMfNUi5Qqazz3Ij0NVtZevnDIJ5fX97y1aqJ0bq+5pn4d7jA
 xgA8s4M8mEIIX3h5fJ9+OSQnHmV7nrCT1tg4GjZ4gDvpdSgDPC9AjhKiUPbOFel4JVy6
 f7as7deKbpLNs4XmXue+NTAnN73VRYbnA1qRm7YHPRfjj2ocMnAaFiLZ8V/9zJPuPSpQ
 2sB7BLxpEinkJtXjHSLxS9g7yVeKGQxKHQ+1dgvAQ084bU7YTM9LVs+NNNM0yKDjGIFa
 MhiMnw7JajgK5SCsX9fqk/uc+2joHLBOsWjPtGPgh9VQgXghSpW0CqvRex7OkErcH2GL KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02k1qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3b93G157706;
        Mon, 28 Feb 2022 03:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21S3hPw0165853;
        Mon, 28 Feb 2022 03:43:33 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnt3-8;
        Mon, 28 Feb 2022 03:43:32 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        asutoshd@codeaurora.org, cang@codeaurora.org, bvanassche@acm.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: Remove wlun_dev_to_hba()
Date:   Sun, 27 Feb 2022 22:43:22 -0500
Message-Id: <164601967776.4503.4940676586153373665.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
References: <CGME20220215114002epcms2p1eb4e53507c96e0f24770af16aedcf5c6@epcms2p1> <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jJS6ZSkMoWIJqKfxnb0BVxCDz9QPKw-x
X-Proofpoint-ORIG-GUID: jJS6ZSkMoWIJqKfxnb0BVxCDz9QPKw-x
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 20:40:02 +0900, Keoseong Park wrote:

> Commit edc0596cc04b ("scsi: ufs: core: Stop clearing UNIT ATTENTIONS")
> removed all callers of wlun_dev_to_hba(). Hence also remove the macro itself.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: ufs: Remove wlun_dev_to_hba()
      https://git.kernel.org/mkp/scsi/c/482dcaa1c91a

-- 
Martin K. Petersen	Oracle Linux Engineering
