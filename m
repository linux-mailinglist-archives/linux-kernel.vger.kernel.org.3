Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59B478ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhLQPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:00:23 -0500
Received: from foss.arm.com ([217.140.110.172]:58430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237743AbhLQPAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:00:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572B11435;
        Fri, 17 Dec 2021 07:00:21 -0800 (PST)
Received: from [10.57.83.65] (unknown [10.57.83.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156CF3F774;
        Fri, 17 Dec 2021 07:00:19 -0800 (PST)
Message-ID: <5c509114-f383-2876-36ae-8648d886a09e@arm.com>
Date:   Fri, 17 Dec 2021 15:00:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 02/12] perf test: Shell - only run .sh shell files to skip
 other files
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        inux-perf-users@vger.kernel.org, acme@kernel.org
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211215160403.69264-2-carsten.haitzler@foss.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2021 16:03, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> You edit your scripts in the tests and end up with your usual shell
> backup files with ~ or .bak or something else at the end, but then your
> next perf test run wants to run the backups too. You might also have perf
> .data files in the directory or something else undesireable as well. You end
> up chasing which test is the one you edited and the backup and have to keep
> removing all the backup files, so automatically skip any files that are
> not plain *.sh scripts to limit the time wasted in chasing ghosts.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>   tools/perf/tests/builtin-test.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index ece272b55587..849737ead9fd 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -297,7 +297,20 @@ static const char *shell_test__description(char *description, size_t size,
>   	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
>   		if (!is_directory(base, ent) && \
>   			is_executable_file(base, ent) && \
> -			ent->d_name[0] != '.')
> +			ent->d_name[0] != '.' && \
> +			(shell_file_is_sh(ent->d_name) == 0))
> +
> +static int shell_file_is_sh(const char *file)

nit: In line with the other "helpers", could this be:

is_shell_file_sh() or even is_shell_script() ?

Also, for consistency, could this be bool, like the other helpers ?

i.e., returns true when the condition matches ?

Suzuki

> +{
> +	const char *ext;
> +
> +	ext = strchr(file, '.');
> +	if (!ext)
> +		return -1;
> +	if (!strcmp(ext, ".sh"))
> +		return 0;
> +	return -1;
> +}


>   
>   static const char *shell_tests__dir(char *path, size_t size)
>   {

