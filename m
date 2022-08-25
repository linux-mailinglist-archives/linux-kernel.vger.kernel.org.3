Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D5A0CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiHYJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiHYJrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AAAB417;
        Thu, 25 Aug 2022 02:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12AA61C21;
        Thu, 25 Aug 2022 09:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179C7C433C1;
        Thu, 25 Aug 2022 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420828;
        bh=DwxCA3CR5K7a5JzZ8eAf21/k+uiLRdWoQ4yt0z0nFpc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JnYcNWP2FZZlj3MXdirxSFt2g5hGq6hXHAauSxw3SV7os46ogZMXg3fmCTy6SxmaP
         uNuPUxpxqUDyJAB+hRAru4H9g4OMK/N4e8W4OqCpxKv84IhJH1zwrY+fRPvpUsNNQN
         AFO7/43Nz7zIZRQy/yoIwKgUO+1xEJI28bSIZIbtZ0GVuxsUw8fFbIhaGdoiu+4CIm
         sP+0wt/1NN+dHQC86G8vQCdqiWmkuyiXhExUqKglh2bwobFxxaAEG8Ot1pEos6CFNz
         z2r7wgRl7s8ZCIHRSNoDrR/havAM/TUpxKLrDGoAqZlXb/WnhVhTtHTcKjcy4VyOCT
         NEFcphLIHNhgw==
Date:   Thu, 25 Aug 2022 11:47:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Stefan Hansson <newbie13xd@gmail.com>,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix uclogic tablets
In-Reply-To: <20220822062247.1146141-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2208251146580.19850@cbobk.fhfr.pm>
References: <20220822062247.1146141-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Benjamin Tissoires wrote:

> commit 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
> made the assumption that it was the only one handling tablets and thus
> kept an internal state regarding the tool.
> 
> Turns out that the uclogic driver has a timer to release the in range
> bit, effectively making hid-input ignoring all in range information
> after the very first one.
> 
> Fix that by having a more rationale approach which consists in forwarding
> every event and let the input stack filter out the duplicates.
> 
> Reported-by: Stefan Hansson <newbie13xd@gmail.com>
> Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 48c1c02c69f4..871a185a0f1f 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1532,7 +1532,10 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
>  			 * assume ours
>  			 */
>  			if (!report->tool)
> -				hid_report_set_tool(report, input, usage->code);
> +				report->tool = usage->code;
> +
> +			/* drivers may have changed the value behind our back, resend it */
> +			hid_report_set_tool(report, input, report->tool);
>  		} else {
>  			hid_report_release_tool(report, input, usage->code);

Queued in for-6.0/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

