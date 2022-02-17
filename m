Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007E04BA292
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiBQOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:09:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBQOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:09:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8909F2B1657;
        Thu, 17 Feb 2022 06:08:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BE06B821B0;
        Thu, 17 Feb 2022 14:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F949C340E8;
        Thu, 17 Feb 2022 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645106936;
        bh=VoulgDqx/o2S+UIto0WbQUhu6IyrEAGb9gidP9e2DWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ctzj9qYXdaQqbnjHcUtT4/xgomJoaerH3oPclUjUHgFE6y3Jp0H88nII3odRZR7Q4
         w+vcJmdliwGCG4C4gZ7JcPUwXOhakozb0nf2N5rLmT1uKiVlVBJOIOWpka4yWKuo90
         /FfzdK0m90xQ+hdrted09EQMLDqfnBjOqcd4nCIw=
Date:   Thu, 17 Feb 2022 15:08:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] tps6598x: clear int mask on probe failure
Message-ID: <Yg5W9iLejXtJm0BP@kroah.com>
References: <e6b80669-20f3-06e7-9ed5-8951a9c6db6f@kernel.dk>
 <Yg4HwO2SKGDvOASz@kuha.fi.intel.com>
 <b6bf2ab5-031d-8be8-e9e7-ba04f39ef35e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bf2ab5-031d-8be8-e9e7-ba04f39ef35e@kernel.dk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:51:27AM -0700, Jens Axboe wrote:
> On 2/17/22 1:30 AM, Heikki Krogerus wrote:
> > On Tue, Feb 15, 2022 at 11:22:04AM -0700, Jens Axboe wrote:
> >> The interrupt mask is enabled before any potential failure points in
> >> the driver, which can leave a failure path where we exit with
> >> interrupts enabled but the device not live. This causes an infinite
> >> stream of interrupts on an Apple M1 Pro laptop on USB-C.
> >>
> >> Add a failure label that's used post enabling interrupts, where we
> >> mask them again before returning an error.
> >>
> >> Suggested-by: Sven Peter <sven@svenpeter.dev>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Should this be marked as a fix?
> 
> Maybe, I can try and dig out the offending commit. From some quick
> checking, it didn't come in with recent fixes, so it's probably been
> there since support got added. Maybe we just mark it stable?
> 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thanks! Greg, will you pick this up?

Will do, thanks.

greg k-h
