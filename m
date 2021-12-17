Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5594783DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhLQEE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:04:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232621AbhLQEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:04:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2LUTs031677;
        Fri, 17 Dec 2021 04:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=62+KeCfEEt4IN0B9vvQrHbqGz7S9naXKNwImC4Q1HhI=;
 b=lsXrhwJXgeI9pvxMAafVPnJx/PsJDeqM/MRp7fSeeLt1LCgLRMWINUOzJb3HvZ3kauyP
 agE787yrnjaAJfUf7itRolNe9GBOsZrbpaV4WbiFPXxsxwkCayN3dee6MhcIBpG/+7/v
 SfdKvQaggwhaMJesuy3Cr3pGsq+n7hYSWngGbXbXVRL+qSaVi/chuPs5lYqYtIfTUDjf
 FGXPU/PNtb2zab6a8wQwSx9Z9Di2dkgnsqH2ysN/qJcJnrw+yUknr9YKk6tePtA5eI1M
 rhCJqE6dm6IpbtyjJosHV4Ggn21h3XbhVanpZbrzgH43BjI3LDzxfJw3BIy00VYAs4Xz cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbmq9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH40jhZ154638;
        Fri, 17 Dec 2021 04:04:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh436dw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:47 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BH44ico167096;
        Fri, 17 Dec 2021 04:04:47 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh436duh-4;
        Fri, 17 Dec 2021 04:04:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Use struct_group to isolate cast to larger object
Date:   Thu, 16 Dec 2021 23:04:43 -0500
Message-Id: <163971367437.637.1523954588992475904.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203223351.107323-1-keescook@chromium.org>
References: <20211203223351.107323-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W7HNAG-oaZzf8oPHrOu5l8Xg8OxZc45-
X-Proofpoint-GUID: W7HNAG-oaZzf8oPHrOu5l8Xg8OxZc45-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 14:33:51 -0800, Kees Cook wrote:

> When building under -Warray-bounds, a warning is generated when casting
> a u32 into MAILBOX_t (which is larger). This warning is conservative, but
> it's not an unreasonable change to make to improve future robustness. Use
> a tagged struct_group that can refer to either the specific fields or
> the first u32 separately, silencing this warning:
> 
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_reset_barrier':
> drivers/scsi/lpfc/lpfc_sli.c:4787:29: error: array subscript 'MAILBOX_t[0]' is partly outside array bounds of 'volatile uint32_t[1]' {aka 'volatile unsigned int[1]'} [-Werror=array-bounds]
>  4787 |         ((MAILBOX_t *)&mbox)->mbxCommand = MBX_KILL_BOARD;
>       |                             ^~
> drivers/scsi/lpfc/lpfc_sli.c:4752:27: note: while referencing 'mbox'
>  4752 |         volatile uint32_t mbox;
>       |                           ^~~~
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: lpfc: Use struct_group to isolate cast to larger object
      https://git.kernel.org/mkp/scsi/c/c167dd0b2a7a

-- 
Martin K. Petersen	Oracle Linux Engineering
