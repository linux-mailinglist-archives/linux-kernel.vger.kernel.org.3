Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F39531B82
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbiEWSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbiEWRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:38:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BF939B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC3F3B8121A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17AC385A9;
        Mon, 23 May 2022 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653327137;
        bh=sjJ34GcqhXoKGZ5Q8UWMhx1olSPo7NFZtw3Y5PKxEh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlJAw0+fvw7YYSd+9g7GsfEddRb3tWM3fIU7cl7Z0lStSu+8/iF8BamcptK+vO6jX
         eq75ZsX91MLz9G/uDOUndCCxQyU1EAQ1ib3pQMSNXuI89tfXSm5zvUmc6/vSfKk08L
         VMOkb9EbsuG4WAT8RRh3+WGdU7DkjAKumAcSjWJI=
Date:   Mon, 23 May 2022 19:15:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
Message-ID: <YovBOwJs/A/5Ua7I@kroah.com>
References: <Yn9XwHxWsLIJXlHu@kroah.com>
 <20220514114819.2773691-1-zheyuma97@gmail.com>
 <Yn+va5fTsuaFTxVR@kroah.com>
 <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com>
 <Yocp+WZ0On9/wObu@kroah.com>
 <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com>
 <YouxHY48daZt7J/O@kroah.com>
 <628BBEEB.9010306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628BBEEB.9010306@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 08:05:47PM +0300, Eli Billauer wrote:
> On 23/05/22 19:06, Greg KH wrote:
> > If the device does not have the EXACT USB endpoints that you are
> > expecting (size, address, direction, type, etc.) at probe time reject
> > the device.
> This is probably a good time to add some information about XillyUSB.
> 
> All XillyUSB devices have EP 1 IN and EP 1 OUT as bulk endpoints.
> 
> On top of that, they *may* have up to 14 additional bulk OUT endpoints,
> having the addresses EP 2 OUT to EP 15 OUT. The population of endpoint
> addresses is not necessarily continuous. Any set of OUT endpoint addresses
> is allowed. The driver doesn't know which of these endpoints are available
> initially.
> 
> Rather, it works like this: The driver uses the EP 1 IN and OUT endpoints to
> query the device for a data structure, which contains information on the
> device's communication channels. The driver sets up device files
> accordingly, and it also gets informed on which bulk OUT endpoints are
> present.
> 
> For what it's worth, I think it's fairly safe to assume that if a device
> returns a legal data structure (which passes a CRC test), it's a XillyUSB
> device.

Why?  You still need to verify that the requested endpoints match up
with what the device really has.

Again, we are talking about "fake" devices that are being used to find
problems in the kernel drivers, this is not a "real" device, yet can
look a lot like one.  Look at the fuzzing tools that are running for
examples of this.

> Either way, it's impossible to verify that all of the device's bulk
> OUT endpoints are correct before obtaining the data structure from the
> device. The fact that each device has a different set of communication
> channels, and that the driver learns about them in run-time is the whole
> trick with Xillybus and XillyUSB.

That's fine, but that can still be done a probe() time, not open() time,
like the current patch was attempting.  That's much too late.

thanks,

greg k-h
