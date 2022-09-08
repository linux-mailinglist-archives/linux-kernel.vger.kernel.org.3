Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD295B2596
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiIHSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiIHSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:23:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B56F2967;
        Thu,  8 Sep 2022 11:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E96AB821E1;
        Thu,  8 Sep 2022 18:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AE4C433D6;
        Thu,  8 Sep 2022 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662661391;
        bh=veGfQcuXT/TZaz1MGKphv5ehLEA9QrpIEJJIWFyMTPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3kDBIOG4XjlB/QyzJBTb74S8Mt25ig2TjV9jtaQONJripVaVwskU5AJv4Q9iSxod
         7vjwpkrp0EeYEoyJlNA9fT6717cjQ3PJTX/vyZDyyg5tjvt9FPHvgSvMwFgkLnh+nZ
         0hUPOAKHNQvoK1FDgnh2HNwJiIqtcS5bebknkfNORmZXSSasUc7DZX2lfDZbmdAFJe
         TjH5RXkbk5iLCfkXEusDhZQLMH+kfjA7ZDbcBqE6BVit/nsf3t4eGR7ObfwUzAC9zS
         jbTwWf9GIyGNQud3n9sFyw9BW+9UEylaohHCBmEy53S2VNhSzrk7yQoWGgxFzdLYIs
         8CP/q7fbIZvyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1916404A1; Thu,  8 Sep 2022 15:23:07 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:23:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] perf: Clean up by adding helpers
Message-ID: <YxozC0P1gdKkLqP+@kernel.org>
References: <20220908021141.27134-1-shangxiaojing@huawei.com>
 <CAM9d7cgOVSohQ6cLnPc3QJZ9aus_pq8xjiRf8WRy8WOuaogoTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgOVSohQ6cLnPc3QJZ9aus_pq8xjiRf8WRy8WOuaogoTQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 08, 2022 at 12:08:06AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Sep 7, 2022 at 6:37 PM Shang XiaoJing <shangxiaojing@huawei.com> wrote:
> >
> > Some clean up in builtin-lock.c, builtin-timechart.c, and
> > builtin-trace.c.
> >
> > Shang XiaoJing (4):
> >   perf trace: Use zalloc to save initialization of syscall_stats
> >   perf lock: Add get_key_by_aggr_mode helper
> >   perf timechart: Add create_pidcomm helper
> >   perf timechart: Add p_state_end helper
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> >
> >  tools/perf/builtin-lock.c      | 129 ++++++++++++++-------------------
> >  tools/perf/builtin-timechart.c |  65 +++++++++--------
> >  tools/perf/builtin-trace.c     |   5 +-
> >  3 files changed, 88 insertions(+), 111 deletions(-)
> >
> > --
> > 2.17.1
> >

-- 

- Arnaldo
