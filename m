Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1D504B48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiDRD0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiDRD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:26:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38083183B4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5B52B80AB7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF0C385A4;
        Mon, 18 Apr 2022 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650252211;
        bh=FdV0BbbkJT2rE9g8AmJful8pYq6qPpf0N6gWli0rXVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=keo2VlSV0vn+iBnJt2gOGe+pMclPf4TSrg0jKCdF4yjOZ/7ZHLghlzfHMOJ1P9JqB
         MqJyGq+RUhTrOWiHBLSrscGeorGKl0Ohif9PqOHXK7ZPXti5LLy127EaivWehuWKag
         E3Fw2td/Bx78EkjMXBoWFafxjefJ8pfhDv5qiFf4730h9BXq8Uhf1dFn1l+nDSf5M9
         IZ5KrwnfYSOvJvZ0ebJnQavcxVK74Gz4Go3dFbIlPgEUcIe53k+E8nwceaxzlmXA67
         UY+vNovVnbcLWc4yWJKzN8+7fJM2Ly1jUD/lq6L1vwce1dG8SM9ILksZz4gxXRkIgx
         fXH5/1RykWigw==
Date:   Mon, 18 Apr 2022 11:23:27 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
Message-ID: <YlzZr/UElg690/ru@google.com>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415003253.1973106-2-swboyd@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:32:51PM -0700, Stephen Boyd wrote:
> Add a peripheral charger count API similar to the one implemented in the
> ChromeOS PCHG driver so we can use it to decide whether or not to
> register the PCHG device in the cros_ec MFD driver.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

With a minor comment about the naming,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index df3c78c92ca2..8f5781bc2d7a 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -230,6 +230,7 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>  
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> +unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec);

I wonder if "cros_ec_get_pchg_port_count" would be a better name for the API.
