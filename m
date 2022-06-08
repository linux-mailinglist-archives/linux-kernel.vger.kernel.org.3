Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED80542E31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiFHKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiFHKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D86A407
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 538F260DDF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60062C34116;
        Wed,  8 Jun 2022 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654685108;
        bh=eRVrxw2TtDyOfO8gMWB1zIDrWzECqh2i9AYfRsqK6Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3oZWf32QmN9uDJsIiHuUTFynEfYTOa1VnGwHnfllpgzxF7HurwOAgMNfPpQHycxQ
         4IPqpl3lWWUQbdF3YWN8aj3OGKzrK0Ua1rTeuxLDcki8UUMuJ1Js1ovfnHcG6wqaHE
         OI6lmEVVS36JRlIeXqLvsR6iPZpUJYHZgpyJaIwc=
Date:   Wed, 8 Jun 2022 12:45:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Martin Kaiser <lists@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG] staging: r8188eu: driver stopped working with commit
 ("staging: r8188eu: add check for kzalloc")
Message-ID: <YqB9siuACKQMKXhv@kroah.com>
References: <20220606064055.12565-1-straube.linux@gmail.com>
 <ded4b3f5-a9bc-4612-33cc-68bd85cb92fe@gmail.com>
 <20220608092731.hz26q37fhmrhipmj@viti.kaiser.cx>
 <01d6737a-9e2d-c009-4e24-c2c54b39b80c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d6737a-9e2d-c009-4e24-c2c54b39b80c@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:34:45PM +0300, Pavel Skripkin wrote:
> Hi Martin,
> 
> On 6/8/22 12:27, Martin Kaiser wrote:
> > Hi Michael & Phil,
> > 
> > Thus wrote Michael Straube (straube.linux@gmail.com):
> > 
> > > The driver does not work anymore on my system. In dmesg there is:
> > 
> > > "r8188eu 1-4:1.0: _rtw_init_xmit_priv failed"
> > 
> > > I bisected it to commit f94b47c6bde ("staging: r8188eu: add check for
> > > kzalloc").
> > 
> > > ~/kernels/staging> git bisect bad
> > > f94b47c6bde624d6c07f43054087607c52054a95 is the first bad commit
> > 
> > > At the moment I have no time to look further into it.
> > 
> > See also
> > 
> > https://lore.kernel.org/linux-staging/YoyU4zXf45UpF1Tq@kroah.com/T/#mb5e56a285b8eb1ebb0e798462fc388cb02b4a7cc
> > 
> > Phil said in
> > 
> > https://lore.kernel.org/linux-staging/YoyU4zXf45UpF1Tq@kroah.com/T/#m7a21d460b2569f6b59965ecc3298a6337fa3458a
> > 
> 
> There is the posted patch [1]. I also have to apply it every time I want to
> test smth.
> 
> [1] https://lore.kernel.org/all/20220521204741.921-1-phil@philpotter.co.uk/

That patch is in linux-next and will be sent to Linus later this week.

thanks,

greg k-h
