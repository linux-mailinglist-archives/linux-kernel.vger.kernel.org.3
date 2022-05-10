Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B05B522173
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiEJQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347516AbiEJQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:45:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB6A20F76;
        Tue, 10 May 2022 09:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD8B7CE1F67;
        Tue, 10 May 2022 16:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B157CC385A6;
        Tue, 10 May 2022 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652200879;
        bh=eGdI0y4JA01sgyI0D77HB0ALql3h9OITV0p7QgmJftA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ1QcKXX5K06VK8x4Yy3btxnV0Ln9te1ufkK0P6Yn8p+PHNehE/b8uAkQMNeId9To
         KY2K+jxPmQE0Uh+QO3Rw76isaGY38wHz4Xq8Z03iPas08eUxJGbMchMVLoxJrTuarm
         kmVCZ2vERbM9AvZtlsmykTIEbE9Iwo0WGPjDT8qXoOZUtVfpmAPgV//CS9Q1xVQ87G
         l7FTNg8WmbN3nfVpg/CNMc0El496+ydUnPkU+FfastBE/UPgNFUEVFGpF0ajz2cvyV
         lbym5XI3rbAtS3G1BILmbKxzEGJWbzURdOcLHqt+0nYkW6jHmj7RCZAbZ6QY64+087
         fdfksoxiMeYxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 019AE400B1; Tue, 10 May 2022 13:41:14 -0300 (-03)
Date:   Tue, 10 May 2022 13:41:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] perf pmu: Add function to check if a pmu file exists
Message-ID: <YnqVqq5QW/b14oPZ@kernel.org>
References: <20220504150216.581281-1-german.gomez@arm.com>
 <20220504150216.581281-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504150216.581281-2-german.gomez@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 04, 2022 at 04:02:12PM +0100, German Gomez escreveu:
> Add a utility function perf_pmu__file_exists() to check if a given pmu
> file exists in the sysfs filesystem.

While reviewing this I noticed:

int perf_pmu__caps_parse(struct perf_pmu *pmu)
{
        struct stat st;
        char caps_path[PATH_MAX];
        const char *sysfs = sysfs__mountpoint();
        DIR *caps_dir;
        struct dirent *evt_ent;
        int nr_caps = 0;

        if (!sysfs)
                return -1;

        snprintf(caps_path, PATH_MAX,
                 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);

        if (stat(caps_path, &st) < 0)
                return 0;       /* no error if caps does not exist */


------------------------

Shouldn't we introduce a:

const int perf__pmu_pathname_scnprintf(struct perf_pmu *pmu, char *pathname, size_t size, char *filename)
{

	return scnprintf(pathname, size, "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, filename);
}

And use in your perf_pmu__file_exists() and in the other places where
this open coded pattern appears?

I'm waiting for reviews for the ARM specific bits.

- Arnaldo
 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/pmu.c | 17 +++++++++++++++++
>  tools/perf/util/pmu.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 9a1c7e63e663..9479e9a4da54 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1854,6 +1854,23 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>  	return ret;
>  }
>  
> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
> +{
> +	char path[PATH_MAX];
> +	struct stat statbuf;
> +	const char *sysfs = sysfs__mountpoint();
> +
> +	if (!sysfs)
> +		return false;
> +
> +	snprintf(path, PATH_MAX,
> +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
> +	if (!file_available(path))
> +		return false;
> +
> +	return stat(path, &statbuf) == 0;
> +}
> +
>  static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
>  {
>  	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 541889fa9f9c..ab728eaf13b6 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -120,6 +120,8 @@ bool pmu_have_event(const char *pname, const char *name);
>  
>  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
>  
> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
> +
>  int perf_pmu__test(void);
>  
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
> -- 
> 2.25.1

-- 

- Arnaldo
