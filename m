Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6149C4B8090
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiBPGBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:01:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344695AbiBPGA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 023A4114FE4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644991244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IVtJkDtiTB1hKGv+nXnAAOQ1ug5ffDsOB5NetPRTYrI=;
        b=OBUXTng6yCQiEr9eA3P+wwM3/INm97u5pLhTWF0BYxQtH/DK0b+myHECMSaQCTJ0Wm61yn
        hvC6GoKZBuweXqU/jM1U2AR2DNo/x7pef4PTjuDDgzaqdCcbjPjCjnw3f+IUdDy0fA/nPV
        8m560xSQzvIwTrZQICZgF6zjjItQT/8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-qJuA9c3jPJmxl9iFY_GXDw-1; Wed, 16 Feb 2022 01:00:43 -0500
X-MC-Unique: qJuA9c3jPJmxl9iFY_GXDw-1
Received: by mail-qt1-f198.google.com with SMTP id e13-20020ac85dcd000000b002dcecef260cso800005qtx.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVtJkDtiTB1hKGv+nXnAAOQ1ug5ffDsOB5NetPRTYrI=;
        b=V0fWzOrlwL+i6mg/wL7ovwBlHC4WMuDNrExZOLH0wHfziIDkzRnFIM4dxNpuccyvdU
         msV++65nOOGNPESK4HBd/Ex2+5NND60yNpvDD4FLe2uY7rMnaJffyoeB4nwlAo3cZIoN
         rPPgqjXGLnEdpzDccFUUHIn9Xvw1DyfJUyzpIHLGIHjuVMyM7/TvJVEpmGT1Q4iSl+dl
         gQK+zcZBtQqwAoSg+qIBh8Wyg8PsE6u+JJEyOwRfrGC8J0T/W79pdfObmWiLA3KXkPCX
         iZ2AbXdDXB0dSnmbNiiGxeybE6gHWd0JcPIzXoqYz9/qFbL44YKtYQ0FYXnUW1uKhCd+
         wY4g==
X-Gm-Message-State: AOAM532LzeWISpMXwtrJs3O5RGQjeBHMjqx7/5v2onXNQTHhzLeMXeSj
        vfUki2KuUJS8w9hPtdQBHyoXbbyoWOXNKCrBI86sSZXDBjTlIOePJwGwOZuHzaipWlzh+kSq5vJ
        wc3df5BTjIEDPPQ+qVja+rvog
X-Received: by 2002:a05:622a:44b:b0:2cf:4b06:5cfa with SMTP id o11-20020a05622a044b00b002cf4b065cfamr933677qtx.595.1644991242530;
        Tue, 15 Feb 2022 22:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzP20QF+Q5eFtyMeIFg2UCeRyv1GHv40qRujvMy8pTnMtYrubrkmL/yeqzjO/CN2P5nYzN+uw==
X-Received: by 2002:a05:622a:44b:b0:2cf:4b06:5cfa with SMTP id o11-20020a05622a044b00b002cf4b065cfamr933669qtx.595.1644991242291;
        Tue, 15 Feb 2022 22:00:42 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::e])
        by smtp.gmail.com with ESMTPSA id j15sm17160411qkp.88.2022.02.15.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 22:00:41 -0800 (PST)
Date:   Tue, 15 Feb 2022 22:00:38 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, ardb@kernel.org,
        bp@alien8.de, broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        ndesaulniers@google.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH v3 0/5] linkage: better symbol aliasing
Message-ID: <20220216060038.s2ymjrfghokzmwp4@treble>
References: <20220211151445.2027553-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211151445.2027553-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:14:40PM +0000, Mark Rutland wrote:
> This series aims to make symbol aliasing simpler and more consistent.
> The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> that e.g.
> 
>     SYM_FUNC_START(func)
>     SYM_FUNC_START_ALIAS(alias1)
>     SYM_FUNC_START_ALIAS(alias2)
>         ... asm insns ...
>     SYM_FUNC_END(func)
>     SYM_FUNC_END_ALIAS(alias1)
>     SYM_FUNC_END_ALIAS(alias2)
>     EXPORT_SYMBOL(alias1)
>     EXPORT_SYMBOL(alias2)
> 
> ... can become:
> 
>     SYM_FUNC_START(name)
>         ... asm insns ...
>     SYM_FUNC_END(name)
> 
>     SYM_FUNC_ALIAS(alias1, func)
>     EXPORT_SYMBOL(alias1)
> 
>     SYM_FUNC_ALIAS(alias2, func)
>     EXPORT_SYMBOL(alias2)
> 
> This avoids repetition and hopefully make it easier to ensure
> consistency (e.g. so each function has a single canonical name and
> associated metadata).

Nice!

Other than the minor comment to squash the synced header changes,

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

