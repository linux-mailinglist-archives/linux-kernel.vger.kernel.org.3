Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72B4FBF18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiDKOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiDKOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767A3AA4B;
        Mon, 11 Apr 2022 07:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DFB61238;
        Mon, 11 Apr 2022 14:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF5EC385A4;
        Mon, 11 Apr 2022 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649687288;
        bh=qSBNhWoQB+3rDttEgS4S8bh557Ou5x/3FESdJViNRA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fv4O5VPdfgN338yYjBkgj+Hzf6G22hCT+GJOhztdSUgwDvdZRHGUP65w0R61kP8hQ
         9ugCeGOl9ED3uyuck9QGOKnBD8UcNLcVqWoika/kdAVL08VGbU9YSft8p6n17svGTp
         CeaFWGDBL+1Kp83crTpgSYwBH7XizDFkZyRy9MCE=
Date:   Mon, 11 Apr 2022 16:28:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 1/5] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YlQ69jMduq/evgTt@kroah.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <YlQyEz3/J0rb2Hew@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQyEz3/J0rb2Hew@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:50:11PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 08, 2022 at 09:48:40PM +0300, Andy Shevchenko wrote:
> > Some of the fwnode APIs might return an error pointer instead of NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> > 
> > 	fwnode = fwnode_find_reference(...);
> > 	if (IS_ERR(fwnode))
> > 		...error handling...
> > 
> > Nevertheless the resulting fwnode may have bumped the reference count
> > and hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> > 
> > To prevent this, allow an error pointer to be passed to the fwnode APIs.
> 
> Rafael and Greg, if this okay for you, can the first three patches be
> applied, so we will have at least the fix in and consider constification
> a further work?

Give us a chance, you sent this on friday and are asking about it first
thing Monday morning?

Please go and review other patches sent on the list to help us catch up.

greg k-h
