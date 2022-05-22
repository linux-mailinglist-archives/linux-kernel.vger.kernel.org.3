Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D896530285
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiEVKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEVKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:55:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DAD3150B;
        Sun, 22 May 2022 03:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E001CE0AF7;
        Sun, 22 May 2022 10:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3416BC385B8;
        Sun, 22 May 2022 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653216924;
        bh=00JNBNcr+cGzsBq2sFO3y7dWzCheWZhTHY+EBkeomVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t53dm2KOLkTKIn5b63f3DeECq/um6j0sh8r11KBUBN/Z4CPEMSufugF61UBPVL7Tw
         vWK+vP/Tlt5Lqj5c72KlmtjgoeGQlCpMiL6I563RgAokmGapDDG9MhEf0VzlXvVr/k
         N5XddCLcowa1S1fSq4N5MfMmHec9DGADkaY3ViVY47POTB9jV+vrjfYCk9QhJKhc5Q
         zrhDcpQ1HDSbfQdhQVqBCQEl8C9oR02VjzQmVGBFXSS5h9H0DKSocs0A6KNAlRVuYA
         qCzQw+gh9sZgv8HZ+CRE8syl1Oh4PnundXXeCtvuQ5FRkI+ciy8vR4d4sGBddZnp45
         MVJA9gektztNA==
Date:   Sun, 22 May 2022 12:04:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: sysfs: fix use-after-free on remove
Message-ID: <20220522120409.5e169a8e@jic23-huawei>
In-Reply-To: <d777d12c-7fd2-07d8-60ee-d2dc8f73f6c7@metafoo.de>
References: <20220519091925.1053897-1-vincent.whitchurch@axis.com>
        <d777d12c-7fd2-07d8-60ee-d2dc8f73f6c7@metafoo.de>
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

On Thu, 19 May 2022 11:58:03 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/19/22 11:19, Vincent Whitchurch wrote:
> > [...]
> >   
> >
> > Fixes: e64e7d5c8c86e ("iio:trigger:sysfs Move out of staging.")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>  
> 
> Thanks for the patch!
> 
> Strictly speaking the Fixes: should be
> 
> f38bc926d022 ("staging:iio:sysfs-trigger: Use irq_work to properly 
> active trigger")
> 
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
I've changed the fixes tag and applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> > ---
> >   drivers/iio/trigger/iio-trig-sysfs.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> > index 2a4b75897910..3d911c24b265 100644
> > --- a/drivers/iio/trigger/iio-trig-sysfs.c
> > +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> > @@ -191,6 +191,7 @@ static int iio_sysfs_trigger_remove(int id)
> >   	}
> >   
> >   	iio_trigger_unregister(t->trig);
> > +	irq_work_sync(&t->work);
> >   	iio_trigger_free(t->trig);
> >   
> >   	list_del(&t->l);  
> 
> 

