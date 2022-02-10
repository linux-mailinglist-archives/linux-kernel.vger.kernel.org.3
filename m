Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ACF4B0E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiBJNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:08:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbiBJNIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:08:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0E100C;
        Thu, 10 Feb 2022 05:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85D7EB8253B;
        Thu, 10 Feb 2022 13:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A5C004E1;
        Thu, 10 Feb 2022 13:08:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RJoxP0PP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644498486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bkaw0l3Ywep/OB57H4YCme/aIlYJcfsB7nVqGUEOgiI=;
        b=RJoxP0PPmm/m6DG9yiZhyP4Eh/6pb7XuA3ktb2pXp/H4g8+Ln/YydrLApT1dZtxrv3hUp6
        AouOjIVrFITLCpVqdB0oEV0duBs5UFAln3QjHRkIhuP9CwER4bl6aBAVB4n9/e8YONoUj5
        4QV1lI+ua/X0SdgDM5CHdJrMiKXpdmo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 510bfb41 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 13:08:06 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id 192so15104497ybd.10;
        Thu, 10 Feb 2022 05:08:06 -0800 (PST)
X-Gm-Message-State: AOAM533DY8pobG6cVvIAvSFnIkuEZ7onu21W63diWPEgok/QxFKTscJ9
        JE2lQRJ5xPQgJcAqkLVsDdhBgNRnIYFTLqsjjsg=
X-Google-Smtp-Source: ABdhPJz4Ks7mDkABlaZrmo/gd+Wnl8zGCt7KD+1b6opcrWmfO2dRwHCdTmFrL4oxjQGz+IU6NT9sDv3EAZphGY6MBh4=
X-Received: by 2002:a81:c646:: with SMTP id q6mr6959997ywj.485.1644498485708;
 Thu, 10 Feb 2022 05:08:05 -0800 (PST)
MIME-Version: 1.0
References: <YgQOgqWr0nwqZCh6@owl.dominikbrodowski.net> <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
 <YgSmDtA2hlrDBmrH@owl.dominikbrodowski.net>
In-Reply-To: <YgSmDtA2hlrDBmrH@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 14:07:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9q-BAsOwfTKH4bqvnrJww_L-Y_owZP7-yzDcxGt9zEd5Q@mail.gmail.com>
Message-ID: <CAHmME9q-BAsOwfTKH4bqvnrJww_L-Y_owZP7-yzDcxGt9zEd5Q@mail.gmail.com>
Subject: Re: [PATCH] random: fix locking for crng_init in crng_reseed()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Thanks, I see your point. I'll do it the way you suggested (which as
you pointed out goes away anyway right after).

Jason
