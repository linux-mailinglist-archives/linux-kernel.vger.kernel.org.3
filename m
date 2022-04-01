Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878244EFCE1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbiDAWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiDAWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:48:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3A56762
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:46:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gi14so3174015qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3SlGevsQL2lAXYmUm86OvjV9WvM+ut7+9oaiLvI2qng=;
        b=fOLVerVUR8dkocBQsva7JQDvU8BzRpyj/lrEqDFTfn35ZpqBFyLXPyF/ElhffQ5UTv
         a3H+7rEmP5QqfaEzC0uV0rYPlOZZfPudTJ/UTbRy7rzRTiG1DXIJDOWMl20ns8XkHwAu
         cfpbkjLw/ygCc5xKKqgYWtA+BibvM8GOf1qaMlI8vkeJsFWBwtvIvXm+c9hgCAkdhvDv
         7vJwe6T0X4pmauPJP1UQx+ybu8EsLoERw/H1NiJdczfl2aCSyijVRT/9ayGEFtg5aJaI
         07EZgznDGfkZ2n1X9t+6cMY4P9lS4ohVuYXV898Qtx9FrH9YwIIsP+fMlKqkWW9wcVOt
         AbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3SlGevsQL2lAXYmUm86OvjV9WvM+ut7+9oaiLvI2qng=;
        b=Gwjt+uR/gjnyckXULFRSG6SwS8boaGhMVsTShnHx4oVCMYkO3lRXV/D+T8tuBkAjy9
         kNEhrdtpyo11+52HOAuWbd9/pPaECqFW3tPfpbVqHwcgyY5cBkHTJlL+gK7wIP6eloAE
         t+DNmfm3Hqf4Qv2VOZvE/aacpSn5GUE7JphgrmiJlSb/dXztib4cYcuhDpK0gTUF3Wof
         +WyEzMFygppnScQffPIxkAnWaFWrIXmyUXexneodDuHx/47JO4F6X4XnBr4F/cmVcgfk
         tees1qmk/jOkPVYcYV4PU40y6cQb0WW20iRLDGCu+LuL7rIVjmn5rjwrR4rJFXjV7Xic
         g0Rg==
X-Gm-Message-State: AOAM530HjpQiWZL8baruLuIMCi2MhKVvqiM459kywrxNdwEYBw/Ape63
        69FqyqPC2GMvreGwo6dX+nUKwmUO78sx+FfI
X-Google-Smtp-Source: ABdhPJzzlbdrkppwgElbTfX/WDZEz5bJKqpG1sU7SQNG0a3ngv+x6jZvNFvAU2ivitMACviJpdq44A==
X-Received: by 2002:ad4:5dca:0:b0:441:55db:2835 with SMTP id m10-20020ad45dca000000b0044155db2835mr41929429qvh.31.1648853181855;
        Fri, 01 Apr 2022 15:46:21 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002e1b9897ae7sm2754617qtj.10.2022.04.01.15.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 15:46:21 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:46:19 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: simplify control flow
Message-ID: <20220401224619.GA71483@euclid>
References: <20220401114635.GA567659@euclid>
 <YkdvzIyz/WGlm2uy@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkdvzIyz/WGlm2uy@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 02:34:04PM -0700, Ira Weiny wrote:
> On Fri, Apr 01, 2022 at 07:46:35AM -0400, Sevinj Aghayeva wrote:
> > The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> > the first index for which the condition is true. If no such index is
> > found, the function returns -1. Current code has a complex control
> > flow that obfuscates this simple task. Replace it with a loop.
> > 
> > Also, given the shortened function body, replace the long variable
> > name psecuritypriv with a short variable name p.
> > 
> > Reported by checkpatch:
> > 
> > WARNING: else is not generally useful after a break or return
> > 
> > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> 
> Wow!  Nice find!  This is a huge clean up.  Extra kudos recognizing that it is
> not just the else statement which is broken here!

Thanks! It took me a while to realize what this loop is doing.

> The only issue for the patch is that I don't see any maintainer emailed?
> However, I don't see a maintainer listed in the MAINTAINERS file so ...
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks for the review!

Greg, please do not apply this yet. After I sent out the patch, I
noticed the comment at the top of the function:

/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */

So I did a git grep to find the original function and fix it as well,
and it looks like there are three copies of the same function in
different files:

$ git grep IsInPreAuthKeyList
r8188eu/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
rtl8712/rtl871x_mlme.c: * Ported from 8185: IsInPreAuthKeyList().
rtl8723bs/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */

I will later send a v2 patch that replaces all of them.

Thanks

> > ---
> >  drivers/staging/rtl8723bs/core/rtw_mlme.c | 28 ++++++-----------------
> >  1 file changed, 7 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > index d5bb3a5bd2fb..3eacf8f9d236 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > @@ -2036,28 +2036,14 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
> >  
> >  static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
> >  {
> > -	struct security_priv *psecuritypriv = &Adapter->securitypriv;
> > -	int i = 0;
> > -
> > -	do {
> > -		if ((psecuritypriv->PMKIDList[i].bUsed) &&
> > -				(!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN))) {
> > -			break;
> > -		} else {
> > -			i++;
> > -			/* continue; */
> > -		}
> > -
> > -	} while (i < NUM_PMKID_CACHE);
> > -
> > -	if (i == NUM_PMKID_CACHE) {
> > -		i = -1;/*  Could not find. */
> > -	} else {
> > -		/*  There is one Pre-Authentication Key for the specific BSSID. */
> > -	}
> > -
> > -	return i;
> > +	struct security_priv *p = &Adapter->securitypriv;
> > +	int i;
> >  
> > +	for (i = 0; i < NUM_PMKID_CACHE; i++)
> > +		if ((p->PMKIDList[i].bUsed) &&
> > +				(!memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
> > +			return i;
> > +	return -1;
> >  }
> >  
> >  /*  */
> > -- 
> > 2.25.1
> > 
