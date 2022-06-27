Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B383855CAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiF0PEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiF0PEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A4167CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6149F615B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE29C3411D;
        Mon, 27 Jun 2022 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656342242;
        bh=YsKjrEb0ud1B28xSx98ye6oo+vg3Tz7dJdUJTyfsPV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+EKKHCVm2hnCNS2sh53Y9S3iLc/Bd9nZZVz9N/Fd5DHh51GCAVH92KOSHSOMc97/
         9d8l/KYhsx0X3pRGgzkKmJItiLgODBqgD2mzLNMpjg5NAmRCY7qTPd0G5PD1qH9Cof
         +PsWiH76Df8RI3yOhZPohUrPDgAsnmPIUIAKjBao=
Date:   Mon, 27 Jun 2022 17:03:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liang He <windhl@126.com>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        michal.simek@xilinx.com, abhyuday.godhasara@xilinx.com,
        simont@opensource.cirrus.com, ronak.jain@xilinx.com,
        peng.fan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] firmware: Hold a reference for
 of_find_compatible_node()
Message-ID: <YrnG3ymy0dg/VPQs@kroah.com>
References: <20220621032625.4078445-1-windhl@126.com>
 <Yrm6JztPuqYmKlKF@kroah.com>
 <578840ee.438c.181a5a58c00.Coremail.windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578840ee.438c.181a5a58c00.Coremail.windhl@126.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:51:38PM +0800, Liang He wrote:
> 
> 
> At 2022-06-27 22:09:43, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Tue, Jun 21, 2022 at 11:26:25AM +0800, Liang He wrote:
> >> In of_register_trusted_foundations(), we need to hold the reference
> >> returned by of_find_compatible_node() and then use it to call
> >> of_node_put() for refcount balance.
> >> 
> >> Signed-off-by: Liang He <windhl@126.com>
> >> ---
> >>  include/linux/firmware/trusted_foundations.h | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/include/linux/firmware/trusted_foundations.h b/include/linux/firmware/trusted_foundations.h
> >> index be5984bda592..399471c2f1c7 100644
> >> --- a/include/linux/firmware/trusted_foundations.h
> >> +++ b/include/linux/firmware/trusted_foundations.h
> >> @@ -71,12 +71,16 @@ static inline void register_trusted_foundations(
> >>  
> >>  static inline void of_register_trusted_foundations(void)
> >>  {
> >> +	struct device_node *np = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
> >> +
> >> +	of_node_put(np);
> >> +	if (!np)
> >
> >While this is technically correct, you are now checking to see if this
> >points to a memory location that you no longer know what it really
> >belongs to.  C will let you do this, but it might be nicer to fix it up
> >properly so it doesn't look like this.
> >
> >thanks,
> >
> >greg k-h
> 
> Hi，Greg KH，
> 
> Thanks very much for your effort to review my patch.
> 
> In fact, I have reported a commit for this kind of 'check-after-put' coding style:
> https://lore.kernel.org/all/20220617112636.4041671-1-windhl@126.com/
> 
> But I have been told to keep such style and I think the explanation is also reasonable.

It's not very reasonable if you talk to C compiler authors.  They can do
crazy things with dereferenced memory locations, including optimizing
them away entirely as they now "know" that this does not point to any
valid memory so it's an undefined thing that the compiler is being asked
to do.

> So when I make this patch, I am indeed confused what I should write.
> 
> Finally, I think it is better to be consistent with current coding style so
> I chose this 'check-after-put' style.
> 
> But if you think it is better to use a normal order, i.e., check-then-put,
> I am, of cause, very happy to send a new patch for this bug and I will
> also keep to use this coding style in future.

check and then put please.  That prevents you from having to fix up this
type of thing in a few years when the compilers all start to blow up on
it.

thanks,

greg k-h
