Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823AB4F16BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiDDOGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354650AbiDDOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:06:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24227CDF;
        Mon,  4 Apr 2022 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649081092; x=1680617092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsWFLHLl25IGPmvMSnceiEs7ypxsKRsANc2aGAvqfWI=;
  b=mWd7UYMZKcjKDqVT94qku7szgAZnXRzU1B7JeQryFjbYFzyCzYbOSx6+
   ikV5C5GWrfP1hfaECeu12QbASwZQh0cb7vUND+gRo1wQX5g5edDgT2ubG
   rtvL+T81mpIeE+S8sQXWw3PMJXnD0rQtFA9PX+rxEKG0yR0RfQH/5zmW+
   6lZigTt8kapO4H7G8c49nQBfVRXx4OHA6QePnM3gB9hpcEkoUeLiMFk5A
   iJSWEaVWOpGlynF1R1wGM9jKSGUA0ezrGf+LFYZrE4xqJe3xLON/DaBxY
   vD/lev/dDThJorEQFnEukl4cBwjjkLDOK7XR8Qqj/y5OhBaPQkCJyEJ67
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="240457523"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="240457523"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 07:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696578362"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Apr 2022 07:04:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 17:04:48 +0300
Date:   Mon, 4 Apr 2022 17:04:48 +0300
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
Subject: Re: [PATCH 7/7] usb: typec: tipd: Fail probe when the controller is
 in BOOT mode
Message-ID: <Ykr7ABCxR9ocVozc@kuha.fi.intel.com>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
 <20220317154518.4082046-8-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317154518.4082046-8-sebastian.krzyszkowiak@puri.sm>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:45:18PM +0100, Sebastian Krzyszkowiak wrote:
> BOOT mode means that the device isn't operational because of missing
> firmware, so there's no reason to try to continue in this condition
> (probe will fail in a different place anyway).
> 
> Aside of that, the warning that used to be emited about "dead-battery
> condition" was misleading, as dead-battery condition is a different
> thing that's unrelated to operation mode.
> 
> Therefore, assume that BOOT mode is not a supported mode of operation.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index d3c70aaf1a0c..c818cc40139d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -729,8 +729,6 @@ static int tps6598x_check_mode(struct tps6598x *tps)
>  	case TPS_MODE_APP:
>  		return 0;
>  	case TPS_MODE_BOOT:
> -		dev_warn(tps->dev, "dead-battery condition\n");
> -		return 0;
>  	case TPS_MODE_BIST:
>  	case TPS_MODE_DISC:
>  	default:
> -- 
> 2.35.1

thanks,

-- 
heikki
