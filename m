Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8C53069A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiEVWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiEVWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:52:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AC37ABB;
        Sun, 22 May 2022 15:52:07 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MFPrc8025905;
        Sun, 22 May 2022 22:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=h/U3nmDw/V9DD3mNJOiPLXUyv885QSazrAVZsXU3XgQ=;
 b=VeWKC6KTcGrkltXBCvc34SACWTFRGixHalUwIQsVQCSIHY2/eXpKQCus2KT9MF5nzApD
 i9bwVHk3vQsxfpn5Ryq/S0XsssFWD9Sbc79lhePqv0RBYTjBQO5NIBoJyooJNzMj8xps
 t3inH/Jzi9Jlo6FkyO+ZXrGzEDm8yatDXMapO1+xbW7lnW8DVu//n9JQBk5VuXnZJKcJ
 Cso+4vlTpU6vP0mO47I2oaW+MVZl6a4AI3Ky81oz/ksEibQWdskIaG+K7pGj//iGCxzU
 puK0azLPGI7yLYqRgJtWNxwzMV5lpQl6j1l2SKHDbhtGMF1z7fd7fe5VUSS3O9t27bT7 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79f4y9yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 22:52:00 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24MMq08O018695;
        Sun, 22 May 2022 22:52:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g79f4y9y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 22:52:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24MMgKKa019363;
        Sun, 22 May 2022 22:51:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3g6qq99v7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 May 2022 22:51:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24MMbqtA33423780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 22:37:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BC8BA4055;
        Sun, 22 May 2022 22:51:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACF1FA4040;
        Sun, 22 May 2022 22:51:51 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.16.48])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sun, 22 May 2022 22:51:51 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 23 May 2022 04:21:50 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linuxppc-dev@lists.ozlabs.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: check previous kernel's ima-kexec-buffer
 against memory bounds
In-Reply-To: <20220520223025.GA359803-robh@kernel.org>
References: <20220518200547.655788-1-vaibhav@linux.ibm.com>
 <20220520223025.GA359803-robh@kernel.org>
Date:   Mon, 23 May 2022 04:21:49 +0530
Message-ID: <87wnedfaey.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XJ-nbft639o3cfbh0Y_TSA5CV3r7Qskn
X-Proofpoint-ORIG-GUID: 26zld3V7bFoYJ-uz-EaIbfKrXHiWOZlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-22_12,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205220144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Thu, May 19, 2022 at 01:35:47AM +0530, Vaibhav Jain wrote:
>> Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
>> ima-kexec-buffer lies outside the addressable memory range. This can result
>> in a kernel panic if the new kernel is booted with 'mem=X' arg and the
>> ima-kexec-buffer was allocated beyond that range by the previous kernel.
>> The panic is usually of the form below:
>> 
>> $ sudo kexec --initrd initrd vmlinux --append='mem=16G'
>> 
>> <snip>
>>  BUG: Unable to handle kernel data access on read at 0xc000c01fff7f0000
>>  Faulting instruction address: 0xc000000000837974
>>  Oops: Kernel access of bad area, sig: 11 [#1]
>> <snip>
>>  NIP [c000000000837974] ima_restore_measurement_list+0x94/0x6c0
>>  LR [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>>  Call Trace:
>>  [c00000000371fa80] [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>>  [c00000000371fb00] [c0000000020512c4] ima_init+0x80/0x108
>>  [c00000000371fb70] [c0000000020514dc] init_ima+0x4c/0x120
>>  [c00000000371fbf0] [c000000000012240] do_one_initcall+0x60/0x2c0
>>  [c00000000371fcc0] [c000000002004ad0] kernel_init_freeable+0x344/0x3ec
>>  [c00000000371fda0] [c0000000000128a4] kernel_init+0x34/0x1b0
>>  [c00000000371fe10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64
>>  Instruction dump:
>>  f92100b8 f92100c0 90e10090 910100a0 4182050c 282a0017 3bc00000 40810330
>>  7c0802a6 fb610198 7c9b2378 f80101d0 <a1240000> 2c090001 40820614 e9240010
>>  ---[ end trace 0000000000000000 ]---
>> 
>> Fix this issue by checking returned address/size of previous kernel's
>> ima-kexec-buffer against memblock's memory bounds.
>> 
>> Fixes: fee3ff99bc67("powerpc: Move arch independent ima kexec functions to
>> drivers/of/kexec.c")
>
> Your mailer (and/or you) corrupted this. There should be a space between 
> the commit hash and subject, and it should not be wrapped.
I probably messed it up. Will resend a fixed patch.

>
> It should also not have a blank line here.
Sure. Will get this fixed
>
> But more importantly, how did this commit introduce the problem? It just 
> moved the code and didn't have any such check.
Yes, the code didnt have the necessary check to see if the address for
previous kernel IMA buffer is beyond the currently addressable memory. I
have described the problem in patch description.

<snip>

-- 
Cheers
~ Vaibhav
