Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17D4A97A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiBDKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357383AbiBDKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:21:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02469C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:21:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f17so10416819wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVFD5+wrvATWQo2VphSGJBAy0Nvku/2BOSwsDGs6plY=;
        b=ncdu5FhdYHr/7zGe/O9dwqQlQJdIr8fh/lvbjtMIBGW5zTeytTy2qQlBJhuyXQTcX9
         eURzgdJRs4V4OsXFvMMMX+gQiQRnbMqCFtCP0D4riPgoN6hK3cH9aO+mrX2D3swDv+aF
         fmq8kAwU3NXQHMIShIF+UTqVrVCDGZgo9lVnlp0OQg4c3u7yRCVD9Kf+55CAWDd62qNV
         myh1mykW+nqphKz3QkjYVDI/Ys4OpfdBbchlaC1MB2rEJz39YD1glYYmPnqEXJyK3ddK
         5pc8TBedjZ5jM3suYkk7JFbXw728O/85hikdwJF3ikp907EX6B/QCvbD+dXmy3qwJpk4
         TtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVFD5+wrvATWQo2VphSGJBAy0Nvku/2BOSwsDGs6plY=;
        b=XU6ldJ8in2lC/Wt9+v1yMjCeyfJ7v+qKzVww++ieTn6GaewJIB8T7oRtkSoc2VKyiP
         HMGMAXh0u0zSg07J8cNWRxr6QtQ+wAl5OtCv+FFNBVtRYOiIdFDZLXcy/mFm84S0JJzB
         wrkG0yIpwNqgSCxIYO9YZnQysuMHEfA5J/kOKgRQ+xRYwSoeejI+mxXNKE2X86q4N0dd
         qHgZT1VhiTih0FMiIEdOVNkqaR915WmUPcQTnZ5mI9Ahu9rEDbd1mo+Y/lc7ctzHhgaA
         rTsc77tNSN8j8ku/4k7w/L9XWeCo0NBX9I+iHPf8ifnfJ8eOmD55PxCqJqlUqqQz3kDJ
         VgEg==
X-Gm-Message-State: AOAM5330eV/lDBLBYooMKhMChLEg7q1JlbIBqMJpaCO3W1FbBgj0ACA8
        MHss1WOvveIjkvZbUP0XrugUrjrxseN8Op3tFTHT/A==
X-Google-Smtp-Source: ABdhPJy4ZBqnEihKnpht/r6GlM2W4GhYqHNN/K3UktTrXLIryumL6EQm7JJr85uqNLqugv2mT2MiKdVBRS4i3xIq9uk=
X-Received: by 2002:adf:d239:: with SMTP id k25mr1928826wrh.699.1643970102423;
 Fri, 04 Feb 2022 02:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com> <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
In-Reply-To: <20211215160403.69264-4-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 4 Feb 2022 10:21:33 +0000
Message-ID: <CAJ9a7VjVRncF1q+oRtz8BHiVAj=rLX1GOSEKK774C3a8z5dyBA@mail.gmail.com>
Subject: Re: [PATCH 04/12] perf test: Add beginning of test infra + test to
 exercise coresight
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten

I've been looking at these tests from a trace decode perspective and
have a few comments to make.

