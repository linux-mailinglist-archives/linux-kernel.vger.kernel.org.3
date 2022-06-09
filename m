Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245D9544D59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiFINT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbiFINS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2D3CE241
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B24D0B82DD9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E1DC34114;
        Thu,  9 Jun 2022 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654780700;
        bh=t5OTrTMFJxvNLCc0YnLnqwrnW6F9Kn/Juv50fvZvLmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMp+tiQt7wzGFD+PRoBFCJSTl+yh4qeE7cXZWFofJyq7HmztJtiekgIjOgQhsbk9x
         NS1qKa14xc6I7+j2Um+LMeAya3pU6+ZsEBPJLWtCNdbxpeutOAcFiP1duFp+od1CoK
         pSK6x1dPDeNi7LTKU7ssKAjbA0m7ybOEEh3C+aBs=
Date:   Thu, 9 Jun 2022 15:18:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, fseidel@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: nozomi: Return an error when failing to create the
 sysfs
Message-ID: <YqHzGeRK0c4nVPc6@kroah.com>
References: <20220609083133.4120738-1-zheyuma97@gmail.com>
 <YqGxjwLHxaXG/646@kroah.com>
 <CAMhUBj=nTiTu8wwjk0=WGE=nJPWtb+kSq_u=MW_FF1DHLE-55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBj=nTiTu8wwjk0=WGE=nJPWtb+kSq_u=MW_FF1DHLE-55A@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 07:03:32PM +0800, Zheyu Ma wrote:
> On Thu, Jun 9, 2022 at 4:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 09, 2022 at 04:31:33PM +0800, Zheyu Ma wrote:
> > > The driver does not handle the error of the creation of sysfs, resulting
> > > in duplicate file names being created.
> > >
> > > The following log can reveal it:
> > >
> > > [   52.907211] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:05.0/card_type'
> >
> > How is the same file being created in a normal codepath?
> >
> > Is the same device being registered twice somehow?
> 
> In fact, I tried to load the nozomi driver twice.

How?  Modules should not be able to be in memory twice.

> In the first load, the driver failed at tty_port_register_device(),
> performed error handling and returned an error, but by this time the
> make_sysfs_files() had been executed and the sysfs had been created.
> In the second load, the make_sysfs_files() is executed again and this
> warning is returned.

Ah, ok, if you make the other changes I suggested, this will not be a
problem.

thanks,

greg k-h
