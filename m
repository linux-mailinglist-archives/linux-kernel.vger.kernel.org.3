Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87350F9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348622AbiDZKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348217AbiDZKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:16:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFD43EE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:39:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B996C1F380;
        Tue, 26 Apr 2022 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650965997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7V6avl/Taxkxq9jRUXbRTBaIMWYoELnXIpQtCKh1xI=;
        b=j1ldpkIhJCSJFnZt/VETy+Zd9UALftvtxyqHAOOUipcj7XN2FG5mgWRrWgxXhzrWbiYOKL
        7BuXdDafAVudfJwpG+zpskDCIwJO36oSu6qMrKKowJwLwOvbutrSW35E3euNoAwqIMaWlO
        TfAYckKO9tgV9q+Jh7nu2kq54SjyTuY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AC552C1EC;
        Tue, 26 Apr 2022 09:39:57 +0000 (UTC)
Date:   Tue, 26 Apr 2022 11:39:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool
Message-ID: <Yme97bRH3hLcqGfC@alley>
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426064001.14241-1-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-26 12:10:01, Jagdish Gediya wrote:
> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted
> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually, kstrtobool can be utilized at such places but
> currently kstrtobool doesn't have support to "false"/"true".
>
> Add "false"/"true" support to kstrtobool while string conversion
> to bool. Modify existing manual sysfs conversions to use kstrtobool().

It looks reasonable. I would just do it slightly other way, see
below.

> This patch doesn't have any functionality change.

This is not true. All kstrtobool() callers will react differently
on the "true"/"false" input.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
> change in v2:
> Modified kstrtobool to handle "false"/"true". Removed
> new function sysfs_strbool introduced in v1.
> 
>  lib/kstrtox.c   | 7 +++++++
>  mm/migrate.c    | 6 +-----
>  mm/swap_state.c | 6 +-----
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 886510d248e5..3a5e29557838 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -377,6 +377,13 @@ int kstrtobool(const char *s, bool *res)
>  		}
>  		break;
>  	default:
> +		if (!strncmp(s, "true", 4)) {
> +			*res = true;
> +			return 0;
> +		} else if (!strncmp(s, "false", 5)) {
> +			*res = false;
> +			return 0;

It should be enough to check the first letter like we do in
the other cases. I mean to set true when s[0] is 'T' or 't'
and false when s[0] is 'F' or 'f'.

Also please update comment above the function definition.


> +		}
>  		break;
>  	}
>  

Best Regards,
Petr
