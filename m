Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6596D46D2E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhLHMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLHMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:09:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD063C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:05:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4005778wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggHGJ4ATATJMFS5LIR5L0EQNDYKwn8R71jjvqFWzLSE=;
        b=Y3IqVnsvfYRZnb7jQ5fpjr2A9Dpom+OyCLn+5X9UeZQRzpjJ8+jqKZoG3T4xoudKQe
         so6xUF2Exkx1Ytc5VYjehSl1Zxqscn0ZIynmeHi8HObY1wozje4uOs9mbNV0dWQYAWrJ
         kbU7v4ty8pSp6jkGbzUnp6U09fbvf6Jn1LebIGmRg5b2PYHTqppzSHHdkKaBPet7rVne
         TK16Ht6FqA/TFovE+sLLaj/eL+uWACrl8T319In9TFtVfTIxNnMyDQeCzsictampXTtI
         VocJnTgO0VRtJMhrusZGsaVfnHzUaxIchfTGS9bq/7JHc9MRu2fVYHZEJz8OoaBL3w26
         duYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggHGJ4ATATJMFS5LIR5L0EQNDYKwn8R71jjvqFWzLSE=;
        b=Cln7WD3nR4QhIv5VIquhW8Wjj1tQ5NjXl58PhUG/Ujiau3Y6Qpo8ZlumBEDs5KNduy
         Ycp30pOQfrJoGgRMr1TZluSlowKeZ3aoTNlmr5DkGV14CYPSBBtwfulOWoi0QkH5ciHZ
         /zdlAt8o5ttqleQi7sweMmm8MpJ76saD9Y6Tq50yfx9NfZ564DyS6ApjzED2QrDWBId+
         VFJH3T9TcbDBo6aWjI3EvFMiCBlEte4L0sy5bcUK6AGr+sN+ysqysoxyF/R19dOXPJDw
         m/NE7O0w/IoGsF71TnlJJeCEbpPVJTnFrUqm+XOPRi54vwRrgO6bXng3i8lNnzepmqo6
         Igtw==
X-Gm-Message-State: AOAM531+g6fLxqNrcTupRk6AnxSAEWqayee70R3O2FDUDME+7J2GDeFf
        494ywZ4bvQ2rYUNwna/QROA67zc+dDSZIQ==
X-Google-Smtp-Source: ABdhPJxDw+jb3ycmttv6BO+Ycld5++UZj4ia2guGsxPME+dZWL34ZxONGd6q0UcfzPJCt2/NBhUH2w==
X-Received: by 2002:a1c:2685:: with SMTP id m127mr15694113wmm.42.1638965131343;
        Wed, 08 Dec 2021 04:05:31 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.199.136])
        by smtp.gmail.com with ESMTPSA id f8sm6230901wmf.2.2021.12.08.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:05:30 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:05:26 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: test-component: fix null pointer dereference.
Message-ID: <20211208120526.GA12550@hamza-OptiPlex-7040>
References: <Ya9YxoUqkATCOASh@sirena.org.uk>
 <20211207142309.222820-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55814819F7AAAC654084615AD46F9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB55814819F7AAAC654084615AD46F9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:05:46AM +0000, Kuninori Morimoto wrote:
> 
> Hi Ameer
> 
> Ah, you posted the patch :)
> 
> > Subject: [PATCH v2] ASoC: test-component: fix null pointer dereference.
> >
> > Dereferncing of_id pointer will result in exception in current
> > implementation since of_match_device() will assign it to NULL.
> > Adding NULL check for protection.
> 
> Previous your patch was already accepted,
> thus this is not v2 patch.
> git log should indicate is replace of_match_device() to of_device_get_match_data()
Thank you for your kind response and clarifying the process. Let me send
the updated patch. :)

Best Regards,
Ameer Hamza.

