Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7114F5B2657
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiIHS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIHS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51939EB2C9;
        Thu,  8 Sep 2022 11:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12FA61D9A;
        Thu,  8 Sep 2022 18:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBC9C433C1;
        Thu,  8 Sep 2022 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662663408;
        bh=ffuuiEg915m93Cbe2AVh4cFBTnX17cIXB+u7GWYV01I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVkaJ8dYZl63fjKLQpX+dJIK2KIozMvxnjs55j1fsTnde9BOPsWzfFoUKXbMGlxpN
         6ONl5oPAzs5t/cIXDFxN30PBmPBYA8Tsu6FUinpq/fi7gmEzYVu9sG6BgtaIY01PLH
         nWWZHsJbziV5hJB8GkIZVxtNEdxF9C0QJvFtOonwLyWtlJRsmQTutA1bo1fPni4Qhs
         C/Vzz7urEpwYdG4DneLoFRQCGrTXDwIBcdSoBxxVOFGL6RSBfGRi7oy9V1vX1eXxA3
         5wWdTeAUyM51O0dTTkX+Qd/p85dTLWisgfMOj2E0aeK6aCo37Dz3E1nZfK5ta3C0Is
         SqSy0J3NA1Adg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00E04404A1; Thu,  8 Sep 2022 15:56:45 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:56:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf: don't install data files with x permissions
Message-ID: <Yxo67YH2kviK8+I4@kernel.org>
References: <20220907105634.29649-1-jslaby@suse.cz>
 <20220908060426.9619-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908060426.9619-1-jslaby@suse.cz>
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

Em Thu, Sep 08, 2022 at 08:04:26AM +0200, Jiri Slaby escreveu:
> install(1), by default, installs with rwxr-xr-x permissions. Modify
> perf's Makefile to pass '-m 644' when installing:
> * Documentation/tips.txt
> * examples/bpf/*
> * perf-completion.sh
> * perf_dlfilter.h header
> * scripts/perl/Perf-Trace-Util/lib/Perf/Trace/*
> * scripts/perl/*.pl
> * tests/attr/*
> * tests/attr.py
> * tests/shell/lib/*.sh
> * trace/strace/groups/*
> 
> All those are supposed to be non-executable. Either they are not scripts
> at all, or they don't have shebang.

Thanks, applied.

- Arnaldo

 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> 
> Notes:
>     [v2] include also bpf example sources
> 
>  tools/perf/Makefile.perf | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e5921b347153..bd947885a639 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -954,11 +954,11 @@ ifndef NO_LIBBPF
>  	$(call QUIET_INSTALL, bpf-headers) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'; \
> -		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
> -		$(INSTALL) include/bpf/linux/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
> +		$(INSTALL) include/bpf/*.h -m 644 -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
> +		$(INSTALL) include/bpf/linux/*.h -m 644 -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
>  	$(call QUIET_INSTALL, bpf-examples) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
> -		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
> +		$(INSTALL) examples/bpf/*.c -m 644 -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
>  endif
>  	$(call QUIET_INSTALL, perf-archive) \
>  		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
> @@ -967,13 +967,13 @@ endif
>  ifndef NO_LIBAUDIT
>  	$(call QUIET_INSTALL, strace/groups) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
> -		$(INSTALL) trace/strace/groups/* -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
> +		$(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
>  endif
>  ifndef NO_LIBPERL
>  	$(call QUIET_INSTALL, perl-scripts) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
> -		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
> -		$(INSTALL) scripts/perl/*.pl -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
> +		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
> +		$(INSTALL) scripts/perl/*.pl -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'; \
>  		$(INSTALL) scripts/perl/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'
>  endif
> @@ -990,23 +990,23 @@ endif
>  		$(INSTALL) $(DLFILTERS) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters';
>  	$(call QUIET_INSTALL, perf_completion-script) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d'; \
> -		$(INSTALL) perf-completion.sh '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
> +		$(INSTALL) perf-completion.sh -m 644 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
>  	$(call QUIET_INSTALL, perf-tip) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(tip_instdir_SQ)'; \
> -		$(INSTALL) Documentation/tips.txt -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
> +		$(INSTALL) Documentation/tips.txt -m 644 -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
>  
>  install-tests: all install-gtk
>  	$(call QUIET_INSTALL, tests) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
> -		$(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
> +		$(INSTALL) tests/attr.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>  		$(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
> -		$(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
> +		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> +		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
>  
>  install-bin: install-tools install-tests install-traceevent-plugins
>  
> -- 
> 2.37.3

-- 

- Arnaldo
