Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978A5ABD2A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiICFKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiICFKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:10:36 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C0F481FA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 22:10:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x80so3687204pgx.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 22:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yIQQnIRHZ7otgrjUvv6TWdYO7TYHo6foOISWsC2sgP4=;
        b=XgqmCKVxNvdUZqdAM2u2tJkOYfE9IK6qUtsHyIhkGWN1wL9Qe0KOuOAqCe0oMdd2+J
         b0IKH8R/vapBrkcOri0ASjwCPCCl5PNKwjRVqIZ4/8dmNT9IIn+IddY17Mui9T0q0ZgZ
         ITEs0fw1BVpr0RADUrPO5GBSYv2MSm0AmJmt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yIQQnIRHZ7otgrjUvv6TWdYO7TYHo6foOISWsC2sgP4=;
        b=mRnCuq3K+ha8wJ7UflQnCj3J2VWNeN/nOQgl1cNdxTzw8wfY7rloH9Te6yfjzcDcYo
         5oO+gZo1v9TiyrU4A+s0Ci+Yg7KdQMwXgMX6PGpeYnx4ZR3VxVwgT5p/1b8JKxWCDqX+
         KOwZjdckxyyjHCwhlW3aAISCLV3vA81IZUSgpRQ4daPZxuifAg0lqqzY1GJvhCi5WqhO
         R+sjwWqqr+qYfvNlyNv8+GKzwE8PQJwi4OhPPejTMxoy7iyub6mgst8HyuZk+66wPg6b
         /DQxYFiCuwPdshKPAqECVT774n643N8pIQcckJwHfRgNUKiC2grisDOtp6MSTdc/Tkmf
         tblA==
X-Gm-Message-State: ACgBeo1bCM7+YRbiYGU1bZzNVpSRjlohcKh20wGN114+2OYO1BoQpMom
        SZlvlxWdIvYU/U3FKku/71zieQ==
X-Google-Smtp-Source: AA6agR7g7BhQHjXWzii+ZGapa9J0ng7mZjMVRAhkXB39C4MnXU9spkFPJQKx2ogag/9LSabHZdOpcQ==
X-Received: by 2002:a63:5962:0:b0:430:41b4:ad2b with SMTP id j34-20020a635962000000b0043041b4ad2bmr12827552pgm.216.1662181832981;
        Fri, 02 Sep 2022 22:10:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b00172b42c1a02sm2615553ple.83.2022.09.02.22.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:10:32 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:10:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mm/memremap: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022210.37E37186@keescook>
References: <YxKO/jY1x0xTpl4r@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKO/jY1x0xTpl4r@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 12:17:18AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in struct dev_pagemap with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Also, this addresses multiple warnings reported when building
> with Clang-15 and -Wzero-length-array.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
