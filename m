Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6384D0183
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiCGOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbiCGOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:37:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7F7E590;
        Mon,  7 Mar 2022 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646663790; x=1678199790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RhzWHO29ZNU2Nsn9nHyfYfEHvrdiuDbT4BJYyRMuu0I=;
  b=Aayj+mL0YZ+JlNuMti7p6qo1lj2/g9CDkPg4kqbuRAEcglkNv6TFKeT9
   0+bfa2RmMM7Z5KwiBtjmoZzLvCtD6/GuKgXSlvIOVso0sdaR9NEq/LeRt
   7p56BpZnAp+PAmN3cjrt66PGtfufIA9AE7Y+gLx6ACgnUdyYF3sJZk+mK
   CptZBx8yUMTErTDVvGGLQ4tQn15w6BcOEu78XQ2GPV8RFJKWs/DZm2aP6
   Nl+AsdtveUb/cN5Y/d0B5HoXPfb2zKy3mDUXTHZfAoe8IhzvH7dhxQsXl
   xCo3KG2k3kKa3v9oZ/Z7D7oRgpRtUjpM0S00t8HvN16r370GmP3PeOnWe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="235012360"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="235012360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 06:36:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="687555371"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 07 Mar 2022 06:36:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Mar 2022 16:36:27 +0200
Date:   Mon, 7 Mar 2022 16:36:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Message-ID: <YiYYa7GkknJ+CAuL@kuha.fi.intel.com>
References: <20220301132010.115258-1-alvin@pqrs.dk>
 <20220301132010.115258-4-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301132010.115258-4-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 01, 2022 at 02:20:07PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The TUSB320LA and TUSB320HA (or LAI, HAI) chips are I2C controlled
> non-PD Type-C port controllers. They support detection of cable
> orientation, port attachment state, and role, including Audio Accessory
> and Debug Accessory modes. Add a typec class driver for this family.
> 
> Note that there already exists an extcon driver for the TUSB320 (a
> slightly older revision that does not support setting role preference or
> disabling the CC state machine). This driver is loosely based on that
> one.

This looked mostly OK to me. There is one question below.

<snip>

> +static int tusb320xa_check_signature(struct tusb320xa *tusb)
> +{
> +	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
> +	unsigned int val;
> +	int i, ret;
> +
> +	mutex_lock(&tusb->lock);
> +
> +	for (i = 0; i < sizeof(sig); i++) {
> +		ret = regmap_read(tusb->regmap, sizeof(sig) - 1 - i, &val);
> +		if (ret)
> +			goto done;
> +
> +		if (val != sig[i]) {
> +			dev_err(tusb->dev, "signature mismatch!\n");
> +			ret = -ENODEV;
> +			goto done;
> +		}
> +	}
> +
> +done:
> +	mutex_unlock(&tusb->lock);
> +
> +	return ret;
> +}

Couldn't that be done with a single read?

        char sig[8];
        u64 val;

        strcpy(sig, "TUSB320")

        mutex_lock(&tusb->lock);

        ret = regmap_raw_read(tusb->regmap, 0, &val, sizeof(val));
        ...
        if (val != cpu_to_le64(*(u64 *)sig)) {
        ...

Something like that?

thanks,

-- 
heikki
