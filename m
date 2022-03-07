Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFEB4CEF91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiCGCT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiCGCTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:19:22 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B417A9D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:18:27 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso2952131ota.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 18:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I75h6LhAtjwEVOG1obXgRQCns82YtNru8ErTsopmb+c=;
        b=Lq99Jt34fM3nkb6AASGabMpRh9l5yEgk02yWCnzPFj5RpuIo0JiRtcpEo4M/Os2Sah
         wyiNCyU9e2SJaNnO6koj/C5/ZSzM1CvuZ0kzCEz9aWWgahJg843WS3uqfqKtvPRIjgPe
         VRb/Lk13abbodpYzFbG8Jb4C1TUl3aHuwr8/H8cWJYDMmAPxCjfW17pNJ+HJLzJoJCdS
         ZQJXXs3OKBw6IeMKBk9W6EX3PBIshkqNBblS5tuOIgVMnBBWx5+hStSh2IreMQgIC+pX
         BrWDo4mrRf6Mg2H6AXJD4+DN88ii7MzSTeprb0usnzpS3fdLDMb/8Mi0qOsMoBBr9rDp
         V8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I75h6LhAtjwEVOG1obXgRQCns82YtNru8ErTsopmb+c=;
        b=NifDGb9OVp9UvIjmy73a4xkInVjqk+6fv8E4ctp9xloOuqpNGZXVUr4+dg970eylUW
         ih2hM4fpHljOkqo4xxXy0boa0xkT2YAPdqAm1UN0fsvLnO6R47GGxhjihix15C/+Sjfr
         dOA7bPlvIL+CHKO8KfmxhFOHI/v0GKt+6u1WLaN0k/eZ0FQgOleHLdjx6jsfNqwTHj9p
         L04zphuiwH4iBRusN5CbrHNmVTqV4yY6vTmU0e1Wk/Qrjj9E34nooy4omzQo1YdACtNb
         S8r4sf0/WZA3a1fO3uVvn1wRSgQymwgkG5YUxEYy2fBn1NqjgpDZcLVlE2YfxTaA+ue/
         og/w==
X-Gm-Message-State: AOAM5322blxpbh1B+vEC7B68gV7WZYxFHJ1U89e042Nm+0e6xGU9O+1s
        vdUp+S0CfdsO1ltGGYxv00fwmg==
X-Google-Smtp-Source: ABdhPJxeOnJtyKa0nRFCFoj+YWeMcIoJsmC3kWoeTCLFhLbBXTmKoqVh6yxCQxm5CEM2JOtCzTyMvg==
X-Received: by 2002:a05:6830:1089:b0:5af:1840:81c0 with SMTP id y9-20020a056830108900b005af184081c0mr4629756oto.232.1646619506724;
        Sun, 06 Mar 2022 18:18:26 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id w1-20020a056871060100b000d9a1c283e8sm5066422oan.37.2022.03.06.18.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 18:18:26 -0800 (PST)
Date:   Sun, 6 Mar 2022 20:18:24 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 1/6] device property: Helper to match multiple
 connections
Message-ID: <YiVrcN3NA3uS0icv@yoga>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
 <YiIXDZnquRZj8dU5@paasikivi.fi.intel.com>
 <YiIZoyfsJDcwR4gr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIZoyfsJDcwR4gr@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Mar 07:52 CST 2022, Andy Shevchenko wrote:

> On Fri, Mar 04, 2022 at 03:41:33PM +0200, Sakari Ailus wrote:
> > On Fri, Mar 04, 2022 at 02:54:21PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 03, 2022 at 02:33:46PM -0800, Bjorn Andersson wrote:
> 
> ...
> 
> > > > +		if (count >= matches_len && matches) {
> > > > +			fwnode_handle_put(ep);
> > > > +			return count;
> > > > +		}
> > > 
> > > Wouldn't be the same as
> > > 
> > > 		if (count >= matches_len) {
> > > 			fwnode_handle_put(ep);
> > > 			break;
> > > 		}
> > 
> > Don't you need to check for non-NULL matches here?
> 
> Right, this should be kept as in original patch.
> 
> > I find return above easier to read.
> 
> Okay, original code may work, so I have no strong opinion about return vs
> break, although I find slightly better to have a single point of return in
> such case.
> 

I like using early returns when possible, but this is not an early
return and it is in the loop so it makes more sense to me to break out.

> > > ?
> 
> ...
> 
> > > > +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > > > +						  matches, matches_len);
> > > 
> > > > +	matches += count_graph;
> > > > +	matches_len -= count_graph;
> > > 
> > > No, won't work when matches == NULL.
> > > 
> > > Also, matches_len is expected to be 0 in that case (or at least being ignored,
> > > check with vsnprintf() behaviour in similar case).
> > > 
> > > So, something like this, perhaps
> > > 
> > > 	if (matches && matches_len) {
> > > 		matches += count_graph;
> > > 		matches_len -= count_graph;
> > > 	}
> > 
> > Good find!
> 
> I have checked vsnprintf() and indeed, it expects to have the size is 0 when
> the resulting buffer pointer is NULL, and it doesn't do any additional checks.
> 

Per the vsnprintf() semantics it's not the destination buffer being NULL
that's significant, but rather just the length being 0 that matters.

To follow that, I should fill @matches_len entries in @matches and then
just continue counting without storing anything in @matches.

But that won't work in this case, because in the event that the @match
function returns something that has to be freed (such as the refcounted
objects returned by the typec_mux code), dropping this in favor of just
counting it would cause memory/reference leaks.

As such, I think this should differ in that @matches = NULL is
significant, and it's nice to not have matches_len turn negative/bogus
in the count case.

So I like your suggestion.

Thanks,
Bjorn

> > > > +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > > > +					  matches, matches_len);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
