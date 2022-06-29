Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52855FBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiF2JTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiF2JTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:19:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9536B54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:19:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso9550224wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YC/LHOFu9z3TE53r3VhOCZbqb8mVfAzk25v1LWZ+ZqI=;
        b=Ed3hgWnUxXFI184u9opb9TjXY2T34eE81AbBniGXLVVcHymbxexa4jdBt/lXMF9Kkz
         FdUIWe7VfK4fPiDQVZBi+nA107B3LsrueCE+px7xbaU4/KmqAvz6zlFzpDmteH/JBoCV
         f0Fq/QLru2/cRpLwCoIq1P05VTwcCI+DT4wreP413sh7YNjbpABPjVzskPNc/5IZ6mBj
         VEHYnWm5hhwBjgfMRH53biJjU/ZiDX34DEVgtM6EKtMmmIoIeqKyLoJt0Yu9EWkB3D7Q
         +cZtw01FNAooe+AqUQo5FKPVRZz0P79O5WQq+JTJ/OQ2WZDPHX/9FRUzFBxHzhhpy7v4
         JKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YC/LHOFu9z3TE53r3VhOCZbqb8mVfAzk25v1LWZ+ZqI=;
        b=SBi42LMQV0CCjyPbgVTmqA3bhG6+u52Xoxvxi8hWMhXotCvxafb9QIEnIsqc9xCKF9
         8u3km3T4slBdncbL9n/SgBoNezzZcC4S6KinUxuCFb4IKBDG0HDiKP021LB2xKiuknfy
         APKX5QkjbLFPi0YhCMrkwJQynSXNprF87K5ZZF6K1+KKhn1riTPwOQhHlsxJaYf4xxcS
         GrXOAaO4gWdkBvVHn80rQ1tdVFolL9j1CNPTXKQjC3/mBxu6FkcbD9rQLTIA/sXFwX0G
         B94xaBrmlJm2RDhmYEcuu2K0j0Xy9/5dbAxrfNdWGdhVeZrdoSVGj8F4j1sADdSA0F5I
         CQtA==
X-Gm-Message-State: AJIora/ByNg8afjoh7POrG4VjBc4LlwJCbKh5ZkOHJYxklb/xVQ0Nc8E
        rE804yOB6nZog7m8+4v/IY7vvA==
X-Google-Smtp-Source: AGRyM1uPINxoFek608dfPS7Ua084BqSv6/lwLBKamjon+SCiL8Hvf8zdgsyn+vfL4ZDpJjRuBbE0ww==
X-Received: by 2002:a05:600c:3508:b0:39c:8240:5538 with SMTP id h8-20020a05600c350800b0039c82405538mr4557016wmq.165.1656494376065;
        Wed, 29 Jun 2022 02:19:36 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b0021a3dd1c5d5sm16004597wrr.96.2022.06.29.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:19:34 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:19:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
Message-ID: <YrwZJEFNBUJvmA6x@google.com>
References: <20220621034224.38995-1-samuel@sholland.org>
 <20220621034224.38995-3-samuel@sholland.org>
 <CACRpkdaxodnaJsKfFMvYHWtPwZyACiec4iX3ZXSBL5Ptfa6mRg@mail.gmail.com>
 <ffe66c81-9a2c-e2b3-ad9c-ad46824fe76e@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe66c81-9a2c-e2b3-ad9c-ad46824fe76e@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Samuel Holland wrote:

> On 6/28/22 9:03 AM, Linus Walleij wrote:
> > On Tue, Jun 21, 2022 at 5:42 AM Samuel Holland <samuel@sholland.org> wrote:
> > 
> >> These PMICs all contain a compatible GPIO controller.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > 
> > If I can get Lee's ACK on this patch I suppose I can apply patches
> > 1-3 to the pin control tree?
> 
> Looks like he already applied v1 of this patch (which was identical):
> 
> https://lore.kernel.org/lkml/YrnZof9lwsIQCqu7@google.com/

Right, you don't need this one Linus.

Please take the others.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
