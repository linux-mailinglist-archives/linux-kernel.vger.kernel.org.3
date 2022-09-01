Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6A5A9CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiIAQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiIAQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:10:29 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B7222A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:10:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 7DAE7200F0;
        Thu,  1 Sep 2022 18:10:26 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9oQyLuhvKSZD; Thu,  1 Sep 2022 18:10:26 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1F383200EE;
        Thu,  1 Sep 2022 18:10:26 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oTmlt-002j8K-22;
        Thu, 01 Sep 2022 18:10:25 +0200
Date:   Thu, 1 Sep 2022 18:10:25 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/2] speakup-dummy: Add support for PUNCT variable
Message-ID: <20220901161025.5q7cwb4hpj2osnuk@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20220823222501.483597563@ens-lyon.org>
 <20220823222514.929670068@ens-lyon.org>
 <YxDI0LWy/Gqwy1GT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDI0LWy/Gqwy1GT@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH, le jeu. 01 sept. 2022 16:59:28 +0200, a ecrit:
> On Wed, Aug 24, 2022 at 12:25:02AM +0200, Samuel Thibault wrote:
> > This allows to debug the update of the punctuation level.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > Index: linux/drivers/accessibility/speakup/speakup_dummy.c
> > ===================================================================
> > --- linux.orig/drivers/accessibility/speakup/speakup_dummy.c
> > +++ linux/drivers/accessibility/speakup/speakup_dummy.c
> > @@ -27,6 +27,7 @@ static struct var_t vars[] = {
> >  	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
> >  	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
> >  	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
> > +	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
> >  	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
> >  	V_LAST_VAR
> >  };
> > @@ -42,6 +43,8 @@ static struct kobj_attribute pitch_attri
> >  	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
> >  static struct kobj_attribute inflection_attribute =
> >  	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
> > +static struct kobj_attribute punct_attribute =
> > +	__ATTR(punct, 0644, spk_var_show, spk_var_store);
> >  static struct kobj_attribute rate_attribute =
> >  	__ATTR(rate, 0644, spk_var_show, spk_var_store);
> >  static struct kobj_attribute tone_attribute =
> > @@ -69,6 +72,7 @@ static struct attribute *synth_attrs[] =
> >  	&caps_stop_attribute.attr,
> >  	&pitch_attribute.attr,
> >  	&inflection_attribute.attr,
> > +	&punct_attribute.attr,
> >  	&rate_attribute.attr,
> >  	&tone_attribute.attr,
> >  	&vol_attribute.attr,
> > 
> 
> Don't we also need a Documentation/ABI/ update for this new sysfs file?

It is already there actually, because it's the same variables fo various
syntheses, and this is just adding the support for punct (already known
in other syntheses) to the dummy synthesis.

Samuel
