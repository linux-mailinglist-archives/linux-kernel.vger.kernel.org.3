Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB154783D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhLQEEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:04:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35678 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232607AbhLQEEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:04:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2XjFu031682;
        Fri, 17 Dec 2021 04:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=19/PQtMWBa3u3QytVnKth6JV/9ZjL9tV4MHRqsQQSKU=;
 b=CdGr58CuPwd+6iDnOxS+zA/f6+cLakKCzYMl/5tU9AZXwRIDkwjsFEa1dfsOHNB8H5zb
 +qIplo9wlcqrjM5xOkltTmsSLaOvREiy4JoY81UfUNPyG/XqLnQJE4MgGNr2z8mQrOZc
 fSLifeZhBURLD/mTjYRgz38NGm/79am2uzU5VIYXtZJZqj3GeT7EuyD2c8Nd9VKKvpvY
 wdynkWTlAZZaPWagdKzJiGl0omgy7VcCYiSZid/qF7wa99QYOnCMB5sk8iugWQyo7Jwx
 EFBCzeLlmBaccSDry9OxWVFSAUEqFIKaxKelHzzvIHfgMqKc144zIO5SoA+98bH1JoBt Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbmq9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH40h6B154456;
        Fri, 17 Dec 2021 04:04:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh436dva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:04:45 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BH44ick167096;
        Fri, 17 Dec 2021 04:04:45 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh436duh-2;
        Fri, 17 Dec 2021 04:04:45 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Enable strict compile-time memcpy() fortify checks
Date:   Thu, 16 Dec 2021 23:04:41 -0500
Message-Id: <163971367436.637.10405641198392326021.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _3DTAqN1sH7ejLob7k4cEHqZJ6z5fVKJ
X-Proofpoint-GUID: _3DTAqN1sH7ejLob7k4cEHqZJ6z5fVKJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 14:33:14 -0800, Kees Cook wrote:

> This is "phase 2" (of several phases) to hardening the kernel against
> memcpy-based buffer overflows. With nearly all compile-time fixes
> landed, the next step is to turn on the warning globally to keep future
> compile-time issues from happening, and let us take the step towards
> run-time checking (and towards a new API for flexible array structures).
> 
> This series is based on latest linux-next, and several patches here
> have already been taken by subsystem maintainers but haven't appeared
> in linux-next yet, and are noted below.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[15/17] scsi: lpfc: Use struct_group() to initialize struct lpfc_cgn_info
        https://git.kernel.org/mkp/scsi/c/532adda9f405

-- 
Martin K. Petersen	Oracle Linux Engineering
