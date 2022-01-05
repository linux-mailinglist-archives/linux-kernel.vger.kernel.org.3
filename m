Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE6485A29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiAEUmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiAEUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:42:40 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9CC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:42:40 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso749324oti.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GqKtuhkPiMoPzGt6j5rJjkXpaGOAonB+8jqGdQJ30AU=;
        b=k5quMqvUgiT2ESX4nHdif3wTGD4JTrRIyVSYUGAUzNuMwItyG7xSG/8T320z4D6/cl
         QRJAdLwwVTNlyzaokVZczMhAawT9VIhvPnliKhWAAIzDzMTSAopHGcZ0EC6ROlnVHqJ7
         ymRlqyvN27bEBwDj5TrQ+ZzJyr8Rgddjl3ayfk1BvgtVYh26/S9X8J1r1dKT9mtyc7vD
         k+99Cyht5XtCpeS6jrEe4bngyOcjLnkOPBIaCx9Js9ZaSyfVcXWIsxsDYA3XjmA7dQeW
         Co3A6uC9nV8yJgBH2CnhdgTFSCuQxXGu9xXdY905uUZqvbRa1amrD99COlZXiqSog0Uj
         vyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GqKtuhkPiMoPzGt6j5rJjkXpaGOAonB+8jqGdQJ30AU=;
        b=j6CCG+NgbTOwkp+Z4bqJBWemx5U7idlqu+QZmEc2NF0pcUnJWW373N2cVtWeO0y+83
         rtgylhlEO/7jrSpZDXP4oVnByStKckPnRRSxqoLK+0SYRm4trHXdEnfGvD724GYXuHyz
         4Zb956degoiHrq7AKE9o3jvOBcRJbmlOiXXMmTTVYA/rrNn4sb2VnHDCca7BuRnq7Ssb
         TmvYTeci5CHnCRizKTtgHqCt5ot1YxUIaeVHSuqCg55UNmgO5b/X3bBuho+0iTYQUGfg
         purAmHqUK56wWNgxpOb6btZhY3IPbizGgpuaRelwfLg0VnhZgv4ymlPMBLYL6SlAg/qM
         yigQ==
X-Gm-Message-State: AOAM532BPUs0ezAJeiAoa4HciC911QPpJ56afTCF1vYepnLhYYX2lJt5
        4T+3XiH3iy+TTYxwJkOjEMHsGA==
X-Google-Smtp-Source: ABdhPJwn09fZPAkcMlQq+rmMAWcs2U0izBZKiAM3vzg/0ktiMRpswUHye3oJ0Gn5utow2lQjPMgFRQ==
X-Received: by 2002:a9d:313:: with SMTP id 19mr38383642otv.2.1641415359717;
        Wed, 05 Jan 2022 12:42:39 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f27sm8430162otc.16.2022.01.05.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:42:38 -0800 (PST)
Date:   Wed, 5 Jan 2022 12:43:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] device property: Helper to match multiple connections
Message-ID: <YdYC8DeF1i9a3RnP@ripper>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org>
 <Yc17Ssug3neFFXKN@kuha.fi.intel.com>
 <Yc7I3gZehc1lHn4Z@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yc7I3gZehc1lHn4Z@paasikivi.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 Dec 01:09 PST 2021, Sakari Ailus wrote:

