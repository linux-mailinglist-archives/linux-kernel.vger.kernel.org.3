Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53F34A551B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiBACDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:03:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63044 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232663AbiBACDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:03:32 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VMNoNc008741;
        Tue, 1 Feb 2022 02:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=fmt6l1dJkXUoRA6wjq+n6yTaZhQU9eLUhCPVoJ4uYkI=;
 b=bu/cmrFHzx4MOiMEy7BJWMMvIOEWTKKiN0i1+RK9XY6O3mTvpjkxJ3204ApOuDhbqnkg
 lHsMSJd4guvnlfg9VoG/+0NOiwT230P9N7H35lDvcwT5PJ8BSqTVdASfeBF/NP+gZkc4
 e+X0jJ5DksGCBq8OmGhTI7/kQSkQQSvjXXTfkzzAXjJ5MWNxX+MnVhHyud7cOmVOmpbB
 maI6tp5bHpr6Tvn9Tw0yd8PwQeuber7C257A2CarQPRJa6QIeXDV7ICjWU5hxlTCN6Iq
 o8912Nc6X5V9l1gldGlCZBVtQq+Eav813b+lSbvgp1Y454ql6H1P0Q6pQIl3hQBuqY+Q mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2gs7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2111tKmo079030;
        Tue, 1 Feb 2022 02:03:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:26 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21123EPd096319;
        Tue, 1 Feb 2022 02:03:26 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w3w-2;
        Tue, 01 Feb 2022 02:03:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Meneghini <jmeneghi@redhat.com>, skashyap@marvell.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, mlombard@redhat.com,
        linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, njavali@marvell.com,
        guazhang@redhat.com
Subject: Re: [PATCH] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
Date:   Mon, 31 Jan 2022 21:03:20 -0500
Message-Id: <164368097301.23346.7911968188172363088.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124145110.442335-1-jmeneghi@redhat.com>
References: <20220124145110.442335-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4vD1BoD_LtZqICZrN0hBsZPFYhnVMwpJ
X-Proofpoint-ORIG-GUID: 4vD1BoD_LtZqICZrN0hBsZPFYhnVMwpJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:51:10 -0500, John Meneghini wrote:

>     Running tests with a debug kernel shows that bnx2fc_recv_frame is
>     modifying the per_cpu lport stats counters in a non-mpsafe way.
>     Just boot a debug kernel and run the bnx2fc driver with the hardware
>     enabled.
> 
>     [ 1391.699147] BUG: using smp_processor_id() in preemptible [00000000] code: bnx2fc_
>     [ 1391.699160] caller is bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>     [ 1391.699174] CPU: 2 PID: 4355 Comm: bnx2fc_l2_threa Kdump: loaded Tainted: G    B
>     [ 1391.699180] Hardware name: HP ProLiant DL120 G7, BIOS J01 07/01/2013
>     [ 1391.699183] Call Trace:
>     [ 1391.699188]  dump_stack_lvl+0x57/0x7d
>     [ 1391.699198]  check_preemption_disabled+0xc8/0xd0
>     [ 1391.699205]  bnx2fc_recv_frame+0xbf9/0x1760 [bnx2fc]
>     [ 1391.699215]  ? do_raw_spin_trylock+0xb5/0x180
>     [ 1391.699221]  ? bnx2fc_npiv_create_vports.isra.0+0x4e0/0x4e0 [bnx2fc]
>     [ 1391.699229]  ? bnx2fc_l2_rcv_thread+0xb7/0x3a0 [bnx2fc]
>     [ 1391.699240]  bnx2fc_l2_rcv_thread+0x1af/0x3a0 [bnx2fc]
>     [ 1391.699250]  ? bnx2fc_ulp_init+0xc0/0xc0 [bnx2fc]
>     [ 1391.699258]  kthread+0x364/0x420
>     [ 1391.699263]  ? _raw_spin_unlock_irq+0x24/0x50
>     [ 1391.699268]  ? set_kthread_struct+0x100/0x100
>     [ 1391.699273]  ret_from_fork+0x22/0x30
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: bnx2fc: make bnx2fc_recv_frame mp safe
      https://git.kernel.org/mkp/scsi/c/936bd03405fc

-- 
Martin K. Petersen	Oracle Linux Engineering
