Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A844C40C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiBYI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiBYI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:57:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4A51520F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD16261C9A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F44C340E7;
        Fri, 25 Feb 2022 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645779445;
        bh=xR6IqDOjKYE1cb2LadcxTdEisTybojj0Kg0Fi83FOS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYj52SKM3qMuwgA4qUyGogw0Q135TmkkXbishFqaX5sz/+HvLd9HREBl9WreqAknY
         0QIdhTkYGMUDyQWJ/mGL3108WDezZFKDuOjgwP/fh3g9y8jgmKukl7dkgdziDDVbeR
         fUjLrqK8xDVna/yY7b4mo/KEuqyGRS3o85IBVCeI=
Date:   Fri, 25 Feb 2022 09:57:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Michael Straube <straube.linux@gmail.com>, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: remove 5 GHz channels from
 ch_freq_map
Message-ID: <YhiZ8lCkQluFeNv8@kroah.com>
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-2-straube.linux@gmail.com>
 <YhPIVFmStJOMI0QZ@kroah.com>
 <636080dd-ab8d-a572-0f81-5f72b14ec1e4@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636080dd-ab8d-a572-0f81-5f72b14ec1e4@lwfinger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 01:41:22PM -0600, Larry Finger wrote:
> On 2/21/22 11:13, Greg KH wrote:
> > On Sun, Feb 20, 2022 at 04:48:45PM +0100, Michael Straube wrote:
> > > This driver is for chips that operate only in the 2.4 GHz band.
> > 
> > How do we know that?
> > 
> > thanks,
> Realtek (https://www.realtek.com/en/products/communications-network-ics/item/rtl8188eus)
> states the following:
> 
> "The Realtek RTL8188EUS is an 802.11bgn 2.4G single-chip that integrates
> Wireless LAN (WLAN) and a network USB interface (USB 1.0/1.1/2.0 compatible)
> controller. It combines a WLAN MAC, a 1T1R capable WLAN baseband, and WLAN
> RF in a single chip. The RTL8188EUS provides a complete solution for
> high-throughput performance and low power consumption integrated wireless
> LAN devices."
> 
> The reason there are 5G snippets in the driver is because Realtek uses the
> base code to generate drivers for other chip families such as RTL8192DU that
> have radios for both 2.4 and 5G bands. The RTL81288EU and variants have only
> a single radio.

Ah, ok, that's good to know.  And should belong in the changelog text so
that we are not confused :)

thanks,

greg k-h
