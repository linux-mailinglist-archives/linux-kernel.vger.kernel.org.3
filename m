Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494E74EAB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiC2KeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiC2Kd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:33:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240432B191;
        Tue, 29 Mar 2022 03:32:15 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KSQmN2F6yz67bH2;
        Tue, 29 Mar 2022 18:29:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 29 Mar 2022 12:32:12 +0200
Received: from [10.47.83.59] (10.47.83.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:32:11 +0100
Message-ID: <e9969b97-3998-d7b2-9fd2-77ddd27969ef@huawei.com>
Date:   Tue, 29 Mar 2022 11:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <mptcp@lists.linux.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.59]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2022 10:31, Matthieu Baerts wrote:

Hi Matthieu,

Sorry for the breakage.

About 4e666cdb06ee, I have since discussed this topic with the git 
community and they think it is unreliable to use any git internal file 
as a depenency, as mentioned here:
https://lore.kernel.org/linux-perf-users/85891cbd-e53c-89ac-6da2-40b5d56cd316@huawei.com/T/#t

So I am not sure if it's better to fix that or just effectively back it 
out with a (hopefully) proper fix.

> It seems it cannot be assumed .git/ORIG_HEAD exists if .git/HEAD is
> there.
> 
> Indeed, recently our public CI reported[1] the following error when
> compiling Perf tool:
> 
>    $ cd tools/perf
>    $ make -j4 -l4 O=/tmp/(...)/perf DESTDIR=/usr install
>    (...)
>    make[2]: *** No rule to make target '../../.git/ORIG_HEAD', needed by '/tmp/(...)/perf/PERF-VERSION-FILE'.
> 
> This is because apparently[2] Cirrus Ci uses a Git client implemented
> purely in Go[3] to perform a clone. Most likely, this tool doesn't
> create any .git/ORIG_HEAD file but .git/HEAD is there. The error can
> indeed be reproduced by renaming this .git/ORIG_HEAD file while keeping
> .git/HEAD. In other words, it means it is not enough to check the
> presence of .git/HEAD to assume .git/ORIG_HEAD exists as well.
> 
> With the modification here, the version file is always regenerated if
> .git/ORIG_HEAD file is not present. But that is not an issue as kernel
> devs probably don't use such tools in their dev env and it can be
> assumed for them that they have both .git/HEAD and .git/ORIG_HEAD files.

right

Could you please try this:

---->8------


 From 694964709a7fc2b46c995bb7b1967cc6b129def8 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Tue, 29 Mar 2022 11:06:46 +0100
Subject: [PATCH] perf: Stop depending on .git internal files for 
building PERF-VERSION-FILE

This essentially reverts commit c72e3f04b45fb2e50cdd81a50c3778c6a57251d8
and commit 4e666cdb06eede2069a7b1a96a1359d1c441a3eb.

In commit c72e3f04b45f ("tools/perf/build: Speed up git-version test on
re-make"), a makefile dependency on .git/HEAD was added. The background 
is that running PERF-VERSION-FILE is relatively slow, and commands like
"git describe" are particularly slow.

In commit 4e666cdb06ee ("perf tools: Fix dependency for version file
creation"), an additional dependency on .git/ORIG_HEAD was added, as
.git/HEAD may not change for "git reset --hard HEAD^" command.

However, as discussed with the git community in [0], using git internal
files for dependencies is not reliable. Commit 4e666cdb06ee also breaks
some build scenarios [1].

As mentioned, c72e3f04b45f was added to speed up the build. However in
commit 7572733b8499 ("perf tools: Fix version kernel tag") we removed 
the call to "git describe", so just revert Makefile.perf back to same as 
pre c72e3f04b45f and the build should not be so slow, as below:

Pre 7572733b8499:
$> time util/PERF-VERSION-GEN
   PERF_VERSION = 5.17.rc8.g4e666cdb06ee

real    0m0.110s
user    0m0.091s
sys     0m0.019s

Post 7572733b8499:
$> time util/PERF-VERSION-GEN
   PERF_VERSION = 5.17.rc8.g7572733b8499

real    0m0.039s
user    0m0.036s
sys     0m0.007s


[0] 
https://lore.kernel.org/git/87wngkpddp.fsf@igel.home/T/#m4a4dd6de52fdbe21179306cd57b3761eb07f45f8
[1] 
https://lore.kernel.org/linux-perf-users/20220329093120.4173283-1-matthieu.baerts@tessares.net/T/#u

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9c935f86d172..ddd03b21bda2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -691,9 +691,8 @@ $(OUTPUT)common-cmds.h: $(wildcard 
Documentation/perf-*.txt)
  $(SCRIPTS) : % : %.sh
  	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'

-$(OUTPUT)PERF-VERSION-FILE: ../../.git/HEAD ../../.git/ORIG_HEAD
+$(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
  	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
-	$(Q)touch $(OUTPUT)PERF-VERSION-FILE

  # These can record PERF_VERSION
  perf.spec $(SCRIPTS) \
@@ -1139,21 +1138,12 @@ else
  	@echo "FEATURE-DUMP file available in $(OUTPUT)FEATURE-DUMP"
  endif

-#
-# Trick: if ../../.git does not exist - we are building out of tree for 
example,
-# then force version regeneration:
-#
-ifeq ($(wildcard ../../.git/HEAD),)
-    GIT-HEAD-PHONY = ../../.git/HEAD ../../.git/ORIG_HEAD
-else
-    GIT-HEAD-PHONY =
-endif

  FORCE:

  .PHONY: all install clean config-clean strip install-gtk
  .PHONY: shell_compatibility_test 
please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
+.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
  .PHONY: libtraceevent_plugins archheaders

  endif # force_fixdep
-- 
2.26.2


-----8<------

I need to test it more as I just wrote it up now.

Thanks,
John

> 
> [1] https://cirrus-ci.com/task/5673396527693824?logs=test#L5026
> [2] https://cirrus-ci.org/guide/tips-and-tricks/
> [3] https://github.com/go-git/go-git
> 
> Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>   tools/perf/Makefile.perf | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 9c935f86d172..2f64e4904bbb 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1143,10 +1143,12 @@ endif
>   # Trick: if ../../.git does not exist - we are building out of tree for example,
>   # then force version regeneration:
>   #
> +GIT-HEAD-PHONY =
>   ifeq ($(wildcard ../../.git/HEAD),)
> -    GIT-HEAD-PHONY = ../../.git/HEAD ../../.git/ORIG_HEAD
> -else
> -    GIT-HEAD-PHONY =
> +    GIT-HEAD-PHONY += ../../.git/HEAD
> +endif
> +ifeq ($(wildcard ../../.git/ORIG_HEAD),)
> +    GIT-HEAD-PHONY += ../../.git/ORIG_HEAD
>   endif
>   
>   FORCE:
> 
> base-commit: ab0809af0bee88b689ba289ec8c40aa2be3a17ec

