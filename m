Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9755D2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiF0Hqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiF0Hqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:46:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A160D2;
        Mon, 27 Jun 2022 00:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E6DB80FAB;
        Mon, 27 Jun 2022 07:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A90C3411D;
        Mon, 27 Jun 2022 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656315990;
        bh=2qUSacDWmeYxJkQPK+63Evm+SWsQuGEK6gdeP5B/qts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZEWDQuAp0/mO/vF1sqVBOyH5IvvUy6kXAC33onl+axLigsBi9Im0PWZctLY7FHzm
         0HioTlziBXjQexiAxTpIU+2ojACmzAdCELvzvph/SiRyWQ08fEZMHS55O3Eg0yi0Te
         hbk6aGKeYe/ejj0cUrdlYy1Y6NQ6a5WPhQzo4mx3Zw1nqunIuyntWem7/lT3VZWu/S
         Zn4u48ZMGnNbyZDL6WzJwRxysGcSoSIwtym+Ewf0eoilqbS+fS2zgSvHeZrm4MEjei
         U/Vg9AXcse7tm/EHzo84k++WqrYi8hl9Cz47hPT07G8Pz1Uh0ZFACm7ure9qWwAzAR
         mH/nHG1t1nXDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o5jRz-00057V-S5; Mon, 27 Jun 2022 09:46:27 +0200
Date:   Mon, 27 Jun 2022 09:46:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: usbtouchscreen - add driver_info sanity check
Message-ID: <YrlgU6A+WYZRYjEn@hovoldconsulting.com>
References: <20220623062446.16944-1-johan@kernel.org>
 <YrSN+DYQun/IOPh7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrSN+DYQun/IOPh7@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:59:52AM -0700, Dmitry Torokhov wrote:
> On Thu, Jun 23, 2022 at 08:24:46AM +0200, Johan Hovold wrote:
> > Add a sanity check on the device id-table driver_info field to make sure
> > we never access a type structure (and function pointers) outside of the
> > device info array (e.g. if someone fails to ifdef a device-id entry).
> > 
> > Note that this also suppresses a compiler warning with -Warray-bounds
> > (gcc-11.3.0) when compile-testing the driver without enabling any of
> > the device type Kconfig options:
> > 
> >     drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
> >     drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
> >      1668 |         type = &usbtouch_dev_info[id->driver_info];
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > Changes in v2
> >  - use ARRAY_SIZE() for the sanity check (Dmitry)
> >  - drop the dummy entry and combine the two patches as the sanity check
> >    itself is enough to suppress the compiler warning (Dmitry)
> >  - use -ENODEV instead of -EINVAL even if this means no error will be
> >    logged in the unlikely event of a future driver bug
> 
> Is this on purpose or because I happened to have used this error code
> when I suggested the change? I'm fine with returning -EINVAL there.

It was on purpose. Returning -EINVAL (invalid argument) here just
doesn't seem quite right. I skimmed the errno list for a better
alternative, but decided -ENODEV works as well.

If there's ever a driver bug that triggers this, you could say the
device isn't supported in that configuration. ;)

If you prefer -EINVAL, I'll change it back.

Johan
