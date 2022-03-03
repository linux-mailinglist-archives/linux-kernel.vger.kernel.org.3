Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036134CBA99
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiCCJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:46:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7017869A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:45:55 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2237qfiv001697;
        Thu, 3 Mar 2022 09:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=VQI18Klv9da56lRnU5/Mczt34dOsN4zaocEEIh6QMc0=;
 b=q9OewZ5NMALXs0HrXNmBUIF7x8yp7FPis4FeNpKIZy4IcGy8fn6xNdNTYvQTqzbzWua/
 XpwAbyE5563VAjcA4paVa9vLFdO3u0sKO+srgOi1IOs8P6fl10VTCd1VztsDAs2Q85GG
 2RF4+K1HSMSBozEqL1XgjMvY2efthhY9WnTTUNYXY8CW94tTMQyvyc662stfzO/VhOrt
 5lQX+G72Hy8hFjaYtQeRCPMI2c7/iak5JLvNbDE3TMXqSthPaCjTrs0cr0Cv/vyTkdp9
 uYy1KzYY063Sr2zaaz1o1ng+FUG6ix5SVYU3JRH9d3u6YMeY7PUI8j93VLc7es7mFAQw zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejsp1t5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:45:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2238rams024219;
        Thu, 3 Mar 2022 09:45:21 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejsp1t5du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:45:21 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2239bNcU013102;
        Thu, 3 Mar 2022 09:45:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3efbu9fk4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:45:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2239jGbQ41419252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 09:45:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F97C52052;
        Thu,  3 Mar 2022 09:45:16 +0000 (GMT)
Received: from localhost (unknown [9.43.78.131])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3A7D5204E;
        Thu,  3 Mar 2022 09:45:15 +0000 (GMT)
Date:   Thu, 03 Mar 2022 15:15:14 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, samitolvanen@google.com, x86@kernel.org
References: <20220224105847.5c899324@gandalf.local.home>
        <20220225103449.6084e5314273556f35107cd9@kernel.org>
        <20220224211919.0612a3f6@rorschach.local.home>
        <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
        <20220225083647.12ceb54b@gandalf.local.home>
        <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
        <20220301142016.22e787fb@gandalf.local.home>
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
        <20220302110138.6d2abcec@gandalf.local.home>
        <20220302144716.1772020c@gandalf.local.home>
        <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646300416.yyrqygami4.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q1sO9Dt-xNgzGLcaprPJTBLK4X9SavVi
X-Proofpoint-GUID: 6Verwl8e6G4iksyCS3oSeV6_WaqUZB4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030044
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
> On Wed, Mar 02, 2022 at 02:47:16PM -0500, Steven Rostedt wrote:
>> Note, I just pulled this patch, and I hit this warning:
>>=20
>> WARNING: CPU: 0 PID: 6965 at arch/x86/kernel/kprobes/core.c:205 recover_=
probed_instruction+0x8f/0xa0
>>=20
>> static unsigned long
>> __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>> {
>>         struct kprobe *kp;
>>         unsigned long faddr;
>>=20
>>         kp =3D get_kprobe((void *)addr);
>>         faddr =3D ftrace_location(addr);
>>         /*
>>          * Addresses inside the ftrace location are refused by
>>          * arch_check_ftrace_location(). Something went terribly wrong
>>          * if such an address is checked here.
>>          */
>>         if (WARN_ON(faddr && faddr !=3D addr))  <<---- HERE
>>                 return 0UL;
>=20
> Ha! so a bunch of IRC later I figured out how it is possible you hit
> this with just the patch on and how I legitimately hit this and what to
> do about it.
>=20
> Your problem seems to be that we got ftrace_location() wrong in that
> lookup_rec()'s end argument is inclusive, hence we need:
>=20
> 	lookup_rec(ip, ip + size - 1)
>=20
> Now, the above thing asserts that:
>=20
> 	ftrace_location(x) =3D=3D {0, x}
>=20
> and that is genuinely false in my case, I get x+4 as additional possible
> output. So I think I need the below change to go on top of all I have:
>=20
>=20
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/cor=
e.c
> index 7f0ce42f8ff9..4c13406e0bc4 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -198,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigne=
d long addr)
>=20
>  	kp =3D get_kprobe((void *)addr);
>  	faddr =3D ftrace_location(addr);
> +
>  	/*
> -	 * Addresses inside the ftrace location are refused by
> -	 * arch_check_ftrace_location(). Something went terribly wrong
> -	 * if such an address is checked here.
> +	 * In case addr maps to sym+0 ftrace_location() might return something
> +	 * other than faddr. In that case consider it the same as !faddr.
>  	 */
> -	if (WARN_ON(faddr && faddr !=3D addr))
> -		return 0UL;
> +	if (faddr && faddr !=3D addr)
> +		faddr =3D 0;
> +
>  	/*
>  	 * Use the current code if it is not modified by Kprobe
>  	 * and it cannot be modified by ftrace.

I hit this issue yesterday in kprobe generic code in check_ftrace_location(=
).=20
In both these scenarios, we just want to check if a particular instruction =
is=20
reserved by ftrace.  ftrace_location_range() should still work for that=20
purpose, so that may be the easier fix:

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 066fa644e9dfa3..ee3cd035403ca2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long ftrace_addr;
=20
-	ftrace_addr =3D ftrace_location((unsigned long)p->addr);
+	ftrace_addr =3D ftrace_location_range((unsigned long)p->addr, (unsigned l=
ong)p->addr);
 	if (ftrace_addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
 		/* Given address is not on the instruction boundary */



- Naveen

