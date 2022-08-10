Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE258E8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiHJIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiHJIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:40:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAD142BB0C;
        Wed, 10 Aug 2022 01:40:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6C51FB;
        Wed, 10 Aug 2022 01:40:56 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96AA3F70D;
        Wed, 10 Aug 2022 01:40:54 -0700 (PDT)
Message-ID: <efadadfb-4aa7-9786-c297-8f073b4e97be@foss.arm.com>
Date:   Wed, 10 Aug 2022 09:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 02/14] perf test: Add CoreSight shell lib shared code
 for future tests
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-3-carsten.haitzler@foss.arm.com>
 <20220806094055.GB124146@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220806094055.GB124146@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/22 10:40, Leo Yan wrote:
> On Thu, Jul 28, 2022 at 03:52:44PM +0100, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> This adds a library of shell "code" to be shared and used by future
>> tests that target quality testing for Arm CoreSight support in perf
>> and the Linux kernel.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   tools/perf/tests/shell/lib/coresight.sh | 132 ++++++++++++++++++++++++
>>   1 file changed, 132 insertions(+)
>>   create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>>
>> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
>> new file mode 100644
> 
> Now one thing is tricky.  Since we scan sub directories, all scripts
> under the folder "tools/perf/tests/shell/lib/" are not added into the
> test list, this is because the scripts under this folder have no the
> executable (X) permission:
> 
> -rw-rw-r-- 1 leoy leoy 4675 Aug  6 17:03 coresight.sh
> -rw-rw-r-- 1 leoy leoy  329 Jul 27 09:37 probe.sh
> -rw-rw-r-- 1 leoy leoy  812 Jul 27 09:37 probe_vfs_getname.sh
> 
> I verified with command "perf list" and it works as expected.

Correct. the code takes advantage of this and skips things that are not 
+x as these will be assumed to be "library files".

