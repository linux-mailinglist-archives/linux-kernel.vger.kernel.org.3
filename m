Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F235886CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiHCFhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiHCFg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:36:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88532ED61;
        Tue,  2 Aug 2022 22:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659505014; x=1691041014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxDJklFAxtYjSI4nea5pCVTWZgJg85NcYb7mK19x0Bk=;
  b=fp4eEGb9VCW9t1NOWQPsKjdPYkxqaAVE7/czi598e3JrOmYRiA+0Hnj6
   /IaA4giA4jL012w5EFxhzCD/mp5iQEY3cgF/RRYzq3TCZQC0uhUQXycJu
   m+7f43Tj6XDa7TV+HiiGSRxxwc9w6ReuCCI1JfsvOqGYot71wqi4yZ1tZ
   RtNQQ+5E4DD4p+0Ukv/c0E2aNdqbYgwmgvHiLUG4i05bEFDpsxXcXv1hW
   PwoIsHQL/61jwOAHf8mrrnlJX/oQpgy1U1sIDIhQRF4PQ4exyVGXNUv/2
   8kxinlKjA5HEp8q85Qtw9RGNtwOGZUKmU6iLGTGvk21/zxoMA1mgP4LCV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290803061"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="290803061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 22:36:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="744934007"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 22:36:51 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Aug 2022 08:36:49 +0300
Date:   Wed, 3 Aug 2022 08:36:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmalani@google.com, bleung@google.com
Subject: Re: [PATCH] Supporting wake on DP hot events behind TBT/USB4 routers
Message-ID: <YuoJceCfuJ4RKon5@lahna>
References: <20220803010139.GA32634@rajth-NUC10i7FNH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803010139.GA32634@rajth-NUC10i7FNH>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 03, 2022 at 06:31:39AM +0530, Rajat Khandelwal wrote:
> Current implementation doesn't allow user to go into system suspend
> and simultaneously project the screen on an external display connected
> to a TBT/USB4 device. This patch enables this feature.
> 
> Let me know what you think about this.

Please prefix patches to follow the sybsystem style. For Thunderbolt it
should be "thunderbolt: ....".

This will cause any monitor plug to wake up the system and I'm not sure
we want that, at least to be default behaviour. If you have a regular
Type-C (non-USB4/TBT) dock and you plug in a monitor to that, does it
wake up?

IIRC I already suggested you to do this for the USB4 ports themselves
(struct usb4_port) so that userspace can make them wake up the system on
any event by writing "enabled > .../wakeup" which is the normal way.
