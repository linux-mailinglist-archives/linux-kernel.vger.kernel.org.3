Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CF58B4CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiHFJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHFJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:41:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B624E659E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:41:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o3so4562577ple.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EEBuFx6DM+1Pu6CeLy6E4LdQQ3xoNoJlUQHPSG/y8jc=;
        b=ppDRa5X6p90CTf1cafDx1Zk0Kc7xcybYOz8P+NWbNDX2ao+uhmjL8RHRFJCeippXtl
         2lmW3fra9l71aVfr6YyrJrJROek2PZx9RgwjL37fOYUJkvuuzpVxWpiZQaFJHl4S+mbo
         JP75/4JePU5fPw33guYkpDp98wX4F4b/g2GIJUdhaDXX6vzkOyMh2L9Crj2WgHGjgACZ
         aFfuivI2c49MH3iHeaq+IcOkT7h5pINs4AxmIoFdzvvWReJVahan5zXWhLfeanKQ9CJp
         VH2foqxXBN94dLeswyCARTwnltPFkTLnP5ugv6dqgAshQT4cjde9F2a10iGX32NLXjsE
         6thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEBuFx6DM+1Pu6CeLy6E4LdQQ3xoNoJlUQHPSG/y8jc=;
        b=bufKvwQV5WAMozeCoWBiPddSEDv69YGd3khw2kyzXVl7jzg02ZFlhr27deiCih3aQb
         pV7rk+eobaX/ah0K0BU6nxtPe8UjyT2jTvphZiqeVyAI01b5MOv9lC66rBD8Ou1FHOsq
         lXhBUIO/jPtzJmBFSzQQePcjM6h0rO/IIVg6WWmztIlhFxRStFfUGmO+fU2rEIB1neyG
         zO6pbLJ2cAk40l9WF0bJxk0avNP9Lm8QwgR/305b1lnhvgupW9mxcqA47EmUYlhCYnZW
         50KUNzHEBmYTfySWH0wT2n+kZX7gqhgWB8jz72r8WD84Lk76mx+ifkNUoG+oJz9gyLGx
         l7gg==
X-Gm-Message-State: ACgBeo2cilXO4WwYQ3pUUunv6smAggiqWvtl1vlUwDVhSAFZ/2oM4/cl
        4/uRu4J5LmaEYDNet1Is0JEIfXNiM1rMqxrZHJ8=
X-Google-Smtp-Source: AA6agR4S2pHS26I/pTJ2W21h40jn+mEA9XTUKWbHuLKprOyZ/r8KySqt1kQO6k3skaJ9VcTIPlR1jg==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr10511226ple.157.1659778860839;
        Sat, 06 Aug 2022 02:41:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id c1-20020a056a00008100b0052d1341a2c6sm4652507pfj.177.2022.08.06.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 02:40:59 -0700 (PDT)
Date:   Sat, 6 Aug 2022 17:40:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 02/14] perf test: Add CoreSight shell lib shared code
 for future tests
Message-ID: <20220806094055.GB124146@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-3-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:44PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> This adds a library of shell "code" to be shared and used by future
> tests that target quality testing for Arm CoreSight support in perf
> and the Linux kernel.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/shell/lib/coresight.sh | 132 ++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/coresight.sh
> 
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> new file mode 100644

Now one thing is tricky.  Since we scan sub directories, all scripts
under the folder "tools/perf/tests/shell/lib/" are not added into the
test list, this is because the scripts under this folder have no the
executable (X) permission:

-rw-rw-r-- 1 leoy leoy 4675 Aug  6 17:03 coresight.sh
-rw-rw-r-- 1 leoy leoy  329 Jul 27 09:37 probe.sh
-rw-rw-r-- 1 leoy leoy  812 Jul 27 09:37 probe_vfs_getname.sh

I verified with command "perf list" and it works as expected.

> index 000000000000..45a1477256b6
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +# This is sourced from a driver script so no need for #!/bin... etc. at the
> +# top - the assumption below is that it runs as part of sourcing after the
> +# test sets up some basic env vars to say what it is.
> +
> +# This currently works with ETMv4 / ETF not any other packet types at thi
> +# point. This will need changes if that changes.
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
> +	DATD="$PERF_TEST_CORESIGHT_DATADIR";
> +fi
> +# If the stat dir env is set then make the data dir use that instead of ./
> +STATD="."
> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
> +	STATD="$PERF_TEST_CORESIGHT_STATDIR";
> +fi
> +
> +# Called if the test fails - error code 1
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
> +	# amount of it. We should almost always see Fn packets in just about
> +	# anything but certainly we will see some trace info and async
> +	# packets
> +	DUMP="$DATD/perf-tmp-aux-dump.txt"
> +	perf report --stdio --dump -i "$1" | \
> +		grep -o -e I_ATOM_F -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
> +	# Simply count how many of these packets we find to see that we are
> +	# producing a reasonable amount of data - exact checks are not sane
> +	# as this is a lossy process where we may lose some blocks and the
> +	# compiler may produce different code depending on the compiler and
> +	# optimization options, so this is rough just to see if we're
> +	# either missing almost all the data or all of it
> +	ATOM_FX_NUM=`grep I_ATOM_F "$DUMP" | wc -l`
> +	ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
> +	TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
> +	rm -f "$DUMP"
> +
> +	# Arguments provide minimums for a pass
> +	CHECK_FX_MIN="$2"
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
> +		echo "ATOM Fx Count, Minimum, ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
> +	fi
> +	echo -n "$ATOM_FX_NUM, $CHECK_FX_MIN, $ASYNC_NUM, $CHECK_ASYNC_MIN, $TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
> +
> +	# Actually check to see if we passed or failed.
> +	check_val_min "ATOM_FX" "$ATOM_FX_NUM" "$CHECK_FX_MIN" "$STATF"
> +	check_val_min "ASYNC" "$ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
> +	check_val_min "TRACE_INFO" "$TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
> +	echo ", Ok" >> "$STATF"
> +}
> +
> +perf_dump_aux_tid_verify() {
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
> +	# No CID=xxx found - maybe your kernel is reporting these as
> +	# VMID=xxx so look there
> +	if test -z "$FOUND_TIDS"; then
> +		FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
> +				grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
> +				uniq | sort | uniq`
> +	fi

Just note, in theory we can check perf meta data and decide if use
VMID or CID as thread ID in the trace data.  But perf meta data doesn't
give direct info and need to parse the "TRCIDR2" field, this would
introduce complexity.

Current approach is simple, so let's keep it.

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

The patch LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> -- 
> 2.32.0
> 
