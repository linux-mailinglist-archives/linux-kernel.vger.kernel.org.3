Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23D4F13CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359494AbiDDL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:27:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C59286F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:25:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c42so3221469edf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRmmpGstRclPRjjwApH1btPXZBsTnruSxfck3SJh4r4=;
        b=Xec7SSTSA/UEqaC37ZEV4dE2Je2KNXkyivlAGkRdaKgATwXD69qOpLf58kgR/8LQ4V
         uXzPpwLF8ZCdagzQg/l468z1zBiUWzpsQikn5wDX2B8ZKGFWIAvBsVFvz7giqowIH5mN
         yOyMQOzWEEg8cliXz9FGxGVHLZhT1rEqe7cb7WR/xjFrJAUKOxZBokuGQ4ADmQRi5jtE
         TMWfeCZ0VCU/unt62Gwl15i9uwLRag8PYBX2hVkwtYO3HnpcO4tF4ziRLeodjADwM6be
         WSA0zRh9Kb9thwu+RaV4OfGEPvKMmmAV/tryX/b3AZk0U/xw6gdxHqmWUFO+Cl6rm2rJ
         oqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRmmpGstRclPRjjwApH1btPXZBsTnruSxfck3SJh4r4=;
        b=lqpzhMBaBGzKeXfV2f91jSrQwIWeggNuEjEfYdTe1ARVXryJWiCBgDKrQxH2ErkH5q
         1XnKHWdSM8XFrEGWKXw7fnmdBQqmAD2hfXsY5UbfAFVcwiSE1djkEmSp0OUOg+33PrPA
         oHhwV5MvgRvaA50EOiqW3Pij2NGcpeI4ti0SA+NPnZLBiKLm1FvmrWv3xqe63wv8gDh5
         /usn/dWDa0ipFPubBiSfqE7/dBaqegmLIWrKuf5wtA5iGE5xckJvul3UQu2gnG+/nRWV
         jV5BbcMTdBQmnLMwuJoquCmqZc28oZamvMZvjI2ksZ371Nbl6sQ77g73O1uprEOibgaL
         c/Ng==
X-Gm-Message-State: AOAM530GD7THHv9VfkwFjcldLZxtLSpGcMmugUCVCVVJQxw2oA4atFQL
        gtKCnkjDon/Gl0Eh1chocNA=
X-Google-Smtp-Source: ABdhPJyY3xQ7CifiD/LgTezse8vbp1FB/R+rACwG3s749AvUaz1JgbEKsxPat98dgdaYzyGXex/3Tg==
X-Received: by 2002:a05:6402:f16:b0:419:d9f3:f8b with SMTP id i22-20020a0564020f1600b00419d9f30f8bmr32808680eda.33.1649071540223;
        Mon, 04 Apr 2022 04:25:40 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b00419209d4c85sm5076057edr.66.2022.04.04.04.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 04:25:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Charlie Sands <sandsch@northvilleschools.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Date:   Mon, 04 Apr 2022 13:25:37 +0200
Message-ID: <4729027.31r3eYUQgx@leap>
In-Reply-To: <20220404105041.GX3293@kadam>
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain> <20220404105041.GX3293@kadam>
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

On luned? 4 aprile 2022 12:50:41 CEST Dan Carpenter wrote:
> On Sun, Apr 03, 2022 at 10:52:07PM -0400, Charlie Sands wrote:
> > This patch fixes sparse warnings about the memcmp function unsafely
> > accessing userspace memory without first copying it to kernel space.
> > 
> > Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> > ---
> > 
> > V2: Fixed checkpatch.pl warning and changed variable name as suggested
> > by Greg K. H. and improved error checking on the "copy_from_user" function as
> > suggested by Pavel Skripkin.
> > 
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > index 7df213856d66..4b4eec2bde96 100644
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -3233,23 +3233,28 @@ static int rtw_p2p_get(struct net_device *dev,
> >  			       struct iw_request_info *info,
> >  			       union iwreq_data *wrqu, char *extra)
> >  {
> > -	if (!memcmp(wrqu->data.pointer, "status", 6)) {
> > +	char wrqu_data[9];
> > +
> > +	if (copy_from_user(wrqu_data, wrqu->data.pointer, 9) != 0)
> > +		return 0;
> 
> return -EFAULT;  We can't assume that that user wants to copy 9 bytes
> especially when they're passing a 4 character + NUL string.
> 
> This is a custom ioctl.  Called from ioctl_private_iw_point().
> 
> I think if you try to dereference a user pointer like this then it will
> cause a crash, right?  So that means no one has ever tested or used this
> code and we hopefully we can just delete it?

After a quick look, I'm pretty confident that we can also delete 
rtw_p2p_get2() and rtw_p2p_set() unless I'm overlooking something.

Thanks,

Fabio M. De Francesco



