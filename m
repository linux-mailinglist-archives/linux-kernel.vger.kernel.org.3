Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70274CDD47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiCDTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiCDTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:20:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0F6DEA1D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646421506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuolMha36fR3V9fCYUEsh1kVaVRuC07DhiUU/5Ph/4c=;
        b=HOwaHQUizKNciuTYM1ezrCBTZSreQC+ffmFBOc0bWKmnVaE3YciC2VyniEaPuVOI0ojGyT
        c9zR8TQc8EaELeWc+GXTf35SXRUnvk+qbyoA4+Bx7xPd+o+rwE8HgE5xSg68is+7+lUlgK
        1n8GFaYGnv5D32OfpgfbsdPpSYUCFzo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-o0J213NeMY6k0yTYe2pc_Q-1; Fri, 04 Mar 2022 14:18:25 -0500
X-MC-Unique: o0J213NeMY6k0yTYe2pc_Q-1
Received: by mail-qt1-f197.google.com with SMTP id a6-20020a05622a02c600b002dd2d38f153so6795167qtx.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuolMha36fR3V9fCYUEsh1kVaVRuC07DhiUU/5Ph/4c=;
        b=ZpuRiN1h+avOUR9SeUpHm4kLdkNpM6hrUKBTDKeTDMc5DRK/PiimsZ+MYY5mjAd/Om
         etu4mVQW5P/yC/QDPKZzVPbhSLH1seZVF3XhUzYOi4xS+CKBktvVKLjrrwDGOpWxzOsA
         2oXdplncua6ma/rg8Sf5FfMiuTVY/gFPzQOf8E/H5mx/ukFFEiTTwcJ1htg4lR+6NyCP
         i0eN4/eKYnp6dmEg2waOaXnLlz8zwgH5P7JFtXZZFim30s0Oh8qB15uYo/hCe3hhPZTw
         HNqjZ7YBJICDQqWsclKILMZkVGeaI5UZrV81Y8EAHn1CtVhj59YpncT6cFJsg2zXMe4i
         WngQ==
X-Gm-Message-State: AOAM5320LPvC4ruS+qtkhwsf4/b7G58tFyGQvo+RSuC5OS+5PA376Z1w
        zpXdRoUnNXSSVG5ned1rZJRFCTRWJ3swTZCwReYAwsF6rRrvZJQvuOEASdMnADexH8ImGa4+8r2
        rQSm5D9d9nNwqcS9lkn5THosN
X-Received: by 2002:a05:622a:11d0:b0:2de:7392:d6b1 with SMTP id n16-20020a05622a11d000b002de7392d6b1mr240408qtk.90.1646421505037;
        Fri, 04 Mar 2022 11:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNLAmehRR6XmhgaVQ3rTtRVaddT9X0qWmp4wbIsh03TTK384xvDr4Yx18KdBkl9NBZZAG23Q==
X-Received: by 2002:a05:622a:11d0:b0:2de:7392:d6b1 with SMTP id n16-20020a05622a11d000b002de7392d6b1mr240393qtk.90.1646421504807;
        Fri, 04 Mar 2022 11:18:24 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a223200b00476534e4fdbsm2708079qkh.95.2022.03.04.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 11:18:24 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:18:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] x86/bug: __WARN_FLAGS: prevent shadowing by renaming
 local variable f to __flags
Message-ID: <20220304191816.tyoowjqivxw4qo2j@treble>
References: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303110755.24147-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:07:55PM +0900, Vincent Mailhol wrote:
> This patch renames the variable from f to __flags (with two underscore
> prefixes as suggested in the Linux kernel coding style [1]) in order
> to prevent collisions.
> 
> [1] Linux kernel coding style, section 12) Macros, Enums and RTL,
> paragraph 5) namespace collisions when defining local variables in
> macros resembling functions
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

Looks good to me.

> 
> fixes: bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into
> _BUG_FLAGS() asm")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Fixes tag should be capitalized and in a single line, like:

Fixes: bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm")

Otherwise:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

