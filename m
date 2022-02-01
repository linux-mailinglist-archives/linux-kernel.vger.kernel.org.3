Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4864A551E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiBACDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:03:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5782 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232255AbiBACDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:03:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VMWrRx008746;
        Tue, 1 Feb 2022 02:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=pOGMqJJpokNe23I9w0DAGD5uDNxb9lYmNYzFb2yZcGw=;
 b=VwwNzDEh8R2WjxBxW2U1ZqXQXbEp27d1d8nOz1DoAC3xc5JVgF41J5VTyGpDAsE3PYv4
 zXFuO4InCy2J+GO+ve1bX5FPabPtvGlGcPho4yb6yPmckXVS7jV3A7+WHm+Vwb5mmAM/
 1u1ijnRFPNjIUGKEtVCiIvZpQvfVuYT9YWMTYW89a0LNbCXviDiKu8csqZp5trHHFqw1
 VWMJwlfYjtoBoYCuYzPvcUI6bmp9lHVdem0Z7OOVEu8DEAwfvXXe0AVap6xphQ6cD6SY
 qRo45xnZnzasfJZBCA2eqtdh5iUv/bt9GeU+ysqwxz39yqIGHR8h0p1QuTfuEp148DBw sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2gs7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2111tKeN079022;
        Tue, 1 Feb 2022 02:03:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:29 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21123EPh096319;
        Tue, 1 Feb 2022 02:03:29 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w3w-4;
        Tue, 01 Feb 2022 02:03:28 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Fix setting of hisi_sas_slot.is_internal
Date:   Mon, 31 Jan 2022 21:03:22 -0500
Message-Id: <164368097302.23346.15184270668603623540.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1643627607-138785-1-git-send-email-john.garry@huawei.com>
References: <1643627607-138785-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G-8oQKFLQxGxaDiehhlTBKPdy2wXNbjr
X-Proofpoint-ORIG-GUID: G-8oQKFLQxGxaDiehhlTBKPdy2wXNbjr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 19:13:27 +0800, John Garry wrote:

> The hisi_sas_slot.is_internal member is not set properly for ATA commands
> which the driver sends directly. A TMF struct pointer is normally used as
> a test to set this, but it is NULL for those commands. It's not ideal, but
> pass an empty TMF struct to set that member properly.
> 
> 

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: hisi_sas: Fix setting of hisi_sas_slot.is_internal
      https://git.kernel.org/mkp/scsi/c/c763ec4c10f7

-- 
Martin K. Petersen	Oracle Linux Engineering
