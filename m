Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34EB519DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348599AbiEDLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348593AbiEDLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:16:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92522528E;
        Wed,  4 May 2022 04:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B9CAB821D5;
        Wed,  4 May 2022 11:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5EAC385AE;
        Wed,  4 May 2022 11:13:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dWXyH6SD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651662792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXiaK4ictgTSjtvWOEUk+V6lbW8n+flqFYQG/qZp/tc=;
        b=dWXyH6SDho1vsZk6jp325598IoQxyDX5RdlrojDYWX33rV3qpguAY0xp8e49erwjIbm//7
        Noa6LXMvAeCBw28nTvaHBCczKc25blHIZKi/Grpmzf52tj13Z+Tfchj99QHzXPuHQOUbhJ
        rQX0IwJd4uuNLiogVYtxli/EBNVsyO0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1638d895 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 11:13:12 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id h10so1771010ybc.4;
        Wed, 04 May 2022 04:13:12 -0700 (PDT)
X-Gm-Message-State: AOAM531HNxE+twLkskJKdM/OH9H0kO5pQGxDJyB2paSJUqoLDBMco6Mm
        N0S7qYaNTXDB+1Jzc/Lr7K+76cR242HrEuWmIA4=
X-Google-Smtp-Source: ABdhPJwCBvpDxWGSWccxUCQ9Dcxzd+za7/HrhxllXzM3nsD8TEctq7GSKBM+TEdo8KJm1AuvrqSU4mLti6+HOafgrIk=
X-Received: by 2002:a25:420b:0:b0:648:4baf:c639 with SMTP id
 p11-20020a25420b000000b006484bafc639mr17860583yba.373.1651662791725; Wed, 04
 May 2022 04:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220503195141.683217-1-Jason@zx2c4.com> <YnGI4lZVJ/FZEkcn@owl.dominikbrodowski.net>
 <CAHmME9o1zhtq=bMetwEx7YEzoW79z36BQ=vTWEv4M_ocChm5eA@mail.gmail.com> <YnIQ9RJpP/3j5aWF@owl.dominikbrodowski.net>
In-Reply-To: <YnIQ9RJpP/3j5aWF@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 4 May 2022 13:13:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9pAHcXk+jyJDX27JfXbXRKtJmQuKH8aVbOo6d6N1RAakA@mail.gmail.com>
Message-ID: <CAHmME9pAHcXk+jyJDX27JfXbXRKtJmQuKH8aVbOo6d6N1RAakA@mail.gmail.com>
Subject: Re: [PATCH] random: mix hwgenerator randomness before sleeping
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

Hi Dominik,

Alright I'll drop this patch for now, and we can revisit it if we ever
get rid of the premature next stuff.

Jason
