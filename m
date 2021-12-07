Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA34746B57A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhLGIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhLGIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:18:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649EDC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:15:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i12so10041670wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 00:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rOIlXsz0PGlaxQV5U7jqAgR4am707r4hcnOeW2eWLV8=;
        b=O8SFw4q1q5ubvaw3zVvh8753feNo1rPiMnkGhekMVUnsCFUaohyqvaZe68fvMGM8N8
         sZmBEpSiVbkdsKuPImwoM1u5FiZ+b+3/jl5Cd0KKSsu0dAAUUeqYVX6DyIrQHlcS2fms
         7J+rRho0iI5Mqzw7u+u11SgF0A/cbP3eBI5MwbYzydorih2gOxyIWaFLdlSVq4M2dIQx
         kdM/tlGiBGVBROrQ1X4OhBFx20/WgzcPgZJr+dTbXD6brOe0JaMKxU5CoJuSJde6YFaP
         yenPSry8I10ZwYJWXiRKF+2uhZuEtGMSxrM6BuGZ241OzmK6K4AK8C0JWM9tfaCYbfgc
         YQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rOIlXsz0PGlaxQV5U7jqAgR4am707r4hcnOeW2eWLV8=;
        b=mL0rk4Oqduogi3jQ/pE8fCfv49ai5RiOMSxDmqIQKs0xlQS3NBHn3vgzPISOGORyqo
         D0VnT4K0GabxsDSbB1OUQP4o4KWT3r6UeElLeUyUa018+RaI8eVhK/XChC4TylPvAvmY
         M4xR6dInMeOEqfocGzskinGhHuUPShYFMutwxZUHHUoYlN9LhjrxK/4Xfxrpt/544sBW
         bnIEebu4l6KKqvRPQ6KBMMxjVRWg2qRXF+R1HD21d4Hc3B8wQ2wN1BQJwXCd24qjqWIH
         yLOk8dPeJIuL2NEia0HlUq6H27HwsACkOr1kRbnBb9/1n9aMbgJ5A4FWIdeNtn9MeoT4
         bQZA==
X-Gm-Message-State: AOAM530OBpt7cvDWd9IWCi4kyuSstM+NVZlaKuZPDaKwvtNfgE9ONrOP
        JqHbcQnXFnil1kMjSxFnY0M=
X-Google-Smtp-Source: ABdhPJy2X3TxTv34u8UaDIlSKuFZUwju+YHjlgxlUlnKm60GtggT+2vqZhY/Oj9PuKjuvpLCt4hQ/Q==
X-Received: by 2002:a05:600c:510d:: with SMTP id o13mr5051389wms.104.1638864926845;
        Tue, 07 Dec 2021 00:15:26 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.238.254])
        by smtp.gmail.com with ESMTPSA id r8sm16944910wrz.43.2021.12.07.00.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:15:26 -0800 (PST)
Date:   Tue, 7 Dec 2021 13:15:22 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: test-component: fix null pointer dereference.
Message-ID: <20211207081522.GA9690@hamza-OptiPlex-7040>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211206092937.GA5609@hamza-OptiPlex-7040>
 <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:19:36PM +0000, Kuninori Morimoto wrote:
> 
> Hi Ameer
> 
> >> Probing this driver without adata is strange for me.
> >> How did probe this driver ??
> >
> > Thank you for your response. Unfortunately, I am not aware of
> > implementation details of this component. Coverity suggested that there
> > can be a potential NULL pointer access which seems logical to me. Do you
> > agree with coverity here?
> 
> I think no potential NULL pointer access, because this driver can't
> be called without of_id->data.
> But, potential NULL pointer check itself is good idea.
> It seems your patch was already accepted :)
Yes, indeed.

> I noticed that we can replace it to use of_device_get_match_data()
> 
> -	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
> -	const struct test_adata *adata = of_id->data;
> +	const struct test_adata *adata = of_device_get_match_data(&pdev->dev);
Thanks, that's a cleaner way. Can you advise how should proceed with
this since previous patch is already applied. Should I send a updated
version of patch, e.g., v2 or a new patch. 

> 
> Best regards
> ---
> Kuninori Morimoto
