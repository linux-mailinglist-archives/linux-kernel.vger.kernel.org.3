Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E358D59C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiHIIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiHIIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF860D2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05568B80B89
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D3C433D6;
        Tue,  9 Aug 2022 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660034743;
        bh=VKIJz/3kseX4NXW5x3L6MqsO9hB4DzRJ2UXkmwU0jLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6wrqg9/xFtT/6CURaKkO/Pfga0WpsRzfLdgqihdYhelEtipuK7OAUp+LDHU8GTJV
         Jn3GdKFC/V31aWSlo9gjwqWlFWJj6njcSRF8XU/8ELupdFlb2wnqyo2Ulg4wlU6h2V
         4IrqmLWeXHIQutSMd9Zz7NBI4034owXmtBBvzWmQ=
Date:   Tue, 9 Aug 2022 10:45:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-ID: <YvIethFMeGyljdVV@kroah.com>
References: <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <YuvctaLwRi+z0Gw4@nvidia.com>
 <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com>
 <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
 <CAFCwf107tLxHKxkPqSRsOHVVp5s2tDEFOOy2oDZUz_KGmv-rDg@mail.gmail.com>
 <YvCozvgodIY19LSr@kroah.com>
 <YvFOEPdC9r8QBH11@nvidia.com>
 <YvH9X5puer4jpzMX@kroah.com>
 <YvIU/wMdqFA1fYc6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvIU/wMdqFA1fYc6@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 01:04:15AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 08:23:27AM +0200, Greg Kroah-Hartman wrote:
> > Based on the number of drivers that I see submitted weekly that try to
> > restrict their open call to just one user by using atomic variables or
> > other tricks, I think my interpretation of this stands :)
> 
> I think they really want what Jason described most of the time.  They
> just don't know about the pitfalls of dup yet.
> 
> > > This is different from the number of FDs pointing at the struct file.
> > > Userpsace can open a HW state and point a lot of FDs at it, that is
> > > userspace's problem. From a kernel view they all share one struct file
> > > and thus one HW state.
> > 
> > Yes, that's fine, if that is what is happening here, I have no
> > objection.
> 
> It would be great if we could actually life that into a common
> layer (chardev or vfs) given just how common this, and drivers tend
> to get it wrong, do it suboptimal so often.

No objection from me, I'll gladly take patches to chardev or miscdev to
support this.

greg k-h
