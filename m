Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6A5795C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiGSJH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGSJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:07:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E18010E2;
        Tue, 19 Jul 2022 02:07:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C841424;
        Tue, 19 Jul 2022 02:07:24 -0700 (PDT)
Received: from [10.32.33.51] (e121896.warwick.arm.com [10.32.33.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A1953F73D;
        Tue, 19 Jul 2022 02:07:23 -0700 (PDT)
Message-ID: <eeec10a3-e9e7-ba7f-34e0-cded9d4af76e@arm.com>
Date:   Tue, 19 Jul 2022 10:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: A patch series improving data quality of perf test for CoreSight
Content-Language: en-US
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2022 14:57, carsten.haitzler@foss.arm.com wrote:
> This is a prelude to adding more tests to shell tests and in order to
> support putting those tests into subdirectories, I need to change the
> test code that scans/finds and runs them.
> 
> To support subdirs I have to recurse so it's time to refactor the code to
> allow this and centralize the shell script finding into one location and
> only one single scan that builds a list of all the found tests in memory
> instead of it being duplicated in 3 places.
> 
> This code also optimizes things like knowing the max width of desciption
> strings (as we can do that while we scan instead of a whole new pass
> of opening files). It also more cleanly filters scripts to see only
> *.sh files thus skipping random other files in directories like *~
> backup files, other random junk/data files that may appear and the
> scripts must be executable to make the cut (this ensures the script
> lib dir is not seen as scripts to run). This avoids perf test running
> previous older versions of test scripts that are editor backup files
> as well as skipping perf.data files that may appear and so on.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> 

Hi Carsten,

What's the plan to move forward with the current test failures? As you
said in the previous patchset it seems that we're not 100% sure if the
failures are a Coresight bug or a test bug.

Do you want to investigate to see what the issue might be? Or do you
intend to leave that to someone else?

Even if it is a Coresight bug rather than a test bug, we shouldn't
merge them because it will cause anyone running the tests to wonder if
they have done something wrong or to duplicate the investigation work,
or that a regression has been added to the kernel.

Thanks
James
