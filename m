Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807CF4F1700
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbiDDOcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377403AbiDDObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:31:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E5222AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:29:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a6so9421790ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77kGfP4Ekffc+7FFnax+xXuZmbqgY9SJOFJ7fk7iBNw=;
        b=R9+3Kmy71VGEeFaQozw9sFkyt7mh1KE6j/VenMTAWOCwG4y79Bmo0CUMvbZKIVOxc8
         qBLFvawexcjQmHB5ySGecSLnR0DxPIhGmCb9721y6ABB4I6o+gyyf2RuNZduUgqIT8kw
         HCxxubAi6CmQ91kTTWyOZBP5+m1sqCTQ21gzaJ0utuPWjwiUVdUfPAYGwOCRp6aR/Utp
         ziS5QeoySUI6inf5z4jKupCNM9pEGP33wTMmu+RkNFsoe8crFXib4OkbXadzY8jqbA5X
         BbCaqn/GgkptZI0kl7l6XxBiOOGwDjITDLuSVwm9swRnQHwin5jvaeJOZpS6lsk3t69Y
         ZNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77kGfP4Ekffc+7FFnax+xXuZmbqgY9SJOFJ7fk7iBNw=;
        b=wkVE9RA7Kcgw1smCodJ+Z9zhg2TGpj0oa8RojgsXM6Wv/Z0oV13WOH1SlNPYKOHCwU
         3I4TN2D6JOcnzf0LNVyYORoq3H7S0zs2hfAJk6uEvxG+rW97CBLkVBCvYnHsOjA1x6nF
         TI+9LecWrQTQvId0gp8dMLbw0pYy4v40ZQy+Is570KR6cu/MWJsjJEsNWvgfuRUCVGML
         qe8t0nD9HeLY87FEcjtewYEy66MX1Y8bSbk2SUNQHAUqCmU7pRTDzSNU7iA4LprOpEr0
         cfcR8ZWhq0AekfAwpTJK8GG/tl3dy7e8QmwfwDffIFIMMG7nzWQTSvOkQZd5fGCpqlR9
         ECyA==
X-Gm-Message-State: AOAM5321wbm/0yNRkp1Rdg4rNGomus1TCmoKkselg8Bk5A+/G1tQUFo5
        ScfwasWPArlcOxFmXkfHs+I=
X-Google-Smtp-Source: ABdhPJwa9ZiC1to5cnPURySwUxxNWevW/upManv7R5NdXF0hNZCzTc9waoQbftAOfnZIin1rsXJsEA==
X-Received: by 2002:a17:906:c147:b0:6df:f047:1677 with SMTP id dp7-20020a170906c14700b006dff0471677mr351120ejc.4.1649082590837;
        Mon, 04 Apr 2022 07:29:50 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id da23-20020a056402177700b0041394d8173csm5293015edb.31.2022.04.04.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:29:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Date:   Mon, 04 Apr 2022 16:29:48 +0200
Message-ID: <1890716.PYKUYFuaPT@leap>
In-Reply-To: <20220404120332.GY3293@kadam>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain> <4729027.31r3eYUQgx@leap> <20220404120332.GY3293@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned? 4 aprile 2022 14:03:32 CEST Dan Carpenter wrote:
> On Mon, Apr 04, 2022 at 01:25:37PM +0200, Fabio M. De Francesco wrote:
> > On luned? 4 aprile 2022 12:50:41 CEST Dan Carpenter wrote:
> > > On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> > > > This patch fixes sparse warnings about the memcmp function unsafely
> > > > accessing userspace memory without first copying it to kernel space.
> > > > 
> > > > Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> > > > ---
> > > > 
> > > > V2: Fixed checkpatch.pl warning and changed variable name as suggested
> > > > by Greg K. H. and improved error checking on the "copy_from_user" function as
> > > > suggested by Pavel Skripkin.
> > > > 
> > > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
> > > >  1 file changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > index 7df213856d66..4b4eec2bde96 100644
> > > > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > > > @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
> > > >  			       struct iw_request_info *info,
> > > >  			       union iwreq_data *wrqu, char *extra)
> > > >  {
> > > > -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> > > > +	char wrqu_data[9];
> > > > +
> > > > +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> > > > +		return 0;
> > > 
> > > return -EFAULT;  We can't assume that that user wants to copy 9 bytes
> > > especially when they're passing a 4 character + NUL string.
> > > 
> > > This is a custom ioctl.  Called from ioctl_private_iw_point().
> > > 
> > > I think if you try to dereference a user pointer like this then it will
> > > cause a crash, right?  So that means no one has ever tested or used this
> > > code and we hopefully we can just delete it?
> > 
> > After a quick look, I'm pretty confident that we can also delete 
> > rtw_p2p_get2() and rtw_p2p_set() unless I'm overlooking something.
> 
> What are the problems with rtw_p2p_get2() and rtw_p2p_set()?
> 
> regards,
> dan carpenter
> 
Is it safe to access user space pointers without using proper helpers? 
In those cases I mean: is it safe without using copy_from_user()?

As I said, perhaps I'm overlooking something. However my conclusions 
follow by your own argument.

If I understand what you wrote, you asked to delete rtw_p2p_get()
because it looks like nobody "has ever tested or used this code".

rtw_p2p_get2() and rtw_p2p_set() use the same pattern of rtw_p2p_get()
when they access user space without using the proper helpers.

Therefore, I thought that, if you suggest to delete rtw_p2p_get(), why
not also rtw_p2p_set() and rtw_p2p_get2() that use the same unsafe
accesses?

What am I still missing?

Thanks,

Fabio M. De Francesco







