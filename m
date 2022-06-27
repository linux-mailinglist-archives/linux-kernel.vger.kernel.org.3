Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5855DD47
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiF0NSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiF0NRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:17:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF604B870;
        Mon, 27 Jun 2022 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656335825; x=1687871825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f4xxEul0YKd5rxrkLyEAwzdVgpps8n1/yZoBsxB6ax4=;
  b=bkSAb6wFGgf9hkeDoXU1+Ul41cMU3Ycq4jfd+3dDAO1nd54MzS6TvyuL
   q+EGa18fC37PgWnKA/oEuNnykdvZz+6YFIvsi8ZrvqNrRuIIVwEv699wl
   G1yF+B4DL/CbHsRSpTp4F/D24kF4iTa6Ms9u/Q/vb25dUhqpCx1ux0sZz
   NXJveKBdsP6TD1IpCUZdZBxGyawVclNrl+ymt75rJjG00H6jdshxNuJxl
   +iOPRK2PmnIj2gNybow0nG116+RSxU/5AQn+QLRGTTOPQh36NmGs9ZbUS
   XT5dSGloVLuaRBaGmOBeZMpz3V4msQzYtZMwIPYyK66EE8/xGZMpl4sZ8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345446389"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="345446389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="732308958"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Jun 2022 06:17:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Jun 2022 16:17:00 +0300
Date:   Mon, 27 Jun 2022 16:17:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH 2/4] usb: typec: ucsi: stm32g0: add support for stm32g0
 i2c controller
Message-ID: <YrmtzDfFm17PFl2r@kuha.fi.intel.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 24, 2022 at 05:54:11PM +0200, Fabrice Gasnier wrote:
> +static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ucsi_stm32g0 *g0;
> +	int ret;
> +
> +	g0 = devm_kzalloc(dev, sizeof(*g0), GFP_KERNEL);
> +	if (!g0)
> +		return -ENOMEM;
> +
> +	g0->dev = dev;
> +	g0->client = client;
> +	init_completion(&g0->complete);
> +	i2c_set_clientdata(client, g0);
> +
> +	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
> +	if (IS_ERR(g0->ucsi))
> +		return PTR_ERR(g0->ucsi);
> +
> +	ucsi_set_drvdata(g0->ucsi, g0);
> +
> +	/* Request alert interrupt */
> +	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
> +				   dev_name(&client->dev), g0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "request IRQ failed\n");
> +		goto destroy;
> +	}
> +
> +	ret = ucsi_register(g0->ucsi);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "ucsi_register failed\n");
> +		goto freeirq;
> +	}

If there isn't UCSI firmware, then ucsi_register() will always safely
fail here, right?


> +	return 0;
> +
> +freeirq:
> +	free_irq(client->irq, g0);
> +destroy:
> +	ucsi_destroy(g0->ucsi);
> +
> +	return ret;
> +}


thanks,

-- 
heikki
