Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598084FE50C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356968AbiDLPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357287AbiDLPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:47:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C555DF25;
        Tue, 12 Apr 2022 08:45:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15ED91424;
        Tue, 12 Apr 2022 08:45:17 -0700 (PDT)
Received: from [10.1.30.135] (e127744.cambridge.arm.com [10.1.30.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218D23F70D;
        Tue, 12 Apr 2022 08:45:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] perf tools: Use Python devtools for version
 autodetection rather than runtime
From:   German Gomez <german.gomez@arm.com>
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220309194313.3350126-1-james.clark@arm.com>
 <20220309194313.3350126-2-james.clark@arm.com>
 <1262ee1e-22dc-0cc6-3e60-257e17d9ed26@arm.com>
Message-ID: <14df315d-7667-d80c-b58f-4ad6a6e1c93c@arm.com>
Date:   Tue, 12 Apr 2022 16:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1262ee1e-22dc-0cc6-3e60-257e17d9ed26@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/04/2022 16:30, German Gomez wrote:
> Hi James,
>
> On 09/03/2022 19:43, James Clark wrote:
>> This fixes the issue where the build will fail if only the Python2
>> runtime is installed but the Python3 devtools are installed. Currently
>> the workaround is 'make PYTHON=python3'.
>>
>> Fix it by autodetecting Python based on whether python[x]-config exists
>> rather than just python[x] because both are needed for the build. Then
>> -config is stripped to find the Python runtime.
>>
>> Testing
>> =======
>>
>>  * Auto detect links with Python3 when the v3 devtools are installed
>>    and only Python 2 runtime is installed
>>  * Auto detect links with Python2 when both devtools are installed
>>  * Sensible warning is printed if no Python devtools are installed
>>  * 'make PYTHON=x' still automatically sets PYTHON_CONFIG=x-config
>>  * 'make PYTHON=x' fails if x-config doesn't exist
> If x is a valid python but no x-config is found in the system, the build
> fails, instead of printing a warning like before. If we use this approach
> I think [1] in the Makefile is never hit and needs to be cleaned up.

Sorry, small correction:

The line in the Makefile is never hit when PYTHON is explicitly defined (probably not a big deal).

Still I wanted to point the small change in behaviour with the build warning vs. build fail.
