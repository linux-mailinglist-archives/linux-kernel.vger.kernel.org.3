Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1134CAA1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbiCBQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiCBQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:27:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A2BCD313
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:26:39 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222GJ9qN012351;
        Wed, 2 Mar 2022 16:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=RcSH3mtdEpdXRg0L6aPSqeiO4AoEs5HLm3q9XVTMxrM=;
 b=d8wiG2blvPNoRBBELdrPbZePAKfogIi+SRTb2El7CV8oJMN6zlHmUo6ETQSX6DNc/YCD
 Y7XmG3ug0Sc1uZRq+QazE04kQPnEhqor6JXSYg0KjNQt62gCsSZKLhIANlW1TVMFwMWU
 gPeR0Xl4yNCIUd3FJ6FXl92zXAmKph0P3Xj5gpCZ2bPgla0ZOdsboDi+e5XLh/OxSrTD
 EK/UaecgK3X7bu/wf74WbgJD9h31G3ii6x4V7WRJzB9ax2lloH12vKrKCeXPeSHsnH/h
 mIZjeFqXc8QtoFq2Mc3r5p8Op1gVr96ANdhUHqf1JBQfo1OaNmmhshgT65VHCyvGhx1Q hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejc0384dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:26:06 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222GKRDN016088;
        Wed, 2 Mar 2022 16:26:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejc0384cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:26:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222GH9lM018544;
        Wed, 2 Mar 2022 16:26:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3egbj1afhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 16:26:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222GQ1Uj55902570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 16:26:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 448DAAE045;
        Wed,  2 Mar 2022 16:26:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF24AE04D;
        Wed,  2 Mar 2022 16:26:00 +0000 (GMT)
Received: from localhost (unknown [9.43.109.149])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 16:26:00 +0000 (GMT)
Date:   Wed, 02 Mar 2022 21:55:58 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
To:     andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, mhiramat@kernel.org,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
In-Reply-To: <20220224151322.714815604@infradead.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646238087.afjf09xr2j.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SkRKCoQCZ7dl2feNbEMk1eRAkiPwxr4U
X-Proofpoint-ORIG-GUID: ZSVhR5uNO1x7LtpaBXolgpK0ciyj9Ej8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=862 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Have ftrace_location() search the symbol for the __fentry__ location
> when it isn't at func+0 and use this for {,un}register_ftrace_direct().
>=20
> This avoids a whole bunch of assumptions about __fentry__ being at
> func+0.
>=20
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/ftrace.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1578,7 +1578,24 @@ unsigned long ftrace_location_range(unsi
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	return ftrace_location_range(ip, ip);
> +	struct dyn_ftrace *rec;
> +	unsigned long offset;
> +	unsigned long size;
> +
> +	rec =3D lookup_rec(ip, ip);
> +	if (!rec) {
> +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> +			goto out;
> +
> +		if (!offset)
> +			rec =3D lookup_rec(ip - offset, (ip - offset) + size);
> +	}
> +
> +	if (rec)
> +		return rec->ip;
> +
> +out:
> +	return 0;
>  }
> =20
>  /**
> @@ -5110,11 +5127,16 @@ int register_ftrace_direct(unsigned long
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *free_hash =3D NULL;
>  	struct dyn_ftrace *rec;
> -	int ret =3D -EBUSY;
> +	int ret =3D -ENODEV;
> =20
>  	mutex_lock(&direct_mutex);
> =20
> +	ip =3D ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	/* See if there's a direct function at @ip already */
> +	ret =3D -EBUSY;
>  	if (ftrace_find_rec_direct(ip))
>  		goto out_unlock;

I think some of the validation at this point can be removed (diff below).

> =20
> @@ -5222,6 +5244,10 @@ int unregister_ftrace_direct(unsigned lo
> =20
>  	mutex_lock(&direct_mutex);
> =20
> +	ip =3D ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	entry =3D find_direct_entry(&ip, NULL);
>  	if (!entry)
>  		goto out_unlock;

We should also update modify_ftrace_direct(). An incremental diff below.


- Naveen


---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65d7553668ca3d..17ce4751a2051a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5126,7 +5126,6 @@ int register_ftrace_direct(unsigned long ip, unsigned=
 long addr)
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash =3D NULL;
-	struct dyn_ftrace *rec;
 	int ret =3D -ENODEV;
=20
 	mutex_lock(&direct_mutex);
@@ -5140,26 +5139,6 @@ int register_ftrace_direct(unsigned long ip, unsigne=
d long addr)
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
=20
-	ret =3D -ENODEV;
-	rec =3D lookup_rec(ip, ip);
-	if (!rec)
-		goto out_unlock;
-
-	/*
-	 * Check if the rec says it has a direct call but we didn't
-	 * find one earlier?
-	 */
-	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
-		goto out_unlock;
-
-	/* Make sure the ip points to the exact record */
-	if (ip !=3D rec->ip) {
-		ip =3D rec->ip;
-		/* Need to check this ip for a direct. */
-		if (ftrace_find_rec_direct(ip))
-			goto out_unlock;
-	}
-
 	ret =3D -ENOMEM;
 	direct =3D ftrace_find_direct_func(addr);
 	if (!direct) {
@@ -5380,6 +5359,10 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
=20
 	mutex_lock(&ftrace_lock);
+	ip =3D ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry =3D find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
--=20
2.35.1

