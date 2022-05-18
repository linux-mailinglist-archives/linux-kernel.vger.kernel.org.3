Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6552B79C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiERJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiERJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738750B39;
        Wed, 18 May 2022 02:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCF48B81EFA;
        Wed, 18 May 2022 09:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08E0C385A5;
        Wed, 18 May 2022 09:52:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TB8L6/pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652867550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=93ht0aSwSq1XsnJqlWLCiggaBy2vO5iv3PB2DpbWdjg=;
        b=TB8L6/pfZrCoYWr8Vf0898d00YKU0aWPVqsa7RyoULM3V056CrQv/JOar3711nzc4GRIsx
        GLK5UTNbdbEMamxM+xIRDUA0ZH/KpmZDmmyxH0tRTPjjcn3bN3AtBn3/fiXZU98wtbiCGN
        QcamfSkBYyVwtRBKYyjGS5Mv76VXAtY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca4e6724 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 09:52:29 +0000 (UTC)
Date:   Wed, 18 May 2022 11:52:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove mostly unused async readiness notifier
Message-ID: <YoTB2OlwQq4J4/2D@zx2c4.com>
References: <YoD7hn4yBHE0RYUa@zx2c4.com>
 <20220515131927.474097-1-Jason@zx2c4.com>
 <YoS0Pn9IotUrQh01@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoS0Pn9IotUrQh01@alley>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Wed, May 18, 2022 at 10:54:22AM +0200, Petr Mladek wrote:
> > +		spin_lock_irqsave(&filling, flags);
> 
> I thought more about this and there is a small risk of a deadlock
> when get_random_bytes() or queue_work() or NMI calls
> printk()/vsprintf() with %p here.
> 
> A simple solution would be to use trylock():
> 
> 		if (!spin_trylock_irqsave(&filling, flags))
> 			return -EDEADLK;
> 
> Could we do this change, please?
> 
> I do not mind if it will be done by re-spinning the original
> patch or another patch on top of it.

Interesting consideration. Sure, I'll do exactly that and send a v2.

Jason
