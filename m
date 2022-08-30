Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FE5A649B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiH3NZ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Aug 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiH3NZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:25:53 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE84E62B;
        Tue, 30 Aug 2022 06:25:49 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 142D3200004;
        Tue, 30 Aug 2022 13:25:46 +0000 (UTC)
Message-ID: <5cc941f72c4b18ac9a39b60f00785d4610dd5054.camel@hadess.net>
Subject: Re: [v3 4/5] HID: logitech-hidpp: Fix "Sw. Id." for HID++ 2.0
 commands
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Tue, 30 Aug 2022 15:25:46 +0200
In-Reply-To: <CAO-hwJJWDFS7zCbGAvbDCx0e+xNCtr_A4gBx0T5M8WeDVhnPgA@mail.gmail.com>
References: <20220830113907.4886-1-hadess@hadess.net>
         <20220830113907.4886-4-hadess@hadess.net>
         <CAO-hwJJWDFS7zCbGAvbDCx0e+xNCtr_A4gBx0T5M8WeDVhnPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 15:19 +0200, Benjamin Tissoires wrote:
> On Tue, Aug 30, 2022 at 1:39 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > Always set a non-zero "Sw. Id." in the lower nibble of the
> > Function/ASE
> > and Software Identifier byte in HID++ 2.0 commands.
> > 
> > As per the "Protocol HID++2.0 essential features" section in
> > https://lekensteyn.nl/files/logitech/logitech_hidpp_2.0_specification_draft_2012-06-04.pdf
> > "
> > Software identifier (4 bits, unsigned)
> > 
> > A number uniquely defining the software that sends a request. The
> > firmware must copy the software identifier in the response but does
> > not use it in any other ways.
> > 
> > 0 Do not use (allows to distinguish a notification from a
> > response).
> > "
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215699
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 98ebedb73d98..9c8088d8879e 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -41,6 +41,9 @@ module_param(disable_tap_to_click, bool, 0644);
> >  MODULE_PARM_DESC(disable_tap_to_click,
> >         "Disable Tap-To-Click mode reporting for touchpads (only on
> > the K400 currently).");
> > 
> > +/* Define a non-zero software ID to identify our own requests */
> > +#define LINUX_KERNEL_SW_ID                     0x06
> 
> For consistency, and as Peter already asked, please use 0x01 instead
> of 0x06.
> 
> The simple reason is that it was well known that the kernel used 0x01
> from day one, and so we might have userspace application that uses
> 0x06, and in this case you are walking on their toes.

Done in v4, thanks.

> 
> Cheers,
> Benjamin
> 
> > +
> >  #define REPORT_ID_HIDPP_SHORT                  0x10
> >  #define REPORT_ID_HIDPP_LONG                   0x11
> >  #define REPORT_ID_HIDPP_VERY_LONG              0x12
> > @@ -343,7 +346,7 @@ static int hidpp_send_fap_command_sync(struct
> > hidpp_device *hidpp,
> >         else
> >                 message->report_id = REPORT_ID_HIDPP_LONG;
> >         message->fap.feature_index = feat_index;
> > -       message->fap.funcindex_clientid = funcindex_clientid;
> > +       message->fap.funcindex_clientid = funcindex_clientid |
> > LINUX_KERNEL_SW_ID;
> >         memcpy(&message->fap.params, params, param_count);
> > 
> >         ret = hidpp_send_message_sync(hidpp, message, response);
> > --
> > 2.37.2
> > 
> 

