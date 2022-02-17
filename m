Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE244BA02F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiBQMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:30:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbiBQMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:30:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A04D2AE286;
        Thu, 17 Feb 2022 04:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D2A61999;
        Thu, 17 Feb 2022 12:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC4C340E8;
        Thu, 17 Feb 2022 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645101021;
        bh=0yb94boifHE+hXXIgBfaz1UQTZ1rrixD4EvD7y07S+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aA0iOsKdwVDAkasnuSyk+QuVQIs2fE/jQQD8mM5JD6Av24cgHlafeg3w+v/myPhT3
         dnqjSdIOWdn8WQAZSAAc86Npl4d2rL/IQNPufQwG6h8pzIHF9EhwbgQYAhnxKpPKPD
         ozBhtCvrcyt2OJj6xtBopJlvGI0wvHzKuOVetRyk=
Date:   Thu, 17 Feb 2022 13:30:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] uio: add ioctl to uio
Message-ID: <Yg4/2rZsCmOazYgb@kroah.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <Yg3nmK7iWp7FuoOa@kroah.com>
 <362edb61-b8ad-495e-2346-8020355c0938@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362edb61-b8ad-495e-2346-8020355c0938@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:15:29PM +0800, Xiaoguang Wang wrote:
> hi,
> 
> > On Thu, Feb 17, 2022 at 10:29:21AM +0800, Guixin Liu wrote:
> > > In TCMU, if backstore holds its own userspace buffer, for read cmd, the
> > > data needs to be copied from userspace buffer to tcmu data area first,
> > > and then needs to be copied from tcmu data area to scsi sgl pages again.
> > > 
> > > To solve this problem, add ioctl to uio to let userspace backstore can
> > > copy data between scsi sgl pages and its own buffer directly.
> > > 
> > > Reviewed-by: Xiaoguang Wang<xiaoguang.wang@linux.alibaba.com>
> > > Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> > > ---
> > >   drivers/uio/uio.c          | 22 ++++++++++++++++++++++
> > >   include/linux/uio_driver.h |  1 +
> > No, sorry, thie uio driver will not be adding ioctls to them.  If you
> > need an ioctl, then you should not be using the UIO api but rather use a
> > custom character driver instead.
> 
> I found that early in 2015, there was developer trying to add ioctl interface
> to uio framework:https://lore.kernel.org/lkml/20151005080149.GB1747@kroah.com/

See, I rejected your ioctl for the very same reasons :)

It's good that I was consistent...

> Some of my customers use tcm_loop & tcmu to simulate block devices, it's tcmu
> driver that uses uio framework. There maybe more extra work if we tries to replace
> uio with a new character driver.

Why is tcmu using uio at all?

> Currently tcmu has performance bottleneck, Guixin's patch uses ioctl interface
> to bypass tcmu data area. I also have implemented a tcmu zero-copy feature that
> allows tcmu driver map io request sgl's pages to user space, which uses ioctl
> to do this mapping work, similar to network getsockopt(TCP_ZEROCOPY_RECEIVE).
> 
> I also understand your concerns about ioctl interface. Except that replacing
> uio with a new character driver in tcmu, are there any less complicated methods
> to complete our needs? Thanks.

I do not know what your needs are, nor what tcmu is, nor why you would
want to simulate a block device to userspace like this through the uio
api, sorry.

good luck!

greg k-h
