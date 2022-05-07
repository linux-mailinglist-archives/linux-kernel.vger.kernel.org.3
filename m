Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA751E85F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446626AbiEGQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiEGQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:04:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960FE027;
        Sat,  7 May 2022 09:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87390B80AE5;
        Sat,  7 May 2022 16:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CA9C385A6;
        Sat,  7 May 2022 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651939262;
        bh=NHfiodbVnluSYWb96H0xbgRSiv4JTISVRIRQPyzuieM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YgC971pQOFnvnhI2RIkeZJ8woF2HDrbf6Vs/HHx8ZrvDxWb3SZSaLSARZxMh6lZvk
         rQwUuWpKw1KycIqKF55KlhvYv620ecmdpME+DTsI6Ef24NK77F/k2e/FWmZhbeZWK4
         XswlI0vrI8gCpflHrQszI46J6BjSntw49D2z7ZbITJBZQ7LGe9YIIpH59DsGp2jBXj
         By4N0ZgmlD6w3TIl8niz0FYkz0gGrUEe5aRCGuXJf0Ej1kmF0uorEp63dPX0G0igWg
         wH3ebHKsJBlGHCk5Uy2kXGuDo0hUWLqIc9IBf268SnYgIjnhAJbU8PJMdarYhERbSA
         FWSdhWRTbGUQQ==
Date:   Sat, 7 May 2022 17:09:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: accel: bma400: Add separate channel for
 step counter
Message-ID: <20220507170929.4fa967d8@jic23-huawei>
In-Reply-To: <20220505133021.22362-6-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
        <20220505133021.22362-6-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Thu,  5 May 2022 19:00:16 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Added channel for step counter which can be enable or disable
> through the sysfs interface.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  
> +static int bma400_enable_steps(struct bma400_data *data, int val)
> +{
> +	int ret;
> +
> +	if (data->steps_enabled == val)
> +		return 0;
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> +				 BMA400_STEP_INT_MSK,
> +				 FIELD_PREP(BMA400_STEP_INT_MSK, !!val));
This gives a dubious x & !y warning

So I've changed it to val ? 1 : 0

Jonathan

> +	if (ret)
> +		return ret;
> +	data->steps_enabled = val;
> +	return ret;
> +}
