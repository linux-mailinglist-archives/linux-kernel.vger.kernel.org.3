Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D83595433
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiHPH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiHPH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B0A00F6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AFEAB815A6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B27C433D6;
        Tue, 16 Aug 2022 05:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626697;
        bh=VTfuQNZqqRUtXPfUaP+wKO7HWPRqgktoX0lYnO9MlWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSvN+1NUIylb/EyTqC0Tj6dbuDQGXtHcwgv9wsru0mqhvE9EkBjZ+w5o67jRlZKox
         jn687pLzHh6Kbcu7959MTVBduPcqdrgO1wY2/Z0MqaqzcOg3qOOwO1HxQwhO/Hnkfc
         buBHaE+IXJuTS9QCcHHhU/4p0suMj9oHys3wsiMxZY/tE8/akv6nndgORfLFffpsOQ
         HnGvneXbnQxwmjtJBe47yg6CBunrS4GomBwLEklKt51fP7RFWSe0SMEnw1hzmYHsOm
         Dvy4O9xz+i0NZVLTofhzTvGoy9EekRVrJ3TufncBDAaqi7FR7a4yfZN5k76sZHApO6
         Qi14Ni8FPTyeg==
Date:   Tue, 16 Aug 2022 05:11:33 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v5 3/7] platform/chrome: cros_typec_switch: Set EC retimer
Message-ID: <YvsnBWZlH8ouSlLk@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-4-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:21AM +0000, Prashant Malani wrote:
> +static int cros_typec_cmd_mux_set(struct cros_typec_switch_data *sdata, int port_num, u8 index,
> +				  u8 state)
> +{
> +	struct typec_usb_mux_set params = {
> +		.mux_index = index,
> +		.mux_flags = state,
> +	};
> +
> +	struct ec_params_typec_control req = {
> +		.port = port_num,
> +		.command = TYPEC_CONTROL_COMMAND_USB_MUX_SET,
> +		.mux_params = params,
> +	};

Would it be better to avoid the memory copy by making `params` inline?

E.g.:
struct ec_params_typec_control req = {
    ...
    .mux_params = {
        ...
    },
    ...

> +/*
> + * The Chrome EC treats both mode-switches and retimers as "muxes" for the purposes of the

To be consistent to the series, I guess you would like to use ChromeOS
instead of Chrome?
