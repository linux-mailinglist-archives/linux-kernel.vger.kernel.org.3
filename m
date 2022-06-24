Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F416558F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiFXDfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiFXDfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:35:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5B53A6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:35:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p14so1428030pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtsUVs/zJwwFM5gUYX+P+dBQz+vLoX2P7tgqbjAxqpU=;
        b=Igv/cQVlwnXdMXYNsaIQ2xZ6KUUYHWVjmjFe8evjbK4TJXB5UP8CBiwIgsuXZ+S9AI
         EFunNpFAoidn3QwIYqkbb2AKkZ5Yhco5TRwijQjHT0LMBeJ5HFtx9aF2GqsZhzE4ItBu
         1zLjgMTwMaHV5JQQOxYJp9gw4Tx3+lxpchn3UjhwJ8F34Ee8Zfe88epQGT2+1wC7HJjy
         SK5BMPrwr18mCeLoWnAfVIcqCAsLyAepC3fYgXFPJ0GDyB+z3P6utAu8RZ6C+C2eBMa8
         MvcV6j38iHxOpkpf6Et1IOl9U4Bqu53mhMjCVhCLrCCWc6yUtVIrL0LJDOtS0qv+a6pS
         KK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtsUVs/zJwwFM5gUYX+P+dBQz+vLoX2P7tgqbjAxqpU=;
        b=QQQT8UfgbQr5hf4tSgwNAWdi23sTeXsqWlgjGUznYfey2bYKAaDEatWtFQB31WKtCC
         vRLc7s61dD8/AlqWrMCUn9PgSxtKHvMCASFU8b7IRm3q/vFi9hmAkwuMTx4JdqpUKywH
         xylgWSoBYaPwgfHEoncHpUrEc1fSvuZhu7D8tEbrSwrOAYNQm3fpDMbqREaUjegKd94D
         NNfOMKaInWni1K0S6EV/bbWBn2mOARowL23626U2HMTTvpdzS1h3NUF8ymLJZFON53fQ
         KKpx5clUbfIBX+nLPu1lo4cxHNn9k6IDXR/Z4wq8d4KfrtO1s2/jEpc3HcffwQRh0183
         WcZg==
X-Gm-Message-State: AJIora8/r+4pxw+W2+m9zHnoH6D9GaVQduAaX/13L7ZwEM5FgnzKyzBP
        qVRHd8Cy4NpH9FXrR+oAjWcb/4FFEwq7bQ==
X-Google-Smtp-Source: AGRyM1u6HPLjTHr4k6HSwyU8K7RRAv5mrynVi7ypJ/4JLie7/3tW9Ko6vHX/K1LAbX1F3lV/Nd9ErQ==
X-Received: by 2002:a05:6a00:10d4:b0:522:8c31:ec23 with SMTP id d20-20020a056a0010d400b005228c31ec23mr44316987pfu.67.1656041710633;
        Thu, 23 Jun 2022 20:35:10 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4e8e00b001e2bd411079sm2692262pjh.20.2022.06.23.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:35:09 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:34:54 -0700
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        marcus.yu.56@gmail.com
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Message-ID: <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com>
 <YrQ2Izg1b399yJou@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrQ2Izg1b399yJou@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:45:07AM +0200, Greg KH wrote:
> On Wed, Jun 22, 2022 at 10:14:04PM -0700, Chang Yu wrote:
> > Combine two nested if statements into a single one
> > 
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > ---
> > Changes in v2:
> > Added a pair of parentheses to make operator precedence explicit.
> > 
> >  drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> > index 6564e82ddd66..020bc212532f 100644
> > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
> >  
> >  	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
> >  
> > -	if (padapter) {
> > -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> > -				precvpriv->free_recvframe_cnt++;
> > -	}
> > +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> > +		precvpriv->free_recvframe_cnt++;
> >  
> >  	spin_unlock_bh(&pfree_recv_queue->lock);
> >  
> > -- 
> > 2.36.1
> > 
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what is needed in order to
>   properly describe the change.
> 
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what a proper Subject: line should
>   look like.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

I'm not entirely sure how to fix this. I checked the original patch
again and the subject and the body looks OK to me. I'm still a newbie so
I might have missed a couple of things. It would be greatly appreciated
if someone could point out what's missing.
