Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83051EA36
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387418AbiEGVBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiEGVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:01:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A485140CD
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 13:57:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t6so14420979wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pkruImICg7e3tjML5xwbBGFokpJkvvtWVTJOxx0KeP8=;
        b=hHoRDQSs59A14mNuIJ0tpMx5XYAfacf7pmJxB4VDY8RAsw6tXHt8KNX1+dGH+k5ahQ
         Y3C3HyvkaLNeagDVWjuC57YmObdGQsewwJDHDBUgP9LoRY6oOk5ltBy3n1v/UgRaYxeX
         KNe+yh/JJ9FNyZ+t+hwXEbcW2Y03OZPP19V1Np7xGyzj8VAH0EoE24CU76tQ+PlmF0K+
         CAHXk7vv3umsYxTerxq2f5WbF0VEuTweOmFDHf5n4haSd9gF9OXPrA5DkrvdIw/DOuTK
         kN+zEmWjmgb5BJ6k8LtQkD1Xl3Wn74oBCQXlGF/PXO3YN/IkihHdwh9mC1dxk8g2MbU5
         Pg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pkruImICg7e3tjML5xwbBGFokpJkvvtWVTJOxx0KeP8=;
        b=yYEiLKdCg3+RpHw5eP+g7gXZNTiCMP2BoEH5g3Cj7sogLvzdTp/LPmo01FpFGPitQh
         VWg09tNvzgHrybPzsfPOYG5Qq+uRVqJjiVbWop4AB2W/nBY+e4vKrmAN5kOpGFf8k0gd
         pe8t4wBF+PCv8VPmj69zUhXva6zUVZsGIBaDTML5iAIuUwc2G3j5MShf2XMJmyBm5pmy
         JwBlQQTdGQ3xCN8bvIHBLXXICZsT/0E71+xMIX5YLbUOrbeJxfsZ+3IZF4/EmD3gClM4
         mlkg2oQcqpFdfTKsH5lreW13dIPeIZ761uxgT/3qGXefj7QPw6ZP0G0s88HjB2TrhWID
         WSSQ==
X-Gm-Message-State: AOAM5328ia3mQLA6u8yTbDLWmKgiz5qDvYuP2VjanirfTrOkMD/y4CQZ
        HYWKCEAsfn7tKPQ+ZLcn2S4vsYQX8jN3Gg==
X-Google-Smtp-Source: ABdhPJwmUZT+egQqIMCiMegHwPuR94XTQjtgAJc+0eiHPRKGR/GqOOr3wlkJ5Z4mOiQtj8GGWcXfDg==
X-Received: by 2002:adf:b35b:0:b0:20a:dd58:ef60 with SMTP id k27-20020adfb35b000000b0020add58ef60mr8018177wrd.647.1651957036045;
        Sat, 07 May 2022 13:57:16 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b0020ad05214d5sm6929538wrw.2.2022.05.07.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:57:15 -0700 (PDT)
Date:   Sat, 7 May 2022 21:57:13 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <YnbdKZiK+MGP6PnD@equinox>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
 <20220506202434.GJ12977@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506202434.GJ12977@windriver.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:24:34PM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 06/05/2022 (Fri 18:54) Phillip Potter wrote:
> 
> > On Fri, May 06, 2022 at 11:32:41AM -0400, Paul Gortmaker wrote:
> 
> [...]
> 
> > > Are you working off linux-next?  If not, what is your baseline and what
> > > are you running and what do you see?  For example, the commands below:
> > > 
> > > The ecb86 that I sent in this e-mail still applies on linux-next of
> > > today which contains Jens next as you can see:
> > > 
> > 
> > I was yes, the point I was trying to make (poorly) is that your patch
> > conflicts with Randy's patch which itself is not yet in linux-next, as
> > normally I send everything together at the start of the merge window to
> > Jens, as I don't have my own kernel.org tree yet, and usually I only get
> > one or two patches in a cycle anyway.
> > 
> > This is not your fault, you couldn't have been expected to know this in
> > retrospect, and I should probably look into getting my own tree/GPG key
> > sorted to alleviate this problem in future.
> > 
> > In the meantime, if you're comfortable with the idea, I can just resolve
> > the conflict myself when I send the patches onto Jens this time and
> > include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> 
> Sure, go ahead - just fix up things so all the last bits are gone; don't
> even worry about patch attribution; I don't care about that.
> 
> Paul.
> --
> 
> > 
> > Thanks,
> > Phil

Hi Paul,

Thanks, I want to make sure you are properly attributed though, as I
appreciate the effort you've gone to.

All the best,
Phil
