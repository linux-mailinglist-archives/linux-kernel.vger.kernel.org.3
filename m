Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61714530272
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiEVKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEVKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918EE26130;
        Sun, 22 May 2022 03:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8EF60F80;
        Sun, 22 May 2022 10:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC03C385AA;
        Sun, 22 May 2022 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653215748;
        bh=ToPPiqXwjV73nuk6F3aB1XXuCBH0hY3ecj+MRp5HnJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hNdqND7HH8gf9A01HNghh2ETdxi3oognFIrhLdUrazqBUIlRJT6erMOeANnv6DUfJ
         1pUCV5wyTgOT7CmG8nPItqVXmOPxEpOkuABoFE9pgN4vK4l66jKmfh7BfwoqI7D9ER
         ZBbSmZFBoYgg8yLN/I2shLxYNLeqfpVypSt1MtwOY+S3Bv28XMAeaHDLaGdfUecnz+
         UbhX1UZ0Ek5CJFH6XdEPmt9DHiJxRdbQMVcf/2JvoWMT8UzGgqG/LKLAK/aJqd7EhD
         bXtNB3G+4sFwOPRp6wS/2UnLGlUektGLYfMfhVB3rEKOXzNaC6XWwtYUuQiTw1Uvlh
         5TRIo76rWt8og==
Date:   Sun, 22 May 2022 11:44:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, lars@metafoo.de,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V6 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <20220522114433.6d3257e1@jic23-huawei>
In-Reply-To: <cd5864b3-c436-4a22-663b-703377bf8521@vaisala.com>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220513124135.1295822-4-Qing-wu.Li@leica-geosystems.com.cn>
        <20220514151003.42fa5044@jic23-huawei>
        <cd5864b3-c436-4a22-663b-703377bf8521@vaisala.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +static int sca3300_set_frequency(struct sca3300_data *data, int val)
> >> +{
> >> +	const struct sca3300_chip_info *chip = data->chip;
> >> +	unsigned int index;
> >> +	unsigned int i;
> >> +
> >> +	if (sca3300_get_op_mode(data, &index))
> >> +		return -EINVAL;
> >> +
> >> +	for (i = 0; i < chip->num_avail_modes; i++) {
> >> +		if ((val == chip->freq_table[chip->freq_map[i]]) &&  
> > 
> > The conditions being checked here are far from obvious, so I think this would benefit
> > from an explanatory comment.
> > 
> > Something along the lines of,
> > "Find a mode in which the requested sampling frequency is available
> >  and the scaling currently set is retained".  
> 
> 
> In addition to a comment, how about small restructure of loop and giving
> local variables that tell the purpose, something like
> 
> 
> ...
> 
> unsigned int opmode_scale, new_scale;
> 
> opmode_scale = chip->accel_scale[chip->accel_scale_map[index]];
> 
> /*
> * Find a mode in which the requested sampling frequency is available
> * and the scaling currently set is retained
> */
> for (i = 0; i < chip->num_avail_modes; i++) {
>     if (val == chip->freq_table[chip->freq_map[i]]) {
>         new_scale = chip->accel_scale[chip->accel_scale_map[i]]);	
>         if (opmode_scale == new_scale)
>             break;
>     }
> }
> 
> 
> That way it's IMHO more clear what we are comparing.
LGTM.

Thanks,

Jonathan

> 
> Thanks,
> Tomas
