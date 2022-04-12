Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F74FCD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiDLEAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDLEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:00:01 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388720F5D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:57:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id q6so7233429qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40nfkm7AJFhrLlgoTZd+KNaCMw5aAK6dNL2X6kEOaPU=;
        b=FLUUa7pAkmcOG05Rc9OftUY87lGEUxCbrJQ7/SOliJA9Ykq6xkAcFgcbXkpMOg2kVZ
         L8QUyRyRAgoPCmg112qYV3BMMby5ETwND3amZT9RdeVkO5CZB3iAYByCa2WpaopAnV5l
         u/RqrlAbTp60+FI+Mi8AgP6xABq2Qd6QyD0UEa6dRNZkuTOQGHu372NpkRrMky/ah+vx
         TWLQSVYgPs6NdL5Zh/+8Iy32yZaZZFrANBj0q+PF/1tOC1X3zo8LqX+9WWWSHF4G3bii
         YOTtxFOLxjGtfTiH5q/dOqW+/g2MaN2q3ySZyvbnIXnp7eBkJbvxuoyweYtD1JYM+iYD
         MKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40nfkm7AJFhrLlgoTZd+KNaCMw5aAK6dNL2X6kEOaPU=;
        b=rI713mSpFCw4RakbLBE4uL+SCDLbJmhIcGAPcfeY4cHygT0D5n1UuQS7TwVAeYL7al
         /P//chpD3fXbwx8DmF4NfDr7laEkKXXiPAojnjf9h6kkvZgfYRgZCLbGwHMAHzWgW9mc
         2MGOvVeyaSpznRu2DUjDQeauFXa4F8zB9b6xTJl34EJ5+vBt07dr/+Tf4ZhwnGW3ebOd
         5+c+tGHRxtGpnJvnop+fAUuMLwCvy7C1f6iW7OiOFw1JyYsmMt/oTGyUOyhgNRrqdA6b
         hFXzLsxNVXoDLStGp7p/xIGt6dUZhv6IvLe/Da850UB0p5RmPb0EXE/L6tVoLcE0Iyv9
         3ZNQ==
X-Gm-Message-State: AOAM532+jo7UWxw1FNzeMT0tmsXfvypMHQEwE756tpS2drKzChhI5IlV
        /osgbi0QmF2ShaT7cGWk6z11k9cCNg4ko3OQ
X-Google-Smtp-Source: ABdhPJwDMrb79BrLKLc115ZZRDqdpyb645S0tJcA3zF36sWQXtHMvG9UT+hb1VJ3oa1zZQuQlFvpQg==
X-Received: by 2002:ac8:4f57:0:b0:2ed:d8f:d0bc with SMTP id i23-20020ac84f57000000b002ed0d8fd0bcmr1926261qtw.280.1649735863414;
        Mon, 11 Apr 2022 20:57:43 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm28152189qtz.92.2022.04.11.20.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 20:57:42 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:57:39 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220412035739.GA2856917@jaehee-ThinkPad-X1-Extreme>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
 <20220408061936.GP3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408061936.GP3293@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:19:36AM +0300, Dan Carpenter wrote:
> On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> > diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> > index 6594cc647c2f..78f2a416fe4f 100644
> > --- a/drivers/staging/wfx/wfx.h
> > +++ b/drivers/staging/wfx/wfx.h
> > @@ -25,6 +25,8 @@
> >  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
> >  #define USEC_PER_TU 1024
> >  
> > +#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))
> > +
> 
> Better to make this a function.
> 

Hi Dan, Thank you for your comments. To make sure I'm understanding your
concerns correctly, do you mean I should define a function instead of
using this macros here?

> Stefano's comments are correct.  It would have saved space with the 80
> limit to do a "struct ieee80211_vif *vif = wvif_to_vif();" at the start

Got it. I implemented this on the next patch (v3) that I will be sending
out soon. 

> of the function.  Also dereferencing the results of a function call
> like this, "frob(foo)->bar", without checking makes me itch.  If it's
> at the top of the function then that's kind of different.  I normally
> assume that the functions in the declaration block cannot fail.  From
> analysing static checker warnings, putting functions which can fail in
> that the declaration block is risky.
> 

The frob(foo)->bar in my case would be wvif_to_vif(wvif)->type?

> It's always better to test things but this patch looks correct to me:
> 
> The add interface does:
> 
> 	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv
>         ...
> 	wvif->vif = vif;
> 
> The remove interface does:
> 	wvif->vif = NULL;
> 
> Those are the only places where ->vif is set container_of() will always
> work.

Yes this is true. The add and remove interface was the inspiration point
for this patch.
> 
> regards,
> dan carpenter
> 
