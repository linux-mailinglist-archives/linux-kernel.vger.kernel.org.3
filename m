Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E54C9D00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiCBFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbiCBFOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A41B150A;
        Tue,  1 Mar 2022 21:13:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222ZTug016801;
        Wed, 2 Mar 2022 05:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=NbzeaFi0z7Sz9o52SekKgALm+FojvqOIJNhInDMUZqA=;
 b=MyKytFczjIcPJlH9Ayr0JP6fe4tDiNqaDT8Ubj6NjkN7Xe4A6/QzSTnE39dpKWR8dJB4
 R5Ig43hjswt+I4KetWdykFgItdbYk/VfY88M5AuTn0845tfYoy3oFzje6OvmfRmF/FU6
 lT+mshpM/dMeY3pn08MV7fDEUt+yfDPEtRMyz9Uym087FQ1hx2/dy+LBZOtM6R9QObi4
 fn6F34V5jKVAK1zHmmyEVidE2DPtcrq7FK/as01ugd0GPm/Utpp6OIFlm4TXhYVfC+JF
 RDYp46ETM2WRq9P8djgftVhTq7swnHhQdqOVVLquKAZ6tiPP84iU2KPSaDQ6+n0X9wSx FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayu3fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C1tK175224;
        Wed, 2 Mar 2022 05:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:37 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPQ178145;
        Wed, 2 Mar 2022 05:13:37 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-6;
        Wed, 02 Mar 2022 05:13:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2][next] scsi: fc: Replace one-element arrays with flexible-array members
Date:   Wed,  2 Mar 2022 00:13:24 -0500
Message-Id: <164619702111.16127.16766138322408976398.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214223903.GA859464@embeddedor>
References: <20220214223903.GA859464@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I1L9p48POxWdIF1CCogKKpt7HuxyLff7
X-Proofpoint-ORIG-GUID: I1L9p48POxWdIF1CCogKKpt7HuxyLff7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 16:39:03 -0600, Gustavo A. R. Silva wrote:

> Use flexible-array members in struct fc_fdmi_attr_entry and
> fs_fdmi_attrs instead of one-element arrays, and refactor the
> code accordingly.
> 
> Also, this helps with the ongoing efforts to globally enable
> -Warray-bounds and get us closer to being able to tighten the
> FORTIFY_SOURCE routines on memcpy().
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: fc: Replace one-element arrays with flexible-array members
      https://git.kernel.org/mkp/scsi/c/c5b483d5c1a2

-- 
Martin K. Petersen	Oracle Linux Engineering
