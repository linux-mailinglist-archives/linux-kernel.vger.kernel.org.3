Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B415A0CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiHYJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHYJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29C183B7;
        Thu, 25 Aug 2022 02:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291A961BBB;
        Thu, 25 Aug 2022 09:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F62C433D7;
        Thu, 25 Aug 2022 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420394;
        bh=5ZGuhl467YXl3FnhjE/K17DNeKWgeRkOxoUhyTorpYM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZQ5MAlm8kqOJCTeoWw8xbxNfobekxp0bk5dVSZBhgcMhRi/67ddg6D3dyg/YUbQJI
         nKCvA2+nKMSkwN47v6qG1GxLx+Nv4r+5UGivQE8CplDMnJH6So/B9zlp724xdpDHXC
         KxsRfIE0xQqzkoC2QeNfdviTrRsK10EfGxdXhd2IzCU6SvsiXwagksPSzhAY9WRcus
         KRISNQ95B2ICcqk6jFn6BOXrz1eDbTJFPvj9U/NdwqtuPph+2B8PnoP0nLjrz3mpBB
         WGANn49P3THIctm/AHDD0fX1pK5ouDJAvbaNbUDRO1YIedlbwBUMRwBlwV8r5PIUp8
         zTIiAlIVDtskA==
Date:   Thu, 25 Aug 2022 11:39:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Michael_H=FCbner?= <michaelh.95@t-online.de>
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH] HID: thrustmaster: Add sparco wheel and fix array
 length
In-Reply-To: <0e9a1a9a9354467cee54714ce08396d4ffdf7738.camel@t-online.de>
Message-ID: <nycvar.YFH.7.76.2208251139020.19850@cbobk.fhfr.pm>
References: <0e9a1a9a9354467cee54714ce08396d4ffdf7738.camel@t-online.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022, Michael Hübner wrote:

> >From c17f6bb769531d143b84d19f32f2961f737ca845 Mon Sep 17 00:00:00 2001
> From: Michael Hübner <michaelh.95@t-online.de>
> Date: Fri, 5 Aug 2022 10:05:23 +0200
> Subject: [PATCH] HID: thrustmaster: Add sparco wheel and fix array length
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Add device id for the Sparco R383 Mod wheel.
> Fix wheel info array length to match actual wheel count present in the
> array.
> 
> Signed-off-by: Michael Hübner <michaelh.95@t-online.de>
> ---
>  drivers/hid/hid-thrustmaster.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
> index c3e6d69fdfbd..cf1679b0d4fb 100644
> --- a/drivers/hid/hid-thrustmaster.c
> +++ b/drivers/hid/hid-thrustmaster.c
> @@ -67,12 +67,13 @@ static const struct tm_wheel_info tm_wheels_infos[] = {
>  	{0x0200, 0x0005, "Thrustmaster T300RS (Missing Attachment)"},
>  	{0x0206, 0x0005, "Thrustmaster T300RS"},
>  	{0x0209, 0x0005, "Thrustmaster T300RS (Open Wheel Attachment)"},
> +	{0x020a, 0x0005, "Thrustmaster T300RS (Sparco R383 Mod)"},
>  	{0x0204, 0x0005, "Thrustmaster T300 Ferrari Alcantara Edition"},
>  	{0x0002, 0x0002, "Thrustmaster T500RS"}
>  	//{0x0407, 0x0001, "Thrustmaster TMX"}
>  };
> 
> -static const uint8_t tm_wheels_infos_length = 4;
> +static const uint8_t tm_wheels_infos_length = 7;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

