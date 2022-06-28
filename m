Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328055D749
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbiF1J5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiF1J5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:57:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DB2FFC0;
        Tue, 28 Jun 2022 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656410198; x=1687946198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8g6oATwOn9T0Tp0qEpsI5CmgdS7Yl7GaxAoiXWVZNk=;
  b=CoFMyxXtUsCwpMRcWLxREQy0GpsI6BEY5vjggLEhlq6gxKfh9PztP9Bh
   gHs/240mQivk4Ys6mHmrw3Us2tkcw5IE9j7SL6cm1Xs0CjIixAkCazN1J
   PhbXKUU7LUwshBkfQuf6GYlVw0v+GBY2MXvIWxCleC4I06DVbGftrCL3V
   bdtypczHgSg0kJR/6o6S1PEPn0rAO4yVIIoCshRlGB49OJdIzcGhPmiyd
   ltdtO0RohtZzKM9DdlP66EDkt0G3Rppa0eE0k5uEa8IWAXVDmVNN5ISTF
   NjwO5CZ/x21srfKZ7EYspOrFqXu30tT9snIcpuWr/GE2dfReLlPCKPGUG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270445391"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270445391"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732691163"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2022 02:56:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jun 2022 12:56:30 +0300
Date:   Tue, 28 Jun 2022 12:56:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH 2/4] usb: typec: ucsi: stm32g0: add support for stm32g0
 i2c controller
Message-ID: <YrrQTiCWsnRKAzn7@kuha.fi.intel.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
 <YrmtzDfFm17PFl2r@kuha.fi.intel.com>
 <bd35eb19-cfda-4799-1ab0-0578d3c79466@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd35eb19-cfda-4799-1ab0-0578d3c79466@foss.st.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:21:12AM +0200, Fabrice Gasnier wrote:
> On 6/27/22 15:17, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Fri, Jun 24, 2022 at 05:54:11PM +0200, Fabrice Gasnier wrote:
> >> +static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >> +{
> >> +	struct device *dev = &client->dev;
> >> +	struct ucsi_stm32g0 *g0;
> >> +	int ret;
> >> +
> >> +	g0 = devm_kzalloc(dev, sizeof(*g0), GFP_KERNEL);
> >> +	if (!g0)
> >> +		return -ENOMEM;
> >> +
> >> +	g0->dev = dev;
> >> +	g0->client = client;
> >> +	init_completion(&g0->complete);
> >> +	i2c_set_clientdata(client, g0);
> >> +
> >> +	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
> >> +	if (IS_ERR(g0->ucsi))
> >> +		return PTR_ERR(g0->ucsi);
> >> +
> >> +	ucsi_set_drvdata(g0->ucsi, g0);
> >> +
> >> +	/* Request alert interrupt */
> >> +	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
> >> +				   dev_name(&client->dev), g0);
> >> +	if (ret) {
> >> +		dev_err_probe(dev, ret, "request IRQ failed\n");
> >> +		goto destroy;
> >> +	}
> >> +
> >> +	ret = ucsi_register(g0->ucsi);
> >> +	if (ret) {
> >> +		dev_err_probe(dev, ret, "ucsi_register failed\n");
> >> +		goto freeirq;
> >> +	}
> > 
> > If there isn't UCSI firmware, then ucsi_register() will always safely
> > fail here, right?
> 
> Hi Heikki,
> 
> Yes, in such a case, the first i2c read (UCSI_VERSION) in
> ucsi_register() will return an error and safely fail here.

Okay, thanks.

-- 
heikki
