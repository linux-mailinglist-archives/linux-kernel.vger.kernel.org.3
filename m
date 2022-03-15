Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0D4D913D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiCOAZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbiCOAZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:25:36 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8363CFC2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:24:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id h126so34207573ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5cXQ6+7k4HoHwif17IVrXXyVjB2qlIH0Mm4cn4G968=;
        b=fSg080hgTEJBSojXJAAC++QVhl5gL4M8QBoMTbmYICmM1ugvzme37B82MfwLag39QC
         MZcBXoSGX/S5ouXPAvyxXGbY4Hkw1isCEfusHGIRHBHp3UIwUqyUPhH8s2ueDWsS8pWG
         QF1hvlLXBkv8DJ5EzSajVTGPV+EejUaIg1y3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5cXQ6+7k4HoHwif17IVrXXyVjB2qlIH0Mm4cn4G968=;
        b=h/1XN2ppU4mb7Ze92BnsByGyI66+M54QE9cL22NMXIBalGGyfBEnyHxhCyL2kZ8GWW
         M9EGCErXVuJ2AfRkZUt183LeGURnLKU2WDAxayhhxhCduh+sPnCbBEXh8RfDQx2Nkh06
         ZcijYxOkw42TLPGTGAb4bwc4kgmbIJNORuxNYHWoTSNOZLPeKrgxrnfBA4bgOChTvx9z
         SL+C4Cpresw8IOjBBCbnT6yX2yjJeHMMo5T2BWNN9Di9Rq1h6sLHu8CsQfLPWEnBP+3R
         FSSVlWyOtaRE2y9uRF8K2IlxCAnzEJori2Tt0JaxsQmwsGQyRM0AtE+Z0SauxlTVz48v
         0q2Q==
X-Gm-Message-State: AOAM531XPOewXWfYmRfc/HNl1Vf5vOHIL0CKp8NfbN8fImpBjt5q97Mi
        Y2JelJWxBcO5GHG8R6IOItS8ZMAfDrx/XVg3CWHLrxsE26e7jw==
X-Google-Smtp-Source: ABdhPJz3sM7LoRO7mKg0fghZnrEKx+tUe0HfZuVIwOfiaSrHEdEoFAs2vItnt7SphCK3vVJ9nilYHMwLQEJBktpNOlk=
X-Received: by 2002:a25:bc8:0:b0:628:80d9:526c with SMTP id
 191-20020a250bc8000000b0062880d9526cmr20532878ybl.115.1647303864105; Mon, 14
 Mar 2022 17:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <Yi/EdMA8re7PCNeU@google.com>
In-Reply-To: <Yi/EdMA8re7PCNeU@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 14 Mar 2022 17:24:13 -0700
Message-ID: <CABWYdi2-2ijsA2r+3_p5AoiBGt=ke7saULVum=Din3jJut_LFQ@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 3:40 PM Minchan Kim <minchan@kernel.org> wrote:
> Could you reproduce the problem with this workaround?
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 0bf8e40f4e57..f2438a5101a7 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -114,7 +114,7 @@ static void end_swap_bio_read(struct bio *bio)
>         }
>
>         SetPageUptodate(page);
> -       swap_slot_free_notify(page);
> +       // swap_slot_free_notify(page);
>  out:
>         unlock_page(page);
>         WRITE_ONCE(bio->bi_private, NULL);
>

Yes:

zram_bvec_write index = 346 [cpu = 5, tid = 7003, nsecs = 956579989]
zram_free_page  index = 346 [cpu = 5, tid = 7003, nsecs = 956620031]
zram_bvec_read  index = 346 [cpu = 2, tid = 7005, nsecs = 967421676]
zram_free_page  index = 346 [cpu = 2, tid = 7005, nsecs = 967502177]

        zram_free_page+0
        swap_range_free+220
        swap_entry_free+244
        swapcache_free_entries+152
        free_swap_slot+288
        __swap_entry_free+216
        swap_free+108
        do_swap_page+1624
        handle_pte_fault+204
        handle_mm_fault+644
        do_page_fault+628
        do_translation_fault+92
        do_mem_abort+80
        el0_da+60
        el0t_64_sync_handler+196
        el0t_64_sync+420

zram_bvec_read  index = 346 [cpu = 6, tid = 7004, nsecs = 974478898]