>> index 000000000000..45a1477256b6
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/lib/coresight.sh
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +# This is sourced from a driver script so no need for #!/bin... etc. at the
>> +# top - the assumption below is that it runs as part of sourcing after the
>> +# test sets up some basic env vars to say what it is.
>> +
>> +# This currently works with ETMv4 / ETF not any other packet types at thi
>> +# point. This will need changes if that changes.
>> +
>> +# perf record options for the perf tests to use
>> +PERFRECMEM="-m ,16M"
>> +PERFRECOPT="$PERFRECMEM -e cs_etm//u"
>> +
>> +TOOLS=$(dirname $0)
>> +DIR="$TOOLS/$TEST"
>> +BIN="$DIR/$TEST"
>> +# If the test tool/binary does not exist and is executable then skip the test
>> +if ! test -x "$BIN"; then exit 2; fi
>> +DATD="."
>> +# If the data dir env is set then make the data dir use that instead of ./
>> +if test -n "$PERF_TEST_CORESIGHT_DATADIR"; then
>> +	DATD="$PERF_TEST_CORESIGHT_DATADIR";
>> +fi
>> +# If the stat dir env is set then make the data dir use that instead of ./
>> +STATD="."
>> +if test -n "$PERF_TEST_CORESIGHT_STATDIR"; then
>> +	STATD="$PERF_TEST_CORESIGHT_STATDIR";
>> +fi
>> +
>> +# Called if the test fails - error code 1
>> +err() {
>> +	echo "$1"
>> +	exit 1
>> +}
>> +
>> +# Check that some statistics from our perf
>> +check_val_min() {
>> +	STATF="$4"
>> +	if test "$2" -lt "$3"; then
>> +		echo ", FAILED" >> "$STATF"
>> +		err "Sanity check number of $1 is too low ($2 < $3)"
>> +	fi
>> +}
>> +
>> +perf_dump_aux_verify() {
>> +	# Some basic checking that the AUX chunk contains some sensible data
>> +	# to see that we are recording something and at least a minimum
>> +	# amount of it. We should almost always see Fn packets in just about
>> +	# anything but certainly we will see some trace info and async
>> +	# packets
>> +	DUMP="$DATD/perf-tmp-aux-dump.txt"
>> +	perf report --stdio --dump -i "$1" | \
>> +		grep -o -e I_ATOM_F -e I_ASYNC -e I_TRACE_INFO > "$DUMP"
>> +	# Simply count how many of these packets we find to see that we are
>> +	# producing a reasonable amount of data - exact checks are not sane
>> +	# as this is a lossy process where we may lose some blocks and the
>> +	# compiler may produce different code depending on the compiler and
>> +	# optimization options, so this is rough just to see if we're
>> +	# either missing almost all the data or all of it
>> +	ATOM_FX_NUM=`grep I_ATOM_F "$DUMP" | wc -l`
>> +	ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
>> +	TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
>> +	rm -f "$DUMP"
>> +
>> +	# Arguments provide minimums for a pass
>> +	CHECK_FX_MIN="$2"
>> +	CHECK_ASYNC_MIN="$3"
>> +	CHECK_TRACE_INFO_MIN="$4"
>> +
>> +	# Write out statistics, so over time you can track results to see if
>> +	# there is a pattern - for example we have less "noisy" results that
>> +	# produce more consistent amounts of data each run, to see if over
>> +	# time any techinques to  minimize data loss are having an effect or
>> +	# not
>> +	STATF="$STATD/stats-$TEST-$DATV.csv"
>> +	if ! test -f "$STATF"; then
>> +		echo "ATOM Fx Count, Minimum, ASYNC Count, Minimum, TRACE INFO Count, Minimum" > "$STATF"
>> +	fi
>> +	echo -n "$ATOM_FX_NUM, $CHECK_FX_MIN, $ASYNC_NUM, $CHECK_ASYNC_MIN, $TRACE_INFO_NUM, $CHECK_TRACE_INFO_MIN" >> "$STATF"
>> +
>> +	# Actually check to see if we passed or failed.
>> +	check_val_min "ATOM_FX" "$ATOM_FX_NUM" "$CHECK_FX_MIN" "$STATF"
>> +	check_val_min "ASYNC" "$ASYNC_NUM" "$CHECK_ASYNC_MIN" "$STATF"
>> +	check_val_min "TRACE_INFO" "$TRACE_INFO_NUM" "$CHECK_TRACE_INFO_MIN" "$STATF"
>> +	echo ", Ok" >> "$STATF"
>> +}
>> +
>> +perf_dump_aux_tid_verify() {
>> +	# Specifically crafted test will produce a list of Tread ID's to
>> +	# stdout that need to be checked to  see that they have had trace
>> +	# info collected in AUX blocks in the perf data. This will go
>> +	# through all the TID's that are listed as CID=0xabcdef and see
>> +	# that all the Thread IDs the test tool reports are  in the perf
>> +	# data AUX chunks
>> +
>> +	# The TID test tools will print a TID per stdout line that are being
>> +	# tested
>> +	TIDS=`cat "$2"`
>> +	# Scan the perf report to find the TIDs that are actually CID in hex
>> +	# and build a list of the ones found
>> +	FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
>> +			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
>> +			uniq | sort | uniq`
>> +	# No CID=xxx found - maybe your kernel is reporting these as
>> +	# VMID=xxx so look there
>> +	if test -z "$FOUND_TIDS"; then
>> +		FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
>> +				grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
>> +				uniq | sort | uniq`
>> +	fi
> 
> Just note, in theory we can check perf meta data and decide if use
> VMID or CID as thread ID in the trace data.  But perf meta data doesn't
> give direct info and need to parse the "TRCIDR2" field, this would
> introduce complexity.
> 
> Current approach is simple, so let's keep it.

A simple approach at least is easier to maintain here. so we're in 
agreement. :)

>> +
>> +	# Iterate over the list of TIDs that the test says it has and find
>> +	# them in the TIDs found in the perf report
>> +	MISSING=""
>> +	for TID2 in $TIDS; do
>> +		FOUND=""
>> +		for TIDHEX in $FOUND_TIDS; do
>> +			TID=`printf "%i" $TIDHEX`
>> +			if test "$TID" -eq "$TID2"; then
>> +				FOUND="y"
>> +				break
>> +			fi
>> +		done
>> +		if test -z "$FOUND"; then
>> +			MISSING="$MISSING $TID"
>> +		fi
>> +	done
>> +	if test -n "$MISSING"; then
>> +		err "Thread IDs $MISSING not found in perf AUX data"
>> +	fi
>> +}
> 
> The patch LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
>> -- 
>> 2.32.0
>>
