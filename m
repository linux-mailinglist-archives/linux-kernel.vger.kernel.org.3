Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D62531D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiEWVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEWVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:17:05 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399438D6BE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:17:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w130so19369320oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ouJwq3gHVrLljqEkISRPOFruhNDZFLgK1U74Bv7TpaI=;
        b=YAqNkahEfUPj9vc6tqLhDbZeuyaWlJDxHdPKh1DMGHM3fJBY1Va3Jht/yoDd0UQuPo
         H12uwHlR7B2fB2zrSh2X9MLPGpCEX7PamXvg7MCRaF6QA4dJKqNDUU1lsOOZ0U30kBcr
         Zo+b4USLbON/KXZOlqADbGYcMykuwVxTVaLXyohJs1GvzlzYTXNxEwgVCrkLrtejlrpO
         oj4cjSJ5/5f33hF5/wu5t3M7SrcLqUcrWznUsFIJPtM9DfVVqDrDwUEXrzpbcx+gLgyR
         rgv9B+EW4V6Kaw8qZlXZ/H0WHbJH8O6qYp7dwt4smrhhxjI+++hnVeooX+GPWzbvdHlM
         PvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ouJwq3gHVrLljqEkISRPOFruhNDZFLgK1U74Bv7TpaI=;
        b=AVV0aP6FWnLKTrr+vhoQuwv7ctyA/Xn2A/BdAe7HMPp/wtWNh4pa4H8EkIe+8umk0B
         lofVn9Hk2zhimpR7FpNS7knW1yg4eL5h3bSPYaVfjOE5IRzv8o6PuV/nxTsyrhey6SiC
         jVwPkIuZTFb0guc3H4WDRBlrnVhgysZqO6Z7l7No1F/LDVykCjL/UQ98BQKAGIJ2RGso
         e2kpwZbRzC+oPe75TrEVGJA0l81TYJOHr+ukTQgeRrnnkhhyS6yyGzNSfiBTXmsjHqAV
         elXcdiPlyOgli+1mTFdZ6quGThbJXT2LEcDyK6yTpKt9oYTFoz9dAT+8MLKlAezh12Ob
         jwuw==
X-Gm-Message-State: AOAM530I8/qWm60Q9VdVYqhhwj5Zi7AtfAB1+5Ygq3q2xzzJbnUYyGXI
        Evuxxg2XWfPJPEYw79syBXysGZC+dM7biA==
X-Google-Smtp-Source: ABdhPJxlDA8sPwDRZaxbYYuRYe9KhgdKw4Zicui3E62nIzBJURs616daR1H2KunOmWyvRqCSvnbWYQ==
X-Received: by 2002:a05:6808:1283:b0:32a:e09b:5a43 with SMTP id a3-20020a056808128300b0032ae09b5a43mr578031oiw.264.1653340622545;
        Mon, 23 May 2022 14:17:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s71-20020acaa94a000000b0032b7c4ead49sm245387oie.18.2022.05.23.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:17:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 14:17:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wang Kefeng <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: 9192/1: amba: fix memory leak in
 amba_device_try_add()
Message-ID: <20220523211700.GA236401@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:07:14AM +0100, Wang Kefeng wrote:
> If amba_device_try_add() return error code (not EPROBE_DEFER),
> memory leak occurred when amba device fails to read periphid.
> 

This patch results in a refcount underflow.

NET: Registered PF_NETLINK/PF_ROUTE protocol family
DMA: preallocated 256 KiB pool for atomic coherent allocations
platform vga: Fixing up cyclic dependency with bridge
OF: amba_device_add() failed (-19) for /amba/smc@10100000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
refcount_t: underflow; use-after-free.
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-next-20220523 #1
Hardware name: ARM-Versatile (Device Tree Support)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x38/0x5c
 dump_stack_lvl from __warn+0xc8/0x1d4
 __warn from warn_slowpath_fmt+0x90/0xc8
 warn_slowpath_fmt from of_platform_bus_create+0x33c/0x3dc
 of_platform_bus_create from of_platform_bus_create+0x1ec/0x3dc
 of_platform_bus_create from of_platform_populate+0x68/0xd8
 of_platform_populate from customize_machine+0x1c/0x30
 customize_machine from do_one_initcall+0x8c/0x2fc
 do_one_initcall from kernel_init_freeable+0x190/0x220
 kernel_init_freeable from kernel_init+0x10/0x108
 kernel_init from ret_from_fork+0x14/0x3c

Guenter

---
# bad: [cc63e8e92cb872081f249ea16e6c460642f3e4fb] Add linux-next specific files for 20220523
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect start 'HEAD' 'v5.18'
# bad: [a812cac8ff60a3f57d59225eaf668f574fd36a65] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad a812cac8ff60a3f57d59225eaf668f574fd36a65
# bad: [ad67b5f981704e575b24e3b650653bae607980dc] Merge branch 'for-next' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
git bisect bad ad67b5f981704e575b24e3b650653bae607980dc
# bad: [793dd6392ef951ae61473acfc7e7016ea22c40f4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad 793dd6392ef951ae61473acfc7e7016ea22c40f4
# good: [00ad84f582be91dd03132c133917cc6b62d754e2] Merge branch 'arm/dt' into for-next
git bisect good 00ad84f582be91dd03132c133917cc6b62d754e2
# bad: [5c4a49fbe99c7c9b814d677ac99e3efcc43d019a] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 5c4a49fbe99c7c9b814d677ac99e3efcc43d019a
# good: [33cd6948f953ab47ffa493bac6c0f34feb191e0d] Merge branch 'clang-format' of https://github.com/ojeda/linux.git
git bisect good 33cd6948f953ab47ffa493bac6c0f34feb191e0d
# good: [d6fc5db0f82828c74742319cb6c988c4a8aac535] Merge branch 'for-next/kselftest' into for-next/core
git bisect good d6fc5db0f82828c74742319cb6c988c4a8aac535
# good: [d7015e50a9ed180dcc3947635bb2b5711c37f48b] perf intel-pt: Add support for emulated ptwrite
git bisect good d7015e50a9ed180dcc3947635bb2b5711c37f48b
# good: [5b86b659fa4b3dd45acbdce13f2e94f882a3d125] Merge branch 'for-next' of git://git.infradead.org/users/hch/dma-mapping.git
git bisect good 5b86b659fa4b3dd45acbdce13f2e94f882a3d125
# good: [945980a9ba0744038659769e9f04e83e8f6b494b] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
git bisect good 945980a9ba0744038659769e9f04e83e8f6b494b
# bad: [b6f21d14f1ac1261579b691673a0c823275cbaf8] ARM: 9204/2: module: Add all unwind tables when load module
git bisect bad b6f21d14f1ac1261579b691673a0c823275cbaf8
# bad: [c4f486f1e7b34b27ec578494a236061b337d50ae] ARM: 9198/1: spectre-bhb: simplify BPIALL vector macro
git bisect bad c4f486f1e7b34b27ec578494a236061b337d50ae
# bad: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 9192/1: amba: fix memory leak in amba_device_try_add()
git bisect bad 7719a68b2fa404fa8af6b0b7119a38c406c74858
# good: [1f44de0f5e309e8699b569b49a8e89ef4e7527c7] ARM: 9193/1: amba: Add amba_read_periphid() helper
git bisect good 1f44de0f5e309e8699b569b49a8e89ef4e7527c7
# first bad commit: [7719a68b2fa404fa8af6b0b7119a38c406c74858] ARM: 9192/1: amba: fix memory leak in amba_device_try_add()


