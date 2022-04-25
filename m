Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13A50E1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbiDYNg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiDYNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:36:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FE1135
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:19 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f38so27061000ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnGDk2mXj8ducKZ6TjV0CCxMODc0uQNA4u/k6GAYohE=;
        b=Ru6CMFDL+759FDN0Z+W8VThj6ZOWjiqunT3Ldu7hr9+T/EwHJ2ill2Bu8QHwYvuSAJ
         7dKDDU5+92cjc7riK3wLgypUn1DzhEiOL9atp+b4uHycuIbPimmCeKShAzX3/lEkWClR
         Dw2NBC/VWTnBFQz+EwaDuGAPMCRx5eDKSvbaXRIiTCMVvdOcx71g4s8y03U9A5Yqfk9a
         x5hIjscu80Kro5O/30lo0/Sc7GCIThTycK8Ke4jCFwjwWctzEXd4/X3ORRR8i9V61+nl
         ueObE4uewQRN9FEHR07RR5YAM4Y118mzN8MbKAPq/riqju6hAdF621UPSpiO9WZo8tWU
         VXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnGDk2mXj8ducKZ6TjV0CCxMODc0uQNA4u/k6GAYohE=;
        b=E95C2rFsiNNjvEkQ7tkFSgoV6h6hhBAGq8FEatsDtt/G67XrF7hcDpzTVJpEnRwEGF
         vr2kHI+tLKETAwxZ3eMKtty3RMz5KirmfeJFxzio1RX0p3ZjGGNQBr6II79Mngv9eNN5
         zRaFHo9Y8jeYR7hGYnncSI1HmX6iohvEtrTlZlIFk6vrT4EsPaKgPtE/x8A8+I11YY6b
         1hyJC9lEscOK48ksXAfbijZAz7T1EviNTWb0NP2c5op2xE/1rvbeF88eF+iihAEugnyZ
         LdIHnd/1ubjCxqQlixufdgdCrHVGJMk8SlosNq1ACqMWKjjHTMjIOGgYmX+yYB9q6M83
         448Q==
X-Gm-Message-State: AOAM533aD/MOaTPyG8S/ijgwsgl/yIordy9/n+DUNhTUELVFLy9Tjgiy
        EJtspjWYefisM/gJyRgSgb6u4K7exDiEzrn1qWI/54eSWbc=
X-Google-Smtp-Source: ABdhPJxT1xHvYnJnmKXomu4Hq7g2Z8f4tfldPU9/2l3zAc4G9If5Or8Dwfh4kiaoWtqonKY9HjM1w65uQiZFxTj56RY=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr4562504ybi.626.1650893598522; Mon, 25
 Apr 2022 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220421091055.12d6465c@canb.auug.org.au> <CACRpkdaD1G9J+jTJH4oGrcF_dinMjBjHCGMJqRZh8FC0dy+Xfw@mail.gmail.com>
 <bf90c37b-0184-845c-dd6a-c2f4a038b075@postmarketos.org>
In-Reply-To: <bf90c37b-0184-845c-dd6a-c2f4a038b075@postmarketos.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 15:33:06 +0200
Message-ID: <CACRpkday2DXDNJJJ7srC5-Fj_d9iiqX-nqY9np1TnsBsOG6sCg@mail.gmail.com>
Subject: Re: linux-next: Fixes tags need some work in the pinctrl tree
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 2:27 PM Caleb Connolly <kc@postmarketos.org> wrote:

> The patch shouldn't be backported to stable as it will introduce a bug if ported
> without the second patch (and as above, I don't think this series should be
> backported at all). Could you let me know how to get this dropped from backporting?

If Greg or Sasha etc propose the patch for stable (which will not happen
automatically unless you explicitly add Cc: stable@vger.kernel.org)
they send out a proposal "I will add this patch to stable", with CC to the
author, and then you can say you don't want it backported.

Many Fixes:-tagged patches do not get picked up for stable, it is not
what the tag means, if you want things to be picked for stable, the
rule is Cc: stable@, it's just that sometimes the stable maintainers
(and an AI!) pick some Fixes: patches anyways.

Yours,
Linus Walleij
