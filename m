Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10685730C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiGMIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiGMIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:17:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C2ACEEA9E;
        Wed, 13 Jul 2022 01:14:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E1181424;
        Wed, 13 Jul 2022 01:14:17 -0700 (PDT)
Received: from [10.57.86.222] (unknown [10.57.86.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99C673F792;
        Wed, 13 Jul 2022 01:14:15 -0700 (PDT)
Message-ID: <524ce022-fbdb-418d-d924-a9c510f3a769@arm.com>
Date:   Wed, 13 Jul 2022 09:14:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: A patch series improving data quality of perf test for CoreSight
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
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

Hi Carsten


On 12/07/2022 14:57, carsten.haitzler@foss.arm.com wrote:
> This is a prelude to adding more tests to shell tests and in order to
> support putting those tests into subdirectories, I need to change the
> test code that scans/finds and runs them.

Please could you add versioning to your series and a changelog of what
changed from one version to the other ? That way, it is easier for the
reviewers to understand and spend their time effectively on the newer
changes.

If you are using git format-patch, you could use -v <N> for the version
number in all your patches.

e.g,

https://lkml.kernel.org/r/20220414064457.12052-1-mike.leach@linaro.org

nit on Subject: This could be:

perf: test: Add trace data quality tests for CoreSight

where "perf" is the linux subsystem you are targeting and
  "test" is the specific area you are contributing. That helps
the reviewers to filter the series in a mailing list with
hundreds of emails.

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

It is also a good idea to have the diffstat of the series in the cover 
letter to give the people an idea of where the changes are touching.

git format-patch automatically gives you this if you add --cover-letter
option.

Suzuki

> 

