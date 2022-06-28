Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08C755E6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbiF1Olg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiF1Olf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:41:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EACF2A268;
        Tue, 28 Jun 2022 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656427294; x=1687963294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CbBZb/9UmDzoKbUZG8KAxpZDdd3qLqErglFpew+xVWo=;
  b=Bll4hWDp+DyAP82LAdKbRLea3TMqrv8Nj/05uGaLiDykUSxH6t74ROOR
   wYd93uPl9QOkiEuQnnS4UiCcKxP4lsV/5Osl1U1AGYhfTjE0B4oKg/363
   19cD+0g/o3r8hqGAUgH4n7E9hnx5PJ4liOXveSgpsdfflGUKRx4Uxfoh+
   /9jVbYKpBeV4PfK2zjCEaX3xNOZlhLRu+1dsVQJw8+db8axOKT1ARhxLM
   wM2kvNpwPJ1WxYvMuBgHMlAh/rCabdeO1aRplVCeaR4NzBWrrVqukxqaQ
   6jBhBBgyc/Bf3QqZ1nzsdvDc/Fp2KmeKzhs7l3dd0SpDUV0aE02dRxKf0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264798783"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="264798783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 07:41:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="693136067"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 07:41:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D4BD72015F;
        Tue, 28 Jun 2022 17:41:12 +0300 (EEST)
Date:   Tue, 28 Jun 2022 17:41:12 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Message-ID: <YrsTCJz/omf90h+Z@paasikivi.fi.intel.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
 <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com>
 <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Rafael,

On Tue, Jun 28, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 15:33, Rafael J. Wysocki wrote:
> > On Mon, Jun 27, 2022 at 3:08 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 27/06/2022 14:49, Michael Walle wrote:
> >>> Hi,
> >>>
> >>> I tired to iterate over all child nodes, regardless if they are
> >>> available
> >>> or not. Now there is that handy fwnode_for_each_child_node() (and the
> >>> fwnode_for_each_available_child_node()). The only thing is the OF
> >>> backend
> >>> already skips disabled nodes [1], making fwnode_for_each_child_node()
> >>> and
> >>> fwnode_for_each_available_child_node() behave the same with the OF
> >>> backend.
> >>>
> >>> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix
> >>> that
> >>> one. fwnode_for_each_child_node() and also fwnode_get_next_child_node()
> >>> are
> >>> used by a handful of drivers. I've looked at some, but couldn't decide
> >>> whether they really want to iterate over all child nodes or just the
> >>> enabled
> >>> ones.
> >>
> >> If I get it correctly, this was introduced  by 8a0662d9ed29 ("Driver
> >> core: Unified interface for firmware node properties")
> >> .
> > 
> > Originally it was, but then it has been reworked a few times.
> > 
> > The backend callbacks were introduced by Sakari, in particular.
> 
> I see you as an author of 8a0662d9ed29 which adds
> device_get_next_child_node() and uses of_get_next_available_child()
> instead of of_get_next_child(). Although it was back in 2014, so maybe
> it will be tricky to get original intention. :)
> 
> Which commit do you mean when you refer to Sakari's work?
> 
> > 
> >> The question to Rafael - what was your intention when you added
> >> device_get_next_child_node() looking only for available nodes?
> > 
> > That depends on the backend.
> 
> We talk about OF backend. In your commit device_get_next_child_node for
> OF uses explicitly available node, not any node.

Well spotted.

I suppose that when the only function to get the next (available) child was
added, the expection was perhaps that only available child nodes did matter
in this API. On ACPI the two are almost always the same thing --- the
property API originates from OF and ACPI primarily uses different means to
work with what's under the level of devices.

What I'd perhaps do is to change the OF behaviour and switch callers to use
a different variant for drivers that do not appear solely ACPI-oriented.

acpi_fwnode_device_is_available() should return true for data nodes.
Otherwise getting the next available child isn't meaningful at all --- and
property API is primarily dealing with data nodes when it comes to ACPI.

I might not still try to backport the fixes as it matters more from API
consistency point of view than being an actual problem _right now_.

Also cc Heikki.

> 
> > fwnode_for_each_available_child_node() is more specific and IIRC it
> > was introduced for fw_devlink (CC Saravana).
> > 
> >> My understanding is that this implementation should be consistent with
> >> OF implementation, so fwnode_get_next_child_node=get any child.
> > 
> > IIUC, the OF implementation is not consistent with the
> > fwnode_get_next_child_node=get any child thing.
> > 
> >> However maybe ACPI treats it somehow differently?
> > 
> > acpi_get_next_subnode() simply returns the next subnode it can find.

-- 
Kind regards,

Sakari Ailus
