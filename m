Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287065858FC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiG3HhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiG3HhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 03:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B82ACD;
        Sat, 30 Jul 2022 00:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D7646023B;
        Sat, 30 Jul 2022 07:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991BAC433D6;
        Sat, 30 Jul 2022 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659166630;
        bh=aR9ivgaVzeDKp4W79lsHVb0HRdcWhuOP0MkLExB+X4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9NViVt5Y18OhoGyC85JBr+ZwHt8NJ681v+flN0bcanU126Kkwi6vASldCcSaEGJU
         PZJ6DB/L5IPoTNiQL59Yf3RQJqUUEa/aMvDnQ5d7ZNFifx03GBNcYncsj+e+DjIByU
         tdQbFX4TE/7TZNGeQCUvIxWoS0TteruAEybb8giU=
Date:   Sat, 30 Jul 2022 09:37:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - convert to use dev_groups
Message-ID: <YuTfoZlsW8nQ69rp@kroah.com>
References: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
 <YuQqN1+4wow5TlUZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQqN1+4wow5TlUZ@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:43:03AM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Fri, Jul 29, 2022 at 03:58:16PM +0200, Greg Kroah-Hartman wrote:
> > The driver core supports the ability to handle the creation and removal
> > of device-specific sysfs files in a race-free manner.  Take advantage of
> > that by converting this driver to use this by moving the sysfs
> > attributes into a group and assigning the dev_groups pointer to it.
> 
> I obviously like this patch as the less boilerplate code the better, but
> I am not sure what race are you talking about in the commit message?
> Could you please elaborate?

The race is normally because the device is announced to userspace before
the attributes are added.  But you are right, the race is still the same
here, the attributes are added after probe succeeds, so it's the same
time, so this changelog text is wrong, sorry about that.

I'll rewrite this to just say it's cleaner and simpler with this change
and resend it in a few days.

thanks,

greg k-h
