Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A736D52FE86
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346933AbiEURRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiEURRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:17:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984486A419
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:17:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g21so1550666qtg.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74iO+k+sU+IlzNDs66QrJFNFWlpeGF1yqzPnmcyjvug=;
        b=IPhtJwQmg55AQ5MR3CMDAvg0X/FBkZk0NlrudtKCYsGrUebzd1wvxucMqzhUcA78ZP
         /VMSvU1UhJL4KchU6QDD0kSHiQARx6GEl6z1qiH2T+3rsx2yDAusXMdgeU1DXqhsfkQq
         h7fCGA+QxQyquYRyOtl877z8vWQHlMdGiJBTw0DvL8rZjuupASwiwq8rv/RVBOXiA9FF
         jAGmGYfTuHa4e3oFv863P1r2CUa5TnnJPTgRfd3LFwcsU6Ef+pCeyxGfyklWumRmbTjQ
         gBYv0zqYbrEr+GuRm8JL/qGjJ3tWPgXHmqdCmb6OuzoMSaddrSwijuE4xx45ibfw15ts
         AEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74iO+k+sU+IlzNDs66QrJFNFWlpeGF1yqzPnmcyjvug=;
        b=YqxXtyVUj4LMcDBygCQIP+y0PhtPvPU9Y607xKGJXsBxzPeDCH284tQIFt1xef3/nf
         o9bukmi4/CMSQ/ZCuSsF6KnoqQBys1NE8yvElVSJyTx3eXeAOO/2f88DKsA5SY3C2LMC
         4DdKop2+Vl2csrN7XJ3+nQ+752VvuE8tpXNHXcznVL8t02C+OYmzfttVmXr/DXKxUasg
         nsHXpvZ2wRTCGbiFpvpBjwFhB/jPB5G9udHhss/8Tcz9YuuZRV2rUi8hhDjehXoPNEVM
         lvUSaSMMJEBPUNw4TbJynJeXNss31cQgLvBrThVVhZkhY6YYztHi+/w1QpmGPMLFi5o+
         ttiA==
X-Gm-Message-State: AOAM531iF6f9mRmtjdyGcM4s5h+3E1+5IBLepxxUHbJQJnWfGNcKzIxr
        liRXPk2JfWmwMj3vR6KvjPGGoS36mvA=
X-Google-Smtp-Source: ABdhPJzu5VPLWE4gUydCnutp3VfDrZj4RVAyEI6T/ckAbtcD9w2Uln7AVuEtHBzYknrd7GMoqCL7ig==
X-Received: by 2002:a05:622a:1214:b0:2f3:c1a4:231c with SMTP id y20-20020a05622a121400b002f3c1a4231cmr11635501qtx.72.1653153451677;
        Sat, 21 May 2022 10:17:31 -0700 (PDT)
Received: from Sassy (bras-base-oshwon9563w-grc-26-142-113-132-114.dsl.bell.ca. [142.113.132.114])
        by smtp.gmail.com with ESMTPSA id v13-20020a05622a144d00b002f92b74ba99sm218706qtx.13.2022.05.21.10.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:17:31 -0700 (PDT)
Date:   Sat, 21 May 2022 13:17:29 -0400
From:   Srivathsan Sivakumar <sri.skumar05@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rts5208: spi.c: clean up dynamic debug code
Message-ID: <YokeqRl/N2m9Nui7@Sassy>
References: <Yojg1nXXTIL3G82l@Sassy>
 <YojnC+kQXcxTMrua@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YojnC+kQXcxTMrua@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:20:11PM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 21, 2022 at 08:53:42AM -0400, Srivathsan Sivakumar wrote:
> > I've condensed the three dev_dbg() lines into one as you requested in the
> > previous patch thread; and sent them all as a singular patch.
> 
> This does not need to be in a changelog text.
> 
> > fix the following checkpatch.pl warning:
> > WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> > 
> > Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>
> > 
> > Changes in v2:
> >         - Condense three dev_dbg() code lines into one
> > ---
> 
> The --- line needs to be right below the signed-off-by line as that is
> where git will cut the changelog at.  You don't want the changelog in
> the commit.
> 
> >  drivers/staging/rts5208/spi.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
> > index f1e9e80044ed..ea736a73e58c 100644
> > --- a/drivers/staging/rts5208/spi.c
> > +++ b/drivers/staging/rts5208/spi.c
> > @@ -460,10 +460,7 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
> >  	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
> >  	spi->write_en = srb->cmnd[6];
> >  
> > -	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
> > -	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
> > -	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
> > -	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
> > +	dev_dbg(rtsx_dev(chip), "spi_clock = %d, clk_div = %d, write_en = %d\n ",                               spi->spi_clock, spi->clk_div, spi->write_en);
> 
> You might want to verify that you really meant to put that many spaces
> in this line :(
> 
> thanks,
> 
> greg k-h

Apologies for the errors, I'll make sure to follow the guidelines more
strictly.

I'll implement your remarks and resend the patch soon.

Thanks, 

Sri
