Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF9953AB02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353383AbiFAQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356214AbiFAQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:23:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764DD3D4B1;
        Wed,  1 Jun 2022 09:23:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e11so2429638pfj.5;
        Wed, 01 Jun 2022 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXmcbpS90c6cPs5yYXuKNTVjXQN/kwuO3h1E2mahOJQ=;
        b=OIIziShah+SIqCYkZ2hpQ8ztiPri03CRgwsAgzGoGc+gCBV4WnTZanGCwO3ZAVwOkp
         iAnyq90+hw53VI5qPY2cnSSKWEWSSrtfNc6lUxPjLcLlRFKysQh1Fluo6hgqKfLmY/1P
         TIkH5+HLNH5t1cynBxuwQq+Tg0qvYLXw2/jEIrkOtjoWD91xo6tWLkS6yZIVrIKkSQKc
         l9ggoB1W4xvrn3wztxxMPH1SUf3HKSMa7YSNtZx/GLSa2prG1x6euAU1SYqaL+bpl72L
         w5rdbS4Lsyumr2J2WMUZknwQher3KfxIqauU7HbW/o7TXPTWVxLusThAPXFeNN/W99tu
         Z8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TXmcbpS90c6cPs5yYXuKNTVjXQN/kwuO3h1E2mahOJQ=;
        b=WraE6+BLDi06oQD63EmD//F478awz10R6kfIAdaA/C3DMNJlAPB1IvWbNeDtrnv2ac
         SriSAmJJlTrRKHFrZl5NSWh0UNbWREsEqCM9Up1vebJSjwpG7YG8jtr1hb0hURmD6nYb
         RSPEW4jYrVdu3dC6d/3AuInLXZc3Yk3UMYz6GlZua1eS4+mdEBC8q/8VTbmsxJVoZK9K
         Q40wEA+TKxg0RcC0zfcUF4BTwWKruL4cy06hPPNltCfNFOcrmFE0haOuk092kgwFnJIa
         8jBC7EByC4XY2Ixr/yJEfXaKXfEJji/jRYOy4ncxR3umExzF40XAz4NKGyXsaJEmpJpx
         +fvA==
X-Gm-Message-State: AOAM533xoaoyNUznaAZSXrfy4Z6a0x6F6YsIwShID0/LGorjwlPtKtnN
        h32vjeDN9zjX9jDs/gQdRjk=
X-Google-Smtp-Source: ABdhPJy5NaAJAwcdBWVbCBE+v8EFNGENmF1xslwE7g06Df/I2ptaJbXFWoeRD2wxbrsIkxUK+xDC6A==
X-Received: by 2002:a05:6a00:24c1:b0:518:c52f:f5 with SMTP id d1-20020a056a0024c100b00518c52f00f5mr347753pfv.15.1654100596743;
        Wed, 01 Jun 2022 09:23:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k7-20020aa79987000000b005104c6d7941sm1750753pfh.31.2022.06.01.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:23:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 06:23:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-iocost: only flush wait and indebt stat deltas
 when needed
Message-ID: <YpeSct3LJcBjnZ2x@slm.duckdns.org>
References: <20220601122007.1057-1-zhouchengming@bytedance.com>
 <20220601122007.1057-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601122007.1057-2-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:20:07PM +0800, Chengming Zhou wrote:
> We only need to flush wait and indebt stat deltas when the iocg
> is in these status.

Hey, so, I'm not seeing any actual benefits of the suggested patches and
none of them has actual justifications. For the time being, I'm gonna be
ignoring these patches.

Thanks.

-- 
tejun
