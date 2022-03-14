Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497E4D7B89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiCNHcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiCNHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:32:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21940A22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:31:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so16540918pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q5n8AXnZfltOT5Bvwt1oR4JiidhsA4iMmBDcmk5blOk=;
        b=BNmras69oEahfMYAfHS+4hbDM1m2IdbOCUf2fW/KLZ0ss3elgkTBOCQfnvY1iE3cYJ
         QhGkk4fsbLKH3w+Krr7lXKFuiAHtTAUSkGKx0YegjwlT35loR2atITFnEPFsVxZrzGxp
         pQKMYgSSqRCCIB8hK4dZazGCbqnAgRGo80NQTc+zOazrAsf37YhosVPO4KXYeDoU+V+W
         AM3EkmgmN5zBK1gZBhuHvY2tgqwbmsc0TP404WOVKidb5y/WQPawcia7YE86vU3eXT3u
         64qzPCntmq3upuCyiAb0n+DMTDQ1yWb2MYfZoZRay736u1TLhkndU/twpaCJm8mIz/nl
         jgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5n8AXnZfltOT5Bvwt1oR4JiidhsA4iMmBDcmk5blOk=;
        b=MH6VLDeRwcAtr1ESL9UdTjCpjNxDzAJmTlEzrQpy1Hf8suP0Y0uxKYFZQ90ilWrYbY
         wLzac/8+6sFfKM+deI1gLmgHL83zF1cpb7T7k+dAMTK+l2KDTYn2CcMgl5Bm2tyTVrJH
         p2fdONjeNFJCbINHfJsT4ExZDQM8bt3yn9n1rUbl7byDoLC7porpfLO2U3h0TG3xlwbX
         FODWsTSGbbYUz1lG+vQdYdJb68lwmbWiEpme+4qANWXum2HWFuXho0ex6StFDMfSJE2r
         Mh4l5j8tRhoKGh/bWDiEYaaghnWgc1mG93Xc0BWW3k6uoIIzY4kinPP08rMO2wFMvDTe
         CATQ==
X-Gm-Message-State: AOAM53142zF6qKLslIxPcRcV0u4fGo30dDShDCuyn5KYxFTvVWx1V/b8
        tuowuFYc/tbuMznXZyIUiGO/zA==
X-Google-Smtp-Source: ABdhPJwv59GhWaXVz6IUUrHHXJK/ATaqogV7YtD8o4pBbVTJcpNGBDbHMhAZJ70aza4yeLAFJWUnxQ==
X-Received: by 2002:a17:902:bc8c:b0:151:8278:d2bf with SMTP id bb12-20020a170902bc8c00b001518278d2bfmr22661394plb.114.1647243064633;
        Mon, 14 Mar 2022 00:31:04 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id i187-20020a62c1c4000000b004f78c98bc57sm11616227pfg.106.2022.03.14.00.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:31:03 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:01:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220314073102.l6vokyookzyo76hj@vireshk-i7>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
 <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
 <20220314065434.GA43329@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314065434.GA43329@9a2d8922b8f1>
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

On 14-03-22, 12:24, Kuldeep Singh wrote:
> Dma-names order matters here.
> As per pl022 binding, dma-names order specify rx,tx and all DTs which
> have tx,rx as order start raising dtbs_chek warning. Thus, need to
> reverse this order. Please note, no functional change in this patch
> apart from just fixing warning.
> 
> Warning:
> 'rx' was expected
> 'tx' was expected

Hmm. I see your point now.

  dma-names:
    description:
      There must be at least one channel named "tx" for transmit and named "rx"
      for receive.
    minItems: 2
    maxItems: 32
    additionalItems: true
    items:
      - const: rx
      - const: tx


I was expecting above to allow adding the items in any order, but
looks like the order is fixed with this.

-- 
viresh
