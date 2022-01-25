Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE049ABE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiAYFnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:43:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbiAYFlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:06 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1VRwU019388;
        Tue, 25 Jan 2022 05:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=nIQ0KufWtds6hXgePiZbqHgasSll9U/MzBBXMbQhQeU=;
 b=pRe85c6jYJQmaa3pfz08FRWIFgAfTmH15qawQOLC2jKoTJ0gGrwG+yum82/pfYga4e90
 y1u6B+kNhtbtvmoVnQ69wgXRNYng0kANgqiz/FUf1lUZR8VCDtPbOO+bP4xDvyaL1w80
 IRQQ6wCg6FH47GMBWAeCRUxUFBZ9MYqhx7GnzaOa9ipWaz/18+xjLqFLdYrXSnFxJZ9p
 PGXNpRDJUMPfVaygMnNDwxhmB0V49NEnLkyq7k1B5LUIj+rlN+X6bJkLH7vHv21HhF1L
 P04sfzm2mEJ2jINivOKLvvupvfCWBt1Z/toXvd9Ac6YUDiDAiGLsUpOgm3PBmYmykyPr JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7asxqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5ev4s181770;
        Tue, 25 Jan 2022 05:40:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1spc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:59 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5evOX181790;
        Tue, 25 Jan 2022 05:40:58 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-4;
        Tue, 25 Jan 2022 05:40:58 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, John Meneghini <jmeneghi@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        mlombard@redhat.com, skashyap@marvell.com,
        linux-kernel@vger.kernel.org, guazhang@redhat.com,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v3] scsi: bnx2fc: flush destroy_work queue before calling bnx2fc_interface_put
Date:   Tue, 25 Jan 2022 00:40:40 -0500
Message-Id: <164308671271.32373.17082574491329103856.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115040044.1013475-1-jmeneghi@redhat.com>
References: <20220115040044.1013475-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8tku-nJpAgn7uBmSTLLIMEipPn-9FHvf
X-Proofpoint-ORIG-GUID: 8tku-nJpAgn7uBmSTLLIMEipPn-9FHvf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 23:00:44 -0500, John Meneghini wrote:

>   The bnx2fc_destroy functions are removing the interface before calling
>   destroy_work. This results multiple WARNings from sysfs_remove_group
>   as the controller rport device attributes are removed to early.
> 
>   Replace the fcoe_port's destroy_work queue.  It's not needed.
> 
>   The problem is easily reproducible with the following steps.
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: bnx2fc: flush destroy_work queue before calling bnx2fc_interface_put
      https://git.kernel.org/mkp/scsi/c/847f9ea4c518

-- 
Martin K. Petersen	Oracle Linux Engineering
