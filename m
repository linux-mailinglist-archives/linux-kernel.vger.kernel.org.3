Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4D4CC029
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiCCOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiCCOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:41:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51632188A0F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:40:21 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223DnAKg026034;
        Thu, 3 Mar 2022 14:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bsMwJWVlivdfgmALofsg8x+fKP/wH4v1z6TPS1LJCao=;
 b=HnEWYF9AWq9C9oZQ8t+Y1AWhx8HttoLqjoVoNVKVtC3r+ySXUT8GJzcVu+pMAt2bW0GX
 285MW2e/XQNf2v20zgK0t+R+3WClv5c9zHmpRb7EcryggddKQUdgTWI8LjP9L/qvuYFF
 NIq+KRU7YYz85fa3lJDBaAquZPWkhTqyViaT5BLucUqOcaLOar9+OEwC7S96RLY5W7NA
 osyj3Ug8FuThnQKAUxYVy03XsyzTBXjR3M+KHq56yze+fzHFROUpUzgJveDmY7xZrSVu
 pwkypKBZzMXNQNomkph6aAFwmUvvSWGGo9Btkc9FlEnvpik2PaA/pXy/FhJ5bZQ3V/BX DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejw4kbm1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:39:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 223Dp7On012517;
        Thu, 3 Mar 2022 14:39:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejw4kbm0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:39:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223EbR8B001697;
        Thu, 3 Mar 2022 14:39:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3efbfjta17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:39:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223Edajo46334342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 14:39:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38693A4065;
        Thu,  3 Mar 2022 14:39:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673F7A405C;
        Thu,  3 Mar 2022 14:39:35 +0000 (GMT)
Received: from localhost (unknown [9.43.78.131])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 14:39:35 +0000 (GMT)
Date:   Thu, 03 Mar 2022 20:09:33 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, Steven Rostedt <rostedt@goodmis.org>,
        samitolvanen@google.com, x86@kernel.org
References: <20220224211919.0612a3f6@rorschach.local.home>
        <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
        <20220225083647.12ceb54b@gandalf.local.home>
        <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
        <20220301142016.22e787fb@gandalf.local.home>
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
        <20220302110138.6d2abcec@gandalf.local.home>
        <20220302144716.1772020c@gandalf.local.home>
        <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
        <1646300416.yyrqygami4.naveen@linux.ibm.com>
        <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
In-Reply-To: <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646318131.j0g5fwgupy.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fT1Z4XZ0PzzhyLMcWJD2NXL-W4fyo4ph
X-Proofpoint-ORIG-GUID: bbDkrVCiJZwLslncHWW_q468fY-mNGiz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030069
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
> On Thu, Mar 03, 2022 at 03:15:14PM +0530, Naveen N. Rao wrote:
>=20
>> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/=
core.c
>> > index 7f0ce42f8ff9..4c13406e0bc4 100644
>> > --- a/arch/x86/kernel/kprobes/core.c
>> > +++ b/arch/x86/kernel/kprobes/core.c
>> > @@ -198,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsi=
gned long addr)
>> >=20
>> >  	kp =3D get_kprobe((void *)addr);
>> >  	faddr =3D ftrace_location(addr);
>> > +
>> >  	/*
>> > -	 * Addresses inside the ftrace location are refused by
>> > -	 * arch_check_ftrace_location(). Something went terribly wrong
>> > -	 * if such an address is checked here.
>> > +	 * In case addr maps to sym+0 ftrace_location() might return somethi=
ng
>> > +	 * other than faddr. In that case consider it the same as !faddr.
>> >  	 */
>> > -	if (WARN_ON(faddr && faddr !=3D addr))
>> > -		return 0UL;
>> > +	if (faddr && faddr !=3D addr)
>> > +		faddr =3D 0;
>> > +
>> >  	/*
>> >  	 * Use the current code if it is not modified by Kprobe
>> >  	 * and it cannot be modified by ftrace.
>>=20
>> I hit this issue yesterday in kprobe generic code in
>> check_ftrace_location().
>=20
> What exactly where you running to trigger this? (so that I can extend my
> test coverage etc..)

With the changes here, we always promote probes at +0 offset to the LEP=20
at +8.  So, we get the old behavior of ftrace_location(). But, we also=20
have functions that do not have a GEP. For those, we allow probing at an=20
offset of +0, resulting in ftrace_location() giving us the actual ftrace=20
site, which on ppc64le will be at +4.

On ppc32, this will affect all probes since the ftrace site is usually=20
at an offset of +8.

I don't think x86 has this issue since you will always have ftrace site=20
at +0 if a function does not have the endbr instruction. And if you do=20
have the endbr instruction, then you adjust the probe address so it=20
won't be at an offset of 0 into the function.

>=20
>> In both these scenarios, we just want to check if a
>> particular instruction is reserved by ftrace.  ftrace_location_range()
>> should still work for that purpose, so that may be the easier fix:
>>=20
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 066fa644e9dfa3..ee3cd035403ca2 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe *p)
>> {
>> 	unsigned long ftrace_addr;
>>=20
>> -	ftrace_addr =3D ftrace_location((unsigned long)p->addr);
>> +	ftrace_addr =3D ftrace_location_range((unsigned long)p->addr, (unsigne=
d long)p->addr);
>=20
> Yes, although perhaps a new helper. I'll go ponder during lunch.

Sure. We do have ftrace_text_reserved(), but that only returns a=20
boolean. Masami wanted to ensure that the probe is at an instruction=20
boundary, hence this check.

>=20
> PS. I posted v3 but forgot to Cc you:
>=20
>   https://lkml.kernel.org/r/20220303112321.422525803@infradead.org
>=20
> I think the above hunk ended up in the kprobe patch, but on second
> thought I should've put it in the ftrace one. I'll go ammend and add
> this other site you found.

Thanks, I'll take a look.

- Naveen
