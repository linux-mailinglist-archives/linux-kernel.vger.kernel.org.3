Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3523349120E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiAQW61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:58:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61168 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238447AbiAQW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:58:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HJvtnh005273;
        Mon, 17 Jan 2022 22:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YKf3QRk6cGL2oEcXu+jYQKo1iAyahjY9WnnEujEJQ8k=;
 b=fb9n2/fjQ4AmyQa76lhi1DbjJ8PxL4IkfJg2dus8nxFXIHtn0RWCg018rRgCWNS1GGTI
 u5ECiGqHO/Mxd6OeZSA4Jxrd0/W4ICJzAliytx6ECsy/lcsy9sRPEFlua8fkDaeOzkVR
 RBDHzMp0wMcp/DQoU7BT5hHTdvQEmNLXNc/6fqT0AwYDVcMi793eJPnR3RSg5A0yS9yi
 8qX9X+tu+JYG2BQiavtFK4oZfyAX886LlKO30AccRipLwKrrfbANwf7mip3Pr8/ktVQk
 WktgWcI6xd9CzoMQ32L9BohU3MYj156t5hGaQvOJZzpqjbpkG3yD12KHXJltHU5WTobI yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnf2yu79v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 22:58:15 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HMwF27027711;
        Mon, 17 Jan 2022 22:58:15 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnf2yu79d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 22:58:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HMvNd4014276;
        Mon, 17 Jan 2022 22:58:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhj7gtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 22:58:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HMwBiw34668866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 22:58:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A95DAE045;
        Mon, 17 Jan 2022 22:58:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B4E3AE056;
        Mon, 17 Jan 2022 22:58:10 +0000 (GMT)
Received: from sig-9-65-85-218.ibm.com (unknown [9.65.85.218])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 22:58:10 +0000 (GMT)
Message-ID: <e6f00d74a9d5b4e05e2229984bb56f02e7523c0f.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: check the return value of audit_log_start()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>, xkernel.wang@foxmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 17:58:09 -0500
In-Reply-To: <CAHC9VhT018QQmjYdh1ftOYrMC9ZxMqKtkBU2dceF=PLg2j6rvQ@mail.gmail.com>
References: <tencent_425C87AB28D1FF53823C3047E48A71FC520A@qq.com>
         <CAHC9VhT018QQmjYdh1ftOYrMC9ZxMqKtkBU2dceF=PLg2j6rvQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TxVUrw4pSeNJs-RrjNxxQekpyiT6UVh6
X-Proofpoint-ORIG-GUID: pG8ETyjHOD3fxW-fgubya-VMhiBHIfy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=997 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-12 at 12:23 -0500, Paul Moore wrote:
> On Tue, Dec 14, 2021 at 12:39 AM <xkernel.wang@foxmail.com> wrote:
> >
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> >
> > audit_log_start() returns audit_buffer pointer on success or NULL on
> > error, so it is better to check the return value of it to prevent
> > potential memory access error.
> >
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> > ---
> >  security/integrity/integrity_audit.c | 38 +++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> > index 2922005..62785d5 100644
> > --- a/security/integrity/integrity_audit.c
> > +++ b/security/integrity/integrity_audit.c
> > @@ -45,23 +45,25 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
> >                 return;
> >
> >         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
> 
> As this is IMA code, it's largely up to Mimi about what she would
> prefer, but I think a much simpler patch would be to just return early
> if ab == NULL, for example:
> 
>   ab = audit_log_start( .... , audit_msgno);
>   if (!ab)
>     return;

Thanks, Paul.  Neither the linux-integrity mailing list nor I were
Cc'ed on this.  Looks like the IMA & EVM records in MAINTAINERS should
be updated to include the security/integrity directory.

thanks,

Mimi

