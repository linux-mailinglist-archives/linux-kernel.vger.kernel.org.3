Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F956760C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiGER4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGER4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:56:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995D13FAE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:56:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so7696892wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tp/mgAHgccbgU9bAMXiScmyIvCd30+VQEBf2GurCHPE=;
        b=NeORGT0pgGebZrwkVHkg52nMivvW56/r+8xwY4nE1j8QhfggCmqERHDAraqqq+NLFM
         n6YnGISqsnPnQANEOGT7V2+jFi9ulS90HZXHFBbS/5BtQNlXKPVEhgOtcjrbXa8u6pe6
         oxwLl2M82Dq+bEO5FQLaEHpIy7jgJqXQ/rlOXF1lSrgTqTqYnoRJITYuCBEau5LzWIQN
         3/ivFSZ5Q8gKsJ6HCsJaa/2yblKxLkkc6C5XhM7Tviz8k+/OG+xXZhd1KFgCMeZygEnr
         /wPJJQzQ+uSw9pUnOOvymkP4+dzQbAEUvVBHm1wl8dzTiF2g9Rvje+eASF609tmnGilD
         8NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tp/mgAHgccbgU9bAMXiScmyIvCd30+VQEBf2GurCHPE=;
        b=iflJiHwGx5CXFh9XFxHsIQrvg8rUZoKC6RrpTV/1969tuuxOhBMJEz/mFIuAWZNhP5
         9wyZ9OdNdwTGZTgupWlL5UWCdhQhMnROuABqvkn6K7PSDi3PhoS/g0JzwvRfp6VRPk5S
         /j4OwSH+JWN6fdzEHdTjVCVSLExdqucy9ceONL1FgvEp264HyQRHZEHjqePg6KsFFgec
         P+f4FQuNso/pjssYaN99PJaOu0X0mfOd1PzCQgtDfWIH9XYsSZSg+DP4tIANEv6NZNKe
         l7UzmivM7YlXxOLEppg16GateZRJsjoiDQm5nWgDWOjA5eIo/39UWJnHvas97D2EQHB/
         aChA==
X-Gm-Message-State: AJIora8zKZOlCYIz+IITw8jGTmE/2pubL8HPa7NwXVLradca7gmW5KDi
        A/Y6veMo81UE5pk9EdXLVqydyw==
X-Google-Smtp-Source: AGRyM1uaAaJsZIYUzoR96B0uDURnDI9gE4pPU/7G92tNYU6lhXMVPWEr4PbPEUYqRzy2za9/VYhVcw==
X-Received: by 2002:a05:600c:600d:b0:3a1:9712:5d31 with SMTP id az13-20020a05600c600d00b003a197125d31mr18969023wmb.67.1657043777275;
        Tue, 05 Jul 2022 10:56:17 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id r12-20020a05600c35cc00b003a04e900552sm22921126wmq.1.2022.07.05.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 10:56:16 -0700 (PDT)
Date:   Tue, 5 Jul 2022 19:56:11 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, herbert@gondor.apana.org.au,
        heiko@sntech.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <YsR7O4q4IRI14Wkc@Red>
References: <20220701132735.1594822-1-clabbe@baylibre.com>
 <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk>
 <YsP0eekTthD4jWGV@Red>
 <20220705164213.GA14484@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705164213.GA14484@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jul 05, 2022 at 06:42:13PM +0200, Christoph Hellwig a écrit :
> On Tue, Jul 05, 2022 at 10:21:13AM +0200, LABBE Corentin wrote:
> > 
> > I just copied what did drivers/crypto/xilinx/zynqmp-sha.c.
> > I tried to do flush_dcache_range() but it seems to not be implemented on riscV.
> 
> That driver is broken and should no have been merged in that form.
> 
> > And flush_dcache_page(virt_to_page(addr), len) produce a kernel panic.
> 
> And that's good so.  Drivers have no business doing their own cache
> flushing.  That is the job of the dma-mapping implementation, so I'd
> suggest to look for problems there.

I am sorry but this code is not in driver but in crypto API code.

It seems that I didnt explain well the problem.

The crypto API run a number of crypto operations against every driver that register crypto algos.
For each buffer given to the tested driver, crypto API setup a poison buffer contigous to this buffer.
The goal is to detect if driver do bad thing outside of buffer it got.

So the tested driver dont know existence of this poison buffer and so cannot not handle it.

My problem is that a dma_sync on the data buffer corrupt the poison buffer as collateral dommage.
Probably because the sync operate on a larger region than the requested dma_sync length.
So I try to flush poison data in the cryptoAPI.

Any hint on how to do it properly is welcome.
