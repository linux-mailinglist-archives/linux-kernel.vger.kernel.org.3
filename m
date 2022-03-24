Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368334E611D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbiCXJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiCXJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:33:59 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290989E9E8;
        Thu, 24 Mar 2022 02:32:26 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BB9C42000F;
        Thu, 24 Mar 2022 09:32:21 +0000 (UTC)
Message-ID: <5b842bd4f8d17e5ecb8e7972637dbe7ad50060ac.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
From:   Bastien Nocera <hadess@hadess.net>
To:     Manuel =?ISO-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 10:32:21 +0100
In-Reply-To: <YjvlQrvRS+ZKNbZ5@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
         <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
         <ce3adf7013ba01aad54fb65bf9c657dd9d0b7d23.camel@hadess.net>
         <YjvlQrvRS+ZKNbZ5@hermes>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-23 at 21:28 -0600, Manuel Schönlaub wrote:
> On Wed, Mar 23, 2022 at 11:24:18PM +0100, Bastien Nocera wrote:
> > On Wed, 2022-03-23 at 21:22 +0000, Filipe Laíns wrote:
> > > On Tue, 2022-03-08 at 16:50 -0700, Manuel Schönlaub wrote:
> > > > The HID++ protocol allows to set multicolor (RGB) to a static
> > > > color.
> > > > Multiple of such LED zones per device are supported.
> > > > This patch exports said LEDs so that they can be set from
> > > > userspace.
> > > > 
> > > > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-logitech-hidpp.c | 188
> > > > +++++++++++++++++++++++++++++++
> > > >  1 file changed, 188 insertions(+)
> > > 
> > > *snip*
> > > 
> > > Hi Manuel,
> > > 
> > > Thanks for putting this forward, although I am not sure if this
> > > is
> > > the best way
> > > to handle this.
> > > 
> > > Before anything, could you elaborate a bit on what lead to you
> > > wanting this?
> > > 
> > > There are a couple of reasons why merging this in the kernel
> > > might be
> > > problematic.
> > > 
> > > 1) I don't think we will ever support the full capabilities of
> > > the
> > > devices, so
> > > configuration via userspace apps will always be required, and
> > > here we
> > > are
> > > introducing a weird line between the two.
> > > 
> > > 2) There is already an ecosystem of userspace configuration apps,
> > > with which
> > > this would conflict. They might not be in the best maintenance
> > > state
> > > due to lack
> > > of time from the maintainers, but moving this functionality to
> > > the
> > > kernel, which
> > > is harder change, and harder to ship to users, will only make
> > > that
> > > worse.
> > 
> > There's already an API for LEDs in the kernel, why shouldn't it be
> > used
> > to avoid user-space needing to know how to configure Logitech, and
> > every other brand of keyboards?
> > 
> > systemd has code to save and restore LED status, as well as code to
> > change the level of backlight. I can imagine that it wouldn't take
> > much
> > to make it aware of RGB LEDs so it handles them properly, whether
> > it's
> > for Logitech, or another brand of keyboards, or laptops.
> 
> Teaching systemd-backlight about mulicolor backlights might be a nice
> project
> too. But their use case seems to be more about screen backlights as
> it seems.
> Did I overlook something here?

From rules.d/99-systemd.rules.in:
# Pull in backlight save/restore for all backlight devices and
# keyboard backlights
SUBSYSTEM=="backlight", TAG+="systemd", IMPORT{builtin}="path_id", ENV{SYSTEMD_WANTS}+="systemd-backlight@backlight:$name.service"
SUBSYSTEM=="leds", KERNEL=="*kbd_backlight", TAG+="systemd", IMPORT{builtin}="path_id", ENV{SYSTEMD_WANTS}+="systemd-backlight@leds:$name.service"

And from the NEWS file for systemd 243:
        * systemd-logind now exposes a per-session SetBrightness() bus call, 
          which may be used to securely change the brightness of a kernel
          brightness device, if it belongs to the session's seat. By using this
          call unprivileged clients can make changes to "backlight" and "leds"
          devices securely with strict requirements on session membership.
          Desktop environments may use this to generically make brightness
          changes to such devices without shipping private SUID binaries or
          udev rules for that purpose.

It's clear that it's not just displays.

> 
> Oh and yeah, IMHO another argument could be that obviously at some
> point
> the LED management could be removed from those user space tools, as
> the
> kernel would already know about them.
> 
> After all the LED class devices should be there for a reason ;-)
> 
> Cheers,
> 
> Manuel
> 

