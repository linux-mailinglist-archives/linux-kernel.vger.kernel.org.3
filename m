Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CB55F784
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiF2HHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiF2HGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:06:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E91BF78
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:05:37 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T5qvFo030850;
        Wed, 29 Jun 2022 07:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=r1lNJUGLbGMfwZNf8zirvOwUj1iy00lLTAfbwkl/EGQ=;
 b=OH4smQSY7bMz89/6xlcq8k49FXxwa00Z7LI9nl7vccT9ocudhvv93eCdSDVu5EFZkbHO
 zFyqEZhucl20U1nIU7Bs3GbGzTrnJLritBhXVYUt+UIRFYKyQgGCJVf5mOv+5Pkb5KoK
 6CRXJF2c8jzhOIZMmxHUOmpsovBwFUzOpzUd0VprHnQ56L9FQ33hPM8H+gvatcFp0gMJ
 pKUxjDWag++tQwARr3RBVs0P1xuoUHdeEKFPvzwxWvyly2bJVi85WaLc/P6Kqazby8+8
 nFHhbwqybswAcfDB4+lJ2/zmRmFi0llNPDujdNWZZbyR1cusJz9JHp/f+WdOBT/HZTe6 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0gyragw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:05:04 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25T70GPk005165;
        Wed, 29 Jun 2022 07:05:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0gyragms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:05:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25T6bBU7022224;
        Wed, 29 Jun 2022 07:04:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhvgr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 07:04:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25T750oR26739006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 07:05:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9409A4040;
        Wed, 29 Jun 2022 07:04:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7BCA4053;
        Wed, 29 Jun 2022 07:04:52 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jun 2022 07:04:52 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
        qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: qemu-system-s390x hang in tcg (was: Re: [PATCH v8 23/70] mm/mmap:
 change do_brk_flags() to expand existing VMA and add do_brk_munmap())
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
        <20220428201947.GA1912192@roeck-us.net>
        <20220429003841.cx7uenepca22qbdl@revolver>
        <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
        <20220502001358.s2azy37zcc27vgdb@revolver>
        <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
        <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
        <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
        <20220503215520.qpaukvjq55o7qwu3@revolver>
        <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
        <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
Date:   Wed, 29 Jun 2022 09:04:52 +0200
In-Reply-To: <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com> (David
        Hildenbrand's message of "Wed, 4 May 2022 20:31:22 +0200")
Message-ID: <yt9d5ykkhrvv.fsf_-_@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ym4yJ76DVMZDDr4u98frPT-tSCAfVkQk
X-Proofpoint-GUID: cEayq-0bo4ZOoqhbBbHZRxj3DbkP2nEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=849 bulkscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206290024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Hildenbrand <david@redhat.com> writes:

> On 04.05.22 09:37, Janosch Frank wrote:
>> I had a short look yesterday and the boot usually hangs in the raid6 
>> code. Disabling vector instructions didn't make a difference but a few 
>> interruptions via GDB solve the problem for some reason.
>> 
>> CCing David and Thomas for TCG
>> 
>
> I somehow recall that KASAN was always disabled under TCG, I might be
> wrong (I thought we'd get a message early during boot that the HW
> doesn't support KASAN).
>
> I recall that raid code is a heavy user of vector instructions.
>
> How can I reproduce? Compile upstream (or -next?) with kasan support and
> run it under TCG?

I spent some time looking into this. It's usually hanging in
s390vx8_gen_syndrome(). My first thought was that it is a problem with
the VX instructions, but turned out that it hangs even if i remove all
the code from s390vx8_gen_syndrome().

Tracing the execution of TB's, i see that the generated code is always
jumping between a few TB's, but never exiting the TB's to check for
interrupts (i.e. return to cpu_tb_exec(). I only see calls to
helper_lookup_tb_ptr to lookup the tb pointer for the next TB.

The raid6 code is waiting for some time to expire by reading jiffies,
but interrupts are never processed and therefore jiffies doesn't change.
So the raid6 code hangs forever.

As a test, i made a quick change to test:

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c997c2e8e0..35819fd5a7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -319,7 +319,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);

     cflags = curr_cflags(cpu);
-    if (check_for_breakpoints(cpu, pc, &cflags)) {
+    if (check_for_breakpoints(cpu, pc, &cflags) ||
+        unlikely(qatomic_read(&cpu->interrupt_request))) {
         cpu_loop_exit(cpu);
     }

And that makes the problem go away. But i'm not familiar with the TCG
internals, so i can't say whether the generated code is incorrect or
something else is wrong. I have tcg log files of a failing + working run
if someone wants to take a look. They are rather large so i would have to
upload them somewhere.
