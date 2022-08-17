Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D205970CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiHQOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiHQOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:17:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E35FF6B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:17:25 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6144F3F1A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660745843;
        bh=UhnbamTxs3VD3gP1EyVknpnkcVMqwamj16Y6i5t4shY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ux6T8tOjaHrb/1mNVNCC+ZQTvPa/xM/2J8LEXzvGgeBijwAAeeTCA9HU0ewSboWne
         /34tW65be6cwJnm0nHdG7S8H8nbSX1AUU/KKhhzWUbDX4kzR8nJoIzd+tghyAnaXJS
         Wqq1Q0WWFFIyfXa6gxSWM308qB+2O6wozut0uIqN5E/zpHJuZzDMFlxHJFiO+2pSWd
         l3rMWVarfO+aQ8/1OwVE7GzdHPJDkvWV/EKV7QT2D1QITMAxMOudddBrA+a1w3rCF9
         LLF6ioHlFLNY8uUf5twZCxXtmI1ClsLC9o1qmDLuIGYnarENKSaL9/lC96tcmMHxTu
         vRtTPfu2YNyOg==
Received: by mail-ej1-f69.google.com with SMTP id g18-20020a1709065d1200b0073082300e1fso2988726ejt.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UhnbamTxs3VD3gP1EyVknpnkcVMqwamj16Y6i5t4shY=;
        b=k4j4hBtYaooA3U+hHMFpVK9rvGKJHe4HUrbqCDgG5g1hc+wmJQYwmqipX/MUiZgYE1
         Zt2my6+egj52TbBr4TcbGNgvwOAvLNBjYdHgPlKCjEu+SeQ5l/w9n65XFxbfDNXTH2/w
         HLVpfoecJTrO929MsjL9vgGszLjfGEWCP6ocJNa0lkxSUcD92UtIMLSj//X+vLCfth0W
         ZJK/pBV6Bh/EXva3dBypb9YaxseoSBkKtjQG87B+rT8D1TgRxEvRzWd2sIsg4SKMMUIj
         W8XiMk+43cRfT9OHhAafK+7Pl1FAdgRwnKGKWu859kWPTG++FHZDqGSDaI10c3NiyAkl
         11Ig==
X-Gm-Message-State: ACgBeo12OWTNiT7jdlRdkG/JIZcEcp8RfS/aU6UolY/g9HiBj4YsHzyh
        PuG2EVI5DiJshKgCU2SIcxYXsnifRmmXD3xm1dobwFkahGLLDhwOkciiISWUNGjP5dNipW/sHov
        0qbzzms32As22QT0ig0/jksWBWFmPEiaSdi57GoEI4w==
X-Received: by 2002:a05:6402:510c:b0:43e:305c:a4d1 with SMTP id m12-20020a056402510c00b0043e305ca4d1mr22580751edd.35.1660745843113;
        Wed, 17 Aug 2022 07:17:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7k6xbfLOi7CnYXs1lgb73zhRMRqr6GJQ0DDpuvO5OWTy6LvD52mGjCtuWGaNHGxw6EwFmtbw==
X-Received: by 2002:a05:6402:510c:b0:43e:305c:a4d1 with SMTP id m12-20020a056402510c00b0043e305ca4d1mr22580739edd.35.1660745842934;
        Wed, 17 Aug 2022 07:17:22 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id fd4-20020a1709072a0400b00722f069fd40sm6849274ejc.159.2022.08.17.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:17:22 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:17:21 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: head: rely on CONFIG_RANDOM_TRUST_CPU
Message-ID: <Yvz4ccSO+BhICmyE@arighi-desktop>
References: <20220817094618.67063-1-andrea.righi@canonical.com>
 <YvzqLFDuXtDRxilZ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvzqLFDuXtDRxilZ@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:16:28PM +0100, Mark Brown wrote:
> On Wed, Aug 17, 2022 at 11:46:18AM +0200, Andrea Righi wrote:
> > The CONFIG_ARCH_RANDOM .config option has been removed by
> > commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM").
> > 
> > Depend on CONFIG_RANDOM_TRUST_CPU to determine whether we can rely on
> > __arm64_rndr() to initialize the seed for kaslr.
> > 
> > Fixes: 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
> 
> > -#ifdef CONFIG_ARCH_RANDOM
> > +#ifdef CONFIG_RANDOM_TRUST_CPU
> >  		 if (!__early_cpu_has_rndr() ||
> >  		     !__arm64_rndr((unsigned long *)&seed))
> >  #endif
> 
> I think the sense here would be more that we should just unconditionally
> use RNDR if it's present - previously we'd use the result even if we
> didn't have strong trust in the CPU implementation and I don't see why
> we'd want to change that.

Makes sense, in that case it'd be better to just remove the guard
completely, as mentioned by Will.

Thanks,
-Andrea
