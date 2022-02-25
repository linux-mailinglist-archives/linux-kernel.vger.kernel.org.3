Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825774C45B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiBYNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBYNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0139181E5A;
        Fri, 25 Feb 2022 05:15:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 482B21F380;
        Fri, 25 Feb 2022 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645794949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PmNIIM3gpZH3rKjV9RV8YeTjUMiihTOkooMrV/E9GyM=;
        b=ZSrW6K79vK/zTZhgRs6T7UlP4hs6EUqsHsiSUV/My/ujlxqJ316FZPZVfSn/2Mnqf4GaUM
        wT5ysHhyfe82zyDrREof/bqZqIM4PWuXHAYmjrRQqwBy2PFrvNMRePKzBEG2uXwyibPu7R
        UMh+UPy5ffqL0H6S/rd2bXklgMFI368=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A46FFA3B83;
        Fri, 25 Feb 2022 13:15:48 +0000 (UTC)
Date:   Fri, 25 Feb 2022 14:15:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, davem@davemloft.net,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sumit.garg@linaro.org,
        kernelfans@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH 3/5] kernel/watchdog_hld: Ensure CPU-bound context when
 creating hardlockup detector event
Message-ID: <YhjWhCoZelIhBMyS@alley>
References: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
 <20220212104349.14266-4-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212104349.14266-4-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-02-12 18:43:47, Lecopzer Chen wrote:
> From: Pingfan Liu <kernelfans@gmail.com>
> 
> from: Pingfan Liu <kernelfans@gmail.com>
> 
> hardlockup_detector_event_create() should create perf_event on the
> current CPU. Preemption could not get disabled because
> perf_event_create_kernel_counter() allocates memory. Instead,
> the CPU locality is achieved by processing the code in a per-CPU
> bound kthread.
> 
> Add a check to prevent mistakes when calling the code in another
> code path.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Co-developed-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
