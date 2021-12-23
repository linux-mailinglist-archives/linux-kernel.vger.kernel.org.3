Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9A47DE85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbhLWFJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:09:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17426 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbhLWFJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:09:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BN0JQvW016934;
        Thu, 23 Dec 2021 05:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=OMvW6eO+PlYGQA9n9eHRPOe3ElC9aaRa9SFIhD8SZcI=;
 b=GhGyOUAivpddHjHv6AewkztRa1FEB4JEQGIUNDFz3wcPPdJFt0VOMB6w2IStZjlYsHBH
 Ev/z9r6ZmLhm2ZoGgVcj+CGX727BhTR2LOBSL+uIwj+yxCoxVGOuUTXg7glMZi7IDaNM
 eDYm2LaSFkb2sotJTYzV8+QgGkSMCrE87pZNq/QGBXBeLepkL5/qrtqxF8vVfKy1DzFG
 cu2cdhT1GXcz7UC4ZUtGSDVH9WVvfv0V6lOS/LReps8C7yJYMqOivt+IJJo8SGUBwHGM
 qLAGgAlblNBmjjWXyR2fuQHXCLyBin/hOCD4clLU8MjF42ybU4/F3D8j7k8xaeQvUa9S zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn1ne3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BN50vOT102251;
        Thu, 23 Dec 2021 05:09:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3d17f68veb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:27 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BN59OTg125399;
        Thu, 23 Dec 2021 05:09:26 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3d17f68vdd-3;
        Thu, 23 Dec 2021 05:09:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     beanhuo@micron.com, stanley.chu@mediatek.com, cang@codeaurora.org,
        bvanassche@acm.org, avri.altman@wdc.com, alim.akhtar@samsung.com,
        tomas.winkler@intel.com, asutoshd@codeaurora.org,
        Bean Huo <huobean@gmail.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        YongQin Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH v2] scsi: ufs: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
Date:   Thu, 23 Dec 2021 00:09:22 -0500
Message-Id: <164023594702.4594.97056831726187754.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211214120537.531628-1-huobean@gmail.com>
References: <20211214120537.531628-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VnYxAGQiFM4wiqX4YeIxK0F0JtQP86IK
X-Proofpoint-GUID: VnYxAGQiFM4wiqX4YeIxK0F0JtQP86IK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 13:05:37 +0100, Bean Huo wrote:

> From: Bean Huo <beanhuo@micron.com>
> 
> Call shost_for_each_device() with holding host->host_lock will cause
> a deadlock situation, which will cause the system to stall (the log
> as follow). Fix this issue by using __shost_for_each_device() in
> ufshcd_pending_cmds().
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: ufs: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
      https://git.kernel.org/mkp/scsi/c/99c66a8868e3

-- 
Martin K. Petersen	Oracle Linux Engineering
