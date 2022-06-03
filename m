Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE253CA21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiFCMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiFCMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:44:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930783A5EB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DFA4B82230
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE46C385A9;
        Fri,  3 Jun 2022 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654260260;
        bh=MdwQN6E1zYdXGIcK3Plde1ard+3rWpXNOrXF6sGmiEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oY6BGao0PIeSnp42jfpSkjurP6exEWid0KVVXEXG7YrMTGW8907IL1jQA9hAf8rOm
         DkQg69x1bVdLa5BmeytSNdpI12jIv4k64KdbwthmDjijAvCsGvS8KlEJjlLYmmD3SS
         PmJNoSlErJTrmVWvhyCDkFn7X1cXIiAD8iclGWXM=
Date:   Fri, 3 Jun 2022 14:44:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     arnd@arndb.de, Shreenidhi Shedi <sshedi@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] char: lp: ensure that index has not exceeded LP_NO
Message-ID: <YpoCIS1HVft8MbmB@kroah.com>
References: <20220515075455.306082-1-sshedi@vmware.com>
 <64570db1-e9f2-4f23-1d14-3d4b35776bca@gmail.com>
 <991f7966-0734-36ea-b206-a428620efe41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991f7966-0734-36ea-b206-a428620efe41@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:32:25PM +0530, Shreenidhi Shedi wrote:
> On 03/06/22 5:27 pm, Shreenidhi Shedi wrote:
> > On 15/05/22 1:24 pm, Shreenidhi Shedi wrote:
> >> After finishing the loop, index value can be equal to LP_NO and lp_table
> >> array is of size LP_NO, so this can end up in accessing an out of bound
> >> address in lp_register function.
> >>
> >> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> >> ---
> >>  drivers/char/lp.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
> >> index bd95aba1f..e61060f3c 100644
> >> --- a/drivers/char/lp.c
> >> +++ b/drivers/char/lp.c
> >> @@ -971,7 +971,7 @@ static void lp_attach(struct parport *port)
> >>  			if (port_num[i] == -1)
> >>  				break;
> >>  
> >> -		if (!lp_register(i, port))
> >> +		if (i < LP_NO && !lp_register(i, port))
> >>  			lp_count++;
> >>  		break;
> >>  
> > 
> > Hi Greg and Arnd Bergmann,
> > 
> > Please review the above changes. Ignore second patch.
> > 
> > --
> > Shedi
> 
> Sorry, not the second patch. Ignore the 3rd patch which fixes checkspec.pl warnings.

I have no way to do that, please fix up and resend the correct series,
our tools can not pick and choose from a series easily.

Also remember this is the middle of the merge window and we can not do
anything at the moment.

greg k-h
