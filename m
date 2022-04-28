Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00B51395C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbiD1QIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiD1QId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:08:33 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97CB6E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:05:16 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e9027efe6aso5560673fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLFwOcGwV0inPPsmcNXn7iUkCGFz77zi4jASX/UuXrs=;
        b=BOEsjfKitpP/5QAnbrPVfybarfXwHG1o4ZektFOcCwtRH6jw3Tq99/Os9UzZ2cFGYs
         PH1zP7Drl9oA/bwu2a6PaL2SuT4xn/Yq/ZRNXt42FHU+7TrcM9JPn0IhS9bDCgZim4D1
         hFJ5T3Hp2weYZexE3qu9br+DjbRowW3iTaOQVKxzYbSRv2JHwGqQQ4tqw8EAtKJjUmOY
         nYf4cM8jGCjG6CpfqTIn4zJpJCp0e6n4vMjDZ6vHTqetm1sfmpv4YbYoxdktzrL+hnIs
         dhXWxXx5EAMy2mnKkBdXpoqoWAsBsI+jCtJ8qBVDi5bYux2eJ5KY2UYnaiO9T97j7eM8
         LwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cLFwOcGwV0inPPsmcNXn7iUkCGFz77zi4jASX/UuXrs=;
        b=3k3raVvuEZRwyI7341zbSuZfca2bfELkHP4qIEqz7FrJczcxPKrE+IfXovAumOMKYO
         ViTPOOHXowTMUefgOPA+moTVG5QEgK4QsXsma/hcqkBjP12h9YvmoAaR1fw52MKZFigB
         nNKlvDMkCvN8y9Jy7MDxdFUlBoGzXP5uFJSJeNssw7yTzQ8PIjh19xdG+xxITDNwkGnB
         8rKb0zIjXyG1ApTT14wvVEobysyFb6R0aolhZroLbNwpyr0/v5SYXXS6kcEWT1yN84dN
         i8pW4+XGHYii5pXX0uzl+cB6geNC7OS7+bgxC2XNx4eq8pKf74ME+LYnKK2PgJjHKtB/
         kJhQ==
X-Gm-Message-State: AOAM532fPHOKt/nJUSNTWVk8d4tfHvwRU47d3zSvNbzUYqwMBo1RsLZr
        zN+Gs2Kv2XRTHKw9QKH3qUw=
X-Google-Smtp-Source: ABdhPJx8N3IGE+6gr0FcjWklc5ZPB4S+DCdgcBaH72mY5nEC02gAtlHGIZtW+u+4GY6wIMNJ/xZUBw==
X-Received: by 2002:a05:6870:a109:b0:e6:8760:bc96 with SMTP id m9-20020a056870a10900b000e68760bc96mr13762195oae.40.1651161914698;
        Thu, 28 Apr 2022 09:05:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020a056808150c00b0032562612b3fsm179054oiw.32.2022.04.28.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:05:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Apr 2022 09:05:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Message-ID: <20220428160511.GA2897430@roeck-us.net>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-67-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150616.3937571-67-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:06:52PM +0000, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the maple tree or VMA iterator instead.  This is faster and will allow
> us to shrink the VMA.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

This patch crashes my xtensa nommu (kc705-nommu) boot test. Crash and bisect logs
attached. I can not revert the patch for cross checks because that results in a
compile failure.

Note that mps2-an385 boot tests also fail but I was not able to bisect.

Guenter

