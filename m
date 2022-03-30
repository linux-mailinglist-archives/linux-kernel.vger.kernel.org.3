Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D76D4EC685
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbiC3OaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiC3OaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:30:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DE21A8AB;
        Wed, 30 Mar 2022 07:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0772AB81C27;
        Wed, 30 Mar 2022 14:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914C3C340EE;
        Wed, 30 Mar 2022 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648650495;
        bh=nBQCGjHpmHKz3RcAjdWlqG2gxS0A7cg8PBmobx5wSzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kr75YnSo/0og7hHPfkz3vrNLvnEcAH0dLgJKmzSczX7tK11FOIvt+DA8mdwPA8Jut
         1VieXPRRdmo6j3R82pE8MxuAdxiNoIQUbRJcqZeIAdipUblXKE5eu/KM515xVptm+t
         /UJDn99v2Xv89vvABLIseUrgnQWmf7AKOrOd/9+WjeoHIB82CZ0OnZU2baOgnxR5M/
         YileiOIKNTSQnqbFGoG52aOYcoDWZmDToDz678Jqo/cKDoUlpf0argxbtsqetMT3iw
         fsFuvAa4aFbf2lTuZrWXt978ft2uMqEXZjQsVVYJ4LWRCTC8ZaCmOVPS1o1mi8hxmX
         j50oJzg/VBDlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3331A40407; Wed, 30 Mar 2022 11:28:12 -0300 (-03)
Date:   Wed, 30 Mar 2022 11:28:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Message-ID: <YkRo/PtIf9aOqpZV@kernel.org>
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
 <YkRlZhaEgmJ5Q4k/@kernel.org>
 <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634d9682-dc78-e09a-865c-9eed28aee667@tessares.net>
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

Em Wed, Mar 30, 2022 at 04:22:35PM +0200, Matthieu Baerts escreveu:
> Hi Arnaldo,
> 
> On 30/03/2022 16:12, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 30, 2022 at 03:22:37PM +0200, Matthieu Baerts escreveu:
> >> Hi John,
> >>
> >> On 30/03/2022 12:22, John Garry wrote:
> >>> This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
> >>> and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.
> >>>
> >>> In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
> >>> re-make"), a makefile dependency on .git/HEAD was added. The background is
> >>> that running PERF-VERSION-FILE is relatively slow, and commands like
> >>> "git describe" are particularly slow.
> >>>
> >>> In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
> >>> creation"), an additional dependency on .git/ORIG_HEAD was added, as
> >>> .git/HEAD may not change for "git reset --hard HEAD^" command. However,
> >>> depending on whether we're on a branch or not, a "git cherry-pick" may
> >>> not lead to the version being updated.
> >>>
> >>> As discussed with the git community in [0], using git internal files for
> >>> dependencies is not reliable. Commit 4e666cdb06ee also breaks some build
> >>> scenarios [1].
> >>>
> >>> As mentioned, c72e3f04b45f was added to speed up the build. However in
> >>> commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed the
> >>> call to "git describe", so just revert Makefile.perf back to same as pre
> >>> c72e3f04b45f and the build should not be so slow, as below:
> >>>
> >>> Pre 7572733b8499:
> >>> $> time util/PERF-VERSION-GEN
> >>>   PERF_VERSION = 5.17.rc8.g4e666cdb06ee
> >>>
> >>> real    0m0.110s
> >>> user    0m0.091s
> >>> sys     0m0.019s
> >>>
> >>> Post 7572733b8499:
> >>> $> time util/PERF-VERSION-GEN
> >>>   PERF_VERSION = 5.17.rc8.g7572733b8499
> >>>
> >>> real    0m0.039s
> >>> user    0m0.036s
> >>> sys     0m0.007s
> >>>
> >>> [0] https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
> >>> [1] https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u
> >>>
> >>> Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
> >>> Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>> Signed-off-by: John Garry <john.garry@huawei.com>
> >>
> >> Thank you for your patch, I just tested it and it also fixes the issue I
> >> reported!
> > 
> > I'm taking this as a:
> > 
> > Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > 
> > Ok?
> 
> Yes, OK for me, thank you!
> 
> I never know what maintainers prefer when there is already a
> "Reported-by" tag so I didn't specify it but I will do next time.

Right, I'll stick both R-by and T-by.

There are cases where people just report and don't test, or just ack.

- Arnaldo
