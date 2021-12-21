Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1003847C22E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhLUPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbhLUPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:03:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C25C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:03:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso2829100pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qfgQvdP56sgjDm9aV8GjlehdbK+Wn1j18ufpGY0Bks=;
        b=bLBMjDxs5nKc4z7kW/XymEBxFNx3y+66XtbDaajc8gAVW4knyK32a1mV59V9o8SmI6
         tVTFlljOoUjNM35jETavGc0iJxM/HjNqXqUGPaJ1UzF3dtJrXQW38cuZ7s95mEWd8peP
         VVQW4lllzl4ZCeHDQ50YdbMYh/dnTbSKu8OvL6rjy/WFh+J6pEsdmyvX26dpfCzGzCnW
         NwUF8t40KC5eN8KEePhEpVN0E1IXgoJT5ZhmL3NihXLA1E8Fnd2cpWQutPOzS2DunuWX
         us6xmsL+ZCqDDeYftC4RIHmfrpdRmVbXv0DESo1x9vYBoRTdKwcehrigQOIhREHOnxQH
         PjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qfgQvdP56sgjDm9aV8GjlehdbK+Wn1j18ufpGY0Bks=;
        b=gX6Wu6gpgXFqC2OeOcbe9H6qrO09EFQ5KV7pTjGmuz9b9bBIoqLS7B/SLIBIaMzP91
         N6VKGrho1Z1yqy+/vWWTraT6+AMsGt18GjTMjFDVwKD8M5OQgxXTTRI6b/5L+FIW3u5U
         tEzNf50lSWforM5Ch8NwbeY7UZ+kMoT1IRb6wrEeh0HcOACOYyWpTrKuvzdqk333osmv
         PJP5RG+glGHjqzJzZ0uaQTWJpsg8Zabd4n/2j/CZVlBs1N4vrJfeOaQuI+fLz3Y0BXlM
         RbDLCnPzvXFHxxLbMzqdbjLEv2OXqzQwHYwzR3QqQwAeKOAPgUSntHIkmB9G+zmcEzvW
         LwaA==
X-Gm-Message-State: AOAM530wVFv/a9xsAEpaPHN+L3xwjYq/2ONEGSX9oiPOF8EgV7qsoKpM
        5fO/tw9zEGE2kSImJF1DpbpihQ==
X-Google-Smtp-Source: ABdhPJw9XUFoi0sgYJPzE1I7Bqb+snbguefx9I5TxFtYo4VD1S8D0sbW36wS1rvTiGlaF6I+CFy6PA==
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr4598951pjz.68.1640099036399;
        Tue, 21 Dec 2021 07:03:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f15sm2928154pjt.18.2021.12.21.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:03:55 -0800 (PST)
Date:   Tue, 21 Dec 2021 23:03:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 04/12] perf test: Add beginning of test infra + test to
 exercise coresight
Message-ID: <20211221150349.GB41974@leoy-ThinkPad-X240s>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Wed, Dec 15, 2021 at 04:03:55PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This adds the initial test harness to run perf record and examine the
> resuling output when coresight is enabled on arm64 and check the
> resulting quality of the output as part of perf test.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  MAINTAINERS                                   |   3 +
>  tools/perf/Makefile.perf                      |  14 +-
>  .../tests/shell/coresight_asm_pure_loop.sh    |  18 +++
>  tools/perf/tests/shell/lib/coresight.sh       | 130 ++++++++++++++++++
>  tools/perf/tests/shell/tools/Makefile         |  26 ++++
>  .../perf/tests/shell/tools/coresight/Makefile |  27 ++++
>  .../shell/tools/coresight/Makefile.miniconfig |  23 ++++
>  .../tools/coresight/asm_pure_loop/Makefile    |  30 ++++
>  .../coresight/asm_pure_loop/asm_pure_loop.S   |  28 ++++
>  9 files changed, 297 insertions(+), 2 deletions(-)
>  create mode 100755 tools/perf/tests/shell/coresight_asm_pure_loop.sh
>  create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>  create mode 100644 tools/perf/tests/shell/tools/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/Makefile.miniconfig
>  create mode 100644 tools/perf/tests/shell/tools/coresight/asm_pure_loop/Makefile
>  create mode 100644 tools/perf/tests/shell/tools/coresight/asm_pure_loop/asm_pure_loop.S

