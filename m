Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA74C9114
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiCARFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiCARFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:05:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A417A86
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:04:31 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GILNI032419;
        Tue, 1 Mar 2022 17:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v/Z8iSvZNKJIfyy/RBRSF3m59VBrSRPLXV/8fS9VPZY=;
 b=AZJuiGWnDuUC2z7Kb7SUtrvSzXinDGdpAy1m4LPar2pKa9Dr24daHHDsg9NjrJGfzaHm
 GPJsV9bQGAIi2gLIzverliXxdHYDiss8uW4+W8ag5JBdjV4pz34UM2XiC60z9ll5YgJV
 dIS7o3SuYZ+hg01U6eUt2DRCIeNWgs+xSa6ORH1EmfP0YGJhuFH5hpv4VjP2DkVePvAd
 oriE5phneH7oTzLBoaCzgAi3m0TQig2O9ArKt2VoI0o6Kb6hAn+K9f89w5Zx/TUKF+W4
 E3bnzLesBuB1yanFWHUDi0BYBMMFTRB4SNEgyp/BWBs+I9cKJBBV+nKUI9xmggWiAEHh ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ehpm89rs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:03:59 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221GISnl000646;
        Tue, 1 Mar 2022 17:03:59 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ehpm89rr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:03:59 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221H3lBS015413;
        Tue, 1 Mar 2022 17:03:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3efbu9b6vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 17:03:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221Gr1l746072308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 16:53:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C986D11C058;
        Tue,  1 Mar 2022 17:03:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CABA11C050;
        Tue,  1 Mar 2022 17:03:54 +0000 (GMT)
Received: from localhost (unknown [9.43.110.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 17:03:54 +0000 (GMT)
Date:   Tue, 01 Mar 2022 22:33:52 +0530
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
In-Reply-To: <20220228232513.GH11184@worktop.programming.kicks-ass.net>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1646153789.geynpzwbid.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hSaf28dtkpqCPMAz-BXMHBVMHSVq3rzO
X-Proofpoint-GUID: z-RcKJuXdoxf9LRt2EKAbxB3uRZk35GH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=777 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Hi Peter,

Peter Zijlstra wrote:
> On Mon, Feb 28, 2022 at 03:07:05PM +0900, Masami Hiramatsu wrote:
>> Hi Peter,
>>=20
>> So, instead of this change, can you try below?
>> This introduce the arch_adjust_kprobe_addr() and use it in the kprobe_ad=
dr()
>> so that it can handle the case that user passed the probe address in=20
>> _text+OFFSET format.
>=20
> It works a little... at the very least it still needs
> arch_kprobe_on_func_entry() allowing offset 4.
>=20
> But looking at this, we've got:
>=20
> kprobe_on_func_entry(addr, sym, offset)
>   _kprobe_addr(addr, sym, offset)
>     if (sym)
>       addr =3D kprobe_lookup_name()
>            =3D kallsyms_lookup_name()
>     arch_adjust_kprobe_addr(addr+offset)
>       skip_endbr()
>         kallsyms_loopup_size_offset(addr, ...)
>   kallsyms_lookup_size_offset(addr, NULL, &offset)
>   arch_kprobe_on_func_entry(offset)
>=20
> Which is _3_ kallsyms lookups and 3 weak/arch hooks.
>=20
> Surely we can make this a little more streamlined? The below seems to
> work.
>=20
> I think with a little care and testing it should be possible to fold all
> the magic of PowerPC's kprobe_lookup_name() into this one hook as well,
> meaning we can get rid of kprobe_lookup_name() entirely.  Naveen?

This is timely. I've been looking at addressing a similar set of issues=20
on powerpc:
http://lkml.kernel.org/r/cover.1645096227.git.naveen.n.rao@linux.vnet.ibm.c=
om

>=20
> This then gets us down to a 1 kallsyms call and 1 arch hook. Hmm?

I was going to propose making _kprobe_addr() into a weak function in=20
place of kprobe_lookup_name() in response to Masami in the other thread,=20
but this is looking better.

>=20
> ---
>  arch/powerpc/kernel/kprobes.c  |   34 +++++++++++++++---------
>  arch/x86/kernel/kprobes/core.c |   17 ++++++++++++
>  include/linux/kprobes.h        |    3 +-
>  kernel/kprobes.c               |   56 ++++++++++++++++++++++++++++++++++=
-------
>  4 files changed, 87 insertions(+), 23 deletions(-)

I will take a closer look at this tomorrow and revert.


Thanks,
- Naveen