On Wed, 15 Dec 2021 at 16:04, <carsten.haitzler@foss.arm.com> wrote:
>
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
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..d46e8469c467 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1894,6 +1894,9 @@ F:        tools/perf/arch/arm/util/auxtrace.c
>  F:     tools/perf/arch/arm/util/cs-etm.c
>  F:     tools/perf/arch/arm/util/cs-etm.h
>  F:     tools/perf/arch/arm/util/pmu.c
> +F:     tools/perf/tests/shell/coresight_*
> +F:     tools/perf/tests/shell/tools/Makefile
> +F:     tools/perf/tests/shell/tools/coresight/*
>  F:     tools/perf/util/cs-etm-decoder/*
>  F:     tools/perf/util/cs-etm.*
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 80522bcfafe0..26467a2c71f4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -630,7 +630,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>  $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>         $(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>
> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> +TESTS_TOOLS_DIR := $(srctree)/tools/perf/tests/shell/tools
> +
> +tests-tools-targets: FORCE
> +       $(Q)$(MAKE) -C $(TESTS_TOOLS_DIR)
> +
> +tests-tools-targets-clean:
> +       $(Q)$(MAKE) -C $(TESTS_TOOLS_DIR) clean
> +
> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-tools-targets
>
>  # Create python binding output directory if not already present
>  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> @@ -1020,6 +1028,7 @@ install-tests: all install-gtk
>                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>                 $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +       $(Q)$(MAKE) -C tests/shell/tools install-tests
>
>  install-bin: install-tools install-tests install-traceevent-plugins
>
> @@ -1088,7 +1097,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>         $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-tools-targets-clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>         $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>         $(Q)$(RM) $(OUTPUT).config-detected
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
> +
> +perf_dump_aux_verify "$DATA" 2601 334 334
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
> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> +
> +# These tests need to be run as root or coresight won't allow large buffers
> +# and will not collect proper data
> +UID=`id -u`
> +if test "$UID" -ne 0; then
> +       echo "Not running as root... skip"
> +       exit 2
> +fi
> +
> +TOOLS=$(dirname $0)/tools
> +DIR="$TOOLS/coresight/$TEST"
> +BIN="$DIR/$TEST"
> +# If the test tool/binary does not exist and is executable then skip the test
> +if ! test -x "$BIN"; then exit 2; fi
> +DATD="."
> +# If the data dir env is set then make the data dir use that instead of ./
> +if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
> +       DATD="$PERF_TEST_CORESIGHT_DATADIR";
> +fi
> +# If the stat dir env is set then make the data dir use that instead of ./
> +STATD="."
> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
> +       STATD="$PERF_TEST_CORESIGHT_STATDIR";
> +fi
> +
> +# Called if the test fails - error code 2
> +err() {
> +       echo "$1"
> +       exit 1
> +}
> +
> +# Check that some statistics from our perf
> +check_val_min() {
> +       STATF="$4"
> +       if test "$2" -lt "$3"; then
> +               echo ", FAILED" >> "$STATF"
> +               err "Sanity check number of $1 is too low ($2 < $3)"
> +       fi
> +}
> +
> +perf_dump_aux_verify() {
> +       # Some basic checking that the AUX chunk contains some sensible data
> +       # to see that we are recording something and at least a minimum
> +       # amount of it. We should almost always see F3 atoms in just about
> +       # anything but certainly we will see some trace info and async atom
> +       # chunks.
> +       DUMP="$DATD/perf-tmp-aux-dump.txt"
> +       perf report --stdio --dump -i "$1" | \
> +               grep -o -e I_ATOM_F3 -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
> +       # Simply count how many of these atoms we find to see that we are
> +       # producing a reasonable amount of data - exact checks are not sane
> +       # as this is a lossy  process where we may lose some blocks and the
> +       # compiler may produce different code depending on the compiler and
> +       # optimization options, so this is rough  just to see if we're
> +       # either missing almost all the data or all of it
> +       ATOM_F3_NUM=`grep I_ATOM_F3 "$DUMP" | wc -l`
> +       ATOM_ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
> +       ATOM_TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
> +       rm -f "$DUMP"
> +

Terminology - an ATOM packet is one that contains branch taken / not
take atoms - E / N. These come in 6 different formats F1 .. F6.

So here we shoud drop the ATOM_ prefix from TRACE_INFO and ASYNC



> +       # Arguments provide minimums for a pass
> +       CHECK_F3_MIN="$2"
> +       CHECK_ASYNC_MIN="$3"
> +       CHECK_TRACE_INFO_MIN="$4"
> +
> +       # Write out statistics, so over time you can track results to see if
> +       # there is a pattern - for example we have less "noisy" results that
> +       # produce more consistent amounts of data each run, to see if over
> +       # time any techinques to  minimize data loss are having an effect or
> +       # not
> +       STATF="$STATD/stats-$TEST-$DATV.csv"
> +       if ! test -f "$STATF"; then
> +               echo "ATOM F3 Count, Minimum, ATOM ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
> +       fi
> +       echo -n "$ATOM_F3_NUM, $CHECK_F3_MIN, $ATOM_ASYNC_NUM, $CHECK_ASYNC_MIN, $ATOM_TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
> +
> +       # Actually check to see if we passed or failed.
> +       check_val_min "ATOM_F3" "$ATOM_F3_NUM" "$CHECK_F3_MIN" "$STATF"
> +       check_val_min "ASYNC" "$ATOM_ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
> +       check_val_min "TRACE_INFO" "$ATOM_TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
> +       echo ", Ok" >> "$STATF"
> +}
> +
> +perf_dump_aux_tid_verify() {
> +       # Specifically crafted test will produce a list of Tread ID's to
> +       # stdout that need to be checked to  see that they have had trace
> +       # info collected in AUX blocks in the perf data. This will go
> +       # through all the TID's that are listed as CID=0xabcdef and see
> +       # that all the Thread IDs the test tool reports are  in the perf
> +       # data AUX chunks
> +
> +       # The TID test tools will print a TID per stdout line that are being
> +       # tested
> +       TIDS=`cat "$2"`
> +       # Scan the perf report to find the TIDs that are actually CID in hex
> +       # and build a list of the ones found
> +       FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
> +                       grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
> +                       uniq | sort | uniq`
> +
> +       # Iterate over the list of TIDs that the test says it has and find
> +       # them in the TIDs found in the perf report
> +       MISSING=""
> +       for TID2 in $TIDS; do
> +               FOUND=""
> +               for TIDHEX in $FOUND_TIDS; do
> +                       TID=`printf "%i" $TIDHEX`
> +                       if test "$TID" -eq "$TID2"; then
> +                               FOUND="y"
> +                               break
> +                       fi
> +               done
> +               if test -z "$FOUND"; then
> +                       MISSING="$MISSING $TID"
> +               fi
> +       done
> +       if test -n "$MISSING"; then
> +               err "Thread IDs $MISSING not found in perf AUX data"
> +       fi
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
> +
> +SUBDIRS = \
> +       coresight
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +       $(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: all $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +       $(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +       $(Q)$(MAKE) -C $(@:clean-%=%) O=$(OUTPUT) clean >/dev/null
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
> +       asm_pure_loop
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +       $(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +       $(Q)$(MAKE) -C $(@:install-%=%) install-tests
> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +       $(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
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
> +       $(Q)$(CC) $(BIN).S -nostdlib -static -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +       $(call QUIET_INSTALL, tests) \
> +               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
> +               $(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +       $(Q)$(RM) -f $(BIN)
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
> +       mov     x0, 0x000fffff
> +       mov     x1, xzr
> +loop:
> +       nop
> +       nop
> +       cbnz    x1, noskip
> +       nop
> +       nop
> +       adrp    x2, skip
> +       add     x2, x2, :lo12:skip
> +       br      x2
> +       nop
> +       nop
> +noskip:
> +       nop
> +       nop
> +skip:
> +       sub     x0, x0, 1
> +       cbnz    x0, loop
> +
> +       mov     x0, #0
> +       mov     x8, #93 // __NR_exit syscall
> +       svc     #0
> --
> 2.32.0
>

Bear in mind too that the general principle of ETM4 trace is to trace
"waypoint" instructions - these are typically branches - which could
potentially cause a change in program flow.
The rest are deduced from the program image.

The test program above is a good start - there are three waypoint
instructions - looking at the code, each iteration of the look will
generate a NEE atom element pattern. (cbnz x1 is never taken as x1 is
always 0, br x2 is unconditional and always taken, cbnz x0, loop is
always taken - except for the final time on loop exit).

Which fits nicely into the ATOM_F3 packet you are counting.

However - there is nothing in the ETM architecture that says an
implementation has to use this packet. Depending on timings and
implementation details the same trace on a different platform could be
output as
consecutive ATOM_F2 packets NE EN EE etc, etc.

Both cases will decode correctly. Counting a particular ATOM packet
type is therefore not a portable test.
For a given bounded trace run*, you shoul always see the same number
of atom elements. Helpfully ATOM_F1 packets contain 1 atom, _F2 2
atoms. up to F5 with 5 atoms. Less helpfully F6 contains between 4 and
24 atoms.

For ASYNC / TRACE INFO these are programmed to appear at every 4k
bytes of trace. This allows synchronisation to be established if the
hardware buffer has wrapped. They will also appear at start of trace
and other locations defined in the ETM4 architecture spec. However,
both are emitted as a pair due to a synchronisation request - the
ASYNC allows the packet processor to start interpreting the bytes
stream into a set of packets. TRACEINFO is used by the trace decoder
to turn the set of packets into decoded trace. For the purposes of the
perf report --dump you are using, it is only necessary to count the
ASYNCs. TRACEINFO does not add a great deal.

One additional caveat here - while most implementations provide the
register that allows the programming of ASYNC frequency, it is
possible for an implementation to set this register as RO and use a
single fixed frequency - which might not be 4k bytes.


Regards

Mike

*by bounded trace run - I mean one that has completed without the
buffer wrapping - i.e. where perf does not report loss of trace.


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
