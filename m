Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CAF4B618D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiBODUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:20:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiBODTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:19:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5120F71;
        Mon, 14 Feb 2022 19:19:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F2Ql26001593;
        Tue, 15 Feb 2022 03:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ym7mAcA1ee4w+AFGdByGLYKpHzufYsvMav0sMd5zBJI=;
 b=iu6Q2O87TAK3ACelIt9Y5xSVhBxSTtFIp4yDMUHOBWd1tfhpsJbcR1qQ9lrcLtgwwp9m
 Hcw6ol/6fLTH0qDD5fOhgmu9ElNqDQv77rQU1KORoOq8e0sFwdMJNQ77J51c8cjbPek1
 M6z9o+n6QkffifAUUcUZ0zbLMx1z6BvjwcBrVVQxneENQWSpykPzZ48Mj+5ilBnkoald
 NbN+S+xT6I/wpivHqjDpuvW5bL0pkNYpVFVA/Pr1Va6jAfvJ8BQSzw6zki/cUlVkY55i
 KGHWFboTmyK2DxJe+qOb1vFUTUSKG0QuP5SBJFcz4OwHF3ezdpH9a5I7LmH0bXsHgg11 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63p26hcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F3H4tq058423;
        Tue, 15 Feb 2022 03:19:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3e620wpgrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:27 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21F3JMP8064243;
        Tue, 15 Feb 2022 03:19:26 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3e620wpgqq-4;
        Tue, 15 Feb 2022 03:19:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, artur.paszkiewicz@intel.com,
        damien.lemoal@opensource.wdc.com,
        John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com, hch@lst.de,
        linux-kernel@vger.kernel.org, chenxiang66@hisilicon.com
Subject: Re: [PATCH 0/2] scsi: libsas: Drop SAS_TASK_AT_INITIATOR
Date:   Mon, 14 Feb 2022 22:19:16 -0500
Message-Id: <164489513314.15031.11868116422089036361.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
References: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HkdnaLm237wral_cqDlAjoqYLRnzJIqS
X-Proofpoint-GUID: HkdnaLm237wral_cqDlAjoqYLRnzJIqS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 18:43:22 +0800, John Garry wrote:

> Apart from some isci driver code, flag SAS_TASK_AT_INITIATOR is only set,
> so drop usage in that driver and then everywhere else.
> 
> This solves a use-after-free in the pm8001 queue path.
> 
> John Garry (2):
>   scsi: isci: Drop SAS_TASK_AT_INITIATOR check in isci_task_abort_task()
>   scsi: libsas: Drop SAS_TASK_AT_INITIATOR
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/2] scsi: isci: Drop SAS_TASK_AT_INITIATOR check in isci_task_abort_task()
      https://git.kernel.org/mkp/scsi/c/c39d5aa457f2
[2/2] scsi: libsas: Drop SAS_TASK_AT_INITIATOR
      https://git.kernel.org/mkp/scsi/c/26fc0ea74fcb

-- 
Martin K. Petersen	Oracle Linux Engineering
