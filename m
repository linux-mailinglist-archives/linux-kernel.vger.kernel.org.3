Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668F463D78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbhK3SRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:17:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237911AbhK3SRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:17:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUI5Qn6013704;
        Tue, 30 Nov 2021 18:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=iUHJ2qRMsJxlw36oo7iC0kjfFA2JMPc0NAlpDjgOE0U=;
 b=FHHNFUn3gsovvL5WkUuiiRSRKBFrhowjDb1U0Kk+suxVOQGEzUx0fgY1hRNOUvxFuneN
 ZyiuEO4pRakD6tI1TOdkfhp0ycMg1ahCQ+SXN4IKoBr66d6zMatk11xqnmYfgPeyY1Ts
 YinOOVvBPTO7O1cOKH5eY5HbWVvQurZEFR6fu07R2L5x2QW6MRJEJKdwJrvqw7qjoAAE
 LtDeM+O62SUWpJDJYdfpUpAAsS7MkYhLPXGvvsIz42W677EZ5IZ555SDbqeDReAPqFYz
 CY1EecRujXlgBu+blMj3L3EFLQNNI9fhKbbvnXk8x0qVZ4MasTzeRzBz/s0y1KgcfqC1 Ww== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cnqv2t0tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 18:13:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUICsP2022799;
        Tue, 30 Nov 2021 18:13:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3ckcabk7ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 18:13:33 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUIDWl357868740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 18:13:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DF9F78067;
        Tue, 30 Nov 2021 18:13:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36E3F7805E;
        Tue, 30 Nov 2021 18:13:31 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 18:13:30 +0000 (GMT)
Message-ID: <e12619e9dbb53874a8a2c455347b0a233f8d7355.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: libfc: Fix a NULL pointer dereference in
 fc_lport_ptp_setup()
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Nov 2021 13:13:29 -0500
In-Reply-To: <20211130171049.199111-1-zhou1615@umn.edu>
References: <20211130171049.199111-1-zhou1615@umn.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xaGW0FLETxz4aD1mk84_Q18Q0US-hGgX
X-Proofpoint-ORIG-GUID: xaGW0FLETxz4aD1mk84_Q18Q0US-hGgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-01 at 01:10 +0800, Zhou Qingyang wrote:
> In fc_lport_ptp_setup(), fc_rport_create() is assigned to
> lport->ptp_rdata and there is a dereference of in
> fc_lport_ptp_setup(),
> which could lead to a NULL pointer dereference on failure of
> fc_rport_create().
> 
> Fix this bug by adding a check of fc_rport_create().
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_LIBFC=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback
> with function call")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/scsi/libfc/fc_lport.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/libfc/fc_lport.c
> b/drivers/scsi/libfc/fc_lport.c
> index 19cd4a95d354..5cd716afb711 100644
> --- a/drivers/scsi/libfc/fc_lport.c
> +++ b/drivers/scsi/libfc/fc_lport.c
> @@ -241,6 +241,13 @@ static void fc_lport_ptp_setup(struct fc_lport
> *lport,
>  	}
>  	mutex_lock(&lport->disc.disc_mutex);
>  	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
> +	if (!lport->ptp_rdata) {
> +		mutex_unlock(&lport->disc.disc_mutex);
> +		printk(KERN_WARNING "libfc: Failed to allocate for the
> port (%6.6x)\n",
> +				remote_fid);
> +		return;
> +	}
> +

This really doesn't look like a good idea.  Most GFP_KERNEL allocations
aren't going to fail unless the kernel is about to wedge anyway under
reclaim pressure.  fc_lport_ptp_setup is assumed to succeed if it
returns, there's no error handling, so the kernel would now continue in
an unexpected state if it recovers from the reclaim issue.

The kmalloc failure will have printed a message anyway and the oops
trace from the NULL deref would identify the location if it's relevant
and likely kill the iscsi daemon, so setting up a time bomb for someone
else really doesn't look to be improving the code.

James


