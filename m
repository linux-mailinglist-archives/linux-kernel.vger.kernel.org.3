Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736D4A3ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbiAaIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:48:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:47541 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233613AbiAaIs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643618909; x=1675154909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9+Kpmyr5uRBM9G/zN3IxYzf/txHBMrv8Hy0wqVDIpk=;
  b=RZPtNIu5AHywThbtBR+s2CEQDUjaSAcdr8RLSgA9YRBngA0+azk/I8o4
   g19G2KXtftVGhDNGSEGd2kUU1OXWN2Wxvl1GqmoQ5M0zNKPF+oEFdUl10
   X0aKqYFoWNXSuMkjgUfBnM0sNmtmyR0WPY1acHDE8gyz35aQSkK94Hq/S
   1/7RRiqBXpY2pAop8aqnophvcVXs9cmB7vxgQV0yoyPCli8gwhkhQHETv
   roYIJemg0NUK6eeUbzj6p8vJfURDX9XLzil1Tikf5Ac10SG8q2Ctb/BjS
   Rx/0bSx/k+CGz2kyMalIJ8EgvaEwntoj8iFqFP+8QCKwvdNQbCom6pYg9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="230993741"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="230993741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 00:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675669007"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 00:48:26 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 10:48:25 +0200
Date:   Mon, 31 Jan 2022 10:48:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Make try power role
 optional
Message-ID: <YfeiWcPfOX5ctFHu@kuha.fi.intel.com>
References: <20220127191659.3560810-1-pmalani@chromium.org>
 <YfOLRBGmwGKwCksR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfOLRBGmwGKwCksR@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 27, 2022 at 10:20:52PM -0800, Benson Leung wrote:
> Hi Prashant,
> 
> On Thu, Jan 27, 2022 at 07:16:59PM +0000, Prashant Malani wrote:
> > Some boards prefer not to specify a try-power-role. Update the port
> > property parsing logic to not error out in case a try-power-role is not
> > specified.
> > 
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> This looks good to me.
> 
> Heikki, if this usage of TYPEC_NO_PREFERRED_ROLE looks good to you, I can
> merge it.

This is OK by me. FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 5de0bfb0bc4d..ee12658009e5 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -115,17 +115,18 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
> >  		return ret;
> >  	cap->data = ret;
> >  
> > +	/* Try-power-role is optional. */
> >  	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
> >  	if (ret) {
> > -		dev_err(dev, "try-power-role not found: %d\n", ret);
> > -		return ret;
> > +		dev_warn(dev, "try-power-role not found: %d\n", ret);
> > +		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
> > +	} else {
> > +		ret = typec_find_power_role(buf);
> > +		if (ret < 0)
> > +			return ret;
> > +		cap->prefer_role = ret;
> >  	}
> >  
> > -	ret = typec_find_power_role(buf);
> > -	if (ret < 0)
> > -		return ret;
> > -	cap->prefer_role = ret;
> > -
> >  	cap->fwnode = fwnode;
> >  
> >  	return 0;

-- 
heikki
