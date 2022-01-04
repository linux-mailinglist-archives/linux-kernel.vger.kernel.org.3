Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D44848CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiADTtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiADTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:49:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A841C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Xt8XKfsUO3oqWyKUpvE4fUY2NxxfQmItdYwYbgqL7Q4=;
        t=1641325751; x=1642535351; b=of3Ms5z9NAMeeG38c2+eIRZCAqYXbyWdB0c0CrjtaPm7kzP
        HVRm+puzgAURhCG0woTq+8o0C1HFGcGfcHsgFxQXbq9jfoiqKGwadaIZXWhdmBvhcFvxShc6xQ8Lk
        ytcVGW6Hq024OS9F1sLxTeCkdwOV2kcsfUVvilwYGBjccRXdGLZcMUiHKFqpucEggyq+kIE+sHwpc
        3c4tY8fUPU5VWfyPaWhjukRUHczFrqYHEvR5Ju2tRu0Lqi4FyopdnWY94jUofoNObS9iNGnoX0g43
        aEP8gE2zLsIkS/Cx7qSFDJtAj2hkeGpJuY/2Iz3VhvAQ/lBmKX8nAQiJQmj/Osag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4pnu-001rmy-Oq;
        Tue, 04 Jan 2022 20:49:06 +0100
Message-ID: <41fe09354fc736fb1ff2cb429e035633f24176ce.camel@sipsolutions.net>
Subject: Re: Occasional hung with UM after enable VMAP_STACK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Walter Lozano <walter.lozano@collabora.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
Date:   Tue, 04 Jan 2022 20:49:05 +0100
In-Reply-To: <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
         <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
         <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 16:26 -0300, Walter Lozano wrote:
> 
> Thank you for your quick response. The Debian configuration on package 
> user-mode-linux have these settings
> 
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y

OK, so it actually _is_ enabled.

> as you can see in [1]. I did run some tests disabling those settings, 
> which passed without any hung.
> 
> Unfortunately the "occasional" behavior makes this issue a bit tricky to 
> debug.
> 

Right.

Hm. I've been running our tests with it for about three months and
haven't observed any hangs, but I guess that doesn't mean much.

To be honest, I have no particular reason to even want it, other than
that it catches accidental DMA from stack more easily ... so I guess if
we can't find anything, we might as well revert it.

Feels like it _should_ work though, since it's just a different location
for the stack.

johannes
