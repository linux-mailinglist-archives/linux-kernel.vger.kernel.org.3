Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CCC5801C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiGYPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiGYPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:21:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143EC12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23s7JvNMsvF2AHH6z4dTYojuhFk5VWrqF+qCO533ufA=; b=W93GVpt2rUDlsdSMVN2WEF1b1L
        92Q01zwXWnid6eWuVyRdi9ZCfnSJo5uxeqjPUcnJFtexKzHFcGPAQ5cbW1y5MSMsZh1I5Wv8L92yS
        K2I794tOgXYlEmbsaE9+zvqHuK/k7VGgB+Z/MjCJ9+hXCVeOclQ4ExRSi2LiGSq0su206Iu+uMzuX
        5G8SuXckL4PQbem6QS/Je8gPoF+z5hSd/8MzfPrwISD/NBNBKbNMIt0FshZSJVEBzPTdwyiycU1+t
        A/iI7WaxWY7AXC0sLGW3tXXkAIkBBzpGNstPLEN4ZtOAogqqqbgkpqofPWXc5r5Pk/j6dTQ72Cl5n
        0nR3VqUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oFztP-001Cg9-BV; Mon, 25 Jul 2022 15:21:11 +0000
Date:   Mon, 25 Jul 2022 16:21:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, will@kernel.org
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <Yt605xj898VSAsA3@casper.infradead.org>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:
> On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > At many places in kernel, It is necessary to convert sysfs input
> > to corrosponding bool value e.g. "false" or "0" need to be converted
> > to bool false, "true" or "1" need to be converted to bool true,
> > places where such conversion is needed currently check the input
> > string manually, kstrtobool() can be utilized at such places but
> > currently it doesn't have support to accept "false"/"true".
> > 
> > Add support to accept "false"/"true" as valid string in kstrtobool().
> > 
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I've just spotted that this broke arm64's "rodata=full" command line option,

That isn't a documented option.

        rodata=         [KNL]
                on      Mark read-only kernel memory as read-only (default).
                off     Leave read-only kernel memory writable for debugging.

Hopefully this is an object lesson in why you need to update the
documentation when you extend a feature.

> since "full" gets parsed as 'f' = FALSE, when previously that would have been
> rejected. So anyone passing "rodata=full" on the command line will have rodata
> disabled, which is not what they wanted.
> 
> The current state of things is a bit messy (we prase the option twice because
> arch code needs it early), and we can probably fix that with some refactoring,
> but I do wonder if we actually want to open up the sysfs parsing to accept
> anything *beginning* with [tTfF] rather than the full "true" and "false"
> strings as previously, or whether it's worth reverting this for now in case
> anything else is affected.

Well, that's going to break people who've started using the new option.
As a quick fix, how about only allowing either "f\0" or "fa"?
