Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0FC58AFC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiHESec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHESe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:34:29 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650A7AC25
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:34:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ct13so2314138qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+Fshx35gKDbhEKNA9+vyw6D6TRNrCJyr6eaykLEZRdc=;
        b=FJaZ6poKkiXH7Up/SOBvgoAB2hRHOPNTHRX8SYhdRLvAHkofQItlr14p5WTHsfy6gy
         Cr2JqeWzm0bls1wmYMFNJCCFJkmPt3DX3ewEjq3BEwR17NjKwoZ+vE9AH5XXE4++fXp/
         hwHD3NUrZNuV+to2V9kKDcxS3S2SrDqemiY6X72EHbzsVrriJX8UhlXG46d4p2E4DuSj
         9h2+k1KSV9h2zaDRwWS4rQXTNsVbe0afwo1lFplzyBJtrQgQQzB833IDoXx3EW1x/AON
         xI2l7rp7YDeq2ViHGwrbtI1HdQyxQd5vg4UAXfAfFrOLjfJp2Zz3/grzwZcCr1til7l/
         DtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+Fshx35gKDbhEKNA9+vyw6D6TRNrCJyr6eaykLEZRdc=;
        b=wsyiJxqO5aw5AFL7MfDpcAvIUW4tJOjEMlJry9lKWhFttqwQ+0L87XzLI1Bn7ktNxI
         /NlemrrJ85e6UkQpiw6wK2Bs5zzRbnmISI+v7B3H2olLPUQVNnXdlzoPXg/CP2Xf5sEQ
         uq2Ex7VRwebmd4R4qHY1WHknYcu7Q7XnS4bDg8zrETgsQxmno9BHTD6+ll3IgxL4zWtD
         o/qawBqzJan3thNfP7PFJaBBBmjxMwRp4SnqwLlSvBr9+FOAWyGnScR81eSTncJ//tWl
         2o2q+dM1j7eYNdrPD24pGumUCdJNjhCP7NCbaX/hROasKVxXE/dpsrBX/uk/o7ep8Ueu
         c8Ng==
X-Gm-Message-State: ACgBeo0k1WmMF0JIdn3T/0tp/rL5BQoK33qNas4zYM71H3VazbSHHD4Y
        3MdPo+maDmOOKwtQca5X9mn/HOIZTDExaqjU
X-Google-Smtp-Source: AA6agR5oikHWzJxCVHLFj/2YT5KkHid1ufzGBJQk9RswK2SSF9EUN8qWAf4S7gJjdD6Q90iwkEX9ig==
X-Received: by 2002:a0c:b39d:0:b0:473:9292:d4ec with SMTP id t29-20020a0cb39d000000b004739292d4ecmr6875240qve.66.1659724467955;
        Fri, 05 Aug 2022 11:34:27 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006a65c58db99sm3555519qko.64.2022.08.05.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:34:27 -0700 (PDT)
Date:   Fri, 5 Aug 2022 18:34:27 +0000
From:   Sean Paul <sean@poorly.run>
To:     Jim Shargo <jshargo@chromium.org>
Cc:     jshargo@google.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/vkms: Support multiple objects (crtcs, etc.) per
 card
Message-ID: <Yu1is1ZNl9RSwAHQ@art_vandelay>
References: <20220722213214.1377835-1-jshargo@chromium.org>
 <20220722213214.1377835-4-jshargo@chromium.org>
 <Yu1g/PLuU559SIm7@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1g/PLuU559SIm7@art_vandelay>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:27:08PM +0000, Sean Paul wrote:
> On Fri, Jul 22, 2022 at 05:32:10PM -0400, Jim Shargo wrote:
> > This is a small refactor to make ConfigFS support easier.
> > 
> > We now store the vkms_device statically, and maintain a list of
> > "cards", each representing a different virtual DRM driver.
> > 
> > We also make it clear when a card is "default", that is created at
> > initialization, and not. This is because, due to limitations on what we
> > can do with the configfs API, the default card won't be reflected in
> > configfs and is initialized in a unique way.
> > 
> > Since we're only managing a single card, this should be a no-op.
> > 
> > Signed-off-by: Jim Shargo <jshargo@chromium.org>

/snip

What a mess, I replied to the wrong patch. The review here is targeting PATCH
2/5 despite the title and reply-to.
