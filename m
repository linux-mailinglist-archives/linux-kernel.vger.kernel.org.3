Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087F4D90D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiCOAHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiCOAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:07:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECA40A2D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:05:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e186so34098520ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXWwMBem/Gvm7YvqdViBU1+FSzXxlHD18ChkWQuSLzc=;
        b=RBr9bZfefdG1+UXjqZGFiv+QI2dNG7CGF751rzo+2OezIEhtxBC35dbsq6UvTXmK9y
         nFNNbB059LQrNEhFOEuxSbPaxFElArnwBhHogrrqcraQUlkplYuVcsBFc/u7utJf2q7V
         C+kBepopEudIZI/ZkcNf+F493C1NXT/Q9zWyb/oa6kGmxgqk4m3sg+v9+4vCApdHfH5j
         wBZR/hue5TGwyiHNK3W3haUsNYkzw/pB6LrWJViCYTBbrw9MJ/0o7GGucBxLP6iB5/nh
         KpZw7GJS/Xvd0OYFbbF5ZazKJkAwt9hhw+rvSYykXhH/EJP3qZWrXS7Mhs+NuIoLWGf7
         eHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXWwMBem/Gvm7YvqdViBU1+FSzXxlHD18ChkWQuSLzc=;
        b=sR7S4ECmDTaLenqtypg8HtTcnRXtxU9IDron0UAFnaVJe1v2rKQ19jPW3Njut1gWWK
         SPniRZy3UgscRQw4o2zCrZSS3diuEmeiXvrKdSYddrOvZztXOgU+nqypBi+JiQX5wmwl
         TTdKnflEq72UAQCAuCpQ+lZfw5WPr8Z2CJlHKBQM+wrTlIand87YDWTCL21mNtLPPVIR
         IyWEDNbeMLwX6hPgxFPzXYmbUB0g6Up84wnokqPvoEFP9vQUtAT1i63GdZKMfdtHEf6n
         w2bOP5zf6wlouDAD8nKU7dcP4fuKnJ+E4yT2bO5gu57aLg/3SO4tBOX0fWexXBYiD+yZ
         coUQ==
X-Gm-Message-State: AOAM532W1HCWTEmjPMb92eS8cju6O3u5HhtL2jiunCg+s2691oUn1lhW
        cE7OhGH+bDJZ61Y6m88CGbPr83tK5Qyux4ak2MCSV8WCu5o=
X-Google-Smtp-Source: ABdhPJyR5vpsWnXi5kvauaWPs9qrHGxCwPVuxAK2hkOuMFqHCrBxMD8EraqUreYUyYNO+WHit+h3KEw8BUOGUAVFz/c=
X-Received: by 2002:a25:e710:0:b0:633:67d3:7264 with SMTP id
 e16-20020a25e710000000b0063367d37264mr3387585ybh.291.1647302758045; Mon, 14
 Mar 2022 17:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220216082020.981797-1-michael@walle.cc>
In-Reply-To: <20220216082020.981797-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:05:46 +0100
Message-ID: <CACRpkdaXACq6q0VE1bgqkCwKyVedvUpJw+80qnBGnJoX4+_FNg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: fix confops resource index
To:     Michael Walle <michael@walle.cc>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 16, 2022 at 9:20 AM Michael Walle <michael@walle.cc> wrote:

> Prior to commit ad96111e658a ("pinctrl: ocelot: combine get resource and
> ioremap into single call") the resource index was 1, now it is 0. But 0
> is the base region for the pinctrl block. Fix it.
> I noticed this because there was an error that the memory region was
> ioremapped twice.
>
> Fixes: ad96111e658a ("pinctrl: ocelot: combine get resource and ioremap into single call")
> Signed-off-by: Michael Walle <michael@walle.cc>

Patch applied!

Yours,
Linus Walleij
