Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D164D2E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiCILtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCILtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:49:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCA3980E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:48:34 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2299hRx6015367;
        Wed, 9 Mar 2022 11:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=aEjQQ7CwS5FIlcz6O6aa5bNh6h1ZX7sZy/lVkJVuFIk=;
 b=Bj2fw76CKsXaGsVL99cEGA4BSCphraRt+nghAIsyDYVxcOsDDDYvkZYYq4yiCs8thb9x
 sVHpcfm+3xpXnpzOH0DWCYYDAbaYS8j40UNYicdos3Xzeuh8JA6Y7pRVBKMMozkne/7b
 RzBpljCnkhT6/kLH1GoOAw67jUZXCzvdL7Qyxd2u5emIoXAVIwDS9Qt9cjjd5bWsRpiH
 0iyRsrIcTF/4CdzWPDssDy3CGRcCkoL0I+Gl89/pVqxup/LhZLL0ttopaYQJq6EXG29d
 5wYVg2E3fIIcIgP54o4xaUye7Wh12YWomzFCGgM5wQn4gr8Xe1QrPEzmro0dS4UCWAEr 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny192bf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 11:47:58 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229Bjw60021788;
        Wed, 9 Mar 2022 11:47:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny192be5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 11:47:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229BgX0Z003721;
        Wed, 9 Mar 2022 11:47:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg91xk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 11:47:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229Blp0P10092874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 11:47:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1E97A405F;
        Wed,  9 Mar 2022 11:47:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32F94A405B;
        Wed,  9 Mar 2022 11:47:51 +0000 (GMT)
Received: from localhost (unknown [9.43.9.116])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 11:47:51 +0000 (GMT)
Date:   Wed, 09 Mar 2022 17:17:49 +0530
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
References: <20220225083647.12ceb54b@gandalf.local.home>
        <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
        <20220301142016.22e787fb@gandalf.local.home>
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
        <20220302110138.6d2abcec@gandalf.local.home>
        <20220302144716.1772020c@gandalf.local.home>
        <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
        <1646300416.yyrqygami4.naveen@linux.ibm.com>
        <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
        <20220303093413.387ee6f1@gandalf.local.home>
        <YiDlx0J1KMNP39if@hirez.programming.kicks-ass.net>
In-Reply-To: <YiDlx0J1KMNP39if@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646826381.jb2bpilh3a.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WDcRevT--b2xYhsYPyJl_7I37NJIzcZm
X-Proofpoint-ORIG-GUID: 52f7x1GDCOQIhy__DVPU6s-xHNFnpXyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090063
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
> On Thu, Mar 03, 2022 at 09:34:13AM -0500, Steven Rostedt wrote:
>> On Thu, 3 Mar 2022 14:04:52 +0100
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>=20
>> > > @@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe=
 *p)
>> > > {
>> > > 	unsigned long ftrace_addr;
>> > >=20
>> > > -	ftrace_addr =3D ftrace_location((unsigned long)p->addr);
>> > > +	ftrace_addr =3D ftrace_location_range((unsigned long)p->addr, (uns=
igned long)p->addr); =20
>> >=20
>> > Yes, although perhaps a new helper. I'll go ponder during lunch.
>>=20
>> Is there more places to add that to make it worth creating a helper?
>=20
> This is what I ended up with, I've looked at all ftrace_location() sites
> there are, seems to work too, both the built-in boot time ftrace tests
> and the selftests work splat-less.
>=20
> I should update the Changelog some though.
>=20
> Naveen also mentioned register_ftrace_direct() could be further cleaned
> up, but I didn't want to do too much in once go.

Not a problem, I can send those as cleanups atop this series.

>=20
> ---
>=20
> Subject: x86/ibt,ftrace: Search for __fentry__ location
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Feb 23 10:01:38 CET 2022
>=20
> Have ftrace_location() search the symbol for the __fentry__ location
> when it isn't at func+0 and use this for {,un}register_ftrace_direct().
>=20
> This avoids a whole bunch of assumptions about __fentry__ being at
> func+0.
>=20
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

This version looks good to me.
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks,
Naveen

