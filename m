Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EE50273C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351693AbiDOJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbiDOJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879820189;
        Fri, 15 Apr 2022 02:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68AE3B80DBB;
        Fri, 15 Apr 2022 09:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87293C385A6;
        Fri, 15 Apr 2022 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650014022;
        bh=uBpYyIwM53dIE3IhFKR8fMQuSzXuhDcAj8oRvnwaJLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPVPohiU52YRqilcCuf3Em1wHggX4lla3+mrTyWvskn7nOrYdrLU7AzxhN4830xQK
         jOCAgLxBu2AB5cR0i2L5rsUluWeifdDjgAyF9IyLfNSjnUhkK3fuEHIo/vU8d1Z/Z1
         2bO5nMqEJ7DQeC67Ro6djkejq/yRBiSQg0nWT5l4=
Date:   Fri, 15 Apr 2022 11:13:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
Message-ID: <Ylk3Q6HyaN/5+97/@kroah.com>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk>
 <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:11:42AM +0100, Maciej W. Rozycki wrote:
> The EndRun PTP/1588 dual serial port device is based on the Oxford
> Semiconductor OXPCIe952 UART device with the PCI vendor:device ID set
> for EndRun Technologies and uses the same sequence to determine the
> number of ports available.  Despite that we have duplicate code
> specific to the EndRun device.
> 
> Remove redundant code then and factor out OxSemi Tornado device
> detection.  Also correct the baud base like with commit 6cbe45d8ac93
> ("serial: 8250: Correct the clock for OxSemi PCIe devices") for the
> value of 3906250 rather than 4000000, obtained by dividing the 62.5MHz
> clock input by the default oversampling rate of 16.  Finally move the
> EndRun vendor:device ID to <linux/pci_ids.h>.

That's a lot of different things happening all the same commit.  Please
break this out into one-patch-per-logical-change as is required.

thanks,

greg k-h
