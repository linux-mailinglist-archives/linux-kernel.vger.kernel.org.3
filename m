Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885084C18F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiBWQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiBWQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:45:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA186E79E;
        Wed, 23 Feb 2022 08:45:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A1B42112A;
        Wed, 23 Feb 2022 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645634730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPPWVGtnil4K6Tjn5q/0MYJifKz3OsctSeTvcUnXcQg=;
        b=KGSjCcLpqs56NloxYQBnFF4buJfplFV7HLG3wgJg2os9R0mmgwlJT3aith27h3HTYlMnmW
        MjgRpbbZS8x7/RECI8QJ4Ca4dVECRB7ykK5Uj0s0PcPZ3r6KEDMfHPSHQgdQMm/duYFDii
        HlNBpz0BHg2PKAKYKi8yLRq1YvuBV3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645634730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPPWVGtnil4K6Tjn5q/0MYJifKz3OsctSeTvcUnXcQg=;
        b=ucZBTGhjOU6YvUy75e7MOpjlgoxMJXIwlbRs08mSF4RoxNUFoMK7X7a5fZF5cZUzA+djL4
        G10dC+QfGhWIHTDw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B95AA3B8D;
        Wed, 23 Feb 2022 16:45:29 +0000 (UTC)
Date:   Wed, 23 Feb 2022 17:45:28 +0100
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
Message-ID: <20220223164528.GE3113@kunlun.suse.cz>
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
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

On Wed, Feb 23, 2022 at 05:34:50PM +0100, Javier Martinez Canillas wrote:
> Hello Michal,
> 
> On 2/18/22 17:04, Michal Suchanek wrote:
> > Since switch to simplefb/simpledrm VESA graphic modes are no longer
> > available with legacy BIOS.
> 
> Maybe you can mention that is the "vga=" kernel command line parameter
> since that may be more evident to people reading the commit message ?

Yes, I suppose that could be added.

> > The x86 realmode boot code enables the VESA graphic modes when option
> > FB_BOOT_VESA_SUPPORT is enabled.
> > 
> > To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
> 
> I think you meant "VESA modes with the sysfb driver" ? or something like
> that since otherwise it seems that you meant to use it with the simplefb
> (drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
> "vga=" param as far as I understand (it just uses whatever was setup).

And the vga= is whatever was set up by the realmode code. And the config
option for realmode code to do that is selected by vesafb and not
simplefb so it does not wotk for simplefb/simpledrm/whatewer when efifib
is not built into the kernel.

> The name sysfb_simplefb is really horrible, because it is too confusing
> and probably we should change it at some point...
> 
> Patch itself looks good to me though.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks

Michal
