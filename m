Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2484BEA63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiBUTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:07:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBUTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:06:51 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262413D0A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:06:27 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso11444095ooc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mKYaMuXCaSDbgjwH5cDbyrb4SD5Y9F+pgT6HwHOAhw4=;
        b=UayZoVpBKx73lHes9iSu/MRvaEOhZYEQ0s336NxWMNl0hTE8xxqgGUfeNvZRpbJdno
         bOXRl6PkW8QImlSkKym03EpeC3YUqykYUDzXJEAjDMnB7u6ql+oPbHK9HEsdVwtY/+C/
         nmuUkEiG2Sl3O+QCGNRlSv3D/YOZKHwFp6gT5CNkRsSapZG88rQf7n6cwMhEw/em7yHn
         tP6rxY2fRy05sFM6IvlXbTZRYrjvqNN6/WHXbLLxKES1yx+79e8gfw9mp/jIgZeDAFZV
         xBs2Ud8HzCJrTLNVQ1+x/cMlh8ji2v4uhcUQHMGrv+jYpYKwGMCo4jD4zxHD8X1dwqjB
         z7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mKYaMuXCaSDbgjwH5cDbyrb4SD5Y9F+pgT6HwHOAhw4=;
        b=ZjpxbiGoTnK0HVAq1Mb/aqWu3YdG3W37Jbl30UJH1VOEg1HgYbPl0Po3/CLhBIiN8T
         6xqd6cr3XvaxEEKhDUU7hDSnfWNtFyZCjg+DwCvcPE6ODtTDzgl+eM5DN+BoYY3vmdnS
         FGwFeLfA4POAYkC6xxPK2aveaDg9Wp6DADgBbCtAr/aMqEsGHAPOEY3FhP7SHcQhAZOv
         D3zi+7BdSnR06AGD8DyUZpk5T5tNiyMpmCdYdkjDHqV7n1RJdLiqCNEGBdurjNKd//U1
         j6MF8ZPt5biU23YwS6L5DayaM2VHrqAkRdQaunE972EIrGTzqnGazcHSbQ2b1h2nE35X
         hr5g==
X-Gm-Message-State: AOAM532UmY4t7QYlwmmxPKNTmKfFafgphyuFF8KnbxmI+grQqA6+nbg3
        pjfOMMPlNUTuA0bldwQ4ONoJ6A==
X-Google-Smtp-Source: ABdhPJxZkhpfXyfMIR6pZATfsUiV6WfNFnMWVkBrVLoHBjm225+ktGOVREx1Vzzq++JUcijZyrDVVQ==
X-Received: by 2002:a4a:1506:0:b0:2da:ee84:9759 with SMTP id 6-20020a4a1506000000b002daee849759mr6514311oon.65.1645470386741;
        Mon, 21 Feb 2022 11:06:26 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j32sm4357309ota.59.2022.02.21.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:06:25 -0800 (PST)
Date:   Mon, 21 Feb 2022 11:08:28 -0800
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
Message-ID: <YhPjLOJchd4l+095@ripper>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
 <20220208031944.3444-2-bjorn.andersson@linaro.org>
 <YgOz6K55Oi2Si4pU@smile.fi.intel.com>
 <Yg/s3eKB2wLEQTgY@ripper>
 <YhIjHjMrhUpM0ucV@smile.fi.intel.com>
 <YhMbLsvF8p/ce+mg@ripper>
 <YhPJmiFSH8s94il7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhPJmiFSH8s94il7@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Feb 09:19 PST 2022, Andy Shevchenko wrote:

> On Sun, Feb 20, 2022 at 08:55:10PM -0800, Bjorn Andersson wrote:
> > On Sun 20 Feb 03:16 PST 2022, Andy Shevchenko wrote:
> > > On Fri, Feb 18, 2022 at 11:00:45AM -0800, Bjorn Andersson wrote:
> > > > On Wed 09 Feb 04:30 PST 2022, Andy Shevchenko wrote:
> > > > > On Mon, Feb 07, 2022 at 07:19:39PM -0800, Bjorn Andersson wrote:
> 
> ...
> 
> > > > > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > > > > +				   const char *con_id, void *data,
> > > > > > +				   devcon_match_fn_t match,
> > > > > > +				   void **matches, unsigned int matches_len)
> > > > > > +{
> > > > > > +	unsigned int count;
> > > > > > +
> > > > > > +	if (!fwnode || !match || !matches)
> > > > > 
> > > > > !matches case may be still useful to get the count and allocate memory by
> > > > > caller. Please, consider this case.
> > > > 
> > > > As discussed in previous version, and described in the commit message,
> > > > the returned value of "match" is a opaque pointer to something which
> > > > has to be passed back to the caller in order to be cleaned up.
> > > > 
> > > > E.g. the typec mux code returns a pointer to a typec_mux/switch object
> > > > with a refcounted struct device within, or an ERR_PTR().
> > > > 
> > > > So unfortunately we can must gather the results into matches and pass it
> > > > back to the caller to take consume or clean up.
> > > 
> > > It's fine. You have **matches, means pointer of an opaque pointer.
> > > What I'm talking about is memory allocation for and array of _pointers_.
> > > That's what caller very much aware of and can allocate on heap. So, please
> > > consider this case.
> > 
> > I'm sorry, but I'm not sure what you're looking for.
> > 
> > 
> > I still interpret your comment as that it would be nice to be able to do
> > something like:
> > 
> > count = fwnode_connection_find_matches(fwnode, "orientation-switch",
> > 				       NULL, typec_switch_match, NULL, 0);
> > 
> > based on the returned value the caller could allocate an array of
> > "count" pointers and then call the function again to actually fill out
> > the count elements.
> 
> Yes, that's what I want from the generic fwnode APIs.
> (Keyword: generic)
> 
> > The problem with this is that, typec_switch_match() does:
> 
> As you stated, the problem is in the typec_switch_match(). So, it's not related
> to the fwnode, but how you are using it.
> 
> > void *typec_switch_match(fwnode, id, data) {
> > 	struct device *dev = find_struct_device(fwnode, id);
> > 	if (!dev)
> > 		return NULL;
> > 	get_device(dev);
> > 	return container_of(dev, struct typec_switch, dev);
> > }
> > 
> > So if we call the match function and if that finds a "dev" it will
> > return a struct typec_switch with a refcounted struct device within.
> 
> fwnode (as being an abstraction on top of the others) has no knowledge
> about this. And more important should not know that.
> 
> > We can see if that's NULL or not and will be able to return a "count",
> > but we have no way of releasing the reference acquired - we must return
> > the void pointer back to the client, so that it can release it.
> 
> The caller (if it wants to!) may create different callbacks for count and real
> matching, no?
> 

Ahh, yeah you're right, we can shift this responsibility onto the caller
and thereby allow them to implement the count as well. Makes sense!

Thanks,
Bjorn

> > My claim is that this is not a problem, because this works fine with any
> > reasonable size of fwnode graphs we might run into - and the client will
> > in general have a sense of the worst case number of matches (in this
> > series its 3, as there's 3 types of lanes that can be switched/muxed
> > coming out of a USB connector).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
