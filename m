Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474ED573694
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiGMMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiGMMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:49:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32218191
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:49:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so13328515ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9yBvm9Ksb4Rmw74utDmUvOM3nzivfvh+Ern9WSW11A=;
        b=fmfHunkvcUwHDXNIbByA2pTdl3B3Javrf0cV+/yN857ltbnnM2feoFqUgzNaxtGavd
         MBTw90v5AmhW+fBn91e6EL37kAqalXI7lGIE0L9vOlbbESf6sWnPlzZTAwFhNAW4NiQ9
         1lEnfMpnzQB3Xp1nIg+wNlIJJ9cx7AYHSmgVaJ0AsCJxsJlQbfaXFJHY/zU3GCVSZZ1q
         NAl+SVdj2hf3OXj555/yuvbF/ofSd2LY4ocPU8sV78kvtG1aeqJ8oZVt9/4Q7WpiMbB6
         wwR1YX99H0RYSL4ew77+8AyCAWuswPVs9pAk96fSOhnsftvbYROUty7J8AETTXY8WJZD
         FSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9yBvm9Ksb4Rmw74utDmUvOM3nzivfvh+Ern9WSW11A=;
        b=8KHEmrSJk2pciLARoE8j6RaAKsJ4X60GNhE3B03eJPspovI/2RQjrUb88Xm5/zGar1
         p6MnCII+3/JAeBHJLfUYTmlWO+KCUukM2eNJ+RZ+3BJVyy9pN+n9oba/e0LSSeUAdgPd
         qwjKkzYtOIxFBRwl9fRj/T+Epkq4Un7FQG42FN4yMmWY6+H8TteXfASbJqPSVrbUlo/J
         RPpHMdjetp0e4FxN+779B3WjGOKg1GKh73j1zaOX4VAGqgNEMx8d7Uc8HbqrJiRqzlbg
         EcFuAPYWbQoqs3UCjQ754qqzcWRKB2TvJFcVP6PR47Hoq44RLlj4xryhZsKeJStumZ4N
         84Sg==
X-Gm-Message-State: AJIora+ekuIEUsq9pNSxaTvk7S76dFBcTN+WwwecYbcpHlTXLECwR1vG
        qpxZ4q9RxHEsJagd1/mrvyw0o/f2KRDmcb9PwCGN4kacHHDw3Q==
X-Google-Smtp-Source: AGRyM1sDjUBNHOKmM/gpvsfE0rDu8TqZAtI2mp9kH96cM1M0+vups+gPTszOr5oZpU57NXjtqhTM3zEorKLpiNfL9+o=
X-Received: by 2002:a2e:b8d6:0:b0:25a:99ce:5c32 with SMTP id
 s22-20020a2eb8d6000000b0025a99ce5c32mr1592537ljp.95.1657716587457; Wed, 13
 Jul 2022 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com> <20220712135750.2212005-3-carsten.haitzler@foss.arm.com>
In-Reply-To: <20220712135750.2212005-3-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 13 Jul 2022 13:49:35 +0100
Message-ID: <CAJ9a7VjBSouo23J2Ws8hw1Gck2b7W4sbxGN+PzjsLHhDAxSP1Q@mail.gmail.com>
Subject: Re: [PATCH 02/14] perf test: Add CoreSight shell lib shared code for
 future tests
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

On Tue, 12 Jul 2022 at 14:58, <carsten.haitzler@foss.arm.com> wrote:
>
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>
> This adds a library of shell "code" to be shared and used by future
> tests that target quality testing for Arm CoreSight support in perf
> and the Linux kernel.
>
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/shell/lib/coresight.sh | 129 ++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> new file mode 100644
> index 000000000000..8c254d2185bc
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +# This is sourced from a driver script so no need for #!/bin... etc. at the
> +# top - the assumption below is that it runs as part of sourcing after the
> +# test sets up some basic env vars to say what it is.
> +
> +# perf record options for the perf tests to use
> +PERFRECMEM="-m ,16M"
> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> +
> +TOOLS=$(dirname $0)
> +DIR="$TOOLS/$TEST"
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

comment and exit 1 don't tie up

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

Please use correct terminology for the tech - ATOM is a specific form
of trace packet,
"ATOM_TRACE_INFO_NUM" makes no sense - TRACE_INFO_NUM is sufficient.
Same for ATOM_ASYNC_NUM.=> ASYNC_NUM  - and all occurrences below.

Moreover it would be better to just search for all atoms i.e. I_ATOM.
This way you avoid hardware variations where an platform
implementation may give different ratios between the different atom
types for the same trace run.


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
> +       # No CID=xxx found - maybe your kernel is reporting these as
> +       # VMID=xxx so look there
> +       if test -z "$FOUND_TIDS"; then
> +               FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
> +                               grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
> +                               uniq | sort | uniq`
> +       fi
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
> --
> 2.32.0
>

I haven't seen it mentioned anywhere but these tests will only work on
ETMv4 / ETE. Platforms with ETMv3.x and PTM have different output
packet types.

We don't need to support these at present - and maybe never, but it
does need to be explicitly stated which trace technologies the tests
are compatible with.

Regards

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
