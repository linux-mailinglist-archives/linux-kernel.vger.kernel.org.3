Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1D4D801D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbiCNKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiCNKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:44:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DEBC22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:43:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d19so6674001pfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=offBx8u5K9bH2yAbo6I5jJGdKaFPcNiQgtHBU/dwurU=;
        b=abaAC5ZVOSjYCB5GTI4jMzp/Cl/Q0BjriRREyaCyTUp1j4rom2RG1SEY7jugYfJ/EP
         mvas1maqJCucHjUM5DzwP+zSwpR3D4nPAmt6MI+ongS9Uh2fwmFYeEib3Z4Uy5TDXJSN
         pnMCu0WnVdNHr7LiEitsfmFUQPWzF1zEZydrUO3xrNkqdWZN/Tb1+QxhXQhxPq2+M+/Z
         rjQuEQW/radAtdYCXe/lJK/4QP7vj0eRCvSoDLhsbhq+eDmiof0juJ/bgL83/u2sKr+p
         Qcpi2fniHGCfwftvFpPh7F+wtPYXkjo1ZIBpObCCanSpmaEhCiQn6QNHaXLlKazRCJ1t
         a1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=offBx8u5K9bH2yAbo6I5jJGdKaFPcNiQgtHBU/dwurU=;
        b=gyFwC0oH0vqv3jwgPORas8zjABpwZ6HLpzE3slJjKtlkUDgUO20FgitRbdAyu75Ukb
         lJUmvjyhJR01g5LOcW9U289Tpp92mFrRF+1lREHMsEPKDZbZUwCuaKgPzNh7UbxQzG/m
         /n8jFBZfbUTOrjJwXNM9VyxjZsMOyFD9jpBnLnqiW3XzAklAXn9WTZSWA6xqbsExhmTk
         jam7tkkEyN5QRwpSe6TD7vhQZ2LdfCB5FO2MhrBYw8ryHGuqIFw7mh0PwoA5d0gMwqH5
         CwRXJS8LlCl17z/WgA4iVSyIpjetBzsQO1JejK/pRHFnslxsr3oySNp+ZeQctxc3PWFo
         401g==
X-Gm-Message-State: AOAM533F+hHW36VLtDH9deFeckp1emmp+mW3Zsg9dvUPTPmnZ42wXr/t
        hnpt10KTvRTw1wLqhWeoY31mDQ==
X-Google-Smtp-Source: ABdhPJzPuCIBqKGT2yR3Mt9Jycz4pRUYKogWOk7q1ldx2/KnEQ0XxCwD/43nSZpnKOQc0BoR4ieMdg==
X-Received: by 2002:a63:914a:0:b0:380:1b9a:5bee with SMTP id l71-20020a63914a000000b003801b9a5beemr19047917pge.39.1647254618131;
        Mon, 14 Mar 2022 03:43:38 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00190500b004f104b5350fsm20537440pfi.93.2022.03.14.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 03:43:37 -0700 (PDT)
Date:   Mon, 14 Mar 2022 16:13:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        SoC Team <soc@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220314104336.ojkkynvqldrnw2kb@vireshk-i7>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
 <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
 <20220314065434.GA43329@9a2d8922b8f1>
 <20220314073102.l6vokyookzyo76hj@vireshk-i7>
 <CAK8P3a1Go8xiQG=BLBmqoQiVqwkcR+T8gi0WLijzVfa3A_WuKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Go8xiQG=BLBmqoQiVqwkcR+T8gi0WLijzVfa3A_WuKA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-22, 11:27, Arnd Bergmann wrote:
> I don't think that it was meant to have a fixed order: unlike the other
> bindings that define xxx-names properties, dmas require giving
> names to allow the DT to specify more than one possible DMA
> specifier for a given name. This means that nothing may ever just
> rely on an index but has to use the name for lookup.

Is there a way to update the yaml or tooling in that case so it doesn't expect a
fixed order ?

> OTOH, while fixing the order in the binding does not add any
> value, it's also harmless as this should never be able to break
> anything that worked for any combination of old/new dtb and
> kernel, and it's probably easier to express in the binding.

I agree, but such a patch shouldn't be required at all, which caught my
attention. It is fine to merge it and won't break anything, but it shouldn't be
required as well.

-- 
viresh
