Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D65028B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352611AbiDOLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352602AbiDOLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:12:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9513D2B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:09:34 -0700 (PDT)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2Dgk-1o5HUZ0YxS-013bBO for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022
 13:09:33 +0200
Received: by mail-wr1-f52.google.com with SMTP id r13so10276069wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:09:33 -0700 (PDT)
X-Gm-Message-State: AOAM531tb6Ujwl5V1eU5n52p8BT/iTjQvhmijCHNcxjrUXqg3AikpmUb
        2ouQq1kRu/0mEJxstBJWTy/wlp7l6qmabEhSI+Q=
X-Google-Smtp-Source: ABdhPJyj3r7FEz5sXf6C3O9OOPQLQ/zV1cGeI/CnsNj84hy2M5ncBvkKZ6ruVU3zwgf+xJtInPaRa4Ahl7zJs9RlMu0=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr3630251wrp.407.1650020972755; Fri, 15
 Apr 2022 04:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com> <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
In-Reply-To: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Apr 2022 13:09:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3j2_8WjZCdj3mEtGnKoRDR4qsckx9igEM70AUG+4VgRA@mail.gmail.com>
Message-ID: <CAK8P3a3j2_8WjZCdj3mEtGnKoRDR4qsckx9igEM70AUG+4VgRA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jF8GBMLIwgbeQC75KoMwzFRReqGd2SUjAruua1+dXtjm5T/c5Hk
 RWftwpp8t6V0V1i1qJQ5UU33PEdlfw/BOZ1j3CwckxYyO+nuDI0FJNKrQx8KlILD8+zpfhu
 ucxqR/IdzBrAdxrVzDdcJcSGroSKa3ZJ4fecg2kClU9qTX9zEnSkNLI+tTayyFbCzMFv/yH
 bchU/USXgaYpIdt+a8hUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrvzaxiy9JE=:qAb1lefpx07fWqO4jPm4PG
 KJs4e9cTQj77CEEeZUgfVs+hgMPzXI45iebmFrMkEFKcqBLOsmK6H6VIGAfkRcFzxHaTJabVw
 vLVYpdNJ28zf8Krr7JGOrBfQukqA730HRlV/mt6H0u2mnS7WhJtsD9SfNGIeoLk5OqX6mD6cW
 U9qmtCoduPcqEpqX1PtPJd/WmLlAT0fUK/5m9hKmJ4xcAObhbK0xcVbC2oRFhPvkFg2eihoNm
 p+5NnmSqQdrF/62lf3hAqyEoh78Z7t+DSbEuyGxIoP9K8nY91zgZ1PZilXq5A+x4+LSZKlKk1
 Sb5gXwrTaNJ0w/SpMfdqH6o1apncmsHyLFPpptESxym0BY6AqFFYA+gdUGJKXo4gcXLuQoPdI
 BSy0MzhnfYS55I2TH4OeBIrfhvamLJZDsAOi1CSK6jqnnDXEs+0Nwp1F2cryo/rKKuhkxZ8Ip
 F+QkaFR4xiNxgy4ggMrT6n2q/QCuAnfcbenKIvZ9JCyeOtkZnugs76IUBOXdAOURZe9vMYhV4
 4j2i/iRnZkj/yAwNIQj6KMgPzQuvsK4rQ0B4KGu6MHBmSFw2YT46JkBxG+xMKKXYdnl6E6k+x
 VyjxycIVvafOZ5ZL+7do3Rww4ZHB7aQx4/gGlTnIh10oI28lPeN0wz7gbqjcWgea+tbAyX0uF
 aW/yb6rtbPNYFDh+idfsSLayFL8c9fMT8ncvPJAiCb/vSYd1IVrgtUW2vUo9ohOiWxLJPgNvW
 LEuOExrqN/YcveaARgX2BPaZDKNe/LhXLfDCWASGmzlvsM/3p8TkqVR2ghrnYYBKzbmiXPXlr
 /6jGVliWArNtBxxr1mLSasg988a+pjEQYu0DhbQTAMCH0c7T8Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> >
> And it could be that if I have 150k of those smallish allocations, a
> server with lots of active users might have millions. Not having
> looked at where they come from, maybe that isn't the case, but it
> *might* be.
>
> Maybe adding something like a
>
>         static int warn_every_1k = 0;
>         WARN_ON(size < 32 && (1023 & ++warn_every_1k));
>
> to kmalloc() would give us a statistical view of "lots of these small
> allocations" thing, and we could add GFP_NODMA to them. There probably
> aren't that many places that have those small allocations, and it's
> certainly safer to annotate "this is not for DMA" than have the
> requirement that all DMA allocations must be marked.

