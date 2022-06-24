Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F1559290
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFXGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXGAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:00:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA468084
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:00:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso4778426pjn.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uimkzAFvcCn6LmBe0H4g6mnvfSts12AX8ni/w00kSmM=;
        b=SQm20SgxcSPcAMHx6AALhB6/LPblXYzlzH/2P0+6iPKuORASlQR4CpoHQdMstCxfc1
         gskYCZ1/7yw5qwu/aRKMCpyN9FpqNH7439V5kkq+Hoy+DKDQ3/kKj4RdU6u5HghKdT3e
         tR4G5EwM89ErU/jJGHFhC9ioUj+kbklk6kFdn912L3DN6yNewpXmIvAbGyB349xOCjnq
         cC4o4iMfDiMvKlvp7l+FM4pzbZMM+iHhIVGAI7rl2gDM00Pd/g670INFP+5AcJp8msVl
         snuo1g2+57ltLW8wB72axgAVRNTd9zeYt4dNnrmXTyyI0sSXG1SRcSGqSABbxI6NtWxj
         yjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uimkzAFvcCn6LmBe0H4g6mnvfSts12AX8ni/w00kSmM=;
        b=UFcr5k3GRxTYFetOeGKqoAJJVh8xijfp960dZVJezbrK+dM5IjIjuCNzRsytIS3I/y
         ttrUA2U03KXvJAVLUioth6zVhSGAVphslqO62b/ChzFupmf9I4jNKombdTuatBHt7euM
         +yh7VtjJIRjvqnWy+CqkEsJnUdnP6cJX5STN/W4OeEQXdLbcolUSl+qS1BGlZL5xAdji
         cOrLtAZMQ+ypvE+1kkFb/tuXVO7G2e5sdsyYv1WyRlVn4VkYpYdtlx6td5XlxWm/iEqt
         p7nE2Bkgf3LcvpEw0u8uf7uOcDbwH/fRxA4w6miA6v9mRXCYOvb6WGd8i6ngie6e7au2
         OmHA==
X-Gm-Message-State: AJIora/BD8VvPALSDQo/mPYQCn/WIfWOxHIfq2Pzfxplkq7IQaw6vNhb
        kQSh6Gry7OvJIaPWuOd/oek=
X-Google-Smtp-Source: AGRyM1tFAYdjU63NJ6WDTJ89bLPZQ89svNimoGxkVeiMs/8YA2XRUSZA8iPFknzuAkYQVvV39V/+TA==
X-Received: by 2002:a17:90b:2bcc:b0:1ec:89c6:be9b with SMTP id ru12-20020a17090b2bcc00b001ec89c6be9bmr2154831pjb.74.1656050414224;
        Thu, 23 Jun 2022 23:00:14 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a0cc300b001ec9dce6f10sm2961837pjt.38.2022.06.23.23.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:00:13 -0700 (PDT)
Date:   Thu, 23 Jun 2022 22:59:58 -0700
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, marcus.yu.56@gmail.com
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Message-ID: <YrVS3qjADYGxuYwq@zephyrus-g14.localdomain>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com>
 <YrQ2Izg1b399yJou@kroah.com>
 <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
 <4e0d3b62-ceb4-5848-446f-6552ab16f852@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e0d3b62-ceb4-5848-446f-6552ab16f852@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:47:12AM +0200, Philipp Hortmann wrote:
> On 6/24/22 05:34, Chang Yu wrote:
> > On Thu, Jun 23, 2022 at 11:45:07AM +0200, Greg KH wrote:
> > > On Wed, Jun 22, 2022 at 10:14:04PM -0700, Chang Yu wrote:
> > > > Combine two nested if statements into a single one
> > > > 
> > > > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > Added a pair of parentheses to make operator precedence explicit.
> > > > 
> > > >   drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
> > > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> > > > index 6564e82ddd66..020bc212532f 100644
> > > > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > > > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > > > @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
> > > >   	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
> > > > -	if (padapter) {
> > > > -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> > > > -				precvpriv->free_recvframe_cnt++;
> > > > -	}
> > > > +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> > > > +		precvpriv->free_recvframe_cnt++;
> > > >   	spin_unlock_bh(&pfree_recv_queue->lock);
> > > > -- 
> > > > 2.36.1
> > > > 
> > > > 
> > > 
> > > Hi,
> > > 
> > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > a patch that has triggered this response.  He used to manually respond
> > > to these common problems, but in order to save his sanity (he kept
> > > writing the same thing over and over, yet to different people), I was
> > > created.  Hopefully you will not take offence and will fix the problem
> > > in your patch and resubmit it so that it can be accepted into the Linux
> > > kernel tree.
> > > 
> > > You are receiving this message because of the following common error(s)
> > > as indicated below:
> > > 
> > > - You did not specify a description of why the patch is needed, or
> > >    possibly, any description at all, in the email body.  Please read the
> > >    section entitled "The canonical patch format" in the kernel file,
> > >    Documentation/SubmittingPatches for what is needed in order to
> > >    properly describe the change.
> > > 
> > > - You did not write a descriptive Subject: for the patch, allowing Greg,
> > >    and everyone else, to know what this patch is all about.  Please read
> > >    the section entitled "The canonical patch format" in the kernel file,
> > >    Documentation/SubmittingPatches for what a proper Subject: line should
> > >    look like.
> > > 
> > > If you wish to discuss this problem further, or you have questions about
> > > how to resolve this issue, please feel free to respond to this email and
> > > Greg will reply once he has dug out from the pending patches received
> > > from other developers.
> > > 
> > > thanks,
> > > 
> > > greg k-h's patch email bot
> > 
> > I'm not entirely sure how to fix this. I checked the original patch
> > again and the subject and the body looks OK to me. I'm still a newbie so
> > I might have missed a couple of things. It would be greatly appreciated
> > if someone could point out what's missing.
> > 
> 
> description:
> You wrote what you did in the description. Even when the why can be likely
> answered as well it is not sufficient for Greg K-H.
> 
> I propose something like:
> Combine two nested if statements into a single one to increase readability.
> 
> Or
> 
> Combine two nested if statements into a single one to shorten code.
> 
> subject:
> I am guessing. The subject could may be remain but I think it is to general.
> Please consider that we can have multiple of this subjects what is not good.
> How to know which patch is which?
> 
> I propose something like:
> staging: r8188eu: combine nested if statements in function xxxx
> 
> Or
> 
> staging: r8188eu: combine nested if statements in file xxxx
> 
> 
> But consider that the patches that were accepted do also have a not so
> specific subject. The description was very clear about the "why". There the
> reason was always checkpatch.
> 
> Bye Philipp
> 
> 
> 
> 
> 
> 
> 
> 

Thank you very much for the valuable input. I will reword the subject
and the description and re-send the patch momentarily.
