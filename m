Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF672590D87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiHLIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiHLIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:40:16 -0400
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 01:40:14 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D0DBEA;
        Fri, 12 Aug 2022 01:40:13 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1660293104; bh=wDg6UBM71uMikyiOtiwiJmqJ+yurtqkNI7534WQKogc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EF2OL4H9HtMyHEQNDskMDUjBotKdr9ltPIbv3ExUgVX74avgOuxmBWaGcYnKECaJ3
         WTovhYZdVbXcuc8sHuH692VXTO+NJFw6auxnhVhunDOIhwNxo6Jji7PHnUxFffgqyI
         9tbMjcotTk3+XO+M626axEhFu52fcWmGGcVDvPBM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Luke Jones <luke@ljones.dev>, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some
 laptops
Message-ID: <0239b3bb-d9cb-4549-9e9e-006923b61634@t-8ch.de>
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-7-luke@ljones.dev>
 <7365d41a-1475-118c-96a8-6ab927bda5b7@redhat.com>
 <9ed62983bd03ed26cdb4399dd69b4096e8711fa9.camel@ljones.dev>
 <b287e98a-7880-5979-94a4-38715d448de4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b287e98a-7880-5979-94a4-38715d448de4@redhat.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-08-12 09:59+0200, Hans de Goede wrote:
> Date: Fri, 12 Aug 2022 09:59:29 +0200
> From: Hans de Goede <hdegoede@redhat.com>
> To: Luke Jones <luke@ljones.dev>
> Cc: andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
>  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some
>  laptops
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
>  Thunderbird/91.12.0
> 
> Hi,
> 
> On 8/12/22 00:01, Luke Jones wrote:
> > Hi Hans,
> > 
> > On Thu, 2022-08-11 at 15:53 +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 8/9/22 04:50, Luke D. Jones wrote:
> >>> Support the hardware GPU MUX switch available on some models. This
> >>> switch can toggle the MUX between:
> >>>
> >>> - 0, Dedicated mode
> >>> - 1, Optimus mode
> >>>
> >>> Optimus mode is the regular iGPU + dGPU available, while dedicated
> >>> mode switches the system to have only the dGPU available.
> >>>
> >>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >>
> >> I see that you have replied to this that it needs more work.
> >>
> >> Besides it needing more work, ideally this should hook into
> >> the existing vga-switcheroo mechanism for this. Can you take
> >> a look at that please?
> >>
> >> I think this might be the first non GPU driver doing vga-
> >> switcheroo stuff. So this may be something to discuss
> >> on the dri-devel list.
> > 
> > I'm not sure how this would work. In typical ASUS fashion they do non-
> > standard stuff. This switch is a basic toggle that requires a reboot to
> > enable after writing to the ACPI method, after reboot the dGPU becomes
> > the only visible GPU on the system and (this GPU) can not be suspended.
> > 
> > In short: it toggles the laptop from discrete-only mode, and optimus
> > mode, requiring a reboot to switch.
> > 
> > From what I understand of switcheroo it is more to manage having dual
> > (or more) GPU available during runtime, and manage the power states,
> > offload etc.
> 
> Right, I did not realize this requires a reboot, that would be
> something to mention in the Documentation bits accompanying the patch.
> 
> This is also a reason why it is good to have the docs update in
> the same patch as adding the functionality, because the docs may
> help with reviewing.
> 
> Anyways I agree that if this requires a reboot then using
> the vga switcheroo stuff is not applicable. So we can just go with
> a simple(ish) asus-wmi sysfs attribute.

Would this not fit the existing "firmware-attributes" class?
It even has a flag to signal that a reboot is required after an attribute has
been changed.

Maybe it is overkill to use it only for this, though.

> > I have a vastly improved patch for this prepared now. Because of how
> > the actual feature works (and the above explanation) it must be under
> > the asus-nb-wmi sysfs (next to the dgpu_disable and egpu_enable toggles
> > which are also unusual and non-standard work-arounds of Windows
> > issues).
> 
> Ack, sounds good.

Thomas
