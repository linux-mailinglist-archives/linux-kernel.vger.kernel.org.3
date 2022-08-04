Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8758A352
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiHDWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiHDWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:37:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463B1CB38
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:37:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so1399909wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gD7k4L101xf65kVYpVp72EaTKRlJXNgHEKS9UB26QDY=;
        b=prhDln7XMn+JfGF45/ZO6FzvNAqVS5NjZpydPq6PuWKFy4y6UnvwQEFzs7L50T3/Lq
         O+6pNsmStP6XPYNCbMSavtYEWtPLwuoKrmN9pc5yiyjy6TO6ZSOkJJDdFKLtAzFI83gi
         gx5mTiB9YqeXK3/qDn6FrCU2wd3mQO5tcK+HDRmUT6tIQPXfF0+MZYhEzYfGy1jTMZmu
         vl5UxJDwtxxsJobkQGwqV206CHuJuzw30JdvanGqYdOAdyEpImTdm383Z3FLnkYzXt3k
         a7VLHPLXkcsjzIRjPfpJZE5sk/6pLa9aKq+VZzIO7GIzOLvZ0B5FbZh6ubNtW746qMUn
         0OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gD7k4L101xf65kVYpVp72EaTKRlJXNgHEKS9UB26QDY=;
        b=gRN3BF2YqCq5bOzwa57boEC+NSEPlyu6IhX1c8g8jOBtGB/neVUoJUXXkSvnP8bO6j
         kZo4756pNL1cqcRS3mDw1HCyhDMUgUmotjpgaN50hgSX0276lso40pabMrTYQaWRld4M
         S5u9Y0UkF+a+RiVSaFIU9wqnVilH4PvNGRCCXdFvm3048TIkTRvGppWRE3J9JdlXv0iT
         buG5TUNIr2Epe0af8jLiikFXCfD6sqXJInNQ1WhoUNc5Hp6EbreiYgOR1P38FUXvpOuW
         BrQTkNBmwEIY6zBTuFF/KxET53RE6jZW1R/W4zUOlCAjIEzbbOj2nEjpEvmWyBARXHdB
         Wcww==
X-Gm-Message-State: ACgBeo2n11fnAlDAUSnRkwdH2gr1vYDUBxid+FV5Pg4rhgimiELUHYdQ
        odBKAXj07Qcj8+uS6vr1Vk6Xag==
X-Google-Smtp-Source: AA6agR4/wIoyA0JmKzCTEH8SLXk3PsghmO4ipfU4t+y34q0gqF3vvxm+bXoI4zsPYd7zIQ3bQ7NG9g==
X-Received: by 2002:a05:6000:1b92:b0:220:7d86:2e30 with SMTP id r18-20020a0560001b9200b002207d862e30mr2647027wru.530.1659652632689;
        Thu, 04 Aug 2022 15:37:12 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c06d500b0039c5ab7167dsm6683458wmn.48.2022.08.04.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:37:12 -0700 (PDT)
Date:   Thu, 4 Aug 2022 23:37:10 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, straube.linux@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert rtw_p2p_enable to correct
 error code semantics
Message-ID: <YuxKFpcdqW7Sq1c/@equinox>
References: <20220802234408.930-1-phil@philpotter.co.uk>
 <99ee7f1d-62fa-a873-403a-445d8d8b096a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ee7f1d-62fa-a873-403a-445d8d8b096a@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:26:39PM +0200, Philipp Hortmann wrote:
> On 8/3/22 01:44, Phillip Potter wrote:
> > Convert the rtw_p2p_enable function to use correct error code semantics
> > rather than _SUCCESS/_FAIL, and also make sure we allow these to be
> > passed through properly in the one caller where we actually check the
> > code, rtw_wext_p2p_enable.
> > 
> > This change moves these functions to a clearer 'return 0;' style at the
> > end of the function, and in the case of errors now returns ret instead
> > of jumping to the end of the function, so that these can still be passed
> > through but without using a goto to jump to a single return statement at
> > the end which is less clear.
> > 
> > This change moves the driver slowly closer to using standard error code
> > semantics everywhere.
> > 
> > Signed-off-by: Phillip Potter<phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_p2p.c       | 19 ++++++++-----------
> >   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 12 +++++-------
> >   2 files changed, 13 insertions(+), 18 deletions(-)
> 
> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Thank you for testing Philipp :-)

Regards,
Phil
