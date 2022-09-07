Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B395B1072
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIGXer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIGXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:34:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6C2559E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:34:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so508658pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XSbBGffu2FVIOAcIwkeNSD8KuaOdq+iesnGMUCwAeTU=;
        b=KY+PrU0lGhQtTLQNN2pWFqcE1LnBpbbWDb0rbOdjRcryAGRzT10mekKUQs/hx5IWfc
         NFnigMwimobNFGgyI+x3a1uPOyWp+GJ57NrlduGzWlADCIfmi4DEvVyxP3klvjGSmK6S
         bIsg/2Kj75aYsnpvzhm/uSVj330L5WzCT/lBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XSbBGffu2FVIOAcIwkeNSD8KuaOdq+iesnGMUCwAeTU=;
        b=oOsCcYXH7GXZvDdG5A/CgYDq+kRuypj0CiFEfDCuQkGiv89oROAbjWcJYUnmL9yBdl
         6DofyYU5+hOUTzalJzLLVu5bu0UkswXiZ60j+MrfuooNiqCaAXfHTy++QoTuoEMKQEIQ
         ZZa3+3Vi16I+Fe/Om7hUPlKSvHB9QsB/oGWrZHYWeK+itFIFmGrLLTcprRo4En2i40Rv
         iHCIb6MAtqBg/SdXKnRHwmOnnZEr2Em2NWW8Q6TKnhA0jCUYve6T6cleBTAZymAAS3+J
         W84vQUzBTXY5e3Hhp0tk1mDDw6n4fb00NcvvEqRwDT6DvIibaNLl3/fAifrGu/2O4g60
         twiQ==
X-Gm-Message-State: ACgBeo2/7kZeYq82ASEQV2A846QQbMw5WEcki2xnPOEH3pt1SKm/ggyz
        qP47cxGzBdWgcfMgRHxbzjbGdQ==
X-Google-Smtp-Source: AA6agR6Rj3Ng4uD4eI/0C1clYjJ/SoLai8r45C+puUVjcvUnjiFrRX0IS6jpxhbi09w8xzFyK3bhEg==
X-Received: by 2002:a17:902:d2cd:b0:177:4940:cc03 with SMTP id n13-20020a170902d2cd00b001774940cc03mr4538114plc.98.1662593680649;
        Wed, 07 Sep 2022 16:34:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10-20020a63da4a000000b0042c0ffa0e62sm11192333pgj.47.2022.09.07.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:34:39 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:34:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc: Fix fall-through warning for Clang
Message-ID: <202209071634.7CEEF9A@keescook>
References: <Yxe8XTY5C9qJLd0Z@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxe8XTY5C9qJLd0Z@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:32:13PM +0100, Gustavo A. R. Silva wrote:
> Fix the following fallthrough warning:
> 
> arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> Link: https://github.com/KSPP/linux/issues/198
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202209061224.KxORRGVg-lkp@intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
