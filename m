Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB74C61F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiB1Dof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiB1Dob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:44:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1D3BA4B;
        Sun, 27 Feb 2022 19:43:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RLWt4K008207;
        Mon, 28 Feb 2022 03:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=8vC1OZK1nNYWF0YYyYwoLSw1BkaA8imP9N4exKKwzSY=;
 b=oLzjV1YuvVw8YQcr4MQ/BPNX2Mv+0MG02NfKXUy27z2KUjCcSSMgOgkXc8DF5f4mH8sg
 yZ3cAOEzKxkFIsJBBPUbWJ8zOuDQ8I0MbzQXxtSX1Y4IF27+g2eZfuS3eY4FaICQp9bY
 drrYXktlHV4SglJJbom1gLhhDgIgw3Bo/tjNs5ECSJbscy89NydlmlSf1OXyV6T0s9R5
 2kj4zugIM5AJMGDDivDfa37809B/CYDEuyHE4hoKXP/qFaJ2quwAD1MAJHUZjznXxSUy
 rlcyrYUaPn0wL8TrNml+3ycaLPEcj7Nu4qA6n2PsUVrWieYA2/4fgDq7k76yyXCs/RdW VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02k1qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3b9eo157682;
        Mon, 28 Feb 2022 03:43:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:31 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21S3hPvu165853;
        Mon, 28 Feb 2022 03:43:30 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnt3-6;
        Mon, 28 Feb 2022 03:43:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        hch@lst.de, chenxiang66@hisilicon.com,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-doc@vger.kernel.org, Ajish.Koshy@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuqi115@huawei.com, yanaijie@huawei.com, Viswas.G@microchip.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 00/18] scsi: libsas and users: Factor out LLDD TMF code
Date:   Sun, 27 Feb 2022 22:43:20 -0500
Message-Id: <164601967778.4503.718375483137953817.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
References: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s9SiSDTFch1kvu-bDVgPfQwCL3_tVd6o
X-Proofpoint-ORIG-GUID: s9SiSDTFch1kvu-bDVgPfQwCL3_tVd6o
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 20:50:41 +0800, John Garry wrote:

> This is just an update of the series to fix a build error, as reported
> here:
> https://lore.kernel.org/lkml/59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com/
> 
> Original cover letter is here:
> https://lore.kernel.org/linux-scsi/0d4f988d-881c-3717-f9d8-38739cf17e91@opensource.wdc.com/T/#mcae9d344f2795bdbb8845da29a140b58dbafb6f8
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[01/18] scsi: libsas: Handle non-TMF codes in sas_scsi_find_task()
        https://git.kernel.org/mkp/scsi/c/9aacf6fe9059
[02/18] scsi: libsas: Use enum for response frame DATAPRES field
        https://git.kernel.org/mkp/scsi/c/1d6049a3b14f
[03/18] scsi: libsas: Delete lldd_clear_aca callback
        https://git.kernel.org/mkp/scsi/c/25882c82f850
[04/18] scsi: libsas: Delete SAS_SG_ERR
        https://git.kernel.org/mkp/scsi/c/2dd6801a671c
[05/18] scsi: hisi_sas: Delete unused I_T_NEXUS_RESET_PHYUP_TIMEOUT
        https://git.kernel.org/mkp/scsi/c/da19eaba6e75
[06/18] scsi: libsas: Move SMP task handlers to core
        https://git.kernel.org/mkp/scsi/c/4aef43b25df2
[07/18] scsi: libsas: Add struct sas_tmf_task
        https://git.kernel.org/mkp/scsi/c/bbfe82cdbaf8
[08/18] scsi: libsas: Add sas_task.tmf
        https://git.kernel.org/mkp/scsi/c/96e54376a8b2
[09/18] scsi: libsas: Add sas_execute_tmf()
        https://git.kernel.org/mkp/scsi/c/001ec7f89bea
[10/18] scsi: libsas: Add sas_execute_ssp_tmf()
        https://git.kernel.org/mkp/scsi/c/350d85ba5bad
[11/18] scsi: libsas: Add TMF handler exec complete callback
        https://git.kernel.org/mkp/scsi/c/2037a340314f
[12/18] scsi: libsas: Add TMF handler aborted callback
        https://git.kernel.org/mkp/scsi/c/693e66a0a6ac
[13/18] scsi: libsas: Add sas_abort_task_set()
        https://git.kernel.org/mkp/scsi/c/69b80a0ed0b5
[14/18] scsi: libsas: Add sas_clear_task_set()
        https://git.kernel.org/mkp/scsi/c/e8585452953a
[15/18] scsi: libsas: Add sas_lu_reset()
        https://git.kernel.org/mkp/scsi/c/29d7769055a2
[16/18] scsi: libsas: Add sas_query_task()
        https://git.kernel.org/mkp/scsi/c/72f8810e1fdc
[17/18] scsi: libsas: Add sas_abort_task()
        https://git.kernel.org/mkp/scsi/c/4fea759edfa7
[18/18] scsi: libsas: Add sas_execute_ata_cmd()
        https://git.kernel.org/mkp/scsi/c/3f2e252ef727

-- 
Martin K. Petersen	Oracle Linux Engineering
