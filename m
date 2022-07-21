Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D957C7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiGUJjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jul 2022 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiGUJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:39:11 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED2D81484;
        Thu, 21 Jul 2022 02:39:09 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7EECE4000B;
        Thu, 21 Jul 2022 09:39:06 +0000 (UTC)
Message-ID: <20debb4d623f057b77ad9d2f5909540baf750c13.camel@hadess.net>
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
From:   Bastien Nocera <hadess@hadess.net>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        spbnick@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 Jul 2022 11:39:06 +0200
In-Reply-To: <20220718172953.6817-1-jose.exposito89@gmail.com>
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 19:29 +0200, José Expósito wrote:
> Hi!
> 
> No code yet, just a kind request for comments and hopefully some
> wisdom
> and experience from Nikolai dealing with HUION devices.
> 
> HUION keeps reusing the same vendor and product IDs for their
> devices.
> This makes it really difficult to differentiate between devices and
> handle them in the kernel and also in user space.
> 
> Reusing IDs could introduce a problem:
> 
> If HUION, or other vendor following the same practices, releases a
> new
> tablet with a duplicated product ID, the UCLogic driver would handle
> it.
> The device might work with the existing code or it might fail because
> of
> a new feature or a whole different firmware.
> 
> As far as I know, at the moment there is not a mechanism in place to
> avoid this situation.
> I think that it'd be better to ignore those devices in UCLogic and
> let
> the HID generic driver handle them because using HID generic would
> provide a basic user experience while using UCLogic might fail to
> probe
> the tablet.
> 
> DIGImend's web already provides a nice list of supported devices:
> http://digimend.github.io/tablets/
> 
> So, I wonder:
> 
>  - Do you think it makes sense to ignore untested devices?
>  - If the answer is yes, do we have a better option than checking the
>    device name against an allow-list? It'd be great to hear other
>    people's ideas.

I don't think it makes sense to ignore untested devices, unless you
know for a fact they won't work.

But if the name is part of detecting the device, it would certainly
make sense to use that as part of the identifier for the device, rather
than just the USB VIP:PID.

You should be able to add the product strings in the .driver_data, and
check them in probe().

Cheers
