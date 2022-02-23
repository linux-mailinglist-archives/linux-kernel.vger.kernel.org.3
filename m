Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A54C1CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbiBWT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiBWT43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:56:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D28C4C419;
        Wed, 23 Feb 2022 11:56:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6AF651F37E;
        Wed, 23 Feb 2022 19:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645646159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTfxWTYZmFg/73zI1DT9D/miIhBxVeQM+x5zfDENgA0=;
        b=ycEZJ7JVzVFBA8/FJfvcykUtodmQ29ZiMibU79bVNW0nl9wlbSOdl0ayDuBPr3X3TOc9kv
        aWVfvIs4e8xD/EG77HSMsS3qt+SC97BFa7hMkZq9Rbh8U0mJE18Z8Xfjmp7jYrsba76Hce
        h8RCR+35NEJQ+WtcAppB7GEo/SSO+bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645646159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTfxWTYZmFg/73zI1DT9D/miIhBxVeQM+x5zfDENgA0=;
        b=uWI8GXldhBNAtfbpzIJX1lnfWzg3k+LcmfGGdcdglWNmYLTf6sbDzVlVRPVLgIyspAsoWT
        jToO008fxzrT/SAw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3AF4A3B81;
        Wed, 23 Feb 2022 19:55:58 +0000 (UTC)
Date:   Wed, 23 Feb 2022 20:55:57 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Message-ID: <20220223195557.GH3113@kunlun.suse.cz>
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
 <20220223164528.GE3113@kunlun.suse.cz>
 <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
 <20220223171235.GF3113@kunlun.suse.cz>
 <a9df1753-8e3b-55bb-2dab-9e7aeaa52a8d@redhat.com>
 <20220223182341.GG3113@kunlun.suse.cz>
 <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:34:54PM +0100, Javier Martinez Canillas wrote:
> On 2/23/22 19:23, Michal Suchánek wrote:
> 
> [snip]
> 
> >> My point about the subject line remains thought, I would use something like:
> >>
> >> firmware: sysfb: Enable boot time VESA graphic mode selection for simplefb
> > 
> > I see where the confusion comes from.
> >
> 
> Yeah. And just to clarify, the "simplefb" in the subject line I proposed
> was about the sysfb simplefb and not the fbdev simplefb :)
>  
> > The efifb (and probably vesafb) has implicit unstated dependency on
> > sysfb. So the drivers that select BOOT_VESA_SUPPORT should instead
> > depend on SYSFB, and then SYSFB can select BOOT_VESA_SUPPORT, and it
> > will look much saner.
> >
> 
> That indeed would be much nicer. And I agree with you that there's an
> implicit dependency that should be made explicit since SYSFB is what
> registers the "efi-framebuffer" or "vesa-framebuffer" if SYSFB_SIMPLEFB
> is not enabled.
> 
> Should SYSFB should only select BOOT_VESA_SUPPORT if x86 ? I know that
> in practice shouldn't matter because BOOT_VESA_SUPPORT is under x86 but
> I guess is more correct if that's the case.

Part of the reason to move it to x86 is to avoid the conditional.
Technically there is nothing stopping other platforms from running the
VESA BIOS, it's just not very practical.

> And I think that FB_SIMPLE should depend on SYSFB_SIMPLEFB if !OF (since
> a "simple-framebuffer" platform device could be registered by OF if a
> Device Tree node with compatible "simple-framebuffer" exists).

So generally SYSFB_SIMPLEFB || OF. The part that you can enable the
driver and it does not do anything because you are missing
SYSFB_SIMPLEFB is indeed confusing. There is a comment in SIMLEDRM
description but not FB_SIMPLE.

Then there is the part that if neither simplefb nor vesafb nor efifb nor
offb is built then the sysfb code is unused.

Thanks

Michal
