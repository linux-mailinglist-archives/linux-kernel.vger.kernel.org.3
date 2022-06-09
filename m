Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB9544FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiFIOph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiFIOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:45:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723C286FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:45:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJn286JLLz4xD5;
        Fri, 10 Jun 2022 00:45:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     catalin.marinas@arm.com, keescook@chromium.org, mpe@ellerman.id.au,
        He Ying <heying24@huawei.com>, npiggin@gmail.com,
        peterz@infradead.org, christophe.leroy@csgroup.eu,
        benh@kernel.crashing.org, paulus@samba.org, sxwjean@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, chenjingwen6@huawei.com,
        huwanming@huaweil.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220121014418.155675-1-heying24@huawei.com>
References: <20220119015025.136902-1-heying24@huawei.com> <20220121014418.155675-1-heying24@huawei.com>
Subject: Re: [PATCH -v2] powerpc/process, kasan: Silence KASAN warnings in __get_wchan()
Message-Id: <165478587162.589231.6430852932301326942.b4-ty@ellerman.id.au>
Date:   Fri, 10 Jun 2022 00:44:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 20:44:18 -0500, He Ying wrote:
> The following KASAN warning was reported in our kernel.
> 
>   BUG: KASAN: stack-out-of-bounds in get_wchan+0x188/0x250
>   Read of size 4 at addr d216f958 by task ps/14437
> 
>   CPU: 3 PID: 14437 Comm: ps Tainted: G           O      5.10.0 #1
>   Call Trace:
>   [daa63858] [c0654348] dump_stack+0x9c/0xe4 (unreliable)
>   [daa63888] [c035cf0c] print_address_description.constprop.3+0x8c/0x570
>   [daa63908] [c035d6bc] kasan_report+0x1ac/0x218
>   [daa63948] [c00496e8] get_wchan+0x188/0x250
>   [daa63978] [c0461ec8] do_task_stat+0xce8/0xe60
>   [daa63b98] [c0455ac8] proc_single_show+0x98/0x170
>   [daa63bc8] [c03cab8c] seq_read_iter+0x1ec/0x900
>   [daa63c38] [c03cb47c] seq_read+0x1dc/0x290
>   [daa63d68] [c037fc94] vfs_read+0x164/0x510
>   [daa63ea8] [c03808e4] ksys_read+0x144/0x1d0
>   [daa63f38] [c005b1dc] ret_from_syscall+0x0/0x38
>   --- interrupt: c00 at 0x8fa8f4
>       LR = 0x8fa8cc
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/process, kasan: Silence KASAN warnings in __get_wchan()
      https://git.kernel.org/powerpc/c/a1b29ba2f2c171b9bea73be993bfdf0a62d37d15

cheers
