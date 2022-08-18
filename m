Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653B597CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiHREIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiHREIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:08:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8065A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9556CE1F30
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6373C433C1;
        Thu, 18 Aug 2022 04:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660795695;
        bh=pDWN1SWFQoLY+kQmDNlmfijZ8n3SHAhhTy8zIM7ERM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYN3YPkZZMXZ3UOhenBuHC2QYCxNpc/wlEKWq4ayEeU7OdxAWPIY02+lbPlIs+pwx
         It6ParZnbv0Kg5FkcqgYbCWLeL7J8IRnXNSvUvIbF0coNw4WPlbHPsIyc0ISjot2SG
         91hgjJMUyD9x+3DHn7rCKFO79ZTqfOlaEn98tU1aLhtB4qtI9ci7p8/MtZVhDv1X7h
         l3EAD8GIyxcXU5RU96QK/iY3fKkk4m75X1byhnY7Hx2PLUfQtuOZdIXcDHy718HrQ6
         1J6o+28rPMhahsmoCxuaduTf8dlmpURyjJfQJRcytAf/ZsNvEZ1LhGAzvoxynyvKIt
         oAX9xCUiIjyaw==
Date:   Thu, 18 Aug 2022 04:08:11 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@google.com>
Cc:     rrangel@chromium.org, robbarnes@google.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Send host event for
 prepare/complete
Message-ID: <Yv27K4+rLfskcQdm@google.com>
References: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:40:08AM -0600, Tim Van Patten wrote:
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This allows the
> EC to log entry/exit of AP's suspend/resume more accurately.

As what I commented on [1], the term "host event" in the commit title is
confusing.  Also, as this is a cros_ec_lpc specific patch, please change
the prefix.

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid/#24934911

> -static int cros_ec_lpc_resume(struct device *dev)
> +static void cros_ec_lpc_complete(struct device *dev)
>  {
>  	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = cros_ec_resume(ec_dev);
>  
> -	return cros_ec_resume(ec_dev);
> +	dev_info(dev, "EC resume completed: ret = %d\n", ret);

cros_ec_resume() always returns 0.
