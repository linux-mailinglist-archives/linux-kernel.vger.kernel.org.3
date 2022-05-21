Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6652FEAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiEUR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiEUR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5362CCE;
        Sat, 21 May 2022 10:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0283CB80945;
        Sat, 21 May 2022 17:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81163C385AA;
        Sat, 21 May 2022 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653155877;
        bh=5YXBG9saoTJwEKPpCnRe7cC5YXg/DpUks9h0Nmo87EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alqoHpFMoD6y3AHyn2nZE0cCHoWAeN+FOj7PC9A5uRuaycY6dEBJiDrDUKBNl2jHu
         7MCDGimDLyq33znzbqPIulHB6NO0tqPkmcsZGQw5Ffmnerb9PSlKbEvWTGh2QXJkkU
         uW3v5n6qOrV6ISpWS1vEs78EaKV9tXy5daprNq8CxJt6VPbwU6g4kPMw3R+Hhs/5pj
         zRxgMVdJJLZ2hEJNrPfBzYcT1pXgR/jIkSN9/vEvmcfALGAj2UAuB9M4jZy0/Pe9Wt
         0kZfzHOHm5Um62LVrKnHKjhyQnA9OcY8+xaRX42PJpadLfgEh7D9kjUtNEwHUX1ydr
         lOZ3cMs/GjIpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60302400B1; Sat, 21 May 2022 14:57:54 -0300 (-03)
Date:   Sat, 21 May 2022 14:57:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Chengdong Li <brytonlee01@gmail.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, likexu@tencent.com,
        chengdongli@tencent.com
Subject: Re: [RESEND PATCH v2] perf tools: fix callstack entries and nr print
 message
Message-ID: <YokoIhhJc0yadqtF@kernel.org>
References: <Ynka4u+jCvFefgwJ@krava>
 <20220517015726.96131-1-chengdongli@tencent.com>
 <CAM9d7chhpuKkUOet1YqvTsR4cc8WHrLTkofjA_meFY9-D_a7Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chhpuKkUOet1YqvTsR4cc8WHrLTkofjA_meFY9-D_a7Mg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 17, 2022 at 04:14:49PM -0700, Namhyung Kim escreveu:
> On Mon, May 16, 2022 at 6:57 PM Chengdong Li <brytonlee01@gmail.com> wrote:
> > Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

