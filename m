Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56794519870
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbiEDHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:41:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8AB0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:38:22 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24472eLJ018292;
        Wed, 4 May 2022 07:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Fh9wPOCKI2jg0Hv4wawOeDWJ68ruuRlGTwxIumn4srw=;
 b=XrAU+X5soSP0tBmLrNHzMJxQIIN5fE6ILJfsV0ilvzMTD5spztSwt0kaYi14SsvnEkJo
 xTT0j1m23hSE8CIhh6dkMzME7sfyUlqNnHXhqYfXzv+Sz0z4gZiapoXiTe2vPkt/LDRY
 9r6Jb2Z21irc7vBevyJMUhyTWlX4c9dwwlXM2zs9quWJy3nzgB7/EPevRd/rqLOMpTHU
 0JpDYhmYmlmlKp4/Pk1sY5VT+71Y5IFP7TUx3zjxmU6cx0E24AT3aSQccdWbVBOO5c9W
 m8tXUf8Nt1jAH1r9zEqrU+cgqMgQj1jokLYoUS52HH86jK8T6RpNajcWzddlK9G/L5kC MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fumrk8gut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:37:59 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2447RHWP015628;
        Wed, 4 May 2022 07:37:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fumrk8gu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:37:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2447WZ5b013128;
        Wed, 4 May 2022 07:37:57 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3frvr8v75f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:37:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2447brM656033782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 07:37:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B335FA405C;
        Wed,  4 May 2022 07:37:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C56FA4054;
        Wed,  4 May 2022 07:37:53 +0000 (GMT)
Received: from [9.152.224.247] (unknown [9.152.224.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 07:37:52 +0000 (GMT)
Message-ID: <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
Date:   Wed, 4 May 2022 09:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
 <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
 <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
 <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
 <20220503215520.qpaukvjq55o7qwu3@revolver>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220503215520.qpaukvjq55o7qwu3@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -gtOdlFTiNt2NV0B5tTMapkPBGN0f4GW
X-Proofpoint-ORIG-GUID: y-8DeiKb1yKRsf1Pa5otUN3bjacwJ9Ge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205040050
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 23:55, Liam Howlett wrote:
> * Heiko Carstens <hca@linux.ibm.com> [220503 15:49]:
>> On Mon, May 02, 2022 at 08:50:04PM +0200, Heiko Carstens wrote:
>>> On Mon, May 02, 2022 at 01:31:00PM +0000, Liam Howlett wrote:
>>>> * Heiko Carstens <hca@linux.ibm.com> [220502 06:18]:
>>>>> On Sun, May 01, 2022 at 05:24:12PM -0700, Andrew Morton wrote:
>>>>>> (cc S390 maintainers)
>>>>>> (cc stable & Greg)
>> ...
>>>>>>> booting.  The last thing I see is:
>>>>>>>
>>>>>>> "[    4.668916] Spectre V2 mitigation: execute trampolines"
>>>>>>>
>>>>>>> I've bisected back to commit e553f62f10d9 (mm, page_alloc: fix
>>>>>>> build_zonerefs_node())
>>>>>>>
>>>>>>> With the this commit, I am unable to boot one out of three times.  When
>>>>>>> using the previous commit I was not able to get it to hang after trying
>>>>>>> 10+ times.  This is a qemu s390 install with KASAN on and I see no error
>>>>>>> messages.  I think it's likely it is this patch, but no guaranteed.
>> ...
>>>>> Liam, could you share your kernel config?
>>>>
>>>> Sure thing.  See attached.
>>>
>>> So, I can reproduce the hanging system now. However this looks like a
>>> qemu problem on s390, since I can reproduce this only with Qemu+TCG.
>>> Qemu with kvm works without any problems (same if I use z/VM as
>>> hypervisor).
>>>
>>> Janosch, Claudio, can you have a look at this please?
>>
>> So, at least for me this problem also exists with plain v5.17.
>> Switching off KASAN, or alternatively switching to KASAN_INLINE
>> "fixes" it for me with Qemu+TCG.
>>
>> Liam, could you please also try to disable KASAN in your config? With
>> that I think we can be almost sure this could be some bug in Qemu.
> 
> With KASAN, my tree fails 100% of the time (mm-stable + my maple tree
> patches)
> 
> Without KASAN, it boots 100% of the time.
> 
> I think this verifies with you say above?
> 
> Thanks,
> Liam

I had a short look yesterday and the boot usually hangs in the raid6 
code. Disabling vector instructions didn't make a difference but a few 
interruptions via GDB solve the problem for some reason.

CCing David and Thomas for TCG
