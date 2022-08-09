Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B458D3AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiHIGXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiHIGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959911FCFC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A2D2B811B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A67C4347C;
        Tue,  9 Aug 2022 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660026211;
        bh=r4gBsXWejMioOyU9kv7AqoaLFSBmsdp3u4zoSc5meJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEztx697rcbEZiFXoACdMEbb6LbyomvNJOqu1DzKUk8Z2VMo6BYyenk6YGf4f2yLi
         sjubCbTVpCuZsqzIVGbVvvcNhSh6DC5u1bQg6a/D6/HSPpnCIjQsyl4PVisfcuD0r6
         vy+nmLXW/3zlz8yODEdV/0oKdPA+Ya0LRx+64b5w=
Date:   Tue, 9 Aug 2022 08:23:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-ID: <YvH9X5puer4jpzMX@kroah.com>
References: <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <YuvctaLwRi+z0Gw4@nvidia.com>
 <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com>
 <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
 <CAFCwf107tLxHKxkPqSRsOHVVp5s2tDEFOOy2oDZUz_KGmv-rDg@mail.gmail.com>
 <YvCozvgodIY19LSr@kroah.com>
 <YvFOEPdC9r8QBH11@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvFOEPdC9r8QBH11@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 02:55:28PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 08, 2022 at 08:10:22AM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Aug 07, 2022 at 02:25:33PM +0300, Oded Gabbay wrote:
> > > 2. Common code to handle drivers that want to allow a single user at a
> > > time to run open the device char file.
> > 
> > Note, that's an impossible request, and one that the kernel should never
> > worry about, so don't even try it.  Think about userspace doing an call
> > to dup() on an open char file descriptor and then passing that off
> > somewhere else.
> 
> Oded is talking about a model like VFIO has where the HW has a limited
> number of concurrent state registers - lets say in this case the ASID
> translation mapping the accelerator into DMA.

Based on the number of drivers that I see submitted weekly that try to
restrict their open call to just one user by using atomic variables or
other tricks, I think my interpretation of this stands :)

> Each 'struct file' that is created owns one of those HW state
> registers, and each struct file is completely isolated from all
> others. eg someone controlling the accelerator through struct file A
> cannot access memory mapped into the accelerator through struct file
> B.
> 
> So, the number of struct files that can be created is capped at the
> number of HW state registers the device can support (eg one for
> Habana).
> 
> This is different from the number of FDs pointing at the struct file.
> Userpsace can open a HW state and point a lot of FDs at it, that is
> userspace's problem. From a kernel view they all share one struct file
> and thus one HW state.

Yes, that's fine, if that is what is happening here, I have no
objection.

greg k-h
