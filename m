Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DF5AAECC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiIBM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiIBM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:28:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04714DA3E1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662121469; x=1693657469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6uviH47qBS+1ubtoWU7lHAlPaOBxaxFqehrVN7z4xgk=;
  b=jX4HtrV6KrEBaG1rq2UzLB8qHFpredMxu6Utc6fcORhLh9Bj1d78/K5A
   CbbFXGwZjhNgEGmDUKN4q/86oiyZtyjUW8HeF7mlddz5A1jMbq6mJJVnM
   lsIsogtUQz6Li1YQTTk/LA7BceGb4iKW/Ok2lgYd+k3ewGYBT+O78BPf0
   ZhqgsuLgOE4jbb/O68ycehS2G2bMsolwjTVqmxBN90tpyPrCh+nasVvnU
   m5peqqW5l8+0JlwjOe29ctjvwv+dujDfpUT7WZwH0RhaPwRi4woey1Ypa
   uo76qjt7xDhgdDHOlzzC2fcEa1M8/QiEaQUF015uqyjtF5U1Y0vW02dF6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293546063"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="293546063"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:23:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941272739"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.248]) ([10.99.241.248])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:23:12 -0700
Message-ID: <e48ffb56-f220-adf5-87ca-1826397f2e7f@linux.intel.com>
Date:   Fri, 2 Sep 2022 14:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] lib/string_helpers: Introduce
 parse_int_array_user()
Content-Language: en-US
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, andy@kernel.org,
        intel-poland@eclists.intel.com, andy.shevchenko@gmail.com
References: <20220902122928.632602-1-cezary.rojewski@intel.com>
 <20220902122928.632602-2-cezary.rojewski@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220902122928.632602-2-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2022 2:29 PM, Cezary Rojewski wrote:
> Add new helper function to allow for splitting specified user string
> into a sequence of integers. Internally it makes use of get_options() so
> the returned sequence contains the integers extracted plus an additional
> element that begins the sequence and specifies the integers count.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   include/linux/string_helpers.h |  2 ++
>   lib/string_helpers.c           | 45 ++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 4d72258d42fd..dc2e726fd820 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -21,6 +21,8 @@ enum string_size_units {
>   void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
>   		     char *buf, int len);
>   
> +int parse_int_array_user(const char __user *from, size_t count, int **array);
> +
>   #define UNESCAPE_SPACE		BIT(0)
>   #define UNESCAPE_OCTAL		BIT(1)
>   #define UNESCAPE_HEX		BIT(2)
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 5ed3beb066e6..d0c8f6ecf84c 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -131,6 +131,51 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>   }
>   EXPORT_SYMBOL(string_get_size);
>   
> +/**
> + * parse_int_array_user - Split string into a sequence of integers
> + * @from:	The user space buffer to read from
> + * @ppos:	The current position in the buffer

There is no such parameter?

> + * @count:	The maximum number of bytes to read
> + * @tkns:	Returned pointer to sequence of integers

s/tkns/array/ ?

> + *
> + * On success @tkns is allocated and initialized with a sequence of

ditto

> + * integers extracted from the @from plus an additional element that
> + * begins the sequence and specifies the integers count.
> + *
> + * Caller takes responsibility for freeing @tkns when it is no longer

ditto

> + * needed.
> + */
> +int parse_int_array_user(const char __user *from, size_t count, int **array)
> +{
> +	int *ints, nints;
> +	char *buf;
> +	int ret = 0;
> +
> +	buf = memdup_user_nul(from, count);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	get_options(buf, 0, &nints);
> +	if (!nints) {
> +		ret = -ENOENT;
> +		goto free_buf;
> +	}
> +
> +	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
> +	if (!ints) {
> +		ret = -ENOMEM;
> +		goto free_buf;
> +	}
> +
> +	get_options(buf, nints + 1, ints);
> +	*array = ints;
> +
> +free_buf:
> +	kfree(buf);
> +	return ret;
> +}
> +EXPORT_SYMBOL(parse_int_array_user);
> +
>   static bool unescape_space(char **src, char **dst)
>   {
>   	char *p = *dst, *q = *src;

