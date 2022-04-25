Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1450EC02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiDYW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbiDYWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:03:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71E2AED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ABD6B81ACD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCACC385A7;
        Mon, 25 Apr 2022 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650924047;
        bh=D/VDL1DahBoKxuAKBJl+6cBrdh/4mvjtNLDy8kSYqLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OTvaaRx+WZC2FTgPWUF92ffX7vNnsCvJ6xGzm3EYYE+onLaPH8ue4af3+31PLTHFQ
         +8nJQqfkcm2RPP7Ibj38OVAk1WzMIa3swMC+VomMeRFckVw0CQGDAYWMBFgHxsKjB+
         KKqgUwCcumKjax0obedXSG38hajcEmIeMkSJOTbE=
Date:   Mon, 25 Apr 2022 15:00:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     andy@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        minchan@kernel.org, ying.huang@intel.com, dave.hansen@intel.com
Subject: Re: [RESEND PATCH] string_helpers: sysfs: Add helper to get bool
 from string
Message-Id: <20220425150046.e23a0198e0076221549eb7cf@linux-foundation.org>
In-Reply-To: <20220425085233.82576-1-jvgediya@linux.ibm.com>
References: <20220425085233.82576-1-jvgediya@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 14:22:33 +0530 Jagdish Gediya <jvgediya@linux.ibm.com> wrote:

> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted
> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually. Also, such conversions compare sysfs input using
> strncmp functions so even if certain number of character match in the
> beginning, they assume the string as valid bool, which is not the
> right semantic e.g. false is bool but falseX is not.
> 
> Introduce new string helper function to convert sysfs input to
> corrosponding bool value. Modify existing such conversions to use
> this new function.
> 
> logs,
> $ cat /sys/kernel/mm/numa/demotion_enabled
> false
> $ echo true > /sys/kernel/mm/numa/demotion_enabled
> $ cat demotion_enabled
> true
> $ echo truex > /sys/kernel/mm/numa/demotion_enabled
> -bash: echo: write error: Invalid argument
> $ echo 10 > /sys/kernel/mm/numa/demotion_enabled
> -bash: echo: write error: Invalid argument
> $ echo false > /sys/kernel/mm/numa/demotion_enabled
> $ cat demotion_enabled
> false
> $ echo falseabc > /sys/kernel/mm/numa/demotion_enabled
> -bash: echo: write error: Invalid argument
> $ echo 1 > /sys/kernel/mm/numa/demotion_enabled
> $ cat demotion_enabled
> true
> $ echo 0 > /sys/kernel/mm/numa/demotion_enabled
> $ cat demotion_enabled
> false
> 
> This patch doesn't have any functionality change.
> 
> ...
>
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -967,6 +967,26 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>  }
>  EXPORT_SYMBOL(memcpy_and_pad);
>  
> +/**
> + * sysfs_strbool - Get bool value corrosponding to string
> + * @s: The string to operate on.
> + * @output: Pointer to fill resulting bool value
> + *
> + * Returns 1 if string represents bool value, 0 otherwise
> + */
> +int sysfs_strbool(const char *s, bool *output)
> +{
> +	if (sysfs_streq(s, "1") || sysfs_streq(s, "true"))
> +		*output = true;
> +	else if (sysfs_streq(s, "0") || sysfs_streq(s, "false"))
> +		*output = false;
> +	else
> +		return 0;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(sysfs_strbool);
> +

Can we teach kstrtobool() about "true" and "false" then use that?
