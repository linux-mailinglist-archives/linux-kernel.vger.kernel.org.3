Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E59573AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiGMQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiGMQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:02:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F850181;
        Wed, 13 Jul 2022 09:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62047B820D6;
        Wed, 13 Jul 2022 16:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB411C34114;
        Wed, 13 Jul 2022 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728155;
        bh=0x7la21sx0eXpWEyHVI4LAHH8EFkUPLyeiwrINqKQwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i0rDRvXCD2agdvFTtmYpi2THI4Nae0zbbA+hI6/F0lLe6dDQuxOP06s/qRXSTUlpJ
         ZQKK/s/DUnJzUBOJ0/CCzyJSCi3G52ztdC9MsP2WI1J3tbZb1wdmhdgVvB/KbKQMKh
         pHu9/9arqbvertIappvNpaFz3FC2YrptGirOAOLQTaq7J3jy4Bp1r5ln9tvC5diYSs
         yhWrds+OTMwVsegDB6TZAWZEMe2vjDb5cdYKmRNtS+hUy0F9FSWAlXMG7vi2TMkKsa
         q5e/HfE//IrBeP6/TY7UvT2iUh38ebMfmeqaZ2KCWmyEC/ZAYuKyvdZ8yzoGoRGWAU
         +sE9afk3Ll04g==
Date:   Wed, 13 Jul 2022 17:12:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michal Simek <michal.simek@amd.com>,
        Conall O'Griofa <conall.o'griofa@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Message-ID: <20220713171223.01005ca7@jic23-huawei>
In-Reply-To: <YsMSvSJdc/eVqnYU@smile.fi.intel.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
        <20220603183224.540b3808@jic23-huawei>
        <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
        <YsBYvPKfZRLygCyz@smile.fi.intel.com>
        <1d6eba67-5a63-e1b2-c9cd-583b950ddca6@amd.com>
        <YsMSvSJdc/eVqnYU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 19:18:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jul 04, 2022 at 12:43:26PM +0200, Michal Simek wrote:
> > On 7/2/22 16:39, Andy Shevchenko wrote:  
> > > On Mon, Jun 20, 2022 at 04:58:04PM +0200, Michal Simek wrote:  
> 
> ...
> 
> > > Hmm... No news?  
> > 
> > Anand unfortunately left the company. I have asked testing team to test this
> > patch and they can't see any issue.
> > That's why:
> > Acked-by: Michal Simek <michal.simek@amd.com>  
> 
> Ah, thanks! Jonathan, I guess we are set to apply now.
> 

Applied to the togreg branch of iio.git and pushed out as testing for all the
normal reasons.

Thanks,

Jonathan
