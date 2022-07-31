Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78489585F86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiGaPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiGaPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:37:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8038E086
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 358FFB80D11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 15:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7138EC433D6;
        Sun, 31 Jul 2022 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659281863;
        bh=WnkSoyEwxHVHfA55vXG+P0/kpgTvW/r+LKRf9XMfM9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0H/Wt4Ik01MeiuDBWdCnHnTU4+V+NRV7g1liVTRkzxEDIPpWoec0CzAD3b1DgmH4h
         pnkit/i09jStCve6/sXcSwWcn6i8y4WellcZMYGa+KfP2luE42BF2KFxxsMHwpMNvb
         SSzCmRdRPhpmP4YjjXtiif5rOEu1pX+F/LT+AlJs=
Date:   Sun, 31 Jul 2022 17:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-ID: <YuahxB6geST6ZtGN@kroah.com>
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 02:45:34PM +0300, Oded Gabbay wrote:
> Hi,
> Greg and I talked a couple of months ago about preparing a new accel
> subsystem for compute/acceleration devices that are not GPUs and I
> think your drivers that you are now trying to upstream fit it as well.
> 
> Would you be open/interested in migrating your drivers to this new subsystem ?
> 
> Because there were no outstanding candidates, I have done so far only
> a basic and partial implementation of the infrastructure for this
> subsystem, but if you are willing to join I believe I can finish it
> rather quickly.
> 
> At start, the new subsystem will provide only a common device
> character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
> same device character. Also sysfs/debugfs entries will be under that
> device and maybe an IOCTL to retrieve information.
> 
> In the future I plan to move some of habanalabs driver's code into the
> subsystem itself, for common tasks such as memory management, dma
> memory allocation, etc.
> 
> Of course, you will be able to add your own IOCTLs as you see fit.
> There will be a range of IOCTLs which are device-specific (similar to
> drm).
> 
> wdyt ?

That sounds reasonable to me as a sane plan forward, thanks for working
on this.

greg k-h
