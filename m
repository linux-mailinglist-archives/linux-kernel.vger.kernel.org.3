Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E454E4740
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiCVUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiCVUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E5142EE2;
        Tue, 22 Mar 2022 13:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2AB0616B4;
        Tue, 22 Mar 2022 20:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14A2C340EC;
        Tue, 22 Mar 2022 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647979880;
        bh=cvZLjZSrlMWpzpNsliNWbCv6RnObT7KD71mdI7Ouk0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3YK1mzA7uy9itbbNhbMTkbuxlPamacpjzK9EMmZYVohrjKtrHkljfsKYA2aIhIV4
         nUh93fygLMFhTq9R5FS9rCRj0hTY0YTOjVBnNS1LROYIywEsmTjl/phIaXby9SL1iZ
         sVpNKHB56OysJmWozm0TU4ZlLndbzKGj0DBneErLgA4qc6vpChVbnst9NVy4JBomyY
         1iOr8gse8HboUGdejEeStUN1mP77fWXIVhK3Egs7jM1RhHc2dcgc8D72O2ATJ0gMYR
         kJqhKB/rfbj1OXnZdbyk1Lt22fh8LZ0JzPf7sDyW54plr6wmD8Z4KmyT8ou+Zo9Rac
         Tn2f80UxZb/Sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DA0D40407; Tue, 22 Mar 2022 17:11:16 -0300 (-03)
Date:   Tue, 22 Mar 2022 17:11:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: perf version issues
Message-ID: <YjotZExyiwhnX6ev@kernel.org>
References: <8a75f3b1-2b99-1233-3a70-070311b6ebc1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a75f3b1-2b99-1233-3a70-070311b6ebc1@huawei.com>
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

Re-adding lkml and Ian, Jiri, as I found some strange behaviour with
'git cherry-pick'.

Em Mon, Mar 21, 2022 at 08:43:26AM +0000, John Garry escreveu:
> Hi Arnaldo,
> 
> I have been finding that during my development that the output from "perf
> -v" may be incorrect in certain circumstances. I sent some patches to fix it
> up:
> https://lore.kernel.org/linux-perf-users/1645449409-158238-1-git-send-email-john.garry@huawei.com/T/#mf7234d2e331a53370c148eb4a0633d405a5c6832
> 
> Is there some issue that these cannot be processed?

So, while testing it I noticed that if we use 'git cherry-pick' it
doesn't trigger a rebuild, even having a new head :-\

I.e. with the two patches in at the HEAD, try:

  $ git log --oneline -2
  cb66befccba18fac (HEAD -> perf/core) perf tools: Fix version kernel tag
  4e666cdb06eede20 perf tools: Fix dependency for version file creation
  $ make -C tools/perf O=/tmp/build/perf install-bin
  $ perf -v
  perf version 5.17.rc8.gcb66befccba1

Ok so far, now lets remove HEAD and leave just the first patch, that has
the ORIG_HEAD dependency to trigger a rebuild:

  $ git reset --hard HEAD~
  HEAD is now at 4e666cdb06eede20 perf tools: Fix dependency for version file creation
  $ make -C tools/perf O=/tmp/build/perf install-bin
  $ perf -v
  perf version 5.17.rc8.g4e666cdb06ee

Ok, detected and rebuilt, perf -v works as expected.

Now lets try cherry picking your second patch:

$ git cherry-pick cb66befccba18fac
  [perf/core 8ff6a6c06a90a362] perf tools: Fix version kernel tag
   Author: John Garry <john.garry@huawei.com>
   Date: Mon Feb 21 21:16:49 2022 +0800
   1 file changed, 4 insertions(+), 9 deletions(-)
  $ make -C tools/perf O=/tmp/build/perf install-bin
  $ perf -v
  perf version 5.17.rc8.g4e666cdb06ee

Now it doesn´t notice it and there is no automatic rebuild triggered, we
stay with the cset from before the cherry-pick :-\

$ git log --oneline -2
8ff6a6c06a90a362 (HEAD -> perf/core) perf tools: Fix version kernel tag
4e666cdb06eede20 perf tools: Fix dependency for version file creation
$

Anyway, your patch works for some cases, so its an improvement and I'll
apply it, we can continue from there.

- Arnaldo
