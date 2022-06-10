Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4252E546EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiFJUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiFJUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:49:15 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0B3A183
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=ACZk3VjAixXI/UfuGjHePmP+cJsCymKcbZ3TtJqGdg8=;
        b=tptHn4+MOhdFBnj3Qsn24UgVlUrX1VnSxOAONv3aLxouY1P0q80VnsgB3JOrXqom3229LyHf1Rk3a
         WH50Ric5a5PykNQdtoi3mNKPwHFBYBpS91QYNfQYZFs8lrxt9Pr8yebDrdxtg7JRRlHuPeKc+UP5pE
         ZWGhF3qiSGU87pYY2633xNTEb6aQqbrQ8uPI0NAcXY6ImPBqKAfwM8BfQ6BpWD5EP4N/NHBxCihVQC
         yTUzzPMKXAO/yw65JIY1U+VKDjW+c3kkTTA4ujjJ9XlEPR1GrQuolxdRpkjkU0feWA7abCW3KsGenl
         QSSN6YDKYxgH2Ejun5PJ6a8fbD4BlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=ACZk3VjAixXI/UfuGjHePmP+cJsCymKcbZ3TtJqGdg8=;
        b=CYZ+3pMf7fEHyrQx7MXlBDkSVpUZA6brYTcjj+epgEOImeaCxFHxMS1nkst/Xsx6rURbHc6wKr4qA
         PYb6WPECA==
X-HalOne-Cookie: c6820af80656695f5a8dc50bdf7a07dee5e9d6b9
X-HalOne-ID: c7b2c282-e8fe-11ec-be77-d0431ea8bb03
Received: from mailproxy3.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c7b2c282-e8fe-11ec-be77-d0431ea8bb03;
        Fri, 10 Jun 2022 20:49:11 +0000 (UTC)
Date:   Fri, 10 Jun 2022 22:49:09 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Len Baker <len.baker@gmx.com>, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: ftbft: Use backlight helper
Message-ID: <YqOuRQ33bo1Y7Q+B@ravnborg.org>
References: <20220607185516.1129900-1-steve@sk2.org>
 <YqOoI6g6GVw0Z1s/@ravnborg.org>
 <20220610224306.325a6c91@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610224306.325a6c91@heffalump.sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:43:06PM +0200, Stephen Kitt wrote:
> Hi Sam,
> 
> On Fri, 10 Jun 2022 22:22:59 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Tue, Jun 07, 2022 at 08:55:16PM +0200, Stephen Kitt wrote:
> > > backlight_properties.fb_blank is deprecated. The states it represents
> > > are handled by other properties; but instead of accessing those
> > > properties directly, drivers should use the helpers provided by
> > > backlight.h.
> > > 
> > > Instead of manually checking the power state in struct
> > > backlight_properties, use backlight_is_blank().
> > > 
> > > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Noralf Trønnes" <noralf@tronnes.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > > Cc: Len Baker <len.baker@gmx.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-fbdev@vger.kernel.org
> > > Cc: linux-staging@lists.linux.dev
> > > ---
> > >  drivers/staging/fbtft/fb_ssd1351.c | 3 +--
> > >  drivers/staging/fbtft/fbtft-core.c | 3 +--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/fbtft/fb_ssd1351.c
> > > b/drivers/staging/fbtft/fb_ssd1351.c index 6fd549a424d5..b8d55aa8c5c7
> > > 100644 --- a/drivers/staging/fbtft/fb_ssd1351.c
> > > +++ b/drivers/staging/fbtft/fb_ssd1351.c
> > > @@ -196,8 +196,7 @@ static int update_onboard_backlight(struct
> > > backlight_device *bd) "%s: power=%d, fb_blank=%d\n",
> > >  		      __func__, bd->props.power, bd->props.fb_blank);  
> > Could you try to kill this use of props.fb_blank too?      ^^^^^^
> > A local variable should do the trick.
> 
> I have a pending patch changing this to show props.state instead, that way
> the debug info shows all the backlight-relevant information from props. How
> does that sound?
In the end we want to have only _one_ state for backlight, so the
simpler solution that just use one of the helpers would be better.
For this driver there is no reason to do much anyway.

	Sam
