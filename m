Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098B3595438
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiHPH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiHPH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722475D0F9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03BFB612C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60262C433D6;
        Tue, 16 Aug 2022 05:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660626762;
        bh=PyvgnXmrmnbT6B4C9lNYxGIRrb3s7yATU2so3O1O4GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCiHeYSktAemVxbfn+FEU16LXFFvTN16+XtYCsKKQGvcdeH6Z6XglzATRLrryOGt8
         2CIA1xuIfUOXqKlI2TzpuL8tBbuJ3ySTp1UA7MsIvz9kHGW9+u9fzQttn8T5oo9KLT
         43NCEQDnHl7WG7YmeMPV7EDwj6kfQaJVbdQ7DsiwO2E3OFGPTF3wd8amY4GsaNzwS5
         YwRwaKdF4EGorMXXtkAA4zuPBcQXUpcJkkXNMHWRCN0c+Qtjkfhf5fhjnaWJO6BIDv
         Sm0Ns1oLzPqPzar5YWIwayb/BhVxPtN0c6TB5Hx70Sp9cP17vcbKwBnk9hRlC+HE09
         HJ3YV9XnacyTg==
Date:   Tue, 16 Aug 2022 05:12:37 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH v5 5/7] platform/chrome: cros_typec_switch: Register mode
 switches
Message-ID: <YvsnRXLVbcI+McEo@google.com>
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-6-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815063555.1384505-6-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:34:26AM +0000, Prashant Malani wrote:
> Register mode switch devices for Type C connectors, when they are
> specified by firmware. These control Type C configuration for any USB
> Type-C mode switches (sometimes known as "muxes") which are controlled
> by the Chrome EC.

To be consistent to the commit message, s/Type C/Type-C/g.

To be consistent to the series, I guess you would like to use ChromeOS
instead of Chrome?

> @@ -235,6 +264,17 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
>  		}
>  
>  		dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
> +
> +		if (!fwnode_property_read_bool(fwnode, "mode-switch"))
> +			continue;

Would it be better to use device_property_present()?
