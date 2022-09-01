Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF15A9CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiIAQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiIAQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3A93519
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82968B82880
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8405C433C1;
        Thu,  1 Sep 2022 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662049410;
        bh=wvgqREPHyp98u3eappzNJVhkpQS3gkbv1YU910Y8M/o=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=OGGhjYPjyzKb1XIp1Ia/Mt/CUK6uJCFs3D/AwI+ebWduqQqCD3wYu6wvPNc/XkSEE
         csHZfFgW2w/4TWA6R/+ErdRZLrOfyhhdJ2aXXuaII61xXx9aAG8lTWTFCq2C5mv3cN
         hWUGKmNz9a7huxYVo+vkqE+UwtDT1Smi5T6kKKGY=
Date:   Thu, 1 Sep 2022 18:23:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/2] speakup-dummy: Add support for PUNCT variable
Message-ID: <YxDcf3+TIhiokxQi@kroah.com>
References: <20220823222501.483597563@ens-lyon.org>
 <20220823222514.929670068@ens-lyon.org>
 <YxDI0LWy/Gqwy1GT@kroah.com>
 <20220901161025.5q7cwb4hpj2osnuk@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901161025.5q7cwb4hpj2osnuk@begin>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 06:10:25PM +0200, Samuel Thibault wrote:
> Hello,
> 
> Greg KH, le jeu. 01 sept. 2022 16:59:28 +0200, a ecrit:
> > On Wed, Aug 24, 2022 at 12:25:02AM +0200, Samuel Thibault wrote:
> > > This allows to debug the update of the punctuation level.
> > > 
> > > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > > 
> > > Index: linux/drivers/accessibility/speakup/speakup_dummy.c
> > > ===================================================================
> > > --- linux.orig/drivers/accessibility/speakup/speakup_dummy.c
> > > +++ linux/drivers/accessibility/speakup/speakup_dummy.c
> > > @@ -27,6 +27,7 @@ static struct var_t vars[] = {
> > >  	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
> > >  	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
> > >  	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
> > > +	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
> > >  	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> > >  	V_LAST_VAR
> > >  };
> > > @@ -42,6 +43,8 @@ static struct kobj_attribute pitch_attri
> > >  	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
> > >  static struct kobj_attribute inflection_attribute =
> > >  	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
> > > +static struct kobj_attribute punct_attribute =
> > > +	__ATTR(punct, 0644, spk_var_show, spk_var_store);
> > >  static struct kobj_attribute rate_attribute =
> > >  	__ATTR(rate, 0644, spk_var_show, spk_var_store);
> > >  static struct kobj_attribute tone_attribute =
> > > @@ -69,6 +72,7 @@ static struct attribute *synth_attrs[] =
> > >  	&caps_stop_attribute.attr,
> > >  	&pitch_attribute.attr,
> > >  	&inflection_attribute.attr,
> > > +	&punct_attribute.attr,
> > >  	&rate_attribute.attr,
> > >  	&tone_attribute.attr,
> > >  	&vol_attribute.attr,
> > > 
> > 
> > Don't we also need a Documentation/ABI/ update for this new sysfs file?
> 
> It is already there actually, because it's the same variables fo various
> syntheses, and this is just adding the support for punct (already known
> in other syntheses) to the dummy synthesis.

Ah, nevermind, thanks!
