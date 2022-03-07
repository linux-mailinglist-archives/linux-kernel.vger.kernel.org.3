Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08F44CEF57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiCGCKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiCGCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:10:36 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0995E0E7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:09:42 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id z7so13785134oid.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91JHo+kN7GqhMtZV/rEVrLYoHL8DpG7QLjAYJ+/Aigc=;
        b=nkrLcVSjKtzpHK3S3tQXUQCWDCHVlxe3tlubcwjorSDBLIGy2bvjmKf4SVkuSM7L5i
         WGd4jS+q6l6IBnrF0/NHAOgEPUjN0Sx3LL9ESYCvrvxZEqREuZ0aK/FNKJWCV8ShXsd6
         2Uceqox+rZhex2s47Sj4TSD/MbCbvTjEOf3Ujwf44vPr+G/t4IaOJhx/1TjgZvVC2vNt
         3fUzrR6MAH+iuXdyFO0x3ggOqOIsKARcSBOEX25QBQbK7DUsq9JWTtLD98/gNfJYeRvl
         4hVtA8FcLJg9DI2sf7zejvabDqs3Tbyf3UwXWDLBWX8qM0Syu0JJDSsqw+5VPqBAEvdu
         nVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91JHo+kN7GqhMtZV/rEVrLYoHL8DpG7QLjAYJ+/Aigc=;
        b=NmNrurg/m8YquOh0qZuZyk3kYT+tXGlXo5gLP+n8tiG46KGwKEetiyr56EjViYwDOv
         RX3oAln+qYogo7glwAGLhqhOekYM6T8StOk9dPSRw4y3XwQHVqi9OfIZc6TGMUf+sF47
         ghrkPlLzCrWVcLHDtbhruRDV+PRF8JG+GGQNvngj5gzuIV2MhFynTsab7fMZDCsJk1Qj
         N5ZWjGtIWg6mb83CIq9VCq6EDzoCd7bN/tNGYMUFmcbs0DAoM//QtmMoQalNnQj+YeCo
         JIJOU+DnuvMgS3/ueNiiN92JnlmtYiOlkHyCJsAMnR0Do1MCV3O9UKl8544sS1FRoPwz
         hHNQ==
X-Gm-Message-State: AOAM531v0ZedRM9d9CxmWXcRlmfj1e7j+8JVTVb3B/CaA2+b/hrRcTLA
        p5qTguSqoqbz58XVonIZhbx1Hg==
X-Google-Smtp-Source: ABdhPJwAKpbxqp6hCZqKQW5habAaQ+QISRXGoSwjX+Iv9KJo+kLrgL9emWB/BJsYLnF447eNJ97nGA==
X-Received: by 2002:a05:6808:10d2:b0:2d9:a01a:4b9d with SMTP id s18-20020a05680810d200b002d9a01a4b9dmr6145452ois.196.1646618981954;
        Sun, 06 Mar 2022 18:09:41 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id bl16-20020a056808309000b002d43b28a8bdsm6012298oib.14.2022.03.06.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 18:09:41 -0800 (PST)
Date:   Sun, 6 Mar 2022 20:09:39 -0600
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
Subject: Re: [PATCH v3 1/6] device property: Helper to match multiple
 connections
Message-ID: <YiVpY4ikOHwDwtZo@yoga>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
 <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIL/ejgxhfRhTDP@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04 Mar 06:54 CST 2022, Andy Shevchenko wrote:

> On Thu, Mar 03, 2022 at 02:33:46PM -0800, Bjorn Andersson wrote:
> > In some cases multiple connections with the same connection id
> > needs to be resolved from a fwnode graph.
> > 
> > One such example is when separate hardware is used for performing muxing
> > and/or orientation switching of the SuperSpeed and SBU lines in a USB
> > Type-C connector. In this case the connector needs to belong to a graph
> > with multiple matching remote endpoints, and the Type-C controller needs
> > to be able to resolve them both.
> > 
> > Add a new API that allows this kind of lookup.
> 
> ...
> 
> > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > +						const char *con_id, void *data,
> > +						devcon_match_fn_t match,
> > +						void **matches,
> > +						unsigned int matches_len)
> > +{
> > +	struct fwnode_handle *node;
> > +	struct fwnode_handle *ep;
> > +	unsigned int count = 0;
> > +	void *ret;
> > +
> > +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> 
> > +		if (count >= matches_len && matches) {
> > +			fwnode_handle_put(ep);
> > +			return count;
> > +		}
> 
> Wouldn't be the same as
> 
> 		if (count >= matches_len) {

This would cause the return value to be at most matches_len, seems
relevant to ignore (or perhaps require it to be 0) when matches is NULL.

But flipping the order of the expression seems better to me, now that
this has been sitting for a while.

> 			fwnode_handle_put(ep);
> 			break;

Right, this isn't an "early return", so nicer to have a single return at
the bottom.

> 		}
> 
> ?
> 
> > +		node = fwnode_graph_get_remote_port_parent(ep);
> > +		if (!fwnode_device_is_available(node)) {
> > +			fwnode_handle_put(node);
> > +			continue;
> > +		}
> > +
> > +		ret = match(node, con_id, data);
> > +		fwnode_handle_put(node);
> > +		if (ret) {
> > +			if (matches)
> > +				matches[count] = ret;
> > +			count++;
> > +		}
> > +	}
> > +	return count;
> > +}
> 
> ...
> 
> > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > +					  const char *con_id, void *data,
> > +					  devcon_match_fn_t match,
> > +					  void **matches,
> > +					  unsigned int matches_len)
> > +{
> > +	struct fwnode_handle *node;
> > +	unsigned int count = 0;
> > +	unsigned int i;
> > +	void *ret;
> > +
> > +	for (i = 0; ; i++) {
> 
> > +		if (count >= matches_len && matches)
> > +			return count;
> 
> Ditto.
> 
> > +		node = fwnode_find_reference(fwnode, con_id, i);
> > +		if (IS_ERR(node))
> > +			break;
> > +
> > +		ret = match(node, NULL, data);
> > +		fwnode_handle_put(node);
> > +		if (ret) {
> > +			if (matches)
> > +				matches[count] = ret;
> > +			count++;
> > +		}
> > +	}
> > +
> > +	return count;
> > +}
> 
> ...
> 
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +				   const char *con_id, void *data,
> > +				   devcon_match_fn_t match,
> > +				   void **matches, unsigned int matches_len)
> > +{
> > +	unsigned int count_graph;
> > +	unsigned int count_ref;
> > +
> > +	if (!fwnode || !match)
> > +		return -EINVAL;
> 
> > +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +						  matches, matches_len);
> 
> > +	matches += count_graph;
> > +	matches_len -= count_graph;
> 
> No, won't work when matches == NULL.
> 

Sorry about that, you're obviously correct.

> Also, matches_len is expected to be 0 in that case (or at least being ignored,
> check with vsnprintf() behaviour in similar case).
> 
> So, something like this, perhaps
> 
> 	if (matches && matches_len) {
> 		matches += count_graph;
> 		matches_len -= count_graph;
> 	}

Seems reasonable.

Thanks,
Bjorn

> 
> > +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > +					  matches, matches_len);
> > +
> > +	return count_graph + count_ref;
> > +}
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
