Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F04DE5C2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiCSD7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbiCSD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:58:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D7B111DF9;
        Fri, 18 Mar 2022 20:57:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J3CLKu001925;
        Sat, 19 Mar 2022 03:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=kKLElV237QkleibtFpSI78rAupFder9wqJSPK8gb4Kg=;
 b=c5xSFM/UZMShnxlXPQBphz0h+R+osLoheBnDzfZBHxNJYK+XxVKbjcb7u6OZb6bghaLH
 Vnh7EGv+Kc5dIPA2TYFwRrng7kYzKoBjARdDlNkFbKwaEmsD10m9W2R1cmBP/lbpthug
 wQJVEcYqMRyFu9KK0Fs8IcM1mOZ6j0Nf1ZSpttJQAUmRvqEBh27m8yEyOZdX1UexGd+V
 5LSbbuxDcNCdtdUkF2wLpg2cv1sLeQ3d79hWrttyeykp3jBhE9AYZ+hgk84uGhYjL2ez
 Wozux+8fqJxZYyE2yoJQBtj9FDQVB0hcmeVWrzVeXl/iWhKCoJKGfOlNcq2GGDrzrZdT rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72a8106-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22J3utTE007031;
        Sat, 19 Mar 2022 03:57:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 03:57:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22J3v5Qg007126;
        Sat, 19 Mar 2022 03:57:08 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ew5kyshmn-3;
        Sat, 19 Mar 2022 03:57:08 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        damien.lemoal@opensource.wdc.com, jinpu.wang@cloud.ionos.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        liuqi115@huawei.com, hch@lst.de, Viswas.G@microchip.com,
        chenxiang66@hisilicon.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Ajish.Koshy@microchip.com
Subject: Re: [PATCH v2 0/4] scsi: libsas and users: Factor out internal abort code
Date:   Fri, 18 Mar 2022 23:56:53 -0400
Message-Id: <164766213030.31329.3570055457807072827.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
References: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9_qatTbC3os9dQaciEafNfM-9sVWYHgu
X-Proofpoint-ORIG-GUID: 9_qatTbC3os9dQaciEafNfM-9sVWYHgu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 20:23:48 +0800, John Garry wrote:

> This is a follow-on from the series to factor out the TMF code shared
> between libsas LLDDs.
> 
> The hisi_sas and pm8001 have an internal abort feature to abort pending
> commands in the host controller, prior to being sent to the target. The
> driver support implementation is naturally quite similar, so factor it
> out.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/4] scsi: libsas: Add sas_execute_internal_abort_single()
      https://git.kernel.org/mkp/scsi/c/5c9bf3635b66
[2/4] scsi: libsas: Add sas_execute_internal_abort_dev()
      https://git.kernel.org/mkp/scsi/c/6a91c3e31578
[3/4] scsi: pm8001: Use libsas internal abort support
      https://git.kernel.org/mkp/scsi/c/2cbbf489778e
[4/4] scsi: hisi_sas: Use libsas internal abort support
      https://git.kernel.org/mkp/scsi/c/095478a6e5bf

-- 
Martin K. Petersen	Oracle Linux Engineering
