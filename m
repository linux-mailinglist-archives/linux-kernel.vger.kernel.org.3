Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245954A8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiFNFaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFNFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059627B22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA6B61655
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D609CC3411B;
        Tue, 14 Jun 2022 05:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655184622;
        bh=9l+iMcSM/DmvozPd4ozkq1hDQFKRmGEPfuXGp/QM7hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arAqPKGls8bT2wjhixbzjcHeeK7f22+DW2dLL5iEYeMcFiUdNDJIR5V4J6S5mcUjr
         Szr9a3oUa5Ihfpl0JJ3kFix+EvWwKK7+Pu57QNZ7WH6KoLV/i7F5gaiIrpu40h77VP
         z+ZI8uOKRQUjCEuUl59SX2K9uLafb7/n91Mvg35qdjp8bxDFa2I6ggsB05FNDqno4v
         rozoKEmTO2DwpAlg5DLuoWv95hZW6s2eKZg/UpJK6oC7USQKhXc8E8gyEQZYG0171R
         pYX99+jMEHqoHXZ9BPZfvYnJUoVGPWcUGmOodVduWrTz9YcEr0TPgFPp5Gn5LNLXiX
         NQDqRbHgkBvMQ==
Date:   Tue, 14 Jun 2022 05:30:18 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Always expose last resume
 result
Message-ID: <Yqgc6sD7bEHLVYRg@google.com>
References: <20220611061825.4119270-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611061825.4119270-1-swboyd@chromium.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:18:25PM -0700, Stephen Boyd wrote:
> @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
>  
>  	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> -
> -	/* For now, report failure to transition to S0ix with a warning. */
> +	/* Report failure to transition to system wide suspend with a warning. */
>  	if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
> +	     sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
>  		ec_dev->last_resume_result =
>  			buf.u.resp1.resume_response.sleep_transitions;

The warning in the if-block:
WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
          EC_HOST_RESUME_SLEEP_TIMEOUT,
          "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
          buf.u.resp1.resume_response.sleep_transitions &
          EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);

Not sure and I wonder if the term "slp_s0" is still generic enough to the case.
And also [1].

[1]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/powerd/system/suspend_configurator.cc#98

At least we should fix [2] once the patch landed.

[2]: https://crrev.com/a311a7657ca0a488f507fa78fd9c2d825cbf083e/power_manager/tools/suspend_stress_test#369
