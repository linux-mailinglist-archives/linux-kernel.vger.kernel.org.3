Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03CA4D6F59
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiCLN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F135ECC56;
        Sat, 12 Mar 2022 05:55:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01AF360C1F;
        Sat, 12 Mar 2022 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCD7C340EB;
        Sat, 12 Mar 2022 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647093300;
        bh=TghPhgKyHcNCjr1VOkt+QHNFrI1ynMBVDbgZcDen3jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PT697Y42+cFRDGafYgs29QGueDdpoLjQUloPnz1x0n5ZaT7G4kp008eAbvdtTk7GN
         vw4dEOp2ja5cFXghYizRc+xNsHIt+CY4osJ0uL3R8krmW4dl9J1EIPQ6agO+4FDKaf
         7rjqk8PxOynoOJ1Xwjf46GMWXrTDGAzpuc2t/d1AHGkVDWxVKWhRlg9/h1luTiCkTn
         vMIy1ZlPcKVKC5gBB/6Ge0PjdSdnDRMAzbCschfoywrNcpIjio/76iY6fS2D6UaEDY
         +VxWwtn+qg+Z17NUXcwUUkUprye+Tdgs7kdGnd+BkDwj/G6N/NG98f1Ouge4C4Aao+
         bI1jw+PC9FRyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8C48403C8; Sat, 12 Mar 2022 10:54:57 -0300 (-03)
Date:   Sat, 12 Mar 2022 10:54:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     zhengjun.xing@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf parse: Fix event parser error for hybrid systems
Message-ID: <YiymMXe5Wdj9rJzP@kernel.org>
References: <20220307151627.30049-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307151627.30049-1-zhengjun.xing@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 07, 2022 at 11:16:27PM +0800, zhengjun.xing@linux.intel.com escreveu:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> This bug happened on hybrid systems when both cpu_core and cpu_atom
> have the same event name such as "UOPS_RETIRED.MS" while their event
> terms are different, then during perf stat, the event for cpu_atom
> will parse fail and then no output for cpu_atom.
> 
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/
> 
> It is because event terms in the "head" of parse_events_multi_pmu_add
> will be changed to event terms for cpu_core after parsing UOPS_RETIRED.MS
> for cpu_core, then when parsing the same event for cpu_atom, it still
> uses the event terms for cpu_core, but event terms for cpu_atom are
> different with cpu_core, the event parses for cpu_atom will fail. This
> patch fixes it, the event terms should be parsed from the original
> event.
> 
> This patch can work for the hybrid systems that have the same event
> in more than 2 PMUs. It also can work in non-hybrid systems.
> 
> Before:
> 
>  #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1
> 
> Using CPUID GenuineIntel-6-97-1
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> Control descriptor is not initialized
> UOPS_RETIRED.MS: 2737845 16068518485 16068518485
> 
>  Performance counter stats for 'system wide':
> 
>          2,737,845      cpu_core/UOPS_RETIRED.MS/
> 
>        1.002553850 seconds time elapsed
> 
> After:
> 
>  #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1
> 
> Using CPUID GenuineIntel-6-97-1
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/
> Control descriptor is not initialized
> UOPS_RETIRED.MS: 1977555 16076950711 16076950711
> UOPS_RETIRED.MS: 568684 8038694234 8038694234

Thanks, applied.

- Arnaldo

