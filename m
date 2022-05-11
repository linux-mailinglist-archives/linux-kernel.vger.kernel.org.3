Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D365524104
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349292AbiEKXZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349243AbiEKXZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:25:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5920956D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:25:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 202so3055953pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ki49xHqa46J2jAs7ta/eJtZ8QS3SBu8XEWl7+OO2No=;
        b=FhScX8YR/t+vuAsu1redHAA4dDPOcMsoT3Bq+dzybnZ3agrhS1LJ82u+gJrbLnbC8A
         hrKKxi5iv3ybGmAYitDOps4nXz87M944fN4oMkhk1uFkNFlc6EYWAzxfJfrLwTCTuLes
         4rZNEMAUENDzVKr1twRJ/olrDDqwPfrLj0+3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ki49xHqa46J2jAs7ta/eJtZ8QS3SBu8XEWl7+OO2No=;
        b=3Oh+K+W3Fn2KWNAs9sAxRqaOSEdFdzuOIOagZWpBWRiygsUnEKRFf0561+1GEXsbd5
         U69ZP6dn+2pJe1QSAVC5RB4IPYnV8zGqKWU8n+Fy3Jh3eBEc72NGdi3QWwjbSVFCu2/s
         j/ZZZ+tS+/bQwySnzliq5nKXWyp9KERrWaB/P1T5nWwvqke8HyYAT0JMOyoJKTeaSZIl
         gE507D7x3FZ+zxmNEf7tf3k3pp8PVJ4h0+cccbo+PDzn2F9blLCaL7IgVzshKb/ge8eO
         2QNbKWrmPV9ujnYj6DW1eZYSLvAAN0cUdaxgJSa3E2dqxvqpPvAuuwJSuvpP86d8RY3A
         2OGg==
X-Gm-Message-State: AOAM532COuaF0jOJyaRvgOtAFQPXfKFp79h8t2UTyjTzsl6PDPh6OAwP
        dBZwtj+J02f/DyB2VbdIsY+MWA==
X-Google-Smtp-Source: ABdhPJzMcvdao9wgCqtHsLuaqbFD5VrRt/A5zEaBjVmcMJGr1jzZWaoQvr9OGs1D6j+yLudNM/YImA==
X-Received: by 2002:a63:d408:0:b0:3c6:e382:c157 with SMTP id a8-20020a63d408000000b003c6e382c157mr10022534pgh.470.1652311512304;
        Wed, 11 May 2022 16:25:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11-20020a63370b000000b003c14af5061esm407098pga.54.2022.05.11.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:25:11 -0700 (PDT)
Date:   Wed, 11 May 2022 16:25:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Du Cheng <ducheng2@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] niu: Silence randstruct warnings
Message-ID: <202205111624.60295F3A2@keescook>
References: <20220510205729.3574400-1-keescook@chromium.org>
 <20220511151647.7290adbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511151647.7290adbe@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:16:47PM -0700, Jakub Kicinski wrote:
> On Tue, 10 May 2022 13:57:29 -0700 Kees Cook wrote:
> > Clang randstruct gets upset when it sees struct addresspace (which is
> > randomized) being assigned to a struct page (which is not randomized):
> > 
> > drivers/net/ethernet/sun/niu.c:3385:12: error: casting from randomized structure pointer type 'struct address_space *' to 'struct page *'
> >                         *link = (struct page *) page->mapping;
> >                                 ^
> > 
> > It looks like niu.c is looking for an in-line place to chain its allocated
> > pages together and is overloading the "mapping" member, as it is unused.
> > This is very non-standard, and is expected to be cleaned up in the
> > future[1], but there is no "correct" way to handle it today.
> > 
> > No meaningful machine code changes result after this change, and source
> > readability is improved.
> > 
> > Drop the randstruct exception now that there is no "confusing" cross-type
> > assignment.
> > 
> > [1] https://lore.kernel.org/lkml/YnqgjVoMDu5v9PNG@casper.infradead.org/
> > 
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I presume you prefer to take this one via your tree too, so:

Yeah, that's easiest for the exception removals.

> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

-- 
Kees Cook
