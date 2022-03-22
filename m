Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95504E47B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiCVUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiCVUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:44:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3309DEBF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3281EB81D02
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A39C340EC;
        Tue, 22 Mar 2022 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647981780;
        bh=79qffZlvQw65hd/UIIF1NQPthcGMEn4m9eg+9BsTt9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSWhjAqh8VVOIkp5OdZM/wDjc+TSeF7LFdEbab5WuPS9OebpRwRTM2Lje3VGTHyti
         j+52ndutbDhMR3BBOj8mkqCWB7RbXMYGjViMKeC3Mts1krCM96e4npn7Y32SlVu6fS
         HJ09D1jIcaV6eDIVyUtvbmfnEiHJZ9KlHeWk/FEt07TP+XFhPCF7/OQEs2EO6EuwaW
         mml2G4FgxxBBNxk0hWfdS4kvCmjttBYBcV5LPIlmwdXJNxohHWi+HZkGwuUbIIwgVd
         gZacmGBlOLiX8VrH0Nv1jf9TchK3fwH+mtw/Yzr0E8qntwtcjKtBuMrcLBpicKrnyA
         W4a0hEcQ0ZyHA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C166740407; Tue, 22 Mar 2022 17:42:57 -0300 (-03)
Date:   Tue, 22 Mar 2022 17:42:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2] perf ftrace: Add -n/--use-nsec option for latency
Message-ID: <Yjo00URy0mhUnNxL@kernel.org>
References: <20220321234609.90455-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321234609.90455-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 21, 2022 at 04:46:08PM -0700, Namhyung Kim escreveu:
> Sometimes we want to see nano-second granularity.
> 
>   $ sudo perf ftrace latency -T dput -a -n sleep 1
>   #   DURATION     |      COUNT | GRAPH                          |
>        0 - 1    us |          0 |                                |
>        1 - 2    ns |          0 |                                |
>        2 - 4    ns |          0 |                                |
>        4 - 8    ns |          0 |                                |
>        8 - 16   ns |          0 |                                |
>       16 - 32   ns |          0 |                                |
>       32 - 64   ns |          0 |                                |
>       64 - 128  ns |    1163434 | ##############                 |
>      128 - 256  ns |     914102 | #############                  |
>      256 - 512  ns |        884 |                                |
>      512 - 1024 ns |        613 |                                |
>        1 - 2    us |         31 |                                |
>        2 - 4    us |         17 |                                |
>        4 - 8    us |          7 |                                |
>        8 - 16   us |        123 |                                |


Thanks, applied.

- Arnaldo

