Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30351398C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiD1QUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiD1QUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:20:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8FB29CB6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E0FEB82EAA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F3C385A0;
        Thu, 28 Apr 2022 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651162607;
        bh=5l1zZFYXR3nbgSWYb9fM49V2g+NgWbrT93chhaME8H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MufhC7j/PfpGGL27LjgUN/RXItVTwHtDZ8qLbKQ30b4mc4cp/bCap/tEssknLBO0q
         LZEj3e6jCLSaUb2nLqA4TSDyEq5LHhNcZLEf99YMHMPZVgw11H/zAtnUuMhXT1kgiG
         wEdOddhuE7t77Y55tbnNWDEi4v21tznaPbPPAe0LY269Yn71Vn+r3S3AciZnDsSiw3
         aAaLLeOZbHYNLVrKktdSYkt/0OU9q+/GN6ge4JmGaqM/7h2wu58yHhvrqezSZQPAYL
         ijt132vobtnjIYH0yllMH5Hmruzg3rNyI71P0eY2DBpsSSJK9rPykjw2l475Xay0QH
         j3CxJBbuwiRMw==
From:   sj@kernel.org
To:     Barry Song <21cnbao@gmail.com>
Cc:     sj@kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        "Shakeel Butt" <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, "Song Jiang" <sjiang88@gmail.com>,
        =?UTF-8?q?=E5=BC=A0=E8=AF=97=E6=98=8E=28Simon=20Zhang=29?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?q?=E6=9D=8E=E5=9F=B9=E9=94=8B=28wink=29?= 
        <lipeifeng@oppo.com>, linux-damon@amazon.com
Subject: Re: DAMON VA regions don't split on an large Android APP
Date:   Thu, 28 Apr 2022 16:16:44 +0000
Message-Id: <20220428161644.84921-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4y==XhrG9mNnLV_s1UovpsUsHGjTAvEK-XDJTy_L7AvDA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 13:27:59 +1200 Barry Song <21cnbao@gmail.com> wrote:

[...]
> 
> Thanks for the clarification.
> 
> i hardcoded min_nr_regions to 200 by:
> diff --git a/_damon.py b/_damon.py
> index 1306ea1..82342a5 100644
> --- a/_damon.py
> +++ b/_damon.py
> @@ -344,7 +344,7 @@ def set_attrs_argparser(parser):
>      parser.add_argument('-u', '--updr', metavar='<interval>', type=int,
>              default=1000000, help='regions update interval (us)')
>      parser.add_argument('-n', '--minr', metavar='<# regions>', type=int,
> -            default=10, help='minimal number of regions')
> +            default=200, help='minimal number of regions')
>      parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
>              default=1000, help='maximum number of regions')
> 
> 
> Now wss seems to make more senses:
> 
> ~/damo # ./damo monitor --report_type=wss --count=20 2551
> # <percentile> <wss>
> # target_id 0
> # avr: 235.394 MiB
>   0             0 B |
>          |
>  25       2.164 MiB |
>          |
>  50     129.875 MiB |*********
>          |
>  75     430.547 MiB |******************************
>          |
> 100     844.238 MiB
> |***********************************************************|
> 
> # <percentile> <wss>
> # target_id 0
> # avr: 352.501 MiB
>   0       8.781 MiB |
[...]
>          |
> 100     664.480 MiB
> |***********************************************************|
> 
> Regions are like:
> 
> monitoring_start:             2.250 s
> monitoring_end:               2.350 s
> monitoring_duration:       100.425 ms
> target_id: 0
> nr_regions: 488
> 000012c00000-00002c14a000( 405.289 MiB): 0
> 00002c14a000-000044f05000( 397.730 MiB): 0
> 000044f05000-00005d106000( 386.004 MiB): 0
> 00005d106000-0000765f9000( 404.949 MiB): 0
> 0000765f9000-0000867b8000( 257.746 MiB): 0
> 0000867b8000-00009fb18000( 403.375 MiB): 0
[...]
> 007f74a66000-007f8caaf000( 384.285 MiB): 0
> 007f8caaf000-007fa423b000( 375.547 MiB): 0
> 007fa423b000-007fb9fb6000( 349.480 MiB): 0
> 007fb9fb6000-007fd29ae000( 393.969 MiB): 0
> 007fd29ae000-007fdbd6e000( 147.750 MiB): 0
> 
> Though I am not quite sure if it is accurate enough :-) so fixed-gran would be
> a nice feature.

Totally agreed.  Thank you for making your voice!  I will use this for
re-prioritizing my TODO list items.

[...]
> > >
> > > And I have a question, what do percentile 0,25,50,75 mean here?
> > > Why are they so different with percentile 100?
> > > For example, 0,25,50,75 has only KiB but 100 has GiB.
> >
> > For each aggregation interval, we get one snapshot.  So, if we have a
> > monitoring results that recorded for, say, 100 aggregation interval, we have
> > 100 snapshots.  'damo' calculates working set size of each snapshot by summing
> > size of regions assumed to be accessed at least once.  So, in this example, we
> > get 100 wss values.  Then, 'damo' sorts the values and provides the smallest
> > one as 0-th percentile, 25th small value as 25-th percentile, and so on.
> >
> > 100-th percentile wss is usually noisy, as DAMON regions shouldn't be converged
> > well at the beginning of the record.  I believe that could be the reason why
> > the 100-th percentile wss is so unexpectedly big.
> >
> > I personally use 50-th percentile as reliable value.
> 
> Thanks, it seems you mean if we get 100 snapshots with values exactly as
> 2, 4, 6, 8, 10..... , 198, 200 (just an example)
> 
> for 25%, we will get 50; for 50%, we will get 100; for 75%, we will
> get 150, for 100%,
> we will get 200. Right?

You're perfectly understanding my point.

> 
> I am not quite sure I understand "as DAMON regions shouldn't be converged well
> at the beginning of the record", in case we are monitoring with
> --count=2000, I suppose
> only at the beginning, regions are not splitted very well? When we
> have run monitor
> for a while, regions should have been relatively stable? I mean I
> don't quite understand
> why 100% is noise and 50% is more reliable.

'damo monitor' simply repeats 'damo record' and 'damo report'.  That is, it
starts recording, stop recording, reporting, and repeat.  Therefore every 'damo
moitor' results are fresh ones, not a snapshot of ongoing record.  Therefore
regions converge from the beginning for every 'damo monitor' output.  Sorry for
the ugly implementation.  It should be improved in a near future.


Thanks,
SJ

[...]
