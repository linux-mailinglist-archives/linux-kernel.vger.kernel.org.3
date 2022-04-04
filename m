Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F74F1E76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350950AbiDDV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378970AbiDDQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9580D2F007
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E551B816F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04BC34110
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:11:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UiBloJww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649088667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJXEF3IT+pXVPI757TmAQZ63PIEB107aaHAXmSZApdA=;
        b=UiBloJwwzBVApHwYa+P/BIi+LDxEXw/bj00uKat7KRCe04nnT9lq14rta88deTd9vjqCTY
        8kuQFBUDCwXhWgE6+fDyV17DpPsMqb+7vT9WeCQVjdDXa5/UG+k+KR9isAoCv28gprsQHe
        3ONTdVtTN12e0NzluZAX4brsELyQY3c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 688b90e3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 4 Apr 2022 16:11:07 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e5e31c34bfso104906177b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:11:07 -0700 (PDT)
X-Gm-Message-State: AOAM530JoDWq+cbLB4c7NdwZqA8c6hiZeuoVwrMelGhQGbo2/6/a+LHw
        PukhvOUmgt2zEjviegWlQ3FBKo28J3qDU3BdDwo=
X-Google-Smtp-Source: ABdhPJys4bTOGYhdA6Lwe2omy+aFz3OCJNZLCiqERsWITDHI+UjOx5nuE5bWDEn0Xu/ktUuKRhXjedzl2MbVG/YQbDM=
X-Received: by 2002:a81:1d4:0:b0:2eb:1b10:f43e with SMTP id
 203-20020a8101d4000000b002eb1b10f43emr690974ywb.100.1649088666148; Mon, 04
 Apr 2022 09:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220404150442.934496-1-jan.varho@gmail.com> <YksMxDLxPZtuYlFm@zx2c4.com>
 <CAE2X=SxCwoKa1OpNAsy5FN1Ugeos3gaM4YX4K4uTWfkKBEr0pA@mail.gmail.com>
In-Reply-To: <CAE2X=SxCwoKa1OpNAsy5FN1Ugeos3gaM4YX4K4uTWfkKBEr0pA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 4 Apr 2022 18:10:55 +0200
X-Gmail-Original-Message-ID: <CAHmME9rKFfv+=Yvu2HZEjLZs1MPLrkHQTA1iLikVf2dxC998YQ@mail.gmail.com>
Message-ID: <CAHmME9rKFfv+=Yvu2HZEjLZs1MPLrkHQTA1iLikVf2dxC998YQ@mail.gmail.com>
Subject: Re: [PATCH] random: fix add_hwgenerator_randomness entropy accounting
To:     Jan Varho <jan.varho@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Jan,

On Mon, Apr 4, 2022 at 5:29 PM Jan Varho <jan.varho@gmail.com> wrote:
> I thought about doing it that way, but the return value allows
> checking that any input was actually used instead of fast init
> completing in the mean time.

I'm not too worried about races here. If lots of things are fighting
to inject entropy here, we're not in a starved situation. Also, the
other callers aren't looking at the return value. Let's keep it
simple; there's little harm in doing so in this instance.

Jason