I think finding out the allocations is one of the most common examples
for ftrace. I followed the instructions from
https://www.kernel.org/doc/Documentation/trace/events.txt to
show me a histogram of all allocations under 256 bytes, which
(one kernel compile later) gives me something like

$echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending
if bytes_req<256' >   \
/sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
$ make -skj30
...
$ head  /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
{ call_site: [ffffffffc04e457f]
btrfs_delete_delayed_dir_index+0xbf/0x1e0 [btrfs]       } hitcount:
 146914  bytes_req:   16454368
{ call_site: [ffffffffbbe601a3] generic_file_buffered_read+0x463/0x4a0
                 } hitcount:      98187  bytes_req:   14906232
{ call_site: [ffffffffc0497b81] btrfs_buffered_write+0x131/0x7e0
[btrfs]                } hitcount:     156513  bytes_req:   10038544
{ call_site: [ffffffffc05125c9] btrfs_alloc_block_rsv+0x29/0x60
[btrfs]                 } hitcount:     155044  bytes_req:    8682464
{ call_site: [ffffffffbbfe7272] kernfs_fop_open+0xc2/0x290
                 } hitcount:      38764  bytes_req:    5892128
{ call_site: [ffffffffbbfb6ea2] load_elf_binary+0x242/0xed0
                 } hitcount:      58276  bytes_req:    3729664
{ call_site: [ffffffffc04b52d0] __btrfs_map_block+0x1f0/0xb60 [btrfs]
                 } hitcount:      29289  bytes_req:    3521656
{ call_site: [ffffffffbbf7ac7e] inotify_handle_inode_event+0x7e/0x210
                 } hitcount:      61688  bytes_req:    2986992
{ call_site: [ffffffffbbf2fa35] alloc_pipe_info+0x65/0x230
                 } hitcount:      13139  bytes_req:    2312464
{ call_site: [ffffffffbc0cd3ec] security_task_alloc+0x9c/0x100
                 } hitcount:      60475  bytes_req:    2177100
{ call_site: [ffffffffbc0cd5f6] security_prepare_creds+0x76/0xa0
                 } hitcount:     266124  bytes_req:    2128992
{ call_site: [ffffffffbbfe710e] kernfs_get_open_node+0x7e/0x120
                 } hitcount:      38764  bytes_req:    1860672
{ call_site: [ffffffffc04e1fbd] btrfs_alloc_delayed_item+0x1d/0x50
[btrfs]              } hitcount:      11859  bytes_req:    1833383
{ call_site: [ffffffffc046595d] split_item+0x8d/0x2e0 [btrfs]
                 } hitcount:      14049  bytes_req:    1716288
{ call_site: [ffffffffbbfb6dbc] load_elf_binary+0x15c/0xed0
                 } hitcount:      58276  bytes_req:    1631728
{ call_site: [ffffffffbbf40e79] __d_alloc+0x179/0x1f0
                 } hitcount:      24814  bytes_req:    1280649
{ call_site: [ffffffffbbf5203f] single_open+0x2f/0xa0
                 } hitcount:      34541  bytes_req:    1105312
{ call_site: [ffffffffc047ad0a] btrfs_wq_submit_bio+0x4a/0xe0 [btrfs]
                 } hitcount:       7746  bytes_req:    1053456
{ call_site: [ffffffffbc519e95] xhci_urb_enqueue+0xf5/0x3c0
                 } hitcount:       5511  bytes_req:     484968
{ call_site: [ffffffffc0482935] btrfs_opendir+0x25/0x70 [btrfs]
                 } hitcount:      60245  bytes_req:     481960
{ call_site: [ffffffffc04c44ff] overwrite_item+0x1cf/0x5c0 [btrfs]
                 } hitcount:       7378  bytes_req:     364305
{ call_site: [ffffffffc04c4514] overwrite_item+0x1e4/0x5c0 [btrfs]
                 } hitcount:       7378  bytes_req:     364305
{ call_site: [ffffffffc04e207f] btrfs_wq_run_delayed_node+0x2f/0x80
[btrfs]             } hitcount:       3427  bytes_req:     356408
{ call_site: [ffffffffbbe7e96d] shmem_symlink+0xbd/0x250
                 } hitcount:       5169  bytes_req:     242943
{ call_site: [ffffffffc03e0526] hid_input_field+0x56/0x290 [hid]
                 } hitcount:      11004  bytes_req:     175760

I think these are all safe for the GFP_NODMA approach you suggest, maybe
not the xhci_urb_enqueue one.

          Arnd
