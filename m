Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91BC536DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiE1RO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiE1ROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:14:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE712D2D;
        Sat, 28 May 2022 10:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A75B801BF;
        Sat, 28 May 2022 17:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60478C34100;
        Sat, 28 May 2022 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653758061;
        bh=i1tX6uyAyQmWx3WtUEkfTOp6hj48zz27F+SBAk/tkrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjzABn4vqPt8RdqtjbC+KUzFsJGO6g434tzB4B2wOg5sMUHnr4fBsvB5uOUWdkLDx
         ksr5JIAVYe48EJGArGha8HdLNefJc39YPFeY8BcJGqkHhjSqILN1p+G77m7k+CKTlw
         8xkH3DnFT2ntB4BFVa4RsXorOsvcLEDVi+KDDqtmZtCjrTLjEM2yrHidk8Rb/Ldtkk
         jW+vX7QnxAEpBYrXtFJgQB0UYajjehEEjVr0j6hVBhm1eAbBgbniuPIONs1lGF3rWX
         4Fp4c47x0RjYSEXI+9eWgG7Mr6X7ef8+yUGN/Y6U/96svbHfye+P9t82wUKt+GMkjm
         DHTx6y7R1XMVA==
Date:   Sat, 28 May 2022 18:23:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH V8 5/5] iio: accel: sca3300: Add inclination channels
Message-ID: <20220528182314.0785a92b@jic23-huawei>
In-Reply-To: <20220523062312.1401944-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220523062312.1401944-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 06:23:12 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Different from SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X = atan2(accx , sqrt(pow(accy , 2) + pow(accz , 2)))
> ANG_Y = atan2(accy , sqrt(pow(accx , 2) + pow(accz , 2)))
> ANG_Z = atan2(accz , sqrt(pow(accx , 2) + pow(accy , 2)))
> 
> The commit adds the output of the raw value, scale
> and scale_available of angles.
> 
> New interfaces:
>   in_incli_scale
>   in_incli_scale_available
>   in_incli_x_raw
>   in_incli_y_raw
>   in_incli_z_raw
> Data converted by application of scale to degrees.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---

Hi,

One comment inline.

>  struct sca3300_chip_info {
>  	const char *name;
>  	const unsigned long *scan_masks;
> @@ -123,12 +167,16 @@ struct sca3300_chip_info {
>  	u8 num_accel_scales;
>  	const int (*accel_scale)[2];
>  	const int *accel_scale_map;
> +	const int (*incli_scale)[2];
> +	const int *incli_scale_map;
> +	u8 num_incli_scales;
>  	u8 num_freqs;
>  	const int *freq_table;
>  	const int *freq_map;
>  	const int *avail_modes_table;
>  	u8 num_avail_modes;
>  	u8 chip_id;
> +	bool angle;

"angle" is a bit vague.  Perhaps "angle_supported"?

Otherwise this looks good to me.

Thanks,

Jonathan

