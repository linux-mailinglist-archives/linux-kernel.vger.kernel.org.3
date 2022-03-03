Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4555B4CBD60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiCCMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCCMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D764172E4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:12:17 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223BJQUx023455;
        Thu, 3 Mar 2022 12:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=Xn1eGr/Sp9q1/T2R2AS3XQ/yIyijiv4dsUS5sUa8Agk=;
 b=kAiJZpJXYE0ceZBLamuHCks7rKj7V12Q2pz8wXQbFNtDLz68yYSu7jXk3sNYentpdsVn
 +8PncUgnl23/hRwdWWhaS6nDz6x53h+KlQnMjlDH1zbZjd9WJeUlt6En+9cmVI9LWAa9
 DQKBVx8QM049JVV+9LNeUj70EaOb4ZIE4czlt5LPiDgk6cFGV4rctgnCVrz7kWEe6zqq
 0tjNGfQqg/rQfUKQRSuhZnqKrh3YqoOoLN9v8wtAC28dQg3vsrKmVpnUKlPJBBo7xdtW
 8MUtFNLRrAPBouhXWIDul8VRFQBkyYwIKGTlP1CO/bpzP1PyuVdcEuu/IhDp5czVHAOQ VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejvpqgxfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 12:11:30 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 223C6Kgd028957;
        Thu, 3 Mar 2022 12:11:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejvpqgxew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 12:11:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223C7WBm013584;
        Thu, 3 Mar 2022 12:11:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3efbfjst1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 12:11:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223C0R9L50266484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 12:00:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 956284204B;
        Thu,  3 Mar 2022 12:11:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE11742045;
        Thu,  3 Mar 2022 12:11:23 +0000 (GMT)
Received: from localhost (unknown [9.43.78.131])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 12:11:23 +0000 (GMT)
Date:   Thu, 03 Mar 2022 17:41:22 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, rostedt@goodmis.org,
        samitolvanen@google.com, x86@kernel.org
References: <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
        <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
        <20220301191245.GI11184@worktop.programming.kicks-ass.net>
        <20220301200547.GK11184@worktop.programming.kicks-ass.net>
        <1646236764.vx04n8yp12.naveen@linux.ibm.com>
        <Yh/GXaqzDNfp93Jd@hirez.programming.kicks-ass.net>
        <Yh/H+IyKnnC0w5TN@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh/H+IyKnnC0w5TN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646305566.4wf34z8v3g.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RIDjZCZ5Y1gPYf81X8CKbiAp5bdl86qq
X-Proofpoint-GUID: pLjc-O3E4cZ3dsniKb4sLE0asZ9RjT9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030058
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
> On Wed, Mar 02, 2022 at 08:32:45PM +0100, Peter Zijlstra wrote:
>> I wonder if you also want to tighten up on_func_entry? Wouldn't the
>> above suggest something like:

Good question ;)
I noticed this yesterday, but held off on making changes so that I can=20
think this through.

>>=20
>> kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned lo=
ng offset,
>> 					 bool *on_func_entry)
>> {
>> #ifdef PPC64_ELF_ABI_V2
>> 	unsigned long entry =3D ppc_function_entry((void *)addr) - addr;
>> 	*on_func_entry =3D !offset || offset =3D=3D entry;
>> 	if (*on_func_entry)
>> 		offset =3D entry;
>> #else
>> 	*on_func_entry =3D !offset;
>> #endif
>> 	return (void *)(addr + offset);
>> }

This is more accurate and probably something we should do in the long=20
term. The main issue I see today is userspace, specifically perf (and=20
perhaps others too).

Historically, we have worked around the issue of probes on a function's=20
global entry point not working by having userspace adjust the offset at=20
which probes are placed. This works well if those object files have=20
either the symbol table, or debuginfo capturing if functions have a=20
separate local entry point. In the absence of those, we are left=20
guessing and we chose to just offset all probes at function entry by 8=20
(GEP almost always has the same two instructions) so that perf "just=20
works". This still works well for functions without a GEP since we=20
expect to see the two ftrace instructions at function entry, so we are=20
ok to probe after that. As an added bonus, this also allows uprobes to=20
work, for the most part.

On the kernel side, we only implemented logic to adjust probe address if=20
a function name was specified without an offset. This went for a toss=20
once perf probe moved to using _text as the base symbol for kprobes=20
though, and we weren't handling scenarios where addr+offset was=20
provided. With the changes in this series, we can now adjust kprobe=20
address across all those scenarios properly.

If we update perf to not pass an offset any more, then newer perf will=20
stop working on older kernels. If we make the logic to determine=20
function entry strict in the kernel, then we risk breaking existing=20
userspace.

I'm not sure how best to address this.

>=20
> One question though; the above seems to work for +0 or +8 (IIRC your
> instructions are 4 bytes each and the GEP is 2 instructions).
>=20
> But what do we want to happen for +4 ?

We don't want to change the behavior of probes at the second instruction=20
in GEP. The thinking is that it allows the rare scenario (if at all) of=20
wanting to catch indirect function calls, and/or cross-module function=20
calls -- especially since we now promote probes at GEP to LEP. I frankly=20
know of no such scenarios so far, but in any case, if the user is=20
specifying an offset, they better know what they are asking for :)

For the same reason, we should allow kretprobe at +4.


Thanks,
Naveen
