Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DF500159
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiDMVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDMVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:49:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396542EFB;
        Wed, 13 Apr 2022 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649886446; x=1681422446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uuTAC6aNQgB3b/UBYiRmY89jAcl2foUE7kRLaw+BgDY=;
  b=oDYyYwJ47hQkErAc7iLbbNwMjD4uJ0NCsJ2hhhrFci4oPeorfC3/Mpde
   opydUVotMJrBgG2QwePnFRJ1S6NF7a/Ys4qyUMXitHJjOlbLkK48SFlZ9
   D9w6HQq0PeZbSjUJLbsRV2R2yViPxtHPeNZ5OjHnswEENK8KtRYg0bFVE
   kIruw7YoEHZrwIpwuXHq+raYtFsyUuoGSHco43z36wAoSHaLaYgipyNLO
   w/rSXIS7Gx+4hw3G4NrUrATIYNxJSPv733XL9oVu7ApagGZ+gpeEm3SqP
   FyOTil32eo+Kd3M0Ypzb5+Ji2kR4NcnIRyls9+YkEnGDWmO0zxbboWTts
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250073546"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="250073546"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:47:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="590914309"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:47:22 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 84FBB20174;
        Thu, 14 Apr 2022 00:47:20 +0300 (EEST)
Date:   Thu, 14 Apr 2022 00:47:20 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <YldE6L7MbgS0NXQY@paasikivi.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
 <YlcUMNe5gDsEca4f@smile.fi.intel.com>
 <YlcVFRQ9wJIH+sjI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcVFRQ9wJIH+sjI@smile.fi.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:23:17PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 09:19:28PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 13, 2022 at 08:10:22PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > > > -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > > > +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
> > > >  {
> > 
> > > >         if (!fwnode_has_op(fwnode, get))
> > > >                 return fwnode;
> > 
> > ^^^^, so it needs a casting, but then we have to comment why is so.
> 
> Note, it means that the fwnode parameter either invalid or has no given option.
> It's not a problem to drop casting in the first case, but the second one should
> be justified and Sakari wants to be sure that the initial container is not
> const, which seems can't be achieved even with the original code.

I wonder if I'm missing something. The fwnode argument originally was not
const here.

-- 
Sakari Ailus
