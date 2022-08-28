Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40815A3EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiH1QvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH1QvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:51:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA01FCCF;
        Sun, 28 Aug 2022 09:51:15 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27SGPoRh011915;
        Sun, 28 Aug 2022 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fPCECHnv11C4AjdzWYsnj3/8k5rXSCOxtstSvkag/Mw=;
 b=mWJ6AujvTMpo6NNDay69YrY14RZMNBnDPDMNjwLMBhBYAAmQByTisYUjj9AbX5W46Ycx
 Ho3ucEXwPJ0uDiUL11C4d8fTK4cocPYDMcLpYd9DTW4Vkt3cmgIID1JRwkOu+tvDCGY5
 y+FJfqoDGPMO93C9ecLTuaUSu4m+dPN507BJ+l/dU1N/wlUl3J2/OSWEfSeolADLOiHU
 DbBZK5mganpDY4BjcG4034VtMWnLD2sNP5TKquVZL8XN3DzwNe+gpVG8mzvMVziBMJR/
 JiwfFOqlWe/59HCB/obJiq4SnnL0j0SxzUjxy8PBmIe0BJVrh3fM9OyyBzhRsyX4Udbe DQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7w9sgbwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 16:51:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27SGaSbU014322;
        Sun, 28 Aug 2022 16:51:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw91cav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 16:51:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27SGp4bl41878004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 16:51:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74333AE04D;
        Sun, 28 Aug 2022 16:51:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18DFAAE045;
        Sun, 28 Aug 2022 16:51:04 +0000 (GMT)
Received: from osiris (unknown [9.145.51.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Aug 2022 16:51:04 +0000 (GMT)
Date:   Sun, 28 Aug 2022 18:51:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH RFC] s390: Fix nospec table alignments
Message-ID: <Ywuc9hxvLIlY516G@osiris>
References: <8719bf1ce4a72ebdeb575200290094e9ce047bcc.1661557333.git.jpoimboe@kernel.org>
 <YwphFXr+pHxf4PGT@osiris>
 <20220827225937.b2mcmvxs7kbrtjda@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827225937.b2mcmvxs7kbrtjda@treble>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bn_EnE8hIij8m8ZylPGSxGpdjcvZ0nFX
X-Proofpoint-ORIG-GUID: bn_EnE8hIij8m8ZylPGSxGpdjcvZ0nFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-28_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=798 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208280070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 03:59:37PM -0700, Josh Poimboeuf wrote:
> > > While working on another s390 issue, I was getting intermittent boot
> > > failures in __nospec_revert() when it tried to access 'instr[0]'.  I
> > > noticed the __nospec_call_start address ended in 'ff'.  This patch
> > > seemed to fix it.  I have no idea why it was (only sometimes) failing in
> > > the first place.
...
> > > +	. = ALIGN(4);
> > >  	.nospec_call_table : {
> > >  		__nospec_call_start = . ;
> > >  		*(.s390_indirect*)
> > 
...
> > Unfortunately I was unable to let any compiler generate code, that
> > would use the larl instruction. Instead the address of
> > nospec_call_table was loaded indirectly via the GOT, which again works
> > always, regardless if the table starts at an even or uneven address.
> > 
> > This needs to be fixed anyway, and your patch certainly is correct.
> > 
> > Could you maybe share your kernel config + compiler version, if you
> > are still able to reproduce this?
> 
> I think the trick is to disable CONFIG_RELOCATABLE.  When I compile with
> CONFIG_RELOCATABLE=n and "gcc version 11.3.1 20220421 (Red Hat 11.3.1-2)
> (GCC)", I get the following in nospec_init_branches():
> 
>  2a8:   c0 20 00 00 00 00       larl    %r2,2a8 <nospec_init_branches+0x30>     2aa: R_390_PC32DBL      __nospec_call_start+0x2
> 
> That said, I still haven't been able to figure out how to recreate the
> program check in __nospec_revert(), even when the nospec_call_table
> starts at an odd offset.

Right, CONFIG_RELOCATABLE=n will do the trick.

I don't know why you cannot recreate it, however on my system it
crashes instantly when I make sure that __nospec_call_start starts at
an odd address.

Apparently 'instr = (u8 *) epo + *epo;' in __nospec_revert() may
result in a very large address, since without KASLR the kernel is
located at a low address, and it only takes one entry within the
incorrectly accessed nospec_call_table which results in a large
negative value for '*epo' and we end up with an overflow and a very
large address for 'instr'.
This will then result in the program check / addressing exception
you've seen when the kernel tried to access 'instr[0]'.

I'll apply your patch. Thanks a lot for debugging and reporting!
