Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9D4EC9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbiC3Qc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiC3QcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6F8FE50;
        Wed, 30 Mar 2022 09:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BA37617BA;
        Wed, 30 Mar 2022 16:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EC8C340EC;
        Wed, 30 Mar 2022 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648657836;
        bh=RwqKhALbZw7kM470uBSAPj0GSjtJqer8dpkOKdJPKm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTfF8lmdntzIFyAETQFu2E2qjdcdsy4Sg64PBAihOHG40c6cQ01FwSqvmcwGDUrSt
         ghABEDHcIogV/nsnJxBmRqiLhKK4f6SGgspEHhyFqGRiFyBtrgfbEGsXQGICTGvD5n
         n6q5qrSaxNIhiJSmMnGhbBG5K4xru5xHK8wdBRWTuzNA3gFaH/smqC5Uu1ad/onWjU
         MqCPW64bQ2lQ/Zp/KYXyQ16jY2T1adKV1OPfrT0yykloVcJRqWSmWO3jMipiO+4Pgh
         cvec+nNXlUQDnbLu+dXOlVntaPtrRWRGRnC9pdoUfVxfnYT9D9ViSOPWjKpQT1InXi
         9X810LWzvkaVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A25A40407; Wed, 30 Mar 2022 13:30:33 -0300 (-03)
Date:   Wed, 30 Mar 2022 13:30:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Stop depending on .git files for building
 PERF-VERSION-FILE
Message-ID: <YkSFqYboG+PpoqHp@kernel.org>
References: <1648635774-14581-1-git-send-email-john.garry@huawei.com>
 <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a72702f-6cf9-2b6e-0f9c-bf6857ab7ed2@tessares.net>
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

Em Wed, Mar 30, 2022 at 03:22:37PM +0200, Matthieu Baerts escreveu:
> Hi John,
> 
> On 30/03/2022 12:22, John Garry wrote:
> > This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
> > and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.
> > 
> > In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
> > re-make"), a makefile dependency on .git/HEAD was added. The background is
> > that running PERF-VERSION-FILE is relatively slow, and commands like
> > "git describe" are particularly slow.
> > 
> > In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
> > creation"), an additional dependency on .git/ORIG_HEAD was added, as
> > .git/HEAD may not change for "git reset --hard HEAD^" command. However,
> > depending on whether we're on a branch or not, a "git cherry-pick" may
> > not lead to the version being updated.
> > 
> > As discussed with the git community in [0], using git internal files for
> > dependencies is not reliable. Commit 4e666cdb06ee also breaks some build
> > scenarios [1].
> > 
> > As mentioned, c72e3f04b45f was added to speed up the build. However in
> > commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed the
> > call to "git describe", so just revert Makefile.perf back to same as pre
> > c72e3f04b45f and the build should not be so slow, as below:
> > 
> > Pre 7572733b8499:
> > $> time util/PERF-VERSION-GEN
> >   PERF_VERSION = 5.17.rc8.g4e666cdb06ee
> > 
> > real    0m0.110s
> > user    0m0.091s
> > sys     0m0.019s
> > 
> > Post 7572733b8499:
> > $> time util/PERF-VERSION-GEN
> >   PERF_VERSION = 5.17.rc8.g7572733b8499
> > 
> > real    0m0.039s
> > user    0m0.036s
> > sys     0m0.007s
> > 
> > [0] https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
> > [1] https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u
> > 
> > Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
> > Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Thank you for your patch, I just tested it and it also fixes the issue I

Thanks, applied.

And added this "Committer testing" section:

-----
    Committer testing:

    After a fresh rebuild using 'make -C tools/perf O=/tmp/build/perf install-bin':

      $ perf -v
      perf version 5.17.g162f9db407b6
      $ git log --oneline -1
      162f9db407b6a6e5 (HEAD -> perf/core) perf tools: Stop depending on .git files for building PERF-VERSION-FILE
      $

    Now using a detached tarball, i.e. outside the kernel source tree:

      $ ls -la perf*tar
      ls: cannot access 'perf*tar': No such file or directory
      $ make perf-tar-src-pkg
        TAR
        PERF_VERSION = 5.17.g31d10b3ef133
      $ ls -la perf*tar
      -rw-r--r--. 1 acme acme 22241280 Mar 30 13:26 perf-5.17.0.tar
      $ mv perf-5.17.0.tar /tmp
      $ cd /tmp
      $ tar xf perf-5.17.0.tar
      $ cd perf-5.17.0/
      $ make -C tools/perf |& tail
        CC      util/pmu.o
        CC      util/pmu-flex.o
        CC      util/expr-flex.o
        CC      util/expr.o
        LD      util/scripting-engines/perf-in.o
        LD      util/intel-pt-decoder/perf-in.o
        LD      util/perf-in.o
        LD      perf-in.o
        LINK    perf
      make: Leaving directory '/tmp/perf-5.17.0/tools/perf'
      $ tools/perf/perf -v
      perf version 5.17.g31d10b3ef133
      $ pwd
      /tmp/perf-5.17.0
      $ cat PERF-VERSION-FILE
      #define PERF_VERSION "5.17.g31d10b3ef133"
      $

-----
