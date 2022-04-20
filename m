Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC622508674
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbiDTK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377857AbiDTK5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:57:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD021138
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650452087; x=1681988087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hyqDQuSmqIjjQPXkotxKrGwioZ0GHsZ6wRaW/+HeR68=;
  b=W7etYtnLqY8vbZ+/uQjBqCyi1v/wXIANYXAq8LWgKyknsqPZeB9Np4hf
   QBm/Yab+ueuzYlw8CP0mJ3g/RNwdnH452Uv67rI1+VQIZj1GXpUfWpYxO
   HAy38dEMXhjnMHCIW1b1Zb/5qoOqVTWKPnKjezzgU4n6dGHpJU72Qql7R
   LOdR3WKRN907R3Sdgor33GLz6bP75hIw0PC1YUaVh2oP8y1hUiq/RONxG
   W0AHfcvXy5GxcjCaj/gsiftGYFYZbz2APHV21/8B0zXqdzetf5NvsH7o3
   aLQtVYLJTPbQxmpFKcu1mSLwsmICLfYoWQMuXeqiVx1vRLV9QCz70Ory7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324439207"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="324439207"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:54:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="510505952"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:54:43 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Apr 2022 13:52:30 +0300
Date:   Wed, 20 Apr 2022 13:52:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C
 connectors
Message-ID: <Yl/l7gjRXj41a93q@lahna>
References: <20220418175932.1809770-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418175932.1809770-1-wonchung@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 05:59:30PM +0000, Won Chung wrote:
> Currently, USB port is linked to Type C connector, using the component
> framework, if they share the same _PLD fields from ACPI table. Type C
> port-mapper searches for devices with the same _PLD values, and
> aggregate them as components.
> 
> When there is another device that share the same _PLD but does not
> registers a component, Type C connector (component master) would never
> be bound due to a component match entry device without a component
> registered. There exists some cases where USB4 port also shares the same
> _PLD with USB port and Type C connector, so we need to register a
> component for USB4 ports too, linking USB4 port with Type C connector.
> Otherwise, link between USB port and Type C connector would not
> work either.
> 
> Due to the nature of the component framework, all registered components
> are shared by all component match despite the relevance. MEI subsystems
> also use the component framework to bind to i915 driver, which try to
> match components registered by USB ports and USB4 ports. This can be
> problematic since MEI assumes that there is a driver bound to the
> component device, while USB4 port does not bind to any drivers. MEI's
> component match callback functions should handle such case to avoid NULL
> pointer dereference when USB4 port registers a component.
> 
> In summary this patch series
> 1. Fixes MEI subsystem's component match callbacks to handle a component
> device without any driver bound
> 2. Registers a component for USB4 ports to link them to Type C
> connectors, similar to USB ports.
> 
> Heikki Krogerus (1):
>   thunderbolt: Link USB4 ports to their USB Type-C connectors
> 
> Won Chung (1):
>   misc/mei: Add NULL check to component match callback functions

The Thunderbolt patch looks good to me. Do you want me to take the both
patches through the Thunderbolt tree or they can go separately? I need
an ack from the mei maintainer it goes through my tree.