[ 1298.139588][ T7004] ------------[ cut here ]------------
[ 1298.140574][ T7004] WARNING: CPU: 6 PID: 7004 at
drivers/block/zram/zram_drv.c:1285 __zram_bvec_read+0x28c/0x2e8 [zram]
[ 1298.142199][ T7004] Modules linked in: zram zsmalloc kheaders nfsv3
nfs lockd grace sunrpc xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xt_addrtype nft_compat nf_tables nfnetlink bridge stp llc overlay xfs
libcrc32c zstd zstd_compress aes_ce_blk aes_ce_cipher af_packet
ghash_ce gf128mul sha3_ce virtio_net sha3_generic net_failover
sha512_ce failover sha512_arm64 sha2_ce sha256_arm64 virtio_mmio
virtio_ring rtc_pl031 qemu_fw_cfg virtio fuse ip_tables x_tables ext4
mbcache crc16 jbd2 nvme nvme_core pci_host_generic pci_host_common
unix [last unloaded: zsmalloc]
[ 1298.149549][ T7004] CPU: 6 PID: 7004 Comm: zram-corruptor Tainted:
G        W         5.17.0-rc7-ivan #1
0b29b2552ab8a22d5ba4845528328b4b4bb50082
[ 1298.151293][ T7004] Hardware name: linux,dummy-virt (DT)
[ 1298.151826][ T7004] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[ 1298.152722][ T7004] pc : __zram_bvec_read+0x28c/0x2e8 [zram]
[ 1298.153501][ T7004] lr : zram_bvec_rw+0x70/0x214 [zram]
[ 1298.154597][ T7004] sp : ffffffc00aefbac0
[ 1298.155417][ T7004] x29: ffffffc00aefbae0 x28: ffffff9bc5770400
x27: ffffff9bc20da100
[ 1298.155838][ T7004] x26: ffffff9bc20da100 x25: 000000000000015a
x24: 00000001000f3aa7
[ 1298.156991][ T7004] x23: 000000000000015a x22: 0000000000000000
x21: fffffffe70cf5580
[ 1298.157718][ T7004] x20: 000000000000015a x19: ffffff9bcbbf3000
x18: ffffffc008755068
[ 1298.158907][ T7004] x17: 0000000000000008 x16: ffffffd7d92df0cc
x15: 0000000000000000
[ 1298.159705][ T7004] x14: 0000000000000000 x13: 00000000000000a0
x12: 0000000000000000
[ 1298.161758][ T7004] x11: 0000000000000000 x10: ffffffc0086fb000 x9
: 0000000001000000
[ 1298.162334][ T7004] x8 : 0000000000002070 x7 : 04f2046406c06e04 x6
: 4929b081d81d4b1b
[ 1298.163165][ T7004] x5 : 0000000000000000 x4 : 0000000000000000 x3
: 0000000000000000
[ 1298.163895][ T7004] x2 : 000000000000015a x1 : 000000000000015a x0
: ffffffd77fd576af
[ 1298.164830][ T7004] Call trace:
[ 1298.165153][ T7004]  __zram_bvec_read+0x28c/0x2e8 [zram
d8b02cd0fd062c13f68799e6d1953bf67d996403]
[ 1298.165900][ T7004]  zram_bvec_rw+0x70/0x214 [zram
d8b02cd0fd062c13f68799e6d1953bf67d996403]
[ 1298.166592][ T7004]  zram_rw_page+0xb4/0x170 [zram
d8b02cd0fd062c13f68799e6d1953bf67d996403]
[ 1298.167529][ T7004]  bdev_read_page+0x74/0xac
[ 1298.167823][ T7004]  swap_readpage+0x60/0x328
[ 1298.168317][ T7004]  do_swap_page+0x438/0x904
[ 1298.168841][ T7004]  handle_pte_fault+0xcc/0x1fc
[ 1298.169250][ T7004]  handle_mm_fault+0x284/0x4a8
[ 1298.169802][ T7004]  do_page_fault+0x274/0x428
[ 1298.170217][ T7004]  do_translation_fault+0x5c/0xf8
[ 1298.170650][ T7004]  do_mem_abort+0x50/0x100
[ 1298.171070][ T7004]  el0_da+0x3c/0x74
[ 1298.171422][ T7004]  el0t_64_sync_handler+0xc4/0xec
[ 1298.172102][ T7004]  el0t_64_sync+0x1a4/0x1a8
[ 1298.172773][ T7004] ---[ end trace 0000000000000000 ]---
[ 1298.173596][ T7004] zram: Page 346 read from zram without previous write
