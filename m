Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937854E3F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiCVNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiCVNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:30:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B5624BE8;
        Tue, 22 Mar 2022 06:28:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A68D1042;
        Tue, 22 Mar 2022 06:28:56 -0700 (PDT)
Received: from [10.1.39.145] (e127744.cambridge.arm.com [10.1.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9636B3F73B;
        Tue, 22 Mar 2022 06:28:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] perf test arm64: Test unwinding using fame-pointer
 (fp) mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, leo.yan@linaro.org, Alexandre.Truong@arm.com,
        Jiri Olsa <jolsa@kernel.org>
References: <20220316172015.98000-1-german.gomez@arm.com>
 <592a32d6-b618-951c-9db9-711d022ff85e@arm.com>
 <b2ff473a-f252-89c9-78b3-bacff2876869@arm.com> <YjjlohvNAL8lKlV+@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <cebb404f-b40c-35f9-0395-32cb28a34ab6@arm.com>
Date:   Tue, 22 Mar 2022 13:27:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YjjlohvNAL8lKlV+@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/03/2022 20:52, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 16, 2022 at 05:48:50PM +0000, German Gomez escreveu:
>> On 16/03/2022 17:30, James Clark wrote:
>>> On 16/03/2022 17:20, German Gomez wrote:
>>>> Add a shell script to check that the call-graphs generated using frame
>>>> pointers (--call-graph fp) are complete and not missing leaf functions:
>>>>
>>>>   | $ perf test 88 -v
>>>>   |  88: Check Arm64 callgraphs are complete in fp mode                  :
>>>>   | --- start ---
>>>>   | test child forked, pid 8734
>>>>   |  + Compiling test program (/tmp/test_program.Cz3yL)...
>>>>   |  + Recording (PID=8749)...
>>>>   |  + Stopping perf-record...
>>>>   | test_program.Cz
>>>>   |                  728 leaf
>>>>   |                  753 parent
>>>>   |                  76c main
>>>>   | test child finished with 0
>>>>   | ---- end ----
>>>>   | Check Arm SPE callgraphs are complete in fp mode: Ok
>>>>
>>> Ran it on N1SDP and it passes, and it fails if b9f6fbb3b2c2 isn't applied.
>> I forgot to mention in the notes that it's supposed to work with both unwinders:
>>
>> $ make                # for libunwind (default)
>> $ make NO_LIBUNWIND=1 # for libdw
> I'll add it to the cset commit log, and also will fix this:
>
> ⬢[acme@toolbox perf]$        git am ./v2_20220316_german_gomez_perf_test_arm64_test_unwinding_using_fame_pointer_fp_mode.mbx
> Applying: perf test arm64: Test unwinding using fame-pointer (fp) mode
> .git/rebase-apply/patch:72: trailing whitespace.
> # program
> warning: 1 line adds whitespace errors.
> tools/perf/tests/shell/test_arm_callgraph_fp.sh:58: trailing whitespace.
> +# program
> ⬢[acme@toolbox perf]$
>  

Thanks Arnaldo, I forgot to run the checkpatch script.

>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>
>>>> Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
>>>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>>>> Signed-off-by: German Gomez <german.gomez@arm.com>
