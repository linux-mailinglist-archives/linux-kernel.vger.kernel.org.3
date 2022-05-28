Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD18536DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiE1RFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiE1RFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEB14024;
        Sat, 28 May 2022 10:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878AC60F44;
        Sat, 28 May 2022 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC8FC34100;
        Sat, 28 May 2022 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653757509;
        bh=RbAT92bIRAtXe0cIR/KDQSi25eFquv7AlgWb4wDfJMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fflB+u6lPkTB015Mj7ATvDLCOSZTNEOaT3vSWNSqD5yc0JjGzo1/rnXSbkidDyJfO
         4R3V3H39X3NsxdVbxCQ5r2HSOX6ZgCrgUl/US1VZ8Vk9SExltkLN2EKo7LaugATSZu
         BFibpKLlCuFLF0Y51jN1xNekwkYMqLpF59g84+hQUsUQVRBeVLmyHKtuFWBOrk1eIE
         RUlUNfqo0OIwV6+OBltfia6A9M85W4wlHFncc9kiZ+mehZKWuTtilb9wOw2QK4CPGc
         kNgD3Qw/+W+aKr31uCgvCkabw3Fsb7hqMzp87N/aIy3ObSHliD7EDQW5Q4D7FnvIit
         rm76/vqBdzsvA==
Date:   Sat, 28 May 2022 18:14:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Li Zhengyu <lizhengyu3@huawei.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf08: Remove redundant if statement
Message-ID: <20220528181403.16c0971d@jic23-huawei>
In-Reply-To: <Yo3Nwnq58tjKp3nl@arbad>
References: <20220523122755.90638-1-lizhengyu3@huawei.com>
        <Yo3Nwnq58tjKp3nl@arbad>
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

On Wed, 25 May 2022 08:33:38 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Acked-by: Andreas Klinger <ak@it-klinger.de>
> 
> Li Zhengyu <lizhengyu3@huawei.com> schrieb am Mo, 23. Mai 20:27:
> > (!val) has been checked outside the loop, remove redundant (val &&)
> > from loop.
> > 
> > Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
Hi Li Zhengyu,

Applied to the togreg branch of iio.git which is initially pushed out as testing
or 0-day to see if we missed anything.

I'll push it out for linux-next to pick up once the merge window closes.

Thanks,

Jonathan

> > ---
> >  drivers/iio/proximity/srf08.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> > index ac1ab7e89d4e..7ed11339c31e 100644
> > --- a/drivers/iio/proximity/srf08.c
> > +++ b/drivers/iio/proximity/srf08.c
> > @@ -354,7 +354,7 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
> >  		return -EINVAL;
> >  
> >  	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
> > -		if (val && (val == data->chip_info->sensitivity_avail[i])) {
> > +		if (val == data->chip_info->sensitivity_avail[i]) {
> >  			regval = i;
> >  			break;
> >  		}
> > -- 
> > 2.17.1
> >   
> 

