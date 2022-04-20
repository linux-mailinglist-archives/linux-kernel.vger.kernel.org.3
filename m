Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D0508D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380754AbiDTQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380665AbiDTQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C9943EC6;
        Wed, 20 Apr 2022 09:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80ED761A5A;
        Wed, 20 Apr 2022 16:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4640C385A0;
        Wed, 20 Apr 2022 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650473203;
        bh=M/eh0tN0adhKymRZr8Sg04qzw3ToptEQdoWNVAjGWes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6w5Wosco2eQF0T3o3gv2Wdt+Fh5cOrvthXwclbS1+LtIjd9ELKM0x9yERkBeaAZ+
         lmdmYmKs9HE1tGDcJLyqBceuucKKslN5tDhZdHvrxL6PbYuxO5m6ed6TyUGbeQ4mTP
         5cr8Tg3GmLoQU6VK8f9Twv9LSb0VFv/WJd/nM4f2gdeEnxkc4jfY2wM+1cOwjCSBpP
         MpTj1goiLkEMnd0HpEoI8gIHJ3L9u/5vo/d4In2sfxec3pE1pjx8FAGdstmFakJeHr
         bv/BHU+ni2UzPOA/jhBNXulapVNkBxtgscBgnHki/08I+acpAGLtLNIjLBYLhO444d
         z9gUruoYILcWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4CF42400B1; Wed, 20 Apr 2022 13:46:41 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:46:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCHSET v4 next 0/3] perf stat: add user_time and system_time
 tool events
Message-ID: <YmA48V09iBbqy6su@kernel.org>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420102354.468173-1-florian.fischer@muhq.space>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 12:23:51PM +0200, Florian Fischer escreveu:
> This patch series adds new internal events to perf stat exposing the times spend
> in user and kernel mode in nanoseconds reported by rusage.
> 
> During some benchmarking using perf it bothered me that I could not easily
> retrieve those times from perf stat when using the machine readable output.
> 
> But perf definitely knows about those values because in the human readable output
> they are present.
> 
> Therefore I exposed the times reported by rusage via the new tool events:
> user_time and system_time.
> 
> This allows to retrieved them in machine-readable output:
> 
> $ ./perf stat -x, -e duration_time,user_time,system_time,cache-misses -- grep -q -r duration_time tools/perf
> 72134524,ns,duration_time:u,72134524,100.00,,
> 65225000,ns,user_time:u,65225000,100.00,,
> 6865000,ns,ssystem_time:u,6865000,100.00,,
> 38705,,cache-misses:u,71189328,100.00,,
> 
> The changes are mostly inspired by the code for the only other available
> tool event: 'duration_time'.
> 
> For now the new user_time and system_time events are not usable with metrics
> (as far as I understand).
> 
> The patch applies cleanly on linux-next/next-20220420.

I tested and applied the first two patches, please take a look at that
"OR" problem with patch 3.

- Arnaldo
 
> [PATCH v4 1/3] perf stat: introduce stats for the user and system
> [PATCH v4 2/3] perf stat: add user_time and system_time events
> [PATCH v4 3/3] perf list: print all available tool events
> 
> [v2]: Split up the changes into separate commits.
> 
> [v3]: * Use nanoseconds as suggested by Xing Zhengjun.
>       * Squash [PATCH v2 2/4] and [PATCH v2 4/4], because it only adds the unit string.
> 
> [v4]: * Simplify event names to only user_time and system_time as suggested by Ian Rogers.
> 
> Florian Fischer
