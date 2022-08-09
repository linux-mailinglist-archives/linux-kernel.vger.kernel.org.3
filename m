Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6528758D51A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbiHIIEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiHIIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:04:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A8101
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oa4idRH4opHSvrEGBh8PFBi1NgOPjrOcCMzNY1zf3fI=; b=X3qOEXcTyIvfa0X8utVuAQut8A
        vp3PtHZDmJyZWtksujPyDFRS793XvV9UCqtI+3cpRpO9iWnwkt+yKf9NUQ8eaaKKdK/DyPbzJhDJm
        QPA6FA7X80izxyNHOyy28oEvSKQjQwwR20YheOyXrtjFQifQWL39YFrxQw7jTmbMeNFS8N+h1eFHS
        +slsmD9wXVFlQx1WW0IOi/bzviepqWBw0xILC/A2MPQatuswMELzIsCkkX8qqFP0HikEfmcp3xtgU
        7h2tE7P0xKX6XNjYn+tGwJ0clp3vhYE8tUop54ZoTld7Rd+qZ/R5SVLrLGv1uRHAxEOYzYojQHMzl
        nKe4pg1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLKDn-002dIs-Tw; Tue, 09 Aug 2022 08:04:15 +0000
Date:   Tue, 9 Aug 2022 01:04:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-ID: <YvIU/wMdqFA1fYc6@infradead.org>
References: <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <YuvctaLwRi+z0Gw4@nvidia.com>
 <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com>
 <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
 <CAFCwf107tLxHKxkPqSRsOHVVp5s2tDEFOOy2oDZUz_KGmv-rDg@mail.gmail.com>
 <YvCozvgodIY19LSr@kroah.com>
 <YvFOEPdC9r8QBH11@nvidia.com>
 <YvH9X5puer4jpzMX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvH9X5puer4jpzMX@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:23:27AM +0200, Greg Kroah-Hartman wrote:
> Based on the number of drivers that I see submitted weekly that try to
> restrict their open call to just one user by using atomic variables or
> other tricks, I think my interpretation of this stands :)

I think they really want what Jason described most of the time.  They
just don't know about the pitfalls of dup yet.

> > This is different from the number of FDs pointing at the struct file.
> > Userpsace can open a HW state and point a lot of FDs at it, that is
> > userspace's problem. From a kernel view they all share one struct file
> > and thus one HW state.
> 
> Yes, that's fine, if that is what is happening here, I have no
> objection.

It would be great if we could actually life that into a common
layer (chardev or vfs) given just how common this, and drivers tend
to get it wrong, do it suboptimal so often.
