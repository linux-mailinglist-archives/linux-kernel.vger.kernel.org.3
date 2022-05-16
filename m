Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE664528904
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiEPPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbiEPPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9143C72D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:37:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDl7si031378;
        Mon, 16 May 2022 15:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=CwhzVZhX+sNwtcS0hm5B2TwUiy/ztA6FCyfi+kQwAa4=;
 b=TFVpFNatV7R8P0N+ECf4MykubGXsKBJ9FmlVMgRdqYa2YBS3bB9dj5Ab6P4A8GJdWN/a
 snTDqHxj33AzPB0/oICoxQkikS85kX01rFlpF+8ZrYLf4arLx64dhSJDu9kmrRhSG398
 MtU8fhzsBmA2CL6Bj04PYe1q7Zzjb0fDxpLFcbJAwDnSbH0rE2xC255sW3s/aTdzMXKU
 zgy4CAYYP8KYLnY9DSkmRAdAEw0mX2lm1qOOSKe2GHAjVdashfro5ojCrULCK04BcG86
 uX7Bmnrrye80sjhM3ms1HaE+kPAws2MLfQ/WADwUSegmID+y5kIphG4GoFhXn6ZwIMlZ Fw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3qt5jr4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 15:37:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GFS3ao026834;
        Mon, 16 May 2022 15:37:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjaxcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 15:37:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GFbUEd15991182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:37:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 119E652050;
        Mon, 16 May 2022 15:37:30 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CC6CE5204E;
        Mon, 16 May 2022 15:37:29 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
        <yt9dk0apbicu.fsf@linux.ibm.com>
        <20220513165955.mkg5wvfi4dwpzoer@revolver>
        <yt9dbkvy5zu0.fsf@linux.ibm.com>
        <20220516140202.pcw2f6gu4kyslmjd@revolver>
Date:   Mon, 16 May 2022 17:37:29 +0200
In-Reply-To: <20220516140202.pcw2f6gu4kyslmjd@revolver> (Liam Howlett's
        message of "Mon, 16 May 2022 14:02:09 +0000")
Message-ID: <yt9d1qwt5w06.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8w7-8ECbtWd7pGOFw5YWXkcOxmQgtVAz
X-Proofpoint-ORIG-GUID: 8w7-8ECbtWd7pGOFw5YWXkcOxmQgtVAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_14,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Liam,

Liam Howlett <liam.howlett@oracle.com> writes:

> * Sven Schnelle <svens@linux.ibm.com> [220515 16:02]:
>
> I tried the above on my qemu s390 with kernel 5.18.0-rc6-next-20220513,
> but it runs without issue, return code is 0.  Is there something the VM
> needs to have for this to trigger?

A coworker said the same. Reason for this seems to be that i've run the
code in a unittest environment which seems to make a difference. When
compiling the code above with gcc on my system it also doesn't crash.
So i have to figure out what makes this unittest binary special.

>> I've added a few debug statements to the maple tree code:
>> 
>> [   27.769641] mas_next_entry: offset=14
>> [   27.769642] mas_next_nentry: entry = 0e00000000000000, slots=0000000090249f80, mas->offset=15 count=14
>
> Where exactly are you printing this?

I added a lot of debug statements to the code trying to understand
it. I'll attach it to this mail.

>> 
>> I see in mas_next_nentry() that there's a while that iterates over the
>> (used?) slots until count is reached.`
>
> Yes, mas_next_nentry() looks for the next non-null entry in the current
> node.
>
>>After that loop mas_next_entry()
>> just picks the next (unused?) entry, which is slot 15 in that case.
>
> mas_next_entry() returns the next non-null entry.  If there isn't one
> returned by mas_next_nentry(), then it will advance to the next node by
> calling mas_next_node().  There are checks in there for detecting dead
> nodes for RCU use and limit checking as well.
>
>> 
>> What i noticed while scanning over include/linux/maple_tree.h is:
>> 
>> struct maple_range_64 {
>> 	struct maple_pnode *parent;
>> 	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
>> 	union {
>> 		void __rcu *slot[MAPLE_RANGE64_SLOTS];
>> 		struct {
>> 		void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
>> 		struct maple_metadata meta;
>>         	};
>> 	};
>> };
>> 
>> and struct maple_metadata is:
>> 
>> struct maple_metadata {
>> 	unsigned char end;
>> 	unsigned char gap;
>> };
>> 
>> If i swap the gap and end members 0x0e00000000000000 becomes
>> 0x000e000000000000. And 0xe matches our msa->offset 14 above.
>> So it looks like mas_next() in mmap_region returns the meta
>> data for the node.
>
> If this is the case, then I think any task that has more than 14 VMAs
> would have issues.  I also use mas_next_entry() in mas_find() which is
> used for the mas_for_each() macro/iterator.  Can you please enable
> CONFIG_DEBUG_VM_MAPLE_TREE ?  mmap.c tests the tree after pretty much
> any change and will dump useful information if there is an issue -
> including the entire tree. See validate_mm_mt() for details.
>
> You can find CONFIG_DEBUG_VM_MAPLE_TREE in the config:
> kernel hacking -> Memory debugging -> Debug VM -> Debug VM maple trees

I have both DEBUG_MAPPLE_TREE and DEBUG_VM_MAPLE_TREE enabled, but don't
see anything printed.

--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=mapple-debug.diff

 lib/maple_tree.c | 37 +++++++++++++++++++++++++++++++++++--
 mm/mmap.c        | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 9 deletions(-)

--=-=-=--