> Hi Björn,
> 
> (And thanks to Heikki for cc'ing me!)
> 
> On Thu, Dec 30, 2021 at 11:26:34AM +0200, Heikki Krogerus wrote:
> > +Andy, Dan and Sakari
> > 
> > On Mon, Dec 27, 2021 at 09:21:11PM -0800, Bjorn Andersson wrote:
> > > In some cases multiple connections with the same connection id
> > > needs to be resolved from a fwnode graph.
> > > 
> > > One such example is when separate hardware is used for performing muxing and/or
> > > orientation switching of the SuperSpeed and SBU lines in a USB-C
> > > connector. In this case the connector needs to belong to a graph with
> > > multiple matching remote endpoints, and the TypeC controller needs to be
> > > able to resolve them both.
> > > 
> > > Add a new API that allows this kind of lookup.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/property.h |  5 +++
> > >  2 files changed, 99 insertions(+)
> > > 
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index cbe4fa298413..0aa0296fd991 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >  	return NULL;
> > >  }
> > >  
> > > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > > +						const char *con_id, void *data,
> > > +						devcon_match_fn_t match,
> > > +						void **matches,
> > > +						unsigned int matches_len)
> > > +{
> > > +	struct fwnode_handle *node;
> > > +	struct fwnode_handle *ep;
> > > +	unsigned int count = 0;
> > > +	void *ret;
> > > +
> > > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > +		if (count >= matches_len) {
> > > +			fwnode_handle_put(ep);
> > > +			return count;
> > > +		}
> > > +
> > > +		node = fwnode_graph_get_remote_port_parent(ep);
> > > +		if (!fwnode_device_is_available(node))
> 
> The reference to node needs to be put here.
> 

You're right, thanks!

> > > +			continue;
> > > +
> > > +		ret = match(node, con_id, data);
> > > +		fwnode_handle_put(node);
> > > +
> > > +		if (ret)
> > > +			matches[count++] = ret;
> > > +	}
> > > +	return count;
> > > +}
> > > +
> > >  static void *
> > >  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >  		    void *data, devcon_match_fn_t match)
> > > @@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >  	return NULL;
> > >  }
> > >  
> > > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > > +					  const char *con_id, void *data,
> > > +					  devcon_match_fn_t match,
> > > +					  void **matches,
> > > +					  unsigned int matches_len)
> > > +{
> > > +	struct fwnode_handle *node;
> > > +	unsigned int count = 0;
> > > +	void *ret;
> > > +	int i;
> 
> unsigned int, please.
> 

Sounds good.

> > > +
> > > +	for (i = 0; ; i++) {
> > > +		if (count >= matches_len)
> > > +			return count;
> > > +
> > > +		node = fwnode_find_reference(fwnode, con_id, i);
> > > +		if (IS_ERR(node))
> > > +			break;
> > > +
> > > +		ret = match(node, NULL, data);
> > > +		fwnode_handle_put(node);
> > > +
> > > +		if (ret)
> > > +			matches[count++] = ret;
> > > +	}
> > > +
> > > +	return count;
> > > +}
> > > +
> > >  /**
> > >   * fwnode_connection_find_match - Find connection from a device node
> > >   * @fwnode: Device node with the connection
> > > @@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> > >  	return fwnode_devcon_match(fwnode, con_id, data, match);
> > >  }
> > >  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> > > +
> > > +/**
> > > + * fwnode_connection_find_matches - Find connections from a device node
> > > + * @fwnode: Device node with the connection
> > > + * @con_id: Identifier for the connection
> > > + * @data: Data for the match function
> > > + * @match: Function to check and convert the connection description
> > > + * @matches: Array of pointers to fill with matches
> > > + * @matches_len: Length of @matches
> > > + *
> > > + * Find up to @matches_len connections with unique identifier @con_id between
> > > + * @fwnode and other device nodes. @match will be used to convert the
> > > + * connection description to data the caller is expecting to be returned
> > > + * through the @matches array.
> 
> If the caller allocates the matches array, how does it know how large it
> should be? Is there a need to provide a way to count the matches before
> writing them to an array? Most similar functions do that by just setting the
> array (matches) to NULL.
> 

This is a very relevant comment and I did look for ways to handle this
as I came up with the patch.

I think the typical mechanism would be to allow @matches to be NULL, in
which case we iterate over objects and return the number of matches, so
that the caller can allocate an appropriately sized array and call the
API again.

But the "match" function simply returns a pointer to something and
looking at the example of the typec_{mux,switch} this pointer points to
a member of an object which has a struct device which is refcounted.

As such, we can't simply discard the returned object. We have to pass it
back to the caller, whom knows what "match" did and is able to reverse
that.

I looked at changing the callback and I looked at using krealloc() to
grow an array dynamically.


But looking at the use case in mind; finding entities that might need to
react to a USB Type-C event I have a need for 2 matches, and 3 seems
plausible. Beyond that the largest of_graph I have ever dealt with has 6
endpoints.

While it isn't relevant to use this API for my 6-endpoint case, it would
result in @matches having to be 48 bytes of pointers. And once the call
returns, the actual number of pointers needed is known and the long-term
storage can be re-allocated as necessary based on the return value.

As such, I dropped the idea of making something fancier and more
dynamic, for the sake of simplicity. Perhaps I'm missing some cool use
case where this is infeasible?

Regards,
Bjorn

> > > + *
> > > + * Return: Number of matches resolved, of negative errno.
> > > + */
> > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > +				   const char *con_id, void *data,
> > > +				   devcon_match_fn_t match,
> > > +				   void **matches, unsigned int matches_len)
> > > +{
> > > +	unsigned int count;
> > > +
> > > +	if (!fwnode || !match || !matches)
> > > +		return -EINVAL;
> > > +
> > > +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > > +					    matches, matches_len);
> > > +
> > > +	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> > > +					     matches + count,
> > > +					     matches_len - count);
> > > +}
> > > +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> > > diff --git a/include/linux/property.h b/include/linux/property.h
> > > index 16f736c698a2..59484ccb260e 100644
> > > --- a/include/linux/property.h
> > > +++ b/include/linux/property.h
> > > @@ -444,6 +444,11 @@ static inline void *device_connection_find_match(struct device *dev,
> > >  	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
> > >  }
> > >  
> > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > +				   const char *con_id, void *data,
> > > +				   devcon_match_fn_t match,
> > > +				   void **matches, unsigned int matches_len);
> > > +
> > >  /* -------------------------------------------------------------------------- */
> > >  /* Software fwnode support - when HW description is incomplete or missing */
> > >  
> 
> -- 
> Kind regards,
> 
> Sakari Ailus
