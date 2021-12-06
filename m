Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43167469263
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbhLFJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbhLFJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:33:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C4EC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:29:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so20991694wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ct+p7VlKlUoKTbIoDDaK1/3A+2HLH4PhtmZuaPsHx1E=;
        b=aLvp8qb0/Ykf4uLdQfwoWQePkl7ChOoNElne/Q+3z6yewHPiRiaLrfJM5bXBQbFKov
         d/QCnT2ZZY38BNu78g1DjZWGnGTiZBTqV1cUYhfL/cuOQimFQcZ4Dwbpwo8fo9Y03sN9
         XqriaxaaXnhClU47iELaKykYTY3HefQQ6e5KK1c/ssvLh7yveLi3pJYuDMST+sLYgzet
         G7Sw+jDdYHffvTDU6lMNCO8k4ZJsIwRpvayT2Y7b1s8cyLX2jBCCoiJ2Afw0t/FIiLM0
         sa0IgapBTa5dNzDvBRBAw/91qSLHdMtFLw7LY1oB3NR6kTjWm76SxWeIw1dDVQqfh7tA
         MsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ct+p7VlKlUoKTbIoDDaK1/3A+2HLH4PhtmZuaPsHx1E=;
        b=SVRbXxUK+pCCKQuWoWVEta11Fh3JC0Zju9vCUnC18tygRQzEHSzsz7uZaIsdS8Pfaq
         9jONs751nBbCGN91cPr8OMek4F8y7HoC0ym5BJkTdBySqFxhVquPFbxEKNEAuwO/ZL83
         bmIbVntRWaW+zLYsg4GIZa7PMbcsQOAuN8OdK54sXnI/Ml6Rs+TjoXT+lZiYju2JrOHw
         HcraWztoB/IA6vVdK5kZoRQ5Yf9egf4LpOUhQWfY+3h6hLIlgbhX4JHLv/VRLuia187R
         cldTK3q7P+fCvQXdV3e+FEOZVROFHTctt1lfvzjsYj9VjM9AbA0mqsUs8jcnDHJXGdxB
         rUmQ==
X-Gm-Message-State: AOAM532t61qZyqJuUZ1dn5wxWAQlS/15hXZfBTYWFaf3h1NkGqbzJzge
        OjNlXskiu8EDoisj0XH8oUU=
X-Google-Smtp-Source: ABdhPJzk0o6XFyoPZi+U2EZCLv55RRVdp+0CpsDkL5sD67loqkWDMtYHz9jBuTZxn/Tl/opi7e06Bw==
X-Received: by 2002:a5d:6d01:: with SMTP id e1mr42061164wrq.157.1638782982192;
        Mon, 06 Dec 2021 01:29:42 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.147.147])
        by smtp.gmail.com with ESMTPSA id j18sm16118678wmq.44.2021.12.06.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:29:41 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:29:37 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: test-component: fix null pointer dereference.
Message-ID: <20211206092937.GA5609@hamza-OptiPlex-7040>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:40:27PM +0000, Kuninori Morimoto wrote:
> 
> Hi Ameer
> 
> Thank you for your patch.
> 
> > Dereferncing of_id pointer will result in exception in current
> > implementation since of_match_device() will assign it to NULL.
> > Adding NULL check for protection.
> (snip)
> > @@ -532,13 +532,16 @@ static int test_driver_probe(struct platform_device *pdev)
> >  	struct device_node *node = dev->of_node;
> >  	struct device_node *ep;
> >  	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
> > -	const struct test_adata *adata = of_id->data;
> > +	const struct test_adata *adata;
> >  	struct snd_soc_component_driver *cdriv;
> >  	struct snd_soc_dai_driver *ddriv;
> >  	struct test_dai_name *dname;
> >  	struct test_priv *priv;
> >  	int num, ret, i;
> >  
> > +	if (!of_id)
> > +		return -EINVAL;
> > +	adata = of_id->data;
> 
> But hmm...
> Probing this driver without adata is strange for me.
> How did probe this driver ??
Thank you for your response. Unfortunately, I am not aware of
implementation details of this component. Coverity suggested that there
can be a potential NULL pointer access which seems logical to me. Do you
agree with coverity here?

> 
> Best regards
> ---
> Kuninori Morimoto
