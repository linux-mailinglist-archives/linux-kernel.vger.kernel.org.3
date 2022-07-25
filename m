Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09D058010F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiGYOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:55:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BA54E0CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:55:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 689B82B;
        Mon, 25 Jul 2022 07:55:36 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5DB3F73D;
        Mon, 25 Jul 2022 07:55:34 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:55:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426180203.70782-1-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted
> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually, kstrtobool() can be utilized at such places but
> currently it doesn't have support to accept "false"/"true".
> 
> Add support to accept "false"/"true" as valid string in kstrtobool().
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I've just spotted that this broke arm64's "rodata=full" command line option,
since "full" gets parsed as 'f' = FALSE, when previously that would have been
rejected. So anyone passing "rodata=full" on the command line will have rodata
disabled, which is not what they wanted.

The current state of things is a bit messy (we prase the option twice because
arch code needs it early), and we can probably fix that with some refactoring,
but I do wonder if we actually want to open up the sysfs parsing to accept
anything *beginning* with [tTfF] rather than the full "true" and "false"
strings as previously, or whether it's worth reverting this for now in case
anything else is affected.

Mark.

> ---
> Chnages in v2:
> - kstrtobool to kstrtobool() in commit message.
> - Split single patch into 2
> - Remove strcmp usage from kstrtobool() and instead compare 1st
>   character only.
> 
> Changes in v3:
> - Covert -> Convert in patch 2 subject
> - Collected Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>  lib/kstrtox.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 886510d248e5..465e31e4d70d 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
>   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
>   * pointed to by res is updated upon finding a match.
>   */
> @@ -353,11 +353,15 @@ int kstrtobool(const char *s, bool *res)
>  	switch (s[0]) {
>  	case 'y':
>  	case 'Y':
> +	case 't':
> +	case 'T':
>  	case '1':
>  		*res = true;
>  		return 0;
>  	case 'n':
>  	case 'N':
> +	case 'f':
> +	case 'F':
>  	case '0':
>  		*res = false;
>  		return 0;
> -- 
> 2.35.1
> 
> 
