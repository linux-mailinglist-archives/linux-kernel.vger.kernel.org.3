Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABE54D9DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349231AbiCOOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiCOOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:35:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6B6914019;
        Tue, 15 Mar 2022 07:33:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6857B1474;
        Tue, 15 Mar 2022 07:33:57 -0700 (PDT)
Received: from [10.1.26.153] (e127744.cambridge.arm.com [10.1.26.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 423853F66F;
        Tue, 15 Mar 2022 07:33:55 -0700 (PDT)
Subject: Re: [PATCH] perf test arm64: Test unwinding using fame-pointer (fp)
 mode
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, acme@kernel.org
References: <20220301133414.11766-1-german.gomez@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <a6ba0ea8-f070-9f79-f018-f638ff677c7c@arm.com>
Date:   Tue, 15 Mar 2022 14:32:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220301133414.11766-1-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/03/2022 13:34, German Gomez wrote:
> Add a shell script to check that the call-graphs generated using frame
> pointers (--call-graph fp) are complete and not missing leaf functions:
>
> [...]
>
> +cat << EOF > $TEST_PROGRAM_SOURCE
> +int a = 0;
> +void leaf(void) {
> +  for (;;)
> +    a += a;
> +}
> +void parent(void) {
> +  leaf();
> +}
> +int main(void) {
> +  parent();
> +  return 0;
> +}
> +EOF
> +
> +echo " + Compiling test program ($TEST_PROGRAM)..."
> +CFLAGS="-O0 -fno-inline -fno-omit-frame-pointer"

This fails when the test program is compiled with gcc-7, due to missing -g flag.

I will re-spin with this fixed.

> +cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> +
> +# Add a 1 second delay to skip samples that are not in the leaf() function
> +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> +PID=$!
> +echo " + Recording (PID=$PID)..."
> +sleep 2
> +echo " + Stopping perf-record..."
> +kill $PID
> +wait $PID
> +
> +# example perf-script output:
> +#
> +# program 
> +# 	728 leaf
> +# 	753 parent
> +# 	76c main
> +# ...
> +
> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4
> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4 |
> +	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
> +						       sym[1] != "parent" ||
> +						       sym[2] != "main") exit 1 }'
