Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA450D0F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiDXJ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiDXJ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:57:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947286A042
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:54:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f6so1217326wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IFzo2AyAr/8UJ+zjot0AiwlKsJEusi+Z1xhhKSENwoU=;
        b=pPi82HnN0vcRuminofbaN8FJbBK7JgIF5OnyIdDCBJUcU34UM7kaAfvTs05v/EqhsR
         SZF2HNtJFIcHquT0Er5PoN44S2KzwDJ42RA4qhV37vHAVr+vbe0q/SI0HUNyyiRF0Hgf
         gCNJ3yYSKcoZvXTLIpxKH/FDUwDWBk9CzWzev3quvT45jXeLt1GCgW94sAbRfDQvaNwL
         bKYrcVi9c4icIgM5az5NAyyNaoVdqIQXkuA7XWjtx1qXKaLuUy7YvUxRcIyt100EZt8d
         1REbds1FU1BMFhvOaE+6gVWogW8To/w3LSfFOVv0EyF0DJXWONm46k9qU0JkGKwAjLDV
         EKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IFzo2AyAr/8UJ+zjot0AiwlKsJEusi+Z1xhhKSENwoU=;
        b=ZvqtFZW6uA0WgxBy/591awl90coMKZ81IsEUCa3We5pZr8MeqsZsOXCsXOj2XrQ3++
         Ho/FnUt7JZJ0lqve2nBx8E5QoSQ1FhuPCh4b7CBypUhgDEUyWUCxpcrVI8aZX6FLk0JT
         62FYQ3R+5IHdS5nZNNjWJ8VI5FsHMkmT3gqt/HPweWJ5XnSE9rO/zRUHNlXgUl+q8Foc
         9fAd6Z43ZXchPaQGTKjUo/iPNRTUI7l62Lc+IWKGFBHL0UlhkBM2b/lsMYaVSdHPHydx
         DLNeue5mkTll+FdRfE5iQ2Sh8QevaKJ9ccKS+UxlYYFuno3s4aF3m3L+d5YvgAeL3nVQ
         Szsg==
X-Gm-Message-State: AOAM532DqiVjrJONItmRy0WoHAlO5SchSysrU9NxbcxDPDfYaoMKMQmI
        8yUZKFO+GbdB9VE4w6VHFFhX/QfQVJvTtA==
X-Google-Smtp-Source: ABdhPJx1C7TZNqA2WDgmRS8PP/JkKglPqepniU5Uam1gCfvOmL17fML6wIRJ1zqLcKVeSaTXVbQkTA==
X-Received: by 2002:a05:600c:2e16:b0:393:e950:4e35 with SMTP id o22-20020a05600c2e1600b00393e9504e35mr2336042wmf.90.1650794076220;
        Sun, 24 Apr 2022 02:54:36 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003928e8e85eesm5908723wmq.10.2022.04.24.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 02:54:35 -0700 (PDT)
Date:   Sun, 24 Apr 2022 10:54:33 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: drop more IDE boot options and ide-cd.rst
Message-ID: <YmUeWXCHZm/OG9sz@equinox>
References: <20220424033701.7988-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424033701.7988-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 08:37:01PM -0700, Randy Dunlap wrote:
> Drop ide-* command line options.
> Drop cdrom/ide-cd.rst documentation.
> 
> Fixes: 898ee22c32be ("Drop Documentation/ide/")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> I missed a few things in dropping all IDE documentation.
> Hopefully this is all of the remaining pieces.
> 
>  Documentation/admin-guide/kernel-parameters.txt |   20 
>  Documentation/cdrom/ide-cd.rst                  |  538 --------------
>  2 files changed, 558 deletions(-)
> 
Hi Randy,

Looks good to me, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
