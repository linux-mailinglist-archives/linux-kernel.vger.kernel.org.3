Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E615B0DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIGUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIGUKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9C3FA32;
        Wed,  7 Sep 2022 13:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2338161A2B;
        Wed,  7 Sep 2022 20:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD46AC433C1;
        Wed,  7 Sep 2022 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662581399;
        bh=tY2rZkKMAh0HGG+k/VKKFfccvfgdnJQ271Rh8HaQ56A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uvMp0pvg/Seeo4CI4fAPNMHhDJSFy0uoZdedZTUujyMpLAxClWKShXl0k9M/ITYF0
         0i8MxAgVUKHLOmnyqJKMDMggXgmb+ojw7WgP84Si+gdLR4vLB/RbTcBBypnp9dT1ST
         5NPvCWe8JRTI4UX0LlJ/gZYA5BXmGxKvvasf/GOut3xJ9HGifpp9lSKvrGPQBNBQZ4
         YiKwdyLneccG5hrbaP73dkZpMEjgbvWSL5LtTFwMzLO++o/XHUbZEoIMH3f7qj2FFf
         /9rI5uc8vg0SAduMxV67hsktLIr9dWxLqd1A80g7JszBojJETTC46ZE0yp7WtlbO14
         YjilFAmt9SbvQ==
Date:   Wed, 7 Sep 2022 22:09:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [v4 1/5] HID: core: Export hid_match_id()
In-Reply-To: <e907c9240fb2cc0c1e60e3610cfae15ff8125c49.camel@hadess.net>
Message-ID: <nycvar.YFH.7.76.2209072208490.19850@cbobk.fhfr.pm>
References: <20220830132549.7240-1-hadess@hadess.net> <e907c9240fb2cc0c1e60e3610cfae15ff8125c49.camel@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022, Bastien Nocera wrote:

> > Export hid_match_id() so it can be used in device-specific drivers to
> > implement their own matching with open-coding a match function.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/hid/hid-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index b7f5566e338d..72f8d8835b34 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2088,6 +2088,7 @@ const struct hid_device_id *hid_match_id(const
> > struct hid_device *hdev,
> >  
> >         return NULL;
> >  }
> > +EXPORT_SYMBOL_GPL(hid_match_id);
> >  
> >  static const struct hid_device_id hid_hiddev_list[] = {
> >         { HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS) },
> 
> If those patches look good to you, would be great to get merged.
> Benjamin doesn't have the bandwidth to test the patches on his own test
> hardware right now, but I've been using them daily for a week now.

Alright, I was waiting for Ack from Benjamin, but based on this, and due 
to the fact that I don't see any issue with it myself, I've now applied 
the series to for-6.1/logitech branch so that it gets as much linux-next 
exposure as possible.

Thanks,

-- 
Jiri Kosina
SUSE Labs

