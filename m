Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7D4FFBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiDMRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiDMRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:01:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDE6A044;
        Wed, 13 Apr 2022 09:58:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243306417"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="243306417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:58:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573354935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:58:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1negGh-001vzG-3X;
        Wed, 13 Apr 2022 19:54:59 +0300
Date:   Wed, 13 Apr 2022 19:54:58 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Message-ID: <YlcAYpZ0yB6wh1uA@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <YlCq79KveByePxe9@paasikivi.fi.intel.com>
 <CAHp75Ve-5=6bsF1mMQ4RceobV=OsR6VwZeP==iFGQJLEbt0-yg@mail.gmail.com>
 <YlbfwjQcxj6fK7re@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbfwjQcxj6fK7re@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:35:46PM +0300, Sakari Ailus wrote:
> On Sun, Apr 10, 2022 at 05:10:23PM +0300, Andy Shevchenko wrote:
> > On Sat, Apr 9, 2022 at 2:35 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Fri, Apr 08, 2022 at 09:48:43PM +0300, Andy Shevchenko wrote:
> > > > As to_of_node() suggests and the way the code in the OF and software node
> > > > back ends actually uses the fwnode handle, it may be constified. Do this
> > > > for good.
> > >
> > > How?
> > >
> > > If the fwnode is const, then the struct it contains must be presumed to be
> > > const, too.
> > 
> > Why? The idea is that we are not updating the fwnode, but the container.
> > The container may or may not be const. It's orthogonal, no?
> 
> As you wrote: may or may not. The stricter requirement, i.e. const, must be
> thus followed. I think it would be fine (after adding a comment on what is
> being done) if you *know* the container struct is not const. But that is
> not the case here.

But even with the original code one may not guarantee that. How the original
code works or prevents of using a const container against non-const fwnode
pointer?

-- 
With Best Regards,
Andy Shevchenko


