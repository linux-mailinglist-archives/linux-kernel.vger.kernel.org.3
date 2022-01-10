Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5C48A250
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiAJWFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23724 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345138AbiAJWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:04:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlWkx020711;
        Mon, 10 Jan 2022 22:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=N7Dxf+DcwX9/Y/Jtfs2m8P2aqSA45sl7OZmw324ZcVA=;
 b=E885sKdeaP/MrpylFeeO9IYgaE04mVwhv9KPEN6yflg9LGTC1+ntpkRfR5ZAlHr3IBMf
 3Wl21UuOOfsBMqgen3Yfbyb3Y5XIRGOH8UkotK8PJmgOyKFbUJXwAkM4a6lHhlz397b+
 DVsvd9ARnJmelehoNHRdbNesb36QrQmDMhUuND6qlkgPEvwHNuaEJqnTQ1CTcrreuavY
 STT/A4RSqdi4dySsciu5w4I+9eywhpS4yHm76mWPfvt/mM8+Rtu7awbOMsoIOYO9rcZI
 Y7mr8MUC3dUJ6S8Dx6shBEdVWPMx9OLZu5FRfxfDHcGryRUgbyAtkOLXP78tEodaq3Qi cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk99hhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ALtw6V139092;
        Mon, 10 Jan 2022 22:04:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:04:52 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AM4iCA174082;
        Mon, 10 Jan 2022 22:04:52 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3df2e3vqp8-7;
        Mon, 10 Jan 2022 22:04:51 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] scsi: megaraid: Avoid mismatched storage type sizes
Date:   Mon, 10 Jan 2022 17:04:39 -0500
Message-Id: <164182835586.13635.12443651708409705777.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220105173633.2421129-1-keescook@chromium.org>
References: <20220105173633.2421129-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wYHm0wyjssySoI76BHzSt0AUqnoe7zVd
X-Proofpoint-ORIG-GUID: wYHm0wyjssySoI76BHzSt0AUqnoe7zVd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 09:36:33 -0800, Kees Cook wrote:

> Remove needless use of mbox_t, replacing with just struct
> mbox_out. Silences compiler warnings under a -Warray-bounds build:
> 
> drivers/scsi/megaraid.c: In function 'megaraid_probe_one':
> drivers/scsi/megaraid.c:3615:30: error: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Werror=array-bounds]
>  3615 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
>       |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/megaraid.c:3599:23: note: while referencing 'raw_mbox'
>  3599 |         unsigned char raw_mbox[sizeof(struct mbox_out)];
>       |                       ^~~~~~~~
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: megaraid: Avoid mismatched storage type sizes
      https://git.kernel.org/mkp/scsi/c/315d049ad195

-- 
Martin K. Petersen	Oracle Linux Engineering
