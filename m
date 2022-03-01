Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B94C9156
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiCARUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiCARUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:20:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220515FFC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:19:49 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GIVak002585;
        Tue, 1 Mar 2022 17:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=rdq2jbQ8hAOdy/vQYcxHYWcdlHF0n8cm1SrZyuVAJSY=;
 b=ePc8Olht55etxrBj6Bvs4ZCK10x+1cVRFsbTupaucX9ReiN+rGcetkBBhX93kYZc+72S
 q53Nqokm2atet+Wdkxc8SnRyFGBHilrt2h3dkVWXbdOLv+WPDDMdWkc7MDwc4BIe/b0e
 SejGKCD81wsWjF/PSaA0NDK+39ny4Ycm2bMEC71og+gM0Q9a8v6RHml7IRPWJvyPase9
 Uw/169+Z9K4vvObzsa4XpnYL5McyGptWzh25LqYdPsOZ4tKuMw5pNIAb30V3GlZ0Sexd
 KygBDLeWAkYo06UnTij3LHSl6Tg0B7ncL5NjVGVfbFXlPLws+e45wyaxhWJ/nzW2C5vg vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehnwp3j1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:19:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221HFr1U008285;
        Tue, 1 Mar 2022 17:19:17 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehnwp3j0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:19:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221HDjwg018248;
        Tue, 1 Mar 2022 17:19:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3efbu9b73e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:19:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221HJB7F58393078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 17:19:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F2BFA405F;
        Tue,  1 Mar 2022 17:19:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326BFA405B;
        Tue,  1 Mar 2022 17:19:11 +0000 (GMT)
Received: from localhost (unknown [9.43.110.204])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 17:19:11 +0000 (GMT)
Date:   Tue, 01 Mar 2022 22:49:09 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        rostedt@goodmis.org, samitolvanen@google.com, x86@kernel.org
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cyaOQige-3iHGcMXEq9RviGhya5tdQNv
X-Proofpoint-ORIG-GUID: Gb94kplrcxQb7tT_JOS4ahg8_qHpVWf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=649 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, Mar 01, 2022 at 11:49:05AM +0900, Masami Hiramatsu wrote:
>=20
>> - the 'offset' is NOT limited under the symbol size.
>>   (e.g. symbol_name =3D "_text" and @offset points the offset of target =
symbol from _text)
>>=20
>> This means we need to call kallsyms_lookup_size_offset() in this case to=
o.
>=20
> I'm feeling we should error out in that case. Using sym+offset beyond
> the limits of sym is just daft.
>=20
> But if you really want/need to retain that, then yes, we need that
> else branch unconditionally :/

I think we will need this. perf always specifies an offset from _text.

Also, I just noticed:

> -static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
> -			const char *symbol_name, unsigned int offset)
> +static kprobe_opcode_t *
> +_kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
> +	     unsigned long offset, bool *on_func_entry)
>  {
>  	if ((symbol_name && addr) || (!symbol_name && !addr))
>  		goto invalid;
> =20
>  	if (symbol_name) {
> +		/*
> +		 * Input: @sym + @offset
> +		 * Output: @addr + @offset
> +		 *
> +		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
> +		 *       argument into it's output!
> +		 */
>  		addr =3D kprobe_lookup_name(symbol_name, offset);
>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
> +	} else {
> +		/*
> +		 * Input: @addr + @offset
> +		 * Output: @addr' + @offset'
> +		 */
> +		if (!kallsyms_lookup_size_offset((unsigned long)addr + offset,
> +						 NULL, &offset))
> +			return ERR_PTR(-ENOENT);
> +		addr =3D (kprobe_opcode_t *)((unsigned long)addr - offset);
>  	}

This looks wrong. I think you need to retain offset to calculate the=20
proper function entry address so that you can do:
	addr =3D (kprobe_opcode_t *)((unsigned long)(addr + offset) - func_offset)=
;
	offset =3D func_offset;

> =20
> -	addr =3D (kprobe_opcode_t *)(((char *)addr) + offset);
> +	addr =3D arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_e=
ntry);
>  	if (addr)
>  		return addr;
>

- Naveen

