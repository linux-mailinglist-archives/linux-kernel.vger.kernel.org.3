Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6B508CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355489AbiDTQEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiDTQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56199BBB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650470474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VxVL4ghGZnPEC5vFwYZynA+vKk4w0NQswkaaYSL7cxQ=;
        b=C902XPpUTqZ/Jkw3iD2Bsp+sRrHNYhzF5IMokds9CBKXfbEsx3d2aRBAX0HWVsHxaV2fob
        TV6VLuy7jS+UyY18oexO9mj+8XRYMOjXMlddTTF3lHliVqog/j9PV8xyl1ow2Hx/2+LSN8
        ZPWoaLMDl+egu4Wz2rk6MxZcEuZu4DI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-GsIvt46tOyuTXo8zIXNtmg-1; Wed, 20 Apr 2022 12:01:12 -0400
X-MC-Unique: GsIvt46tOyuTXo8zIXNtmg-1
Received: by mail-qt1-f198.google.com with SMTP id fp30-20020a05622a509e00b002f33ea61111so1255088qtb.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxVL4ghGZnPEC5vFwYZynA+vKk4w0NQswkaaYSL7cxQ=;
        b=A87eRp+QG/oGW6XVCEeS77sK2M8erE/ykV0yAYat4EvivvWfglJQysqeBfxmw9lF7F
         FRwelxnnjw3lyipX4X4U3OHnoOiq3EZdOY65ULq48HKkATcj3nKviEH4mbX4Pjt892pG
         kNGYghBecMK27Rl2+tRn6DOf2/IxlfULetsWzzfBhIfOJEUNkCEDYiHN7spX2Ancneov
         3YbTcKM/+HHJYqZFrL/snMQa8oNpR/lURK0tH7RAqb//WuZJuZLuxKJjKDIlYFcMfWhh
         0P/Nj4Q3HTkYJNAZS7gRQtuImJ57o8UPWWt8VnKGpiwnCFNQgFVVUnpNeo/xRyLsDEdj
         YzGw==
X-Gm-Message-State: AOAM532ok4Zr24uDTn9YCa/dOOziyzwSlKT1kHxM04tybR6X9W/PbaE3
        NaiIxSfaErL6i4K6rw8yeG5Qkg6idXzk/rYx5ZPEYIqjidN/zbft1mKjK+gSvmpdD23dQBpSNQ5
        BgMLYk1Qw0ijh6eu7x0eYz/oc
X-Received: by 2002:ac8:7ee4:0:b0:2f1:e9e6:7200 with SMTP id r4-20020ac87ee4000000b002f1e9e67200mr14196181qtc.622.1650470472447;
        Wed, 20 Apr 2022 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF2P3YQNDtZZpjeFbYaPsXv2IV95hGJOjMeb5v5TrIYcOeNkobSHTZNVj7tGL0BajRL8LkFQ==
X-Received: by 2002:ac8:7ee4:0:b0:2f1:e9e6:7200 with SMTP id r4-20020ac87ee4000000b002f1e9e67200mr14196152qtc.622.1650470472217;
        Wed, 20 Apr 2022 09:01:12 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id t4-20020ae9df04000000b0069e9a6734dbsm1709186qkf.11.2022.04.20.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:01:11 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:01:08 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Simplify Retpoline thunk
Message-ID: <20220420160108.w3rxf3vhmgnnpplq@treble>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.280037046@infradead.org>
 <20220420152736.qzl3nikds6mq5nrr@treble>
 <20220420155116.GH2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420155116.GH2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 05:51:16PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 20, 2022 at 08:27:36AM -0700, Josh Poimboeuf wrote:
> > On Tue, Apr 19, 2022 at 10:41:10PM +0200, Peter Zijlstra wrote:
> > > Now that we rewrite all the indirect call sites, per commit:
> > > 
> > >   750850090081 ("x86/alternative: Implement .retpoline_sites support")
> > > 
> > > it doesn't make sense to have the retpoline thunks be an ALTERNATIVE_2
> > > that still includes a 'naked' indirect jump.
> > > 
> > > (this accidentally 'defunnels' i386 by going back to full retpolines)
> > 
> > So mitigations=off no longer works on i386?
> 
> Also true I suppose... does anybody care? /me runs like heck.
> 
> I'd hate to make all this more complicated just because i386 tho :/

Not that I care... but at least the commit log should own up to it :-)

-- 
Josh

