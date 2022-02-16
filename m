Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D94B8DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiBPQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:20:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiBPQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:20:16 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B22AE289
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:20:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z4so2540286pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUEK1OPatjz/xS89rOiQIJkojmQppC70TLq4uXsnOCU=;
        b=awiYRJK7xVss9qUlz/+ZAsH80T6s71tCIdTOeiyrQ0x99UFr0wnuctr63kQIRgErZp
         Pjfqzv1BqeebYXL4GcrP/MyMzdMDlGQjvfr6bbW2B//BH8jrUYt1XEZHs+OKMGfIVuiv
         RJpsPjfFgg4A8/+DgzM1yTr8QymR2qoNgB2u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUEK1OPatjz/xS89rOiQIJkojmQppC70TLq4uXsnOCU=;
        b=NSGFVx+7kpAckNf9q5x1NGY7Ehs6dZgnmPB75pqkaeGwpk+fU4qz2ZHGHhPXDisEDU
         ziNhtIEaaeBduyoNvrvsjWDR4DJoaRxkrt1tD4TyhXvBhjiTefUHNRNYa0EqY9umsd4A
         G/T7e6y+QH9C7N3wiJw9wfr5vhnKBukQfhnL4nMQZL9AvjAi6BUwdLd3T2tLdLWy2FWb
         mbNCGIApQ8/MdF28Mrpha6T14hT7bAuye4t0GEWjF77uDa/FykVrkR8DFhJlPeMo7JP2
         EeKmJ0PGgB3wphas63B0I0WiIpqy5TcCs9o0WdWR+pQb47xjo5ctLlOLdv+aVTZ6QaTw
         zewQ==
X-Gm-Message-State: AOAM532RRLnKIKsDmfQmfnxraUqsCnGSNDPqGc5B6nMa8vSq5bP79zx+
        SJh6C4sXGfKV+0vDr+xkQ0eBuA==
X-Google-Smtp-Source: ABdhPJwkMae/H/K70R+Ctzw/galxZ1wgyt9T2ZBccthHmsi3muEDVk9x1KPlstE3Ys6++5ijnUTmdw==
X-Received: by 2002:a63:86:0:b0:36c:48e8:627e with SMTP id 128-20020a630086000000b0036c48e8627emr2940332pga.53.1645028403498;
        Wed, 16 Feb 2022 08:20:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4sm1535073pjq.2.2022.02.16.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:20:03 -0800 (PST)
Date:   Wed, 16 Feb 2022 08:20:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
Message-ID: <202202160818.7C3862B@keescook>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <202202150807.D584917D34@keescook>
 <87y22bm25y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y22bm25y.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:22:33PM +1100, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Feb 15, 2022 at 01:40:55PM +0100, Christophe Leroy wrote:
> >> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
> >> on those three architectures because LKDTM messes up function
> >> descriptors with functions.
> >> 
> >> This series does some cleanup in the three architectures and
> >> refactors function descriptors so that it can then easily use it
> >> in a generic way in LKDTM.
> >
> > Thanks for doing this! It looks good to me. :)
> 
> How should we merge this series, it's a bit all over the map.
> 
> I could put it in a topic branch?

That's fine by me -- I had assumed it'd go via the ppc tree. But if
you'd rather I take it as a topic branch I can do that too.

-- 
Kees Cook