---
[   19.394659] Unable to handle kernel paging request at virtual address 00000048
[   19.394659]  pc = 600d7039, ra = a00d7ed4
[   19.394840] Oops: sig: 11 [#1] PREEMPT
[   19.394930] CPU: 0 PID: 142 Comm: mount Not tainted 5.18.0-rc4-next-20220428 #1
[   19.394980] a00: a00d7ed4 6253be00 6b6b6b6b ffffffff 00000001 6254ada0 00000000 6253be20
[   19.395091] a08: a03b91a8 00000000 6b6b6b6b ffffff00 6b6b6b6b 6235c400 6253be40 6b6b6b6b
[   19.395198] pc: 600d7039, ps: 00060710, depc: 0000001c, excvaddr: 00000048
[   19.395225] lbeg: 6056536c, lend: 60565377 lcount: ffffffff, sar: 00000009
[   19.395275] Stack:
[   19.395320]  6b6b6b6b 6235c400 0000001f 6b6b6b6b a0009585 6253be40 6234e020 6235a2e0
[   19.395349]  00000000 6254ada0 00000000 6253be20 a000e789 6253be80 6234e020 60731424
[   19.395375]  6234e020 6b6b6b6c 6b6b6b6b 6235c40c 00000000 ffffffff 00000000 00000200
[   19.395401]  60748f3c 6234e090 00000001 6253be50 a000eee0 6253bea0 6234e020 6254a8a0
[   19.395426]  00000000 6234e020 6254a8a0 00000000 60005e8c 6253bf00 00000000 6270d6d4
[   19.395452]  60005e8c 6253bef0 00000000 00000000 6254aca0 00000000 fffff000 00000000
[   19.395478]  6254b3a0 619a0780 627aff95 627aff9a 60005c19 6253bf00 6253bf00 3fffffff
[   19.395503]  6234e090 00000000 00000000 00000000 60005ba9 6253bf20 6253bf30 00000000
[   19.395519] Call Trace:
[   19.395577] Disabling lock debugging due to kernel taint
[   19.395714] Fixing recursive fault but reboot is needed!
[   19.395826] BUG: scheduling while atomic: mount/142/0x00000000
[   19.395871] INFO: lockdep is turned off.
[   19.395904] Modules linked in:
[   19.396000] Preemption disabled at:
[   19.396019] [<00000000>] 0x0
[   19.396256] CPU: 0 PID: 142 Comm: mount Tainted: G      D           5.18.0-rc4-next-20220428 #1
[   19.396284] Stack:
[   19.396311]  00000100 00000000 6253bbf0 6253bbd0 6074b97c 0000008e 6095915c a057531a
[   19.396339]  a00287ab 6253bc10 00000010 60734364 00000000 00000004 6253bbf0 6253bbd0
[   19.396365]  a0578975 6253bc30 00000000 00000000 00000000 00000000 60730cbc 6253bda4
[   19.396392]  a002b770 6253bc50 00000000 6254a8a0 40000000 00000000 00000000 6253bc30
[   19.396418]  a000eece 6253bca0 0000810c 00008000 00000000 00000000 00000001 60915040
[   19.396444]  00000000 60915020 6253a000 60915040 a000eece 6253bca0 00000000 0000050c
[   19.396471]  608011c0 608015c0 6253a000 6253bc50 a0007f39 6253bcc0 00000003 00000001
[   19.396497]  0000008e 00060003 00000000 6253bca0 a0008675 6253bce0 00000000 0000ff00
[   19.396509] Call Trace:
[   19.396520]  [<6057535d>] dump_stack+0x9/0x18
[   19.396556]  [<600287ab>] __schedule_bug+0x7f/0xc0
[   19.396584]  [<60578975>] __schedule+0x59/0x764
[   19.396609]  [<6002b770>] do_task_dead+0x4c/0x74
[   19.396633]  [<6000eece>] make_task_dead+0xaa/0xb0
[   19.396657]  [<60007f39>] die+0x9d/0xb4
[   19.396681]  [<60008675>] bad_page_fault+0x61/0xc4
[   19.396705]  [<60008875>] do_page_fault+0x19d/0x1ec
[   19.396729]  [<60005ba9>] common_exception+0x7f/0x7f
[   19.396752]  [<600d7ed4>] exit_mmap+0x44/0xa8
[   19.396778]  [<60009585>] mmput+0x55/0xec
[   19.396802]  [<6000e789>] do_exit+0x279/0x914
[   19.396825]  [<6000eee0>] sys_exit+0xc/0xc
[   19.396849]  [<60005e8c>] system_call+0x48/0x60
[   19.396872]  [<60005ba9>] common_exception+0x7f/0x7f

---
# bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific files for 20220428
# good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
git bisect start 'HEAD' 'v5.18-rc4'
# good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
# good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
# good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
# good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
# good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
# good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-for-next' of https://github.com/norov/linux.git
git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
# good: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
git bisect good 40b39116fe8e6fb66e3166ea40138eec506dfd91
# bad: [33ef257872566922df2b6bcfdb5330b2388aef53] Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges monitoring
git bisect bad 33ef257872566922df2b6bcfdb5330b2388aef53
# good: [2d8640f244c1ea6c40acde911d339dabc2ac765d] mm/oom_kill: use maple tree iterators instead of vma linked list
git bisect good 2d8640f244c1ea6c40acde911d339dabc2ac765d
# bad: [49d281fa016f2906346f1707e5059b6f7674a948] mm/mmap.c: pass in mapping to __vma_link_file()
git bisect bad 49d281fa016f2906346f1707e5059b6f7674a948
# bad: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: remove uses of VMA linked list
git bisect bad 487c2c6d922605aebe6f470e1a458eb1425548db
# good: [dc4a1ab575a32e454be953f7b1b0222dcd3d47fa] mm/swapfile: use vma iterator instead of vma linked list
git bisect good dc4a1ab575a32e454be953f7b1b0222dcd3d47fa
# good: [7fffbdd08665ddeeb38768309269fa5b32388c3d] i915: use the VMA iterator
git bisect good 7fffbdd08665ddeeb38768309269fa5b32388c3d
# first bad commit: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: remove uses of VMA linked list
