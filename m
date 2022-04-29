Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F75149AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiD2Mnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD2Mni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5799C2DA96
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651236019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qlZEt0CJ15MY5lrHUSg5jHxaHP1fOvUAbi7yAjR/3g=;
        b=hXCKtpSCA3GUYSKsiN2T8jOxYz4bOIReaeptpRHDvgc4xCWwx+AUvSHSyekimYAvSzKcoE
        gwN2kB1qzh7PIDWzAAZI6qyzaPHwUc8poVPUKEKpKdXa7wE5MDLuLH7gYgeH1erPChOHSO
        Nz1NnMUx3gnWIAeKVvDxyOhsv1OkwTU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-1S36XympOpGGN1z4radOxA-1; Fri, 29 Apr 2022 08:40:18 -0400
X-MC-Unique: 1S36XympOpGGN1z4radOxA-1
Received: by mail-wr1-f72.google.com with SMTP id l11-20020adfc78b000000b0020abc1ce7e4so3031564wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7qlZEt0CJ15MY5lrHUSg5jHxaHP1fOvUAbi7yAjR/3g=;
        b=2yM9rmymiA2nLya6Pji3hb0uS13bXgp10l4hi6TBdQNtgxzf8ieyV7ychG7AS2sVc7
         Oc5wFJ8lrPwAwpRxvuFag52VN+jHZnxKpPDAW3vPoagahPNAaUCFLVNQbZKBfb7+kRHk
         Q1T43ImW0bBjYQjxt6yYaaX/+qetVtyhQhJ86h3MbjA7AfAPtioYgztKzj0Di4vBcA4V
         bzzFZ8ZN2+4phPYXb/wSWHhJS7kx6VbRCp2inxuSRVXu0HRsbxcEABgY0fFJE0kF8+fM
         JgZILVWZEYcj03BJylA3x7g5KBNOmiKghWjueBfihrwt5IGPcvsPhXoxn5aSvrshk4Ko
         cPzw==
X-Gm-Message-State: AOAM533dLvQUF5RzCIn0dT3/kx1NcyzwquoYSxSubYVvOBcKfIuc8B3+
        I8OK05mxiUBiMaKvna4WN7eet3SJtDLXLQSRVs7LPKutcn+xGVUGAS8TVwuIFlRO2ExnXNj1V1N
        2EKPRCqMawgtkUgnvvvgQDN1p
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr3035677wme.94.1651236016937;
        Fri, 29 Apr 2022 05:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS6t4Goyq6LgyXFEChCd7us/yvKMEtigp8qy3y8CY9duWI4nCjtGSEu1M44Z3Q7Xg4LrVrlA==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr3035641wme.94.1651236016652;
        Fri, 29 Apr 2022 05:40:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id b11-20020adfc74b000000b0020ad84d3fa3sm2530734wrh.44.2022.04.29.05.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:40:16 -0700 (PDT)
Message-ID: <90d3ef00-bacb-2090-b932-bdaf26f1a9e2@redhat.com>
Date:   Fri, 29 Apr 2022 14:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [next] x86: BUG: kernel NULL pointer dereference, address:
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Rolf Eike Beer <eb@emlix.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linmiaohe@huawei.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Xu <peterx@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <CA+G9fYvPgTdSU_9BcSrL8qPOhzPSykxa=NdTiT-pb0H+OqBpEg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CA+G9fYvPgTdSU_9BcSrL8qPOhzPSykxa=NdTiT-pb0H+OqBpEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.22 13:50, Naresh Kamboju wrote:
> Following kernel BUG noticed on Linux next-20220428 on x86_64 while running
> selftests x86 fsgsbase_64 test cases.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 

My gut feeling is that this could be related to the maple tree patches,
but might be just wrong.


