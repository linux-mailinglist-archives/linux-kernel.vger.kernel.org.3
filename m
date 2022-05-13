Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85338525FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379370AbiEMKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379369AbiEMKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F8166440
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCEB6222B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85167C34100;
        Fri, 13 May 2022 10:21:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YEipm3ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652437295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9guTYSF77xdE/OjLFIshPpl9Sd/e3mIVmMDqCLm7Ek=;
        b=YEipm3ml98SQI3klpGvYMjmPPMkQVXuDq8oG4yImUqn1/kH4FS1urx9ZjevF2RZbu54vtn
        /9kZteamKXdmcnZVE6Yv4pucVMoSgTetaawjSRE/qCu0rSNIQcNzYciWneHCQCXydmKFu6
        KiTBdXfcwf+L3F4ACZPEr88Hwhmnrn0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34076031 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:21:35 +0000 (UTC)
Date:   Fri, 13 May 2022 12:21:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] random: move initialization out of reseeding hot path
Message-ID: <Yn4xLowv+farg814@zx2c4.com>
References: <20220509121409.529788-1-Jason@zx2c4.com>
 <20220509121409.529788-2-Jason@zx2c4.com>
 <Yn35k+yyrvgAt3tb@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn35k+yyrvgAt3tb@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

On Fri, May 13, 2022 at 08:24:19AM +0200, Dominik Brodowski wrote:
> > -	if (!crng_ready()) {
> > -		crng_init = CRNG_READY;
> > -		finalize_init = true;
> > -	}
> > +	crng_init = CRNG_READY;
> 
> Why unconditionally

To avoid a useless branch.


> (you revert that bit in the static branch patch and make
> it conditional again; so I see no reason for that here)?

With the static branch patch, I can totally remove the branch and the
store all together, so we get the best of both worlds.

Jason
