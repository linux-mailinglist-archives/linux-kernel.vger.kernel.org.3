Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4584D0755
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiCGTMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiCGTMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:12:41 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE35641B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:11:46 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w17-20020a056830111100b005b22c584b93so3624660otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jb3LOlMf5pk1D9PjLVHGSfg0goBFbrUHnygCupUhgZI=;
        b=iNQpsc5C47zsL+rwea5Gp9oqE5D8fpUxVHM/oEeqnouFvmu3EH516OlUb2UAnzE9j7
         0fKrEb4VlNgNhBDOxV3WTDoN9IjJv7auS6de717hqUuXbO8rfTXzlEGqnVyfSBYs4TRo
         JbHNYrXbasfzo6mbe5OoZ43yxlqsM24sjqZeKJddKqh+lHn/8ULKrgyJODzAudqWEF2M
         dZQJtvb/W71PecwPK8ychQ5EwhbpQfCJL6Yz3j/4KX4p5jnGKQKdzSlKW5WRYZOJA82r
         SQi+26rzzx5f0ztSOvpa211LBscQiorvpyq+3U7Wca8GeWz9ACEhPQLS8pKIgqhbMLjM
         9itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jb3LOlMf5pk1D9PjLVHGSfg0goBFbrUHnygCupUhgZI=;
        b=YJiYLklzSmyIORJCDgpC/DjWciLckXgBICxfhFB8+QafHm9/mgbNJAuPvGK68sX2xz
         it+AlX/ng23qwgJt7JDrrbXXdxipaF8zPOLD9YFYDYLXqgZP9+Fp1d9uctIzRhN+q61y
         LkAeAM9CQP6JpxPyRjIAf/vTeEP2wYdkzXnIZlciNQp9VPECbRiby6up52ATnJkG+heT
         DKvHh9fl60lKyV67ci1WW4gtx6xSdnB4duoKEECFTnhCZuaH3fXP5nHQxf7PLi5dqyYh
         7TRXd8CGGrnO7JNcH9trYNpsP5x2sqKpGKyeIQ3r0+w8de1oTPVY6CYlGfTnqq8rnIot
         d47Q==
X-Gm-Message-State: AOAM533rksMR1laniYeYK5WgriW9IJXTcstts2opMT3n0HWtzbU/228j
        2qzby4G9z+txkYZYzmKpKZJnxQ==
X-Google-Smtp-Source: ABdhPJyrQkhnOMlIjCfuY6r6deiMNn2tGrB6tFf9VgrnJ7SyMmVsaBZWntgAitDk2cHkCVeXVdDvAQ==
X-Received: by 2002:a9d:2045:0:b0:5b2:1052:93fd with SMTP id n63-20020a9d2045000000b005b2105293fdmr6358924ota.259.1646680305167;
        Mon, 07 Mar 2022 11:11:45 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k15-20020a056808068f00b002d91362e56esm6764310oig.1.2022.03.07.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:11:44 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:13:28 -0800
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
Subject: Re: [PATCH v4 1/7] device property: Helper to match multiple
 connections
Message-ID: <YiZZWN1FgnWxBCuN@ripper>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <YiXZBMG7cK6Cm7wP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiXZBMG7cK6Cm7wP@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Mar 02:05 PST 2022, Andy Shevchenko wrote:

> On Sun, Mar 06, 2022 at 07:40:34PM -0800, Bjorn Andersson wrote:
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
> Thanks for the update!
> 
> First of all, I have noticed that subject misses the verb, something like Add
> or Introduce.
> 

Will update accordingly.

> ...
> 
> > +/**
> > + * fwnode_connection_find_matches - Find connections from a device node
> > + * @fwnode: Device node with the connection
> > + * @con_id: Identifier for the connection
> > + * @data: Data for the match function
> > + * @match: Function to check and convert the connection description
> > + * @matches: Array of pointers to fill with matches
> 
> (Optional) array...
> 

Ditto.

> > + * @matches_len: Length of @matches
> > + *
> > + * Find up to @matches_len connections with unique identifier @con_id between
> > + * @fwnode and other device nodes. @match will be used to convert the
> > + * connection description to data the caller is expecting to be returned
> > + * through the @matches array.
> 
> > + * If @matches is NULL @matches_len is ignored and the total number of resolved
> > + * matches is returned.
> 
> I would require matches_len to be 0, see below.
> 
> > + * Return: Number of matches resolved, or negative errno.
> > + */
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
> > +
> > +	count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +						  matches, matches_len);
> 
> > +	if (matches) {
> > +		matches += count_graph;
> > +		matches_len -= count_graph;
> > +	}
> 
> So, the valid case is matches != NULL and matches_len == 0. For example, when
> we have run something previously on the buffer and it becomes full.
> 
> In this case we have carefully handle this case.
> 
> 	if (matches) {
> 		matches += count_graph;
> 		if (matches_len)
> 			matches_len -= count_graph;

When matches is non-NULL, both the sub-functions are limited by
matches_len and as such count_graph <= matches_len.

As such matches_len >= 0.

In the event that the originally passed matches_len was 0, then
count_graph will be 0 and matches_len will remain 0.

I therefor don't see that this additional check changes things.

> 	}
> 
> Seems it can be also
> 
> 	if (matches)
> 		matches += count_graph;
> 
> 	if (matches_len)
> 		matches_len -= count_graph;

We covered the case of matches && (matches_len || !matches_len) above.

For the case of !matches && matches_len, this added conditional would
cause matches_len to be extra ignored by keeping it at 0, but per
kernel-doc and implementation we ignore all other values already.


Note that this is in contrast from vsnprintf() where the code will
continue to produce results, only store the first "matches_len"
entires and return the final count.

Unfortunately we can't follow such semantics here, instead it is clearly
documented in the kernel-doc that @matches_len is ignored when @matches
is NULL.


So unless I'm missing something I don't see what you gain over keeping
the check on only matches.

> 
> That said, do we have a test cases for this?
> 

I looked briefly at adding some kunit tests for this, but was discourage
by the prospect of building up the graphs to run the tests against.

Regards,
Bjorn

> > +	count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > +					  matches, matches_len);
> > +
> > +	return count_graph + count_ref;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
