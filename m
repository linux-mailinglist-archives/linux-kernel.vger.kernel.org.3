Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE284516E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384480AbiEBKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384463AbiEBKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141D1112
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:18:46 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242AF2WZ038252;
        Mon, 2 May 2022 10:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qnlrrWXRiuHsjRIGUnyYyYn2kNaU+BCFWw1Jtl7IdrE=;
 b=Bzbyfu0mXrImezor+6i6laHeAo+0TUOOVKQrhwrwXX5iJ3ZJMslbXPvPhIraOHLpXGBZ
 FhfRtzVP3saNtfcFaYBFqUhc84FE7Byc/l6lUYWf2bb76YFDnBNWbLMzA3NtdYKmRSfB
 /kjP30BzqlhYUvTV3a9ljZOPJLjAZUx2Mi+JqlPr1eDhML13dqfZVjlc8H8PAY6XOpzC
 24ahexdcLkWSROzAYMZqYWK1wOe0yUNJsM/enuGkd26dOomYKYMvcZ65qkfZ1AfvLD9E
 NnjOMWC4OpUS5FpSttB0JsadlHInTlZUaZ0V6EehjBRWvvSF59kRZOGYpo0fWu+GC0FY zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftdcj01x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 10:18:17 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 242AFgqW039059;
        Mon, 2 May 2022 10:18:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftdcj01wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 10:18:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 242AIF89030416;
        Mon, 2 May 2022 10:18:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3frvcj22xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 10:18:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 242AIBn948234986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 10:18:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB1FA52050;
        Mon,  2 May 2022 10:18:11 +0000 (GMT)
Received: from osiris (unknown [9.145.172.68])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6616D5204E;
        Mon,  2 May 2022 10:18:11 +0000 (GMT)
Date:   Mon, 2 May 2022 12:18:10 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-ID: <Ym+v4lfU5IyxkGc4@osiris>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p1KnFsuBiVVpyE0RuT8eMvo_hXOt7FPF
X-Proofpoint-ORIG-GUID: w-4HAuyvV4ijDE1TzS4tpBIDHIlP49Fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_03,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxlogscore=933 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
> (cc S390 maintainers)
> (cc stable & Greg)
> 
> > I have been porting my patches over and hit a bit of a snag. It looked
> > like my patches were not booting on the s390 - but not all the time. So
> > I reverted back to mm-stable (059342d1dd4e) and found that also failed
> > to boot sometimes on my qemu setup.  When it fails it's ~4-5sec into
> > booting.  The last thing I see is:
> > 
> > "[    4.668916] Spectre V2 mitigation: execute trampolines"
> > 
> > I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
> > build_zonerefs_node())
> > 
> > With the this commit, I am unable to boot one out of three times.  When
> > using the previous commit I was not able to get it to hang after trying
> > 10+ times.  This is a qemu s390 install with KASAN on and I see no error
> > messages.  I think it's likely it is this patch, but no guaranteed.
> > 
> 
> Great, thanks.  So mapletree is absolved.
> 
> Unfortunately 059342d1dd4e was cc:stable.  Greg, you might want to pull
> the plug on that one if it isn't too late.
> 
> I'll await input from the S390 team, but from my reading the issues
> which that patch addresses aren't terribly serious, so perhaps the
> thing to do is to revert 059342d1dd4e (with a cc:stable) while
> 059342d1dd4e gets a redo?

I cannot confirm that Linus' tree currently has problems on s390 with
commit e553f62f10d9 ("mm, page_alloc: fix build_zonerefs_node()").

This commit was applied by Linus on 15th of April, and our CI didn't
report any problems since then. At least nothing that would point to
this commit. Also I just gave e553f62f10d9 a try (defconfig + KASAN):
no problems to report.

Same with 059342d1dd4e (mm-stable): it just works for me.

Liam, could you share your kernel config?
