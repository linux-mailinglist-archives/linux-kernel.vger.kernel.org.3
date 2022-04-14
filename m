Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60AB500E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiDNNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiDNNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:12:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E91AF13;
        Thu, 14 Apr 2022 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649941791; x=1681477791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v5CxLQbfWtXiVq/sE32vce32MQXtkQXZiAcw0x85tOs=;
  b=N6qy/l1225/WvWy3yBeDGBeEe6Bkv2vmF1gju1TpaH+T4SfCMBVcppF+
   /6ZEjL7q3kDV5CEtp2WeuSA+8wwlSQWpk1+kq14aK7+gMfWkwIWJwge9I
   uH+RtlXd8SSIncmUFyJ1SYyi9mmdyX89ozsai7PcTG4CB4dF8XW6EAO9z
   2psrP+I52C/3aqrOSldPpdK7pSFTs/A0At188MAd//hf7OIx/BChXGt2T
   0vf1UPyn4WMDWE/8wxzkP1n05q9xgKgmjta5AJ56TMdhlKDOc2DvWCHDo
   KmKjouJewl8WiidNeBnuupAH8fXRaawNUtRPGJrk9JNVdxQrXGtLMNIOV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244810465"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="244810465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="508401064"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:09:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nezEH-002KKY-Gu;
        Thu, 14 Apr 2022 16:09:45 +0300
Date:   Thu, 14 Apr 2022 16:09:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <YlgdGb/vKfdCXXx1@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
 <YlcUMNe5gDsEca4f@smile.fi.intel.com>
 <YlcVFRQ9wJIH+sjI@smile.fi.intel.com>
 <YldE6L7MbgS0NXQY@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YldE6L7MbgS0NXQY@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:47:20AM +0300, Sakari Ailus wrote:
> On Wed, Apr 13, 2022 at 09:23:17PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 13, 2022 at 09:19:28PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 13, 2022 at 08:10:22PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > > > > +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
> > > > >  {
> > > 
> > > > >         if (!fwnode_has_op(fwnode, get))
> > > > >                 return fwnode;
> > > 
> > > ^^^^, so it needs a casting, but then we have to comment why is so.
> > 
> > Note, it means that the fwnode parameter either invalid or has no given option.
> > It's not a problem to drop casting in the first case, but the second one should
> > be justified and Sakari wants to be sure that the initial container is not
> > const, which seems can't be achieved even with the original code.
> 
> I wonder if I'm missing something. The fwnode argument originally was not
> const here.

Yes, and our discussion went to the direction of what const qualifier implies
here. I assume that the const means that we do not modify the fwnode object,
while its container is another story which we have no influence on. You, if
I read your messages correctly, insisting that const here implies that the
container object is const as well.

Reading current implementation I see now, that with children APIs we have
two pointers passed, while with parent APIs only a single one. In children
API due to above is easy to use const qualifier for the first argument.
Parent APIs missed that and hence have this problem that we can't constify
their parameters.

to_of_node() expects const parameter while returns non-const container.
Is it a subtle issue there? (I believe it should be consistent then)

This patch and the followed one can be moved without understanding why
we need the non-const parameter there.

-- 
With Best Regards,
Andy Shevchenko


