Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2E54DAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358842AbiFPGqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiFPGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1045AEC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:46:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G5Tm5U028636;
        Thu, 16 Jun 2022 06:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=6vmnm4kBl3UFvsM/hULFWgecv/EQ1mykD+mI1t+yBqk=;
 b=b8mXAK+Fc93H+upzFW6CfjmjpKNN0wQZQUMTvc9GOaWHOKPZ3q+heYIjGnz9yb6S2pDE
 2LkgOd5Dc1zNH+z+mAU3lyBD2LpsNlqf8vpGCyqAA/cMdDA1fnImkKkQ9BGNlkUVqqJS
 /A+mtvzwoxnURLZPtRZGqfGTQje0/DkxyX4iNWlLLh7Up8Nn8reCNiCw1mm6DSjl4oXf
 CTJT+BddM0dOOon1eXfnYxvhRWAEXQ4GkUB5FBIeLk66+scim5zfT8DbA2cPBUkyP8o8
 WRBZI9GVsGKwGiphhyVBrn1NlzUZEG4YrrNnmimI9j5/h6lCEGUSmx+EYD7rIBuGSTY/ OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqxe21mrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 06:45:45 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25G6RXrd020667;
        Thu, 16 Jun 2022 06:45:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqxe21mq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 06:45:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25G6Ke1X013527;
        Thu, 16 Jun 2022 06:45:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajewev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 06:45:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25G6jeHB23593254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 06:45:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9678C11C052;
        Thu, 16 Jun 2022 06:45:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C98111C04A;
        Thu, 16 Jun 2022 06:45:35 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.19.101])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 16 Jun 2022 06:45:32 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 16 Jun 2022 12:15:25 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] resource: re-factor page_is_ram()
In-Reply-To: <05623846-03c7-89f1-e1dd-0ee23723c7e9@redhat.com>
References: <20220601163243.3806231-1-vaibhav@linux.ibm.com>
 <05623846-03c7-89f1-e1dd-0ee23723c7e9@redhat.com>
Date:   Thu, 16 Jun 2022 12:15:25 +0530
Message-ID: <87r13p2jju.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WTHn1HK-adfmQGWEduq0GsC8AruckbXG
X-Proofpoint-ORIG-GUID: MSC0paP8-W37yu01ZG0pKJktEZr62rji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_02,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for looking into this patch,

David Hildenbrand <david@redhat.com> writes:

> On 01.06.22 18:32, Vaibhav Jain wrote:
>> Presently page_is_ram() relies on walk_system_ram_range() that performs a walk
>> on kernel iomem resources hierarchy with a dummy callback __is_ram(). Before
>> calling find_next_iomem_res(), walk_system_ram_range() does some book-keeping
>> which can be avoided for page_is_ram() use-case.
>> 
>> Hence this patch proposes to update page_is_ram() to directly call
>> find_next_iomem_res() with minimal book-keeping needed.
>
> I consider the code harder to get compared to just reusing the
> more-generic and expressive walk_system_ram_range()
>
> It somehow feels like we're duplicating the code here just to optimize
> out a handful of instructions.

The only reason for existence of dummy callback __is_ram() is for
page_is_ram() to be able to use walk_system_ram_range(). For
page_is_ram() usecase what walk_system_ram_range() essentially does is
to iterate over find_next_iomem_res() and call __is_ram() which is not
really needed to page_is_ram().

The improvement to the gcc (v12.1.1) generated code (x86_64) for
page_is_ram is quite evident.

With the patch:
   0x0000000000000920 <+0>:	call   0x925 <page_is_ram+5>
   0x0000000000000925 <+5>:	shl    $0xc,%rdi
   0x0000000000000929 <+9>:	xor    %r8d,%r8d
   0x000000000000092c <+12>:	xor    %ecx,%ecx
   0x000000000000092e <+14>:	mov    $0x81000200,%edx
   0x0000000000000933 <+19>:	lea    0x1(%rdi),%rsi
   0x0000000000000937 <+23>:	call   0x7e0 <find_next_iomem_res>
   0x000000000000093c <+28>:	test   %eax,%eax
   0x000000000000093e <+30>:	sete   %al
   0x0000000000000941 <+33>:	movzbl %al,%eax
   0x0000000000000944 <+36>:	ret
   0x0000000000000945 <+37>:	int3

Without the patch:
   0x0000000000001000 <+0>:	call   0x1005 <page_is_ram+5>
   0x0000000000001005 <+5>:	shl    $0xc,%rdi
   0x0000000000001009 <+9>:	lea    0xfff(%rdi),%rsi
   0x0000000000001010 <+16>:	cmp    %rsi,%rdi
   0x0000000000001013 <+19>:	jae    0x1064 <page_is_ram+100>
   0x0000000000001015 <+21>:	sub    $0x40,%rsp
   0x0000000000001019 <+25>:	xor    %ecx,%ecx
   0x000000000000101b <+27>:	mov    $0x81000200,%edx
   0x0000000000001020 <+32>:	mov    %rsp,%r8
   0x0000000000001023 <+35>:	call   0x7e0 <find_next_iomem_res>
   0x0000000000001028 <+40>:	test   %eax,%eax
   0x000000000000102a <+42>:	jne    0x105a <page_is_ram+90>
   0x000000000000102c <+44>:	mov    (%rsp),%rax
   0x0000000000001030 <+48>:	mov    $0x1,%ecx
   0x0000000000001035 <+53>:	lea    0xfff(%rax),%rdx
   0x000000000000103c <+60>:	mov    0x8(%rsp),%rax
   0x0000000000001041 <+65>:	shr    $0xc,%rdx
   0x0000000000001045 <+69>:	add    $0x1,%rax
   0x0000000000001049 <+73>:	shr    $0xc,%rax
   0x000000000000104d <+77>:	cmp    %rax,%rdx
   0x0000000000001050 <+80>:	jae    0x105a <page_is_ram+90>
   0x0000000000001052 <+82>:	mov    %ecx,%eax
   0x0000000000001054 <+84>:	add    $0x40,%rsp
   0x0000000000001058 <+88>:	ret
   0x0000000000001059 <+89>:	int3
   0x000000000000105a <+90>:	xor    %ecx,%ecx
   0x000000000000105c <+92>:	add    $0x40,%rsp
   0x0000000000001060 <+96>:	mov    %ecx,%eax
   0x0000000000001062 <+98>:	ret
   0x0000000000001063 <+99>:	int3
   0x0000000000001064 <+100>:	xor    %eax,%eax
   0x0000000000001066 <+102>:	ret
   0x0000000000001067 <+103>:	int3

Looking at the disassembly above, gcc has inlined both walk_system_ram_range()
and __is_ram() in page_is_ram(). This ends up in page_is_ram() calling
find_next_iomem_res() directly anyways with bunch of book-keeping
afterwards which can be avoided.

>
> If it doesn't make the code easier to read (at least for me), why do we
> care?
IMHO, calling find_next_iomem_res() from page_is_ram() instead of
calling walk_system_ram_range() makes it easy to trace the path of
page_is_ram(). Also the dummy callback makes the code flow seems strange
initially.

-- 
Cheers
~ Vaibhav
