Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607054DDBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiCROcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiCROcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:32:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B25C64F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7646B823DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 14:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91AFC340E8;
        Fri, 18 Mar 2022 14:30:47 +0000 (UTC)
Date:   Fri, 18 Mar 2022 14:30:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        yee.lee@mediatek.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mm/kmemleak: Reset tag when compare object pointer
Message-ID: <YjSXkyq6icIFx4GS@arm.com>
References: <20220318034051.30687-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318034051.30687-1-Kuan-Ying.Lee@mediatek.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:40:48AM +0800, Kuan-Ying Lee wrote:
> When we use HW-tag based kasan and enable vmalloc support, we hit
> the following bug. It is due to comparison between tagged object
> and non-tagged pointer.
> 
> We need to reset the kasan tag when we need to compare tagged object
> and non-tagged pointer.
> 
> [    7.690429][T400001] init: kmemleak: [name:kmemleak&]Scan area larger than object 0xffffffe77076f440
> [    7.691762][T400001] init: CPU: 4 PID: 1 Comm: init Tainted: G S      W         5.15.25-android13-0-g5cacf919c2bc #1
> [    7.693218][T400001] init: Hardware name: MT6983(ENG) (DT)
> [    7.693983][T400001] init: Call trace:
> [    7.694508][T400001] init:  dump_backtrace.cfi_jt+0x0/0x8
> [    7.695272][T400001] init:  dump_stack_lvl+0xac/0x120
> [    7.695985][T400001] init:  add_scan_area+0xc4/0x244
> [    7.696685][T400001] init:  kmemleak_scan_area+0x40/0x9c
> [    7.697428][T400001] init:  layout_and_allocate+0x1e8/0x288
> [    7.698211][T400001] init:  load_module+0x2c8/0xf00
> [    7.698895][T400001] init:  __se_sys_finit_module+0x190/0x1d0
> [    7.699701][T400001] init:  __arm64_sys_finit_module+0x20/0x30
> [    7.700517][T400001] init:  invoke_syscall+0x60/0x170
> [    7.701225][T400001] init:  el0_svc_common+0xc8/0x114
> [    7.701933][T400001] init:  do_el0_svc+0x28/0xa0
> [    7.702580][T400001] init:  el0_svc+0x60/0xf8
> [    7.703196][T400001] init:  el0t_64_sync_handler+0x88/0xec
> [    7.703964][T400001] init:  el0t_64_sync+0x1b4/0x1b8
> [    7.704658][T400001] init: kmemleak: [name:kmemleak&]Object 0xf5ffffe77076b000 (size 32768):
> [    7.705824][T400001] init: kmemleak: [name:kmemleak&]  comm "init", pid 1, jiffies 4294894197
> [    7.707002][T400001] init: kmemleak: [name:kmemleak&]  min_count = 0
> [    7.707886][T400001] init: kmemleak: [name:kmemleak&]  count = 0
> [    7.708718][T400001] init: kmemleak: [name:kmemleak&]  flags = 0x1
> [    7.709574][T400001] init: kmemleak: [name:kmemleak&]  checksum = 0
> [    7.710440][T400001] init: kmemleak: [name:kmemleak&]  backtrace:
> [    7.711284][T400001] init:      module_alloc+0x9c/0x120
> [    7.712015][T400001] init:      move_module+0x34/0x19c
> [    7.712735][T400001] init:      layout_and_allocate+0x1c4/0x288
> [    7.713561][T400001] init:      load_module+0x2c8/0xf00
> [    7.714291][T400001] init:      __se_sys_finit_module+0x190/0x1d0
> [    7.715142][T400001] init:      __arm64_sys_finit_module+0x20/0x30
> [    7.716004][T400001] init:      invoke_syscall+0x60/0x170
> [    7.716758][T400001] init:      el0_svc_common+0xc8/0x114
> [    7.717512][T400001] init:      do_el0_svc+0x28/0xa0
> [    7.718207][T400001] init:      el0_svc+0x60/0xf8
> [    7.718869][T400001] init:      el0t_64_sync_handler+0x88/0xec
> [    7.719683][T400001] init:      el0t_64_sync+0x1b4/0x1b8
> 
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
