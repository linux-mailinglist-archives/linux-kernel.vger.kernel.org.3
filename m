Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537A4EEE77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiDANvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbiDANvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:51:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7027CA0E8;
        Fri,  1 Apr 2022 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648820969; x=1680356969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6sFUED6jomDpVrS/0BCwozH6u0xdut4xuWB/lq33NWs=;
  b=UuWT5bZoSV1IX33c1ceZHd8ws9Y13j2Xl2M18HGKM5whavdyTetaqTKL
   wR2QHpnr04hcyEIgCI1N4vpAR2XF5llZb3Tg4ye2oa6ZGA1WmsvbCkJgZ
   rgLoKMBoY16RR39L2WDFeN/5ZGX3xvWXIIVgQ2mznSsgBrv23Ew6cq542
   9OzOhqyZ6xSiN8pzQm6TPgUvoTOtLVDFcApeuTTWcaFRYE60L7JI0kceg
   4wSH8GteG0HsoAMK64LShvGcnrRKl1F/Nshp+ExQWZpZOkXxH6uAY9H7N
   6JfGit9xM4Zd15pYiTenptmy6tfgoLCsjtDf1z1bqQqVv2ziVZFNoG89i
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240077425"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="240077425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="695896434"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 01 Apr 2022 06:49:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Apr 2022 16:49:25 +0300
Date:   Fri, 1 Apr 2022 16:49:25 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH 0/7] TPS6598x PD tracing and other improvements
Message-ID: <YkcC5XKZzIQBID8w@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 04:45:11PM +0100, Sebastian Krzyszkowiak wrote:
> This is a series developed for the Librem 5 phone, which uses TPS65982
> as its USB-C controller. Implemented are Power Delivery sink contract
> tracing and exporting negotiated power values as power supply properties,
> fixes for data role swapping, status register caching and a debugfs entry
> for querying customer use word of the firmware running on the controller.
> 
> Angus Ainslie (3):
>   usb: typec: tipd: set the data role on tps IRQ
>   usb: typec: tipd: Add trace event for SINK PD contract
>   usb: typec: tipd: Provide POWER_SUPPLY_PROP_{CURRENT,VOLTAGE}_MAX
> 
> Guido Günther (2):
>   usb: typec: tipd: Only update power status on IRQ
>   usb: typec: tipd: Add debugfs entries for customer use word
> 
> Sebastian Krzyszkowiak (2):
>   usb: typec: tipd: Provide POWER_SUPPLY_PROP_PRESENT
>   usb: typec: tipd: Fail probe when the controller is in BOOT mode
> 
>  drivers/usb/typec/tipd/core.c     | 263 ++++++++++++++++++++++++++----
>  drivers/usb/typec/tipd/tps6598x.h |  30 ++++
>  drivers/usb/typec/tipd/trace.h    |  38 +++++
>  3 files changed, 302 insertions(+), 29 deletions(-)

These look pretty good to me. I'll see if I can test these on Monday -
I finally have access to a machine again that actually has TI PD
controller. But I will give my comments then in any case, if there is
anything to comment.

But related to patch 3/7, there is a series in works that would expose
the PDOs in sysfs [1]. I was wondering have you guys noticed it, and
would that actually work also in your case?

[1] https://lore.kernel.org/linux-usb/20220203144657.16527-1-heikki.krogerus@linux.intel.com/

Br,

-- 
heikki