> 
> Test log:
> ----------
> # selftests: x86: fsgsbase_64
> # [OK] GSBASE started at 1
> # [RUN] Set GS = 0x7, read GSBASE
> # [OK] GSBASE reads as 0x1 with invalid GS
> # FSGSBASE instructions are enabled
> # [RUN] ARCH_SET_GS to 0x0
> # [OK] GSBASE was set as expected (selector 0x0)
> # [OK] ARCH_GET_GS worked as expected (selector 0x0)
> # [RUN] ARCH_SET_GS to 0x1
> # [OK] GSBASE was set as expected (selector 0x0)
> # [OK] ARCH_GET_GS worked as exp[  199.295202] BUG: kernel NULL
> pointer dereference, address: 0000000000000000
> [  199.302779] #PF: supervisor read access in kernel mode
> [  199.307918] #PF: error_code(0x0000) - not-present page
> [  199.313057] PGD 8000000145f05067 P4D 8000000145f05067 PUD 145f04067 PMD 0
> [  199.319930] Oops: 0000 [#1] PREEMPT SMP PTI
> [  199.324117] CPU: 1 PID: 2948 Comm: sysret_rip_64 Tainted: G
>      K   5.18.0-rc4-next-20220428 #1
> [  199.333587] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [  199.340972] RIP: 0010:copy_vma+0x61/0x220
> [  199.344983] Code: 48 89 45 d0 31 c0 49 8b 07 49 83 7f 60 00 48 89
> 45 b8 0f 84 47 01 00 00 48 8d 55 c8 4c 89 ee 4c 89 f7 4c 01 eb e8 2f
> ec ff ff <48> 39 18 72 7e 4d 8b 47 20 4d 8b 4f 58 6a 00 48 89 d9 41 ff
> b7 90
> [  199.363722] RSP: 0018:ffffacf8813bfca0 EFLAGS: 00010292
> [  199.368946] RAX: 0000000000000000 RBX: 00007fffffffe000 RCX: 0000000000000001
> [  199.376070] RDX: ffffffffffffffff RSI: ffff9c6d04959f00 RDI: ffffacf8813bfc38
> [  199.383193] RBP: ffffacf8813bfcf0 R08: 000000000000000b R09: 000000000000000b
> [  199.390317] R10: ffff9c6d03e392f0 R11: 0000000000000058 R12: ffffacf8813bfd48
> [  199.397441] R13: 00007fffffffd000 R14: ffff9c6ccc331d40 R15: ffff9c6d03e392f0
> [  199.404566] FS:  00007fce67a16b80(0000) GS:ffff9c6e2fa80000(0000)
> knlGS:0000000000000000
> [  199.412644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  199.418391] CR2: 0000000000000000 CR3: 0000000156398002 CR4: 00000000003706e0
> [  199.425521] DR0: 00000000006021a8 DR1: 0000000000400ae9 DR2: 0000000000000000
> [  199.432647] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  199.439778] Call Trace:
> [  199.442221]  <TASK>
> [  199.444320]  move_vma+0x131/0x4a0
> [  199.447644]  __do_sys_mremap+0x35c/0x890
> [  199.451578]  ? syscall_trace_enter.constprop.0+0x176/0x230
> [  199.457068]  __x64_sys_mremap+0x25/0x30
> [  199.460907]  do_syscall_64+0x5c/0x80
> [  199.464486]  ? do_syscall_64+0x69/0x80
> [  199.468239]  ? syscall_exit_to_user_mode+0x3a/0x50
> [  199.473031]  ? do_syscall_64+0x69/0x80
> [  199.476786]  ? asm_exc_general_protection+0x8/0x30
> [  199.481576]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  199.486631] RIP: 0033:0x7fce66f10bda
> [  199.490208] Code: 73 01 c3 48 8b 0d be a2 2b 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8e a2 2b 00 f7 d8 64 89
> 01 48
> [  199.508952] RSP: 002b:00007ffd71e44b28 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000019
> [  199.516511] RAX: ffffffffffffffda RBX: 00007fffffffd000 RCX: 00007fce66f10bda
> [  199.523634] RDX: 0000000000001000 RSI: 0000000000001000 RDI: 0000000000402000
> [  199.530757] RBP: 0000000000000001 R08: 00007fffffffd000 R09: 00007ffd71e449fc
> [  199.537883] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000001
> [  199.545016] R13: 00007ffd71e44ce0 R14: 0000000000000000 R15: 0000000000000000
> [  199.552150]  </TASK>
> [  199.554341] Modules linked in: x86_pkg_temp_thermal fuse [last
> unloaded: test_klp_livepatch]
> [  199.562772] CR2: 0000000000000000
> ected (selector [  199.566084] ---[ end trace 0000000000000000 ]---
> [  199.566085] RIP: 0010:copy_vma+0x61/0x220
> 0x0)
> # [RUN] AR[  199.566088] Code: 48 89 45 d0 31 c0 49 8b 07 49 83 7f 60
> 00 48 89 45 b8 0f 84 47 01 00 00 48 8d 55 c8 4c 89 ee 4c 89 f7 4c 01
> eb e8 2f ec ff ff <48> 39 18 72 7e 4d 8b 47 20 4d 8b 4f 58 6a 00 48 89
> d9 41 ff b7 90
> [  199.566089] RSP: 0018:ffffacf8813bfca0 EFLAGS: 00010292
> CH_SET_GS to 0x2[  199.566090] RAX: 0000000000000000 RBX:
> 00007fffffffe000 RCX: 0000000000000001
> [  199.566091] RDX: ffffffffffffffff RSI: ffff9c6d04959f00 RDI: ffffacf8813bfc38
> 00000000
> # [OK][  199.566092] RBP: ffffacf8813bfcf0 R08: 000000000000000b R09:
> 000000000000000b
> GSBASE was set [  199.566092] R10: ffff9c6d03e392f0 R11:
> 0000000000000058 R12: ffffacf8813bfd48
> [  199.566093] R13: 00007fffffffd000 R14: ffff9c6ccc331d40 R15: ffff9c6d03e392f0
> as expected (sel[  199.566094] FS:  00007fce67a16b80(0000)
> GS:ffff9c6e2fa80000(0000) knlGS:0000000000000000
> [  199.566095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> ector 0x0)
> # [O[  199.566096] CR2: 0000000000000000 CR3: 0000000156398002 CR4:
> 00000000003706e0
> [  199.566097] DR0: 00000000006021a8 DR1: 0000000000400ae9 DR2: 0000000000000000
> K] ARCH_GET_GS w[  199.566098] DR3: 0000000000000000 DR6:
> 00000000ffff0ff0 DR7: 0000000000000600
> orked as expected (selector 0x0)
> # [RUN] ARCH_SET_GS to 0x0
> # [OK] GSBASE was set as expected (selector 0x0)
> # [OK] ARCH_GET_GS worked as expected (selector 0x0)
> 
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: bdc61aad77faf67187525028f1f355eff3849f22
>   git_describe: next-20220428
>   kernel_version: 5.18.0-rc4
>   kernel-config: https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/config
>   vmlinux : https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/vmlinux.xz
>   System.map : https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/System.map
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 


-- 
Thanks,

David / dhildenb

