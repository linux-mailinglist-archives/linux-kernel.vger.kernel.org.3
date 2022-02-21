Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75064BD4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiBUExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:53:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbiBUExe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:53:34 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCAF517F4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:53:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s5so9650556oic.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U9guWiEcPMV7PWzSzfcCTMB5YDev3KLGmnMGaqiDx+0=;
        b=rx94dO90CjQ8ANnCwpTq4fW8qzvkh1TM5mwcJUm3S0DciuQfHg+tqccg/KMa76WVaX
         fgcht9DjQJ6KMnTI1S9evOQih/k0sq8/dCMvFyzQS8jTZ6pEDLVOs3vcTTR2wT4vTIxT
         X+yrVpOtyrb0TJxrYaKMLtChBmwwunPx53xjZBCfNZ2d7NR9jkRUF0tpwugsDMytNsmr
         GxB97w2U1aXNbZGswcEm6L1Cs9eIn0oVpfydKaHVtBHdJyIgTcy2FEarX2wIfPbPl+Rq
         JqIPq995H7n+0/IAmORhljAcPae/VaARwqRl5E0t8jmBsjtVlPHZCr4Tw0zmvb2mhVgL
         hMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9guWiEcPMV7PWzSzfcCTMB5YDev3KLGmnMGaqiDx+0=;
        b=cW9GPPVyR1IQJQ/Wbn97g1w01lDhq/3mHIPetn0ZzMb9n9qQY1vbe1Y87Ywm3Cxn/P
         3ZnOBhkuMFhxCc09vE7aoZVRoBy1DPpAXgIfW3fU88S6aBDq8jd4VgVgC5Ggg/06ysf0
         dqORAOw7QD5KI2SAGblqEJd/ApxzE9h6KBuerJIft5SxBcA9BZg9e16acjrCw8wnq3tx
         uJnOnCUdTDYAcNQ0xfj2vXfSRAkK7sT4yyX1qkV9ZWMNTCJwfD8kQsrxKFNLgnBau9nq
         Wg0sVtz0Jy+KFUwzFfuSKZGaJQInMt4a2kK74yay2X6KWIojhnmr1YimoQy5Tl509Nj2
         KzSg==
X-Gm-Message-State: AOAM533XdInb8MOWjg3lP61WZ6fm3Hy2fDB+iYtLDaGF+jrby3GruIhK
        dSXeW/wW2TmSQgEOV4mz6OnQ1w==
X-Google-Smtp-Source: ABdhPJwLpaRqy77tse+QFPujJ1+fkFgfK7d1zSVnK9L9wQyNlSWzfzxJ4NBsuc5FdSiTPDSTr6TCCA==
X-Received: by 2002:aca:368a:0:b0:2d3:fc60:937f with SMTP id d132-20020aca368a000000b002d3fc60937fmr9426236oia.182.1645419188539;
        Sun, 20 Feb 2022 20:53:08 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w4sm4405549oor.30.2022.02.20.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 20:53:08 -0800 (PST)
Date:   Sun, 20 Feb 2022 20:55:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/6] device property: Helper to match multiple
 connections
Message-ID: <YhMbLsvF8p/ce+mg@ripper>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
 <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
 <Yg/s3eKB2wLEQTgY@ripper>
 <YhIjHjMrhUpM0ucV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhIjHjMrhUpM0ucV@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 20 Feb 03:16 PST 2022, Andy Shevchenko wrote:

> On Fri, Feb 18, 2022 at 11:00:45AM -0800, Bjorn Andersson wrote:
> > On Wed 09 Feb 04:30 PST 2022, Andy Shevchenko wrote:
> > > On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:
> 
> ...
> 
> > > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > > +				   const char *con_id, void *data,
> > > > +				   devcon_match_fn_t match,
> > > > +				   void **matches, unsigned int matches_len)
> > > > +{
> > > > +	unsigned int count;
> > > > +
> > > > +	if (!fwnode || !match || !matches)
> > > 
> > > !matches case may be still useful to get the count and allocate memory by
> > > caller. Please, consider this case.
> > > 
> > 
> > As discussed in previous version, and described in the commit message,
> > the returned value of "match" is a opaque pointer to something which
> > has to be passed back to the caller in order to be cleaned up.
> > 
> > E.g. the typec mux code returns a pointer to a typec_mux/switch object
> > with a refcounted struct device within, or an ERR_PTR().
> > 
> > So unfortunately we can must gather the results into matches and pass it
> > back to the caller to take consume or clean up.
> 
> 
> It's fine. You have **matches, means pointer of an opaque pointer.
> What I'm talking about is memory allocation for and array of _pointers_.
> That's what caller very much aware of and can allocate on heap. So, please
> consider this case.
> 

I'm sorry, but I'm not sure what you're looking for.


I still interpret your comment as that it would be nice to be able to do
something like:

count = fwnode_connection_find_matches(fwnode, "orientation-switch",
				       NULL, typec_switch_match, NULL, 0);

based on the returned value the caller could allocate an array of
"count" pointers and then call the function again to actually fill out
the count elements.


The problem with this is that, typec_switch_match() does:

void *typec_switch_match(fwnode, id, data) {
	struct device *dev = find_struct_device(fwnode, id);
	if (!dev)
		return NULL;
	get_device(dev);
	return container_of(dev, struct typec_switch, dev);
}

So if we call the match function and if that finds a "dev" it will
return a struct typec_switch with a refcounted struct device within.

We can see if that's NULL or not and will be able to return a "count",
but we have no way of releasing the reference acquired - we must return
the void pointer back to the client, so that it can release it.


My claim is that this is not a problem, because this works fine with any
reasonable size of fwnode graphs we might run into - and the client will
in general have a sense of the worst case number of matches (in this
series its 3, as there's 3 types of lanes that can be switched/muxed
coming out of a USB connector).


But that's perhaps not what you're referring to? Or perhaps I'm missing
something else?

Regards,
Bjorn