The folder naming is okay for me, but it is cyclic with the format:
"tools/.../tools/".  So I am wandering if below two pathes are better?

  tools/perf/tests/shell/prog/coresight/
  or
  tools/perf/tests/shell/coresight/

I'd like to leave this question for Arnaldo / Jiri for the folder
layout.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..d46e8469c467 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1894,6 +1894,9 @@ F:	tools/perf/arch/arm/util/auxtrace.c
>  F:	tools/perf/arch/arm/util/cs-etm.c
>  F:	tools/perf/arch/arm/util/cs-etm.h
>  F:	tools/perf/arch/arm/util/pmu.c
> +F:	tools/perf/tests/shell/coresight_*
> +F:	tools/perf/tests/shell/tools/Makefile
> +F:	tools/perf/tests/shell/tools/coresight/*
>  F:	tools/perf/util/cs-etm-decoder/*
>  F:	tools/perf/util/cs-etm.*
>  
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 80522bcfafe0..26467a2c71f4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -630,7 +630,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>  $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>  	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>  
> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> +TESTS_TOOLS_DIR := $(srctree)/tools/perf/tests/shell/tools
> +
> +tests-tools-targets: FORCE
> +	$(Q)$(MAKE) -C $(TESTS_TOOLS_DIR)
> +
> +tests-tools-targets-clean:
> +	$(Q)$(MAKE) -C $(TESTS_TOOLS_DIR) clean
> +
> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-tools-targets
>  
>  # Create python binding output directory if not already present
>  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> @@ -1020,6 +1028,7 @@ install-tests: all install-gtk
>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>  		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +	$(Q)$(MAKE) -C tests/shell/tools install-tests
>  
>  install-bin: install-tools install-tests install-traceevent-plugins
>  
> @@ -1088,7 +1097,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-tools-targets-clean
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> @@ -1155,5 +1164,6 @@ FORCE:
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
>  .PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
>  .PHONY: libtraceevent_plugins archheaders
> +.PHONY: $(TESTS_TOOLS_TARGETS)
>  
>  endif # force_fixdep
> diff --git a/tools/perf/tests/shell/coresight_asm_pure_loop.sh b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
> new file mode 100755
> index 000000000000..542d4a37e349
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight_asm_pure_loop.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# Coresight / ASM Pure Loop
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="asm_pure_loop"
> +. $(dirname $0)/lib/coresight.sh
> +ARGS=""
> +DATV="out"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS

Is $ARGS redundant and can be removed?

> +perf_dump_aux_verify "$DATA" 2601 334 334

These three magic numbers "2601 334 334" would be hard to understand.
One way is the code can dynamically calculate these values based on the
loop times (the loop is is predefined in asm_pure_loop.S), or it's
good to give explanation in comments for these values.

> +
> +err=$?
> +exit $err
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> new file mode 100644
> index 000000000000..cd6c1283e6f5
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +# This is sourced from a driver script so no need for #!/bin... etc. at the
> +# top - the assumption below is that it runs as part of sourcing after the
> +# test sets up some basic env vars to say what it is.
> +
> +# perf record options for the perf tests to use
> +PERFRECMEM="-m ,128M"

We must use 128Mb for the AUX trace buffer?  The big buffer size is
not friendly for embedded system.

> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> +
> +# These tests need to be run as root or coresight won't allow large buffers
> +# and will not collect proper data
> +UID=`id -u`
> +if test "$UID" -ne 0; then
> +	echo "Not running as root... skip"
> +	exit 2
> +fi
> +
> +TOOLS=$(dirname $0)/tools
> +DIR="$TOOLS/coresight/$TEST"
> +BIN="$DIR/$TEST"
> +# If the test tool/binary does not exist and is executable then skip the test
> +if ! test -x "$BIN"; then exit 2; fi
> +DATD="."

It's blur to set DATD and STATD to ".".  If the user doesn't specify
the envs, it's not clear it will point to which folder.

> +# If the data dir env is set then make the data dir use that instead of ./
> +if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
> +	DATD="$PERF_TEST_CORESIGHT_DATADIR";
> +fi
> +# If the stat dir env is set then make the data dir use that instead of ./
> +STATD="."
> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
> +	STATD="$PERF_TEST_CORESIGHT_STATDIR";
> +fi
> +
> +# Called if the test fails - error code 2
> +err() {
> +	echo "$1"
> +	exit 1
> +}
> +
> +# Check that some statistics from our perf
> +check_val_min() {
> +	STATF="$4"
> +	if test "$2" -lt "$3"; then
> +		echo ", FAILED" >> "$STATF"
> +		err "Sanity check number of $1 is too low ($2 < $3)"
> +	fi
> +}
> +
> +perf_dump_aux_verify() {
> +	# Some basic checking that the AUX chunk contains some sensible data
> +	# to see that we are recording something and at least a minimum
> +	# amount of it. We should almost always see F3 atoms in just about
> +	# anything but certainly we will see some trace info and async atom
> +	# chunks.
> +	DUMP="$DATD/perf-tmp-aux-dump.txt"
> +	perf report --stdio --dump -i "$1" | \
> +		grep -o -e I_ATOM_F3 -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
> +	# Simply count how many of these atoms we find to see that we are
> +	# producing a reasonable amount of data - exact checks are not sane
> +	# as this is a lossy  process where we may lose some blocks and the
> +	# compiler may produce different code depending on the compiler and
> +	# optimization options, so this is rough  just to see if we're
> +	# either missing almost all the data or all of it
> +	ATOM_F3_NUM=`grep I_ATOM_F3 "$DUMP" | wc -l`
> +	ATOM_ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
> +	ATOM_TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
> +	rm -f "$DUMP"
> +
> +	# Arguments provide minimums for a pass
> +	CHECK_F3_MIN="$2"
> +	CHECK_ASYNC_MIN="$3"
> +	CHECK_TRACE_INFO_MIN="$4"
> +
> +	# Write out statistics, so over time you can track results to see if
> +	# there is a pattern - for example we have less "noisy" results that
> +	# produce more consistent amounts of data each run, to see if over
> +	# time any techinques to  minimize data loss are having an effect or
> +	# not
> +	STATF="$STATD/stats-$TEST-$DATV.csv"
> +	if ! test -f "$STATF"; then
> +		echo "ATOM F3 Count, Minimum, ATOM ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
> +	fi
> +	echo -n "$ATOM_F3_NUM, $CHECK_F3_MIN, $ATOM_ASYNC_NUM, $CHECK_ASYNC_MIN, $ATOM_TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
> +
> +	# Actually check to see if we passed or failed.
> +	check_val_min "ATOM_F3" "$ATOM_F3_NUM" "$CHECK_F3_MIN" "$STATF"
> +	check_val_min "ASYNC" "$ATOM_ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
> +	check_val_min "TRACE_INFO" "$ATOM_TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
> +	echo ", Ok" >> "$STATF"
> +}
> +
> +perf_dump_aux_tid_verify() {

This function is not used in the test contained in this patch.

> +	# Specifically crafted test will produce a list of Tread ID's to
> +	# stdout that need to be checked to  see that they have had trace
> +	# info collected in AUX blocks in the perf data. This will go
> +	# through all the TID's that are listed as CID=0xabcdef and see
> +	# that all the Thread IDs the test tool reports are  in the perf
> +	# data AUX chunks
> +
> +	# The TID test tools will print a TID per stdout line that are being
> +	# tested
> +	TIDS=`cat "$2"`
> +	# Scan the perf report to find the TIDs that are actually CID in hex
> +	# and build a list of the ones found
> +	FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
> +			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
> +			uniq | sort | uniq`
> +
> +	# Iterate over the list of TIDs that the test says it has and find
> +	# them in the TIDs found in the perf report
> +	MISSING=""
> +	for TID2 in $TIDS; do
> +		FOUND=""
> +		for TIDHEX in $FOUND_TIDS; do
> +			TID=`printf "%i" $TIDHEX`
> +			if test "$TID" -eq "$TID2"; then
> +				FOUND="y"
> +				break
> +			fi
> +		done
> +		if test -z "$FOUND"; then
> +			MISSING="$MISSING $TID"
> +		fi
> +	done
> +	if test -n "$MISSING"; then
> +		err "Thread IDs $MISSING not found in perf AUX data"
> +	fi
> +}
> diff --git a/tools/perf/tests/shell/tools/Makefile b/tools/perf/tests/shell/tools/Makefile
> new file mode 100644
> index 000000000000..c7ada20922fd
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../tools/scripts/Makefile.include
> +include ../../../../../tools/scripts/Makefile.arch
> +include ../../../../../tools/scripts/utilities.mak

To be honest, I don't understand well for perf's build and config
system.  Seems to me, a good example for building program is jevents.

Please take a look for the code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Makefile.perf#n667

If follow the same method with jevents for building test programs,
I can see one benefit is we don't need to create a Makefile, on the
other hand, we can reuse the perf's build system and simply create a
Build file under the folder tools/perf/tests/shell/.../coresight/.

> +
> +SUBDIRS = \
> +	coresight
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: all $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) O=$(OUTPUT) clean >/dev/null
> +
> +.PHONY: all clean install-tests $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
> new file mode 100644
> index 000000000000..723006ea827c
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/Makefile
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../../tools/scripts/Makefile.include
> +include ../../../../../../tools/scripts/Makefile.arch
> +include ../../../../../../tools/scripts/utilities.mak
> +
> +SUBDIRS = \
> +	asm_pure_loop
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> +
> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> +
> diff --git a/tools/perf/tests/shell/tools/coresight/Makefile.miniconfig b/tools/perf/tests/shell/tools/coresight/Makefile.miniconfig
> new file mode 100644
> index 000000000000..cedd26c6a0eb
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/Makefile.miniconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +ifndef DESTDIR
> +prefix ?= $(HOME)
> +endif
> +
> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
> +perfexecdir = libexec/perf-core
> +perfexec_instdir = $(perfexecdir)
> +
> +ifneq ($(filter /%,$(firstword $(perfexecdir))),)
> +perfexec_instdir = $(perfexecdir)
> +else
> +perfexec_instdir = $(prefix)/$(perfexecdir)
> +endif
> +
> +perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
> +INSTALL = install
> +
> +include ../../../../../../scripts/Makefile.include
> +include ../../../../../../scripts/Makefile.arch
> +include ../../../../../../scripts/utilities.mak

As suggested above, if we refer the building method of jevent, I think
this Makefile.miniconfig is not needed anymore.

> diff --git a/tools/perf/tests/shell/tools/coresight/asm_pure_loop/Makefile b/tools/perf/tests/shell/tools/coresight/asm_pure_loop/Makefile
> new file mode 100644
> index 000000000000..10c5a60cb71c
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/asm_pure_loop/Makefile
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +include ../Makefile.miniconfig
> +
> +BIN=asm_pure_loop
> +LIB=
> +
> +all: $(BIN)
> +
> +$(BIN): $(BIN).S
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +	$(Q)$(CC) $(BIN).S -nostdlib -static -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +	$(call QUIET_INSTALL, tests) \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +	$(Q)$(RM) -f $(BIN)
> +
> +.PHONY: all clean install-tests
> diff --git a/tools/perf/tests/shell/tools/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/tools/coresight/asm_pure_loop/asm_pure_loop.S
> new file mode 100644
> index 000000000000..262876451021
> --- /dev/null
> +++ b/tools/perf/tests/shell/tools/coresight/asm_pure_loop/asm_pure_loop.S
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Tamas Zsoldos <tamas.zsoldos@arm.com>, 2021 */
> +
> +.globl _start
> +_start:
> +	mov	x0, 0x000fffff
> +	mov	x1, xzr
> +loop:
> +	nop
> +	nop
> +	cbnz	x1, noskip
> +	nop
> +	nop
> +	adrp	x2, skip
> +	add 	x2, x2, :lo12:skip
> +	br	x2
> +	nop
> +	nop
> +noskip:
> +	nop
> +	nop
> +skip:
> +	sub	x0, x0, 1
> +	cbnz	x0, loop
> +
> +	mov	x0, #0
> +	mov	x8, #93 // __NR_exit syscall
> +	svc	#0

I verified this code on Arm64 machine and it works!

I am a bit worry about the code for using the hard code number for
system call.  Another option is to use the inline assembly
in C code, I think you have considered for this approach, this might
introduce noise for extra branch instructions during the testing,
but it can allow us to program standard C program (and don't worry
about the program exiting).

If you think using assembly code is better than inline assembly, it
would be fine for me.  Eventually, the system call number is very
seldomly to be changed.

Thanks,
Leo
