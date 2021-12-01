Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2404C46587D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbhLAVoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:44:39 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:35236 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234546AbhLAVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:44:36 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EdegA021340;
        Wed, 1 Dec 2021 21:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=lq1Aez2+UHMni68Xhsqib9AYf8dl940fJOED/rrCohQ=;
 b=EhYuMIpP6xxzQLvJpoDKIbKHWqAvl0h/WKf82j4+rAiEKcbCVqnZ4H3wOFpiF8CkJLro
 w/cdBejjilkq6zqxt7ArtirEuClW0aiVJez5p8LBTPl2sJaEAKziV6mswWDnGQS8vPBm
 8Ott9Ge0wk9J3NT6wU1XRgzxxe51Iq2m6eA3SXsiVm7RfRa3LYjnFOVRD48x5eXGfXH6
 RiGpUjBAIqi8ZEfeeFd9OQsiZ/TzoSVGk0BWY+rFe29xp+1rk49v8NiQvowPVoCiPAQL
 oWf3Iz7lodoU+3v4p34iuKGBr0ojsmJvjVYhm67mXjYBUeCZvCZaBJ8zHAlv/CygdLow SQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 3cp598pd1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 21:40:00 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 96866AF;
        Wed,  1 Dec 2021 21:39:59 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.99.162.214])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 7D88F42;
        Wed,  1 Dec 2021 21:39:57 +0000 (UTC)
Date:   Wed, 1 Dec 2021 15:39:57 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joe Perches <joe@perches.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: make const pointer dots a static const
 array
Message-ID: <YafrrfwAMzxrPvWU@swahl-home.5wahls.com>
References: <20211127170320.77963-1-colin.i.king@gmail.com>
 <YaZ8vtajDKUVDCne@swahl-home.5wahls.com>
 <c5a827c2b690aeadf7d633c29edaf4db23d94fdb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a827c2b690aeadf7d633c29edaf4db23d94fdb.camel@perches.com>
X-Proofpoint-GUID: Q_j75eB4ePzuof6Ldit0rv7RWYR_j8kf
X-Proofpoint-ORIG-GUID: Q_j75eB4ePzuof6Ldit0rv7RWYR_j8kf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 04:26:39PM -0800, Joe Perches wrote:
> On Tue, 2021-11-30 at 13:34 -0600, Steve Wahl wrote:
> > On Sat, Nov 27, 2021 at 05:03:20PM +0000, Colin Ian King wrote:
> > > Don't populate the const array dots on the stack
> []
> > Examination of the disassembly shows that the compiler actually
> > eliminates the creation of the pointer "dots" on the stack and just
> > passes the address of the string constant to the printk function.
> > 
> > So this change should not have any actual effect (I don't know where
> > you got the "shrinks object code" from), and in my humble opinion
> > makes the code less clear.
> 
> Probably shrinks an allmodconfig where the symbols are referenced.
> It probably doesn't do anything to a defconfig.

OK, I looked. Under allmodconfig, the new code is one byte smaller.

Defconfig doesn't include CONFIG_X86_UV and this file doesn't get
compiled.

Using defconfig plus CONFIG_X86_UV and prerequisites, the new code is
24 bytes larger, probably because of alignment added.

allmodconfig:

   text	   data	    bss	    dec	    hex	filename
  30827	  18358	   1472	  50657	   c5e1	uv_nmi.o
  30828	  18358	   1472	  50658	   c5e2	uv_nmi.orig.o

default config + CONFIG_X86_UV:

   text	   data	    bss	    dec	    hex	filename
   9918	    216	    160	  10294	   2836	uv_nmi.o
   9894	    216	    160	  10270	   281e	uv_nmi.orig.o

So I still don't think this patch makes sense.

--> Steve Wahl

> > As such, unless there's something here I don't understand, I vote to
> > reject this patch.
> []
> > > but make it static
> > > const and make the pointer an array to remove a dereference. Shrinks
> > > object code a few bytes too.
> []
> > > diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> []
> > > @@ -725,7 +725,7 @@ static void uv_nmi_dump_cpu_ip(int cpu, struct pt_regs *regs)
> > >   */
> > >  static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
> > >  {
> > > -	const char *dots = " ................................. ";
> > > +	static const char dots[] = " ................................. ";
> 
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
