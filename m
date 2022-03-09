Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102C34D27CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiCIEPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCIEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:15:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7E3B3F9;
        Tue,  8 Mar 2022 20:14:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228M9Opt010816;
        Wed, 9 Mar 2022 04:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Ee8V5JTFr5ipyfP0/LnKk12lN6jSMRmDSRlUrIwmcaQ=;
 b=SrbdUig5uK8FtXQUYYiFMdU7+OCF66U6vZL/3TtZFBpXZZJITjOl+dKhKCKxUcSkknfg
 AM7P2hVCkBffep31MZmXUFCBBm69LBMcQB9kGxK/6zFhp9lcrYi+GUTar5FEzxRGIDEs
 QMtKomqa4aUI1Z+axQiqYvSv/3Zxm5e4fKY6nsLVz3H+Fm3vfFWqOoJj0kBZxoLXjpYb
 RGSbDI1mU5crqW9YVe4xQR3gz3jEXxSFuW+32DWBDV+C7YQXU8z26N+r644t/6EHMBIW
 26vn/ZgF93FjAZzXcWEoVAbD96AmFoov2zYg64+g8KoiclHNcjKkeyj4G8vfZiBGg3TX Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrarhvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 04:14:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22947CNu166749;
        Wed, 9 Mar 2022 04:14:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3ekyp2qdeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 04:14:14 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2294EAeN174884;
        Wed, 9 Mar 2022 04:14:13 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3ekyp2qddd-5;
        Wed, 09 Mar 2022 04:14:13 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, Zheyu Ma <zheyuma97@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: wd719x: Return proper error code when dma_set_mask() fails
Date:   Tue,  8 Mar 2022 23:14:09 -0500
Message-Id: <164679903743.29335.13151374172045636513.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com>
References: <1646060055-11361-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9IvUjNjLmE3ra5bt1neXgimORnAUbO6Z
X-Proofpoint-ORIG-GUID: 9IvUjNjLmE3ra5bt1neXgimORnAUbO6Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 14:54:15 +0000, Zheyu Ma wrote:

> During the process of driver probing, the probe function should return < 0
> for failure, otherwise, the kernel will treat value >= 0 as success.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: wd719x: Return proper error code when dma_set_mask() fails
      https://git.kernel.org/mkp/scsi/c/98cdcd6c6b4a

-- 
Martin K. Petersen	Oracle Linux Engineering
