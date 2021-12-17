Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D824783DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhLQEFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:05:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40466 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232624AbhLQEEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:04:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2X4T8004122;
        Fri, 17 Dec 2021 04:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=47mkUn5AIE/gaIz5Xk8dghf/d3/VjCK/LqtvQA/k/gk=;
 b=vBORmk6TUjVAe/N3VTkmAn1iUXC3E5PjTb/8pkip43+Fe4IRWclzawYLlu1X7HtsLZoB
 89Z9NetZghoKJsAJ7C+/6mxj6as5cIj2EeQDq32/VjF4j3fm18at3uaTVgIG+92eKr5b
 cL89kCTyCpoPrlgRxBOJq7EnHwHYahOoVctAVY7107rjz5/m/mGOobd8eJb29XTtUHMM
 rwKBjUkThPyUWxR05DMlszcGVtOwi/6uiIJq4UMNpPhAD7c5GHMqPkzs9i6fgLNq/y+v
 NYUgzTFfVZrDR7I30/ybBqd2n0dtVutgBT8XuhdiVTnm6uR81Sb7oVgahsgyBe+hCmpR Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcmkgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH40jfb154622;
        Fri, 17 Dec 2021 04:04:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh436dvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:46 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BH44icm167096;
        Fri, 17 Dec 2021 04:04:46 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh436duh-3;
        Fri, 17 Dec 2021 04:04:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
Date:   Thu, 16 Dec 2021 23:04:42 -0500
Message-Id: <163971367435.637.14441712327828336248.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208195957.1603092-1-keescook@chromium.org>
References: <20211208195957.1603092-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6yjbvYlfNEKDGgBhzbA7FIUKZnHGi540
X-Proofpoint-GUID: 6yjbvYlfNEKDGgBhzbA7FIUKZnHGi540
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 11:59:57 -0800, Kees Cook wrote:

> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add struct_group() to mark "stat" region of struct lpfc_cgn_info that
> should be initialized to zero, and refactor the "data" region memset()
> to wipe everything up to the cgn_stats region.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
      https://git.kernel.org/mkp/scsi/c/532adda9f405

-- 
Martin K. Petersen	Oracle Linux Engineering
