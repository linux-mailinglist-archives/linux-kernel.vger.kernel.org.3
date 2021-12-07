Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8246B2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhLGG2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:28:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28280 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhLGG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:28:46 -0500
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J7Vdq4QmGzQjD0;
        Tue,  7 Dec 2021 14:25:03 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 14:25:15 +0800
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>, <cocci@inria.fr>
CC:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <yzaikin@google.com>, <wangle6@huawei.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ce96717e-3f18-bf9e-90e2-a482be33a488@huawei.com>
Date:   Tue, 7 Dec 2021 14:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/7 9:50, Joe Perches wrote:
> On Mon, 2021-12-06 at 17:38 -0800, Andrew Morton wrote:
>> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
>>
>>> To avoid duplicated code, add a set of macro functions to initialize the
>>> sysctl table for each feature.
>>>
>>> The system initialization process is as follows:
>>>
>>> 	start_kernel () {
>>> 		...
>>> 		/* init proc and sysctl base,
>>> 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
>>> 		 */
>>> 		proc_root_init(); /* init proc and sysctl base */
>>> 		...
>>> 		arch_call_rest_init();
>>> 	}
>>>
>>> 	arch_call_rest_init()-->rest_init()-->kernel_init()
>>> 	kernel_init() {
>>> 		...
>>> 		kernel_init_freeable(); /* do all initcalls */
>>> 		...
>>> 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
>>> 	}
>>>
>>> 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
>>> 	do_initcalls() {
>>> 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
>>> 			do_initcall_level
>>> 	}
>>>
>>> The sysctl interface of each subfeature should be registered after
>>> sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
>>> interface does not depend on initcall_levels. To prevent the sysctl
>>> interface from being initialized before the feature itself. The
>>> lowest-level late_initcall() is used as the common sysctl interface
>>> registration level.
>>
>> I'm not normally a fan of wrapping commonly-used code sequences into
>> magical macros, but this one does seem to make sense.
>>
>> I wonder if it is possible to cook up a checkpatch rule to tell people
>> to henceforth use the magic macros rather than to open-code things in
>> the old way.  Sounds hard.
> 
> Almost impossible for checkpatch.
> Likely easier in coccinelle.
>

Maybe we can add a rudimentary check to the checkpatch.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..26e953ae4cc5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7212,6 +7212,12 @@ sub process {
                              "Deprecated use of '$deprecated_api', 
prefer '$new_api' instead\n" . $herecurr);
                 }

+# check register_sysctl_init
+               if ($prevline =~ /{/ && $rawline =~ 
/\sregister_sysctl_init\(\"(kernel|fs|vm|debug|dev)\",\s+(.*)\)\;/) {
+                       WARN("DEPRECATED_API",
+                            "Deprecated use of 
'register_sysctl_init(\"$1\", $2);', prefer '$1_sysctl_initcall($2);' 
instead\n".$herecurr);
+               }
+
  # check for various structs that are normally const (ops, kgdb, 
device_tree)
  # and avoid what seem like struct definitions 'struct foo {'
                 if (defined($const_structs) &&



Thanks
Xiaoming Ni
