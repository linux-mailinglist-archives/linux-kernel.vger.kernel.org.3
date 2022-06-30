Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD1561511
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiF3I3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiF3I24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24940E67;
        Thu, 30 Jun 2022 01:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F140FB826A3;
        Thu, 30 Jun 2022 08:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94878C34115;
        Thu, 30 Jun 2022 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656577732;
        bh=cAQUo7kspmH4XuHsaG4rJWzgQnrBlFeAfBrz4QmTHZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEKx7fPQrI57hq5FMCZ4ZTRDfq0uDdvKS3bsZwHo+uSu09HoY3A9QmEPU/uWOxaTY
         OXTFxgpHqz/4urILdk6F20jqIaKhhnvfOLX15qE0ggN1fGKXPhKzy7MT+bX00HtdNb
         eyHHWyRNQjmi504QnlzS4yT31DxOBOxYnxv/5dJPp+uB7JzU9lr8yDJ0JyBspDPWtA
         e2kA9eoIvMZ+IlvfIdyOw1S+GjTSicIryNMuOOc16hZs4kHgfZGyk6eBcfHOU22wNW
         2VPra0C4xfKaYQKC3YgBkKlN3NCzTmG6w/shL0MxHKaZcBziS5/O7Ip+2re6qNAlH5
         cK7ZmVsJJIvBw==
Received: by pali.im (Postfix)
        id 3414096E; Thu, 30 Jun 2022 10:28:49 +0200 (CEST)
Date:   Thu, 30 Jun 2022 10:28:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: mvebu: Apply old baudrate to termios
Message-ID: <20220630082849.ldvqu7frdrln4ite@pali>
References: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
 <20220628095136.fhtjjjkj3mre7hwa@pali>
 <20220628095942.rbpl2iocxoqtzxiy@pali>
 <CAHp75VeHNERyPAam_-u7+ykYxcUM_N-YT6kBAh+hG+7WNW31SA@mail.gmail.com>
 <CAHp75VfDA1x0OQjBb8rj7RB9bHgjXa86jrcayeuxbYxGLf2=Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfDA1x0OQjBb8rj7RB9bHgjXa86jrcayeuxbYxGLf2=Kg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2022 13:40:28 Andy Shevchenko wrote:
> On Tue, Jun 28, 2022 at 1:39 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 28, 2022 at 12:01 PM Pali Rohár <pali@kernel.org> wrote:
> > > On Tuesday 28 June 2022 11:51:36 Pali Rohár wrote:
> 
> ...
> 
> > > Ou, now I see where is the issue. Patch which I tested and which fixes
> > > reporting baudrate is not in kernel tree yet and it looks like I totally
> > > forgot to sent it to ML. I will send it. Sorry for confusion.
> >
> > Shouldn't the Ilpo's applied anyway to fix the current code base?
> 
> Ah, now I understand that your patch is a fix. Sorry for the noise.

Yes, my patch fixes the issue which Ilpo described and handles also errors:
https://lore.kernel.org/linux-serial/20220628100922.10717-1-pali@kernel.org/
