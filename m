Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89646573B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiGMQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGMQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB9183B6;
        Wed, 13 Jul 2022 09:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB8D06193B;
        Wed, 13 Jul 2022 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498E4C341C6;
        Wed, 13 Jul 2022 16:21:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l0DIH7fw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657729315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAW0ZSw1OlXVeHuT1rXQxx0CIa3pjnuyl8rUYru32Wk=;
        b=l0DIH7fwFzHtsZWskoI9YiZ0pVLt9yhFZIbwLLQ/6QuTZ5gcIVJu115WiUbPvH8ISlVMSO
        /twFsR8txdzVpL5PL8dhgHaxE2KzMIYZbBDXTRx2tLn9E7ZQYMMJn2evUiL1TW+auZuL8+
        /SQt1RfVov2FkEfJ6B7vIU1anZEggio=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d8dbd479 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 16:21:54 +0000 (UTC)
Date:   Wed, 13 Jul 2022 18:21:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@google.com, tytso@mit.edu, torvalds@linux-foundation.org
Subject: Re: [PATCH] random: cap jitter samples per bit to factor of HZ
Message-ID: <Ys7xHMIF6OLkLbvv@zx2c4.com>
References: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
 <20220713151115.1014188-1-Jason@zx2c4.com>
 <88d9e600-b687-7d09-53cb-727601612e21@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88d9e600-b687-7d09-53cb-727601612e21@arm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladmir,

On Wed, Jul 13, 2022 at 04:52:20PM +0100, Vladimir Murzin wrote:
> On 7/13/22 16:11, Jason A. Donenfeld wrote:
> > Vladimir - Can you let me know if this appears to fix the issue you're
> > seeing? -Jason
> 
> Works for me, thanks! :) 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks for testing. I'll push this out to Linus probably tomorrow.

(Though I noticed that Linus is in the CC for this thread already, and
he's been on a patch picking spree as of late, so in case he happens to
be following along, fell free to pick away. Otherwise I'll send a pull
not before long.)

Jason
