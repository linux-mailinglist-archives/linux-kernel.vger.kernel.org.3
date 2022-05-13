Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C24526C51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384670AbiEMV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384666AbiEMV1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:27:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6A12772
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:27:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j84so6578357ybc.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5AthED04DvJKPgqpu7aFbZJ2so3QAiqmWJHWR8vFaU=;
        b=SNOrvzyPthgcBhIMLJS++HW5z0GuyJwLjXKA2K73VDB2hRg8mgC5kpEFN2SCEnd1Df
         4ong9e7mtL3QvvmbZfeYOkfP7zjFdGiXsDr8pNUVP8ruCyC0GAvvABFcM/flbrIfwkmJ
         +SU9AJVBfzn832ahOfi/isu4j3EiNvZMPjijck2vsQyf7wrqX4L1mHp+CReHtG9LdfsW
         Fw/44ZL4wpHMDWrxPNcstCK0H8jSytBPUykESvjqyxxNONcdqivkWlJKJP2SOmOtoysg
         bjgTmKZKsW/9Moq5W7iicISLpsdgVHTKlIlpaPIzzSAUSTMtwu0+giE5bOrsFTZsuOlm
         4AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5AthED04DvJKPgqpu7aFbZJ2so3QAiqmWJHWR8vFaU=;
        b=rA9DbLe8z2dhosvoqX4+fjlMhNxg2LFwT38Ke6NOFKQyQb9+fbYydN+E1myLD8rcQS
         eER+JqXDVwxGLcevmASBMXwVyWSlzQZJdrYOvWO+gx3ntWVCFgtLdF3K3tAK02eKzD0n
         OR/7cV1XusW2yPto9HhFydGbp1ksyUEHY428XJJ4+uykb4VBkrqdwN/rx2ohgZJ/mqVk
         okv1mn7ZNkeep+6aJ9iJeggN34qpYLvIhWBHykf1fokZGYXkpL/kxiFG3Xbp7YciWfyi
         wyVKIWzBfuqfaThDsZ1InmGaoete+P/gOAg7qb1mVki/QGJPh7c7OHtqu3kBb8HUWE1l
         fyKA==
X-Gm-Message-State: AOAM531oBp7aIRSm2zXK6ODcsR5FctjWuw7dRhqoywTvpZLor/2U/p8P
        HlKKI5QlSnu8gLXqhBftuulx84Mj33hBacRmH49Ufw==
X-Google-Smtp-Source: ABdhPJw+o49OaFd2ww+QOMWIlJs0P4szqp/cOcXcZhsilvmGlEbkOYSY3aBHnBUbtfc19fSqMxxlocvLPmva7WBZNes=
X-Received: by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr3984163ybf.514.1652477238724; Fri, 13
 May 2022 14:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220513075554.127677-1-wanjiabing@vivo.com>
In-Reply-To: <20220513075554.127677-1-wanjiabing@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 23:27:07 +0200
Message-ID: <CACRpkdaLArmZc5Zwi-2r3kvBgWHDJ6tbY5o-=qLAG=8B70Hfag@mail.gmail.com>
Subject: Re: [PATCH] ata: Remove unneeded ERROR check before clk_disable_unprepare
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:56 AM Wan Jiabing <wanjiabing@vivo.com> wrote:

> ERROR check is already in clk_disable() and clk_unprepare() by using
> IS_ERR_OR_NULL. Remove unneeded ERROR check for ftide->pclk here.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
