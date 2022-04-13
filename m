Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6BA4FF91D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiDMOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiDMOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:42:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053F515A1E;
        Wed, 13 Apr 2022 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860799; x=1681396799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEqVR/bJ6blkfzQcYZuLKr7WhhCYJ06aOnPu5ZB6Q6Q=;
  b=hgvQS/NeeIBDfF4aq/D3TVyFvbAS/ER/8U4Tdy/kuxOfH2FNXMVJ0d7R
   /mSXNt/g6C63nZKXq2NLQWBPXvdga8xwQtjxvSL/7daYIHMDSzjLpFkMd
   ox7kk0xz1EAQElKCsjNyFiPPk42JfP/WXSTW0MW+Z9AqddXNxBsPvUE4N
   l6DWYD0XTisDRspuKNW/3Tgx7uM2/2XpVsLoDUXuBm8IS+8aJMHvUcOZw
   h/SZ+Q7WQjwe+kr1HnGEhHyp0f6wB2tRbGldNdBGLVk7RAyEABCJhYand
   2/aNtGDMnZjz/qViuxLurBAqHtZZ4izRO9wNaalXNv3o6VePvhiOwu5in
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325589399"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="325589399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:35:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573295871"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:35:49 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C987220316;
        Wed, 13 Apr 2022 17:35:46 +0300 (EEST)
Date:   Wed, 13 Apr 2022 17:35:46 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
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
Message-ID: <YlbfwjQcxj6fK7re@paasikivi.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
 <YlCq79KveByePxe9@paasikivi.fi.intel.com>
 <CAHp75Ve-5=6bsF1mMQ4RceobV=OsR6VwZeP==iFGQJLEbt0-yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve-5=6bsF1mMQ4RceobV=OsR6VwZeP==iFGQJLEbt0-yg@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 05:10:23PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 9, 2022 at 2:35 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Fri, Apr 08, 2022 at 09:48:43PM +0300, Andy Shevchenko wrote:
> > > As to_of_node() suggests and the way the code in the OF and software node
> > > back ends actually uses the fwnode handle, it may be constified. Do this
> > > for good.
> >
> > How?
> >
> > If the fwnode is const, then the struct it contains must be presumed to be
> > const, too.
> 
> Why? The idea is that we are not updating the fwnode, but the container.
> The container may or may not be const. It's orthogonal, no?

As you wrote: may or may not. The stricter requirement, i.e. const, must be
thus followed. I think it would be fine (after adding a comment on what is
being done) if you *know* the container struct is not const. But that is
not the case here.

-- 
Sakari Ailus
