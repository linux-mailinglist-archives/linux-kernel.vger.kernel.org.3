Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72360567FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiGFHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGFHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:25:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002062251C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:25:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cl1so20686955wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RNGv+/8XLL3pLmqx9QBeEgEnepJuAQVAPCFO8Yi+Cro=;
        b=3mUI2v7SV28d9VmjYj0Fyg+1wNOzEcpQ4VMVHukiS0/GQw88kM3nJjZIj9oUc5CyOn
         HWcWTODnZgR+0wizfsFWughub1yC23i2CW45v0j3SfQ6zbxNdXA8w2tH0HZO1N5WWZah
         9l6I3qFan41NyCXQCm14R222BXC4hhrZWPm5nFJfGfc6eKig5tAO1KCC1MsEvu1oJO56
         ArveHYEYcNb5z55A57UdWFcrxHRuCxGREVvxJZ2XM2ZrBPzy2YGruospChNnGUgoleU1
         b1QGJDfEz9UYeOIri0rx7Nqk+wtupPIUNQYC3rxhUem/IABM7T9tuf5TB0uUF0jZB69F
         o/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RNGv+/8XLL3pLmqx9QBeEgEnepJuAQVAPCFO8Yi+Cro=;
        b=3immzu3a3KdPJXhDcPmn+PErloHRDCfpebFcIXCTcETQpOiUyFvoIS4nyiyHReZ0T2
         gPSMi5aHtAqmXWrh6n9go1I0nnqAaOomQX3gYOrzpRnzSKc0W9I8Sghc6SWmwva4ckhG
         UW2FFA8ZnjOqt81QfAAQgVFd1Pf4HEVxvQzqNHoHACpnSBqF/QOwoCpeKDLLn/+kh64O
         UZqxMeMDgxZph8fLEXXux0lH4lofk0+Kp/EaO8ahjWXPVFcXAn+pF75dFJXl3hnPouql
         lW7zEPth6y8rS9s9KxG2VMTeJIlZVQ0bdYfIRzObltnEYr+aSDabkkyOlsRGnaSxmUdL
         LNeQ==
X-Gm-Message-State: AJIora9ebQ3dUr3JG9TraflA5hfKdbb6ajIXPymu3cJR+EA8fXGkSq6U
        fSl10xyAcQrn/IZWDevEP7zosA==
X-Google-Smtp-Source: AGRyM1sjjoD72QqN/kPda1ll5BXRtL8M7g0zel6AU2vN3d7fDNT6a5wzNwnXMciWvstWpJaNyTIO/g==
X-Received: by 2002:a5d:468a:0:b0:21d:6dc8:9e60 with SMTP id u10-20020a5d468a000000b0021d6dc89e60mr11671635wrq.595.1657092355613;
        Wed, 06 Jul 2022 00:25:55 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id a1-20020a05600c348100b003a03be22f9fsm20272887wmq.18.2022.07.06.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 00:25:55 -0700 (PDT)
Date:   Wed, 6 Jul 2022 09:25:50 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, herbert@gondor.apana.org.au,
        heiko@sntech.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <YsU4/qrnxG8yjFwC@Red>
References: <20220701132735.1594822-1-clabbe@baylibre.com>
 <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk>
 <YsP0eekTthD4jWGV@Red>
 <20220705164213.GA14484@lst.de>
 <YsR7O4q4IRI14Wkc@Red>
 <20220705175834.GA15815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705175834.GA15815@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jul 05, 2022 at 07:58:34PM +0200, Christoph Hellwig a écrit :
> On Tue, Jul 05, 2022 at 07:56:11PM +0200, LABBE Corentin wrote:
> > My problem is that a dma_sync on the data buffer corrupt the poison buffer as collateral dommage.
> > Probably because the sync operate on a larger region than the requested dma_sync length.
> > So I try to flush poison data in the cryptoAPI.
> 
> Data structures that are DMAed to must be aligned to
> the value returned by dma_get_cache_alignment(), as non-coherent DMA
> by definition can disturb the data inside that boundary.  That is not
> a bug but fundamentally part of how DMA works when the device attachment
> is not cache coherent.

I am sorry but I dont see how this can help my problem.
