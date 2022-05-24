Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E52532B91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiEXNpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiEXNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:45:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EE4D954A5;
        Tue, 24 May 2022 06:45:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CAA61FB;
        Tue, 24 May 2022 06:45:52 -0700 (PDT)
Received: from [10.1.36.137] (e127744.cambridge.arm.com [10.1.36.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D7653F70D;
        Tue, 24 May 2022 06:45:48 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] perf test cs-etm: Add end-to-end tests for
 CoreSight decoding
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        james.clark@arm.com, leo.yan@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220523144952.364370-1-german.gomez@arm.com>
 <Yovo33Qh7eE7pTn1@kernel.org>
 <CAP-5=fVKcL5icCEaRRZT8Lh02=OsptJtaAk9JojwHNdyqcjvkw@mail.gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <6274f80b-a430-5392-8a28-e86541f57c05@arm.com>
Date:   Tue, 24 May 2022 14:45:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVKcL5icCEaRRZT8Lh02=OsptJtaAk9JojwHNdyqcjvkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian, Arnaldo, thanks a lot for your feedback

On 23/05/2022 22:29, Ian Rogers wrote:
> On Mon, May 23, 2022 at 1:05 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>> Em Mon, May 23, 2022 at 03:49:51PM +0100, German Gomez escreveu:
>>> Hi
>>>
>>> While discussing running more tests for CoreSight, we thought it might
>>> be a good idea to upstream some EndToEnd tests for CoreSight decoding in
>>> order to lock down the behaviour. I am sending this as RFC to get some
>>> feedback from the community first.
>>>
>>> The test relies on pre-geneated perf.data files that are downloaded
>>> during the test. I'm not sure it's a good idea to commit those files to
>>> the Linux repository, so they would have to live in an external source
>>> and be downloaded during the test.
>> That is ok, but please cache it locally, so that from the second 'perf
>> test' run onwards one doesn´t have to incur in the download delay and
>> also be able to run the tests while not connected.

Agreed, I will keep this in mind.

> I have some continuous tests running that don't have internet access.
> Could we have an environment variable to give a path to an already
> downloaded version? I may be able to fake having a cached downloaded
> version. Where would such a download live?

Yes sure, download location could be (in order of priority) $PERF_TEST_AUXTRACE_DECODER > $XDG_CACHE_HOME > ~/.cache. I can add a mechanism to override the download step if needed.

Also I think it would make sense for it to be generic/extensible for SPE and PT as well.

Imho best location for Arm files at the moment is github/ARM-software, since we already kind of use it for perf work (the pmu json files, for example). We also have gitlab.arm.com but I'm not very familiar with that one, or if it can be used at all.

Thanks,
German

>
> Thanks,
> Ian
>
>> - Arnaldo
>>
>>> For this RFC, the files are stored in a Github repository [1]. As an
>>> idea, I think we could store them in a new repo in the ARM-software
>>> namespace. Any hosting suggestions are very welcome.
>>>
>>> Thanks,
>>> German
>>>
>>> [1] https://github.com/ARM-software/data/tree/984cde8fb0bb22591e284826a80b338bb79c3655/perf/coresight
>>>
>>> German Gomez (1):
>>>   perf test cs-etm: Add end-to-end tests for CoreSight decoding
>>>
>>>  tools/perf/tests/shell/lib/arm_auxtrace.sh    | 21 +++++++
>>>  .../tests/shell/test_arm_coresight_decoder.sh | 57 +++++++++++++++++++
>>>  2 files changed, 78 insertions(+)
>>>  create mode 100644 tools/perf/tests/shell/lib/arm_auxtrace.sh
>>>  create mode 100755 tools/perf/tests/shell/test_arm_coresight_decoder.sh
>>>
>>> --
>>> 2.25.1
>> --
>>
>> - Arnaldo
