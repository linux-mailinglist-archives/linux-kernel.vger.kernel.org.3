Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6984E6FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356509AbiCYJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352556AbiCYJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:15:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BFCF48C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:13:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bx5so7017992pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=91AkTY/kb1Ola/H5vx+Ixj6/0B7eA+Up0Yhlp2qn5C4=;
        b=PQHiG9F2wFN2LXQYhcwEzphWhUxvJ/DFulUpijtusLYP7YNeDEp23RfC10WubXETue
         kbY98gqyjT4OSpTLvDeBUeTQWNPgCZ4Vya/Ea79sGUfvdyvKoYGXJ8VOAQXEdAyKT0CA
         xDzWjr/D1OHA9wpH3lRkbwtRFuKErNNrczaNHHFIBytv3opSKMRW/5XGhWuCXZqcoLLt
         9aU4e6z0Q3gikLLuHhnkUYMdc2TMhqbY9vK14+b/tJz63Yf2kIaAdxnbtFMxS+xloXjw
         PhVWcYLzMH33/T+k8Q+aGk/BJTC39jMWU5rZq/20J+HBgSA3yQCKNJVHG4NucfxYnsJq
         MzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=91AkTY/kb1Ola/H5vx+Ixj6/0B7eA+Up0Yhlp2qn5C4=;
        b=TxArPktUP3k50HTZhXeSPRFzxXOZG0B0w+w7BRnJtROBhzzd4WPfZ4LXZMrTkXZfhr
         sDeTXRTDzaZfvsSOC1PrqHZNGkRcihZCDHBBiJMiYoda3xebSIowL0JdE422DtpetdKu
         Fp8Ej5vv/mfxOlj2r0JFVFPzWi5vNq7nFsBlLBK0gRsgY1uwBlj5J8CdcjuantgpRNp+
         k9V9LlBdbBCYRAukaZEaFN98DiFo5CZzB+gzmIlxa2TccwNMnB3p59rHEN1j0f8HI5wy
         yKjuivW7rUEVyY1dEX8//AdBluzquQqvZ2u3vAwXT8H63DUqeeAVz8fJnX5oVH9sCJM7
         ElwA==
X-Gm-Message-State: AOAM532maj7cNSwWwiZu+TYRyeCCcVP3900yKja6GuCT0yoYkKHj/u8O
        KKFlNtsIlcy2DspMUTvxIDEo3SXiFwRyuA==
X-Google-Smtp-Source: ABdhPJyGAdv0p9neUjb2iIntzidCBrpS4MK8HEZItIseo0BAj/9TpC+G+XGDQwJahN+ncD6rUPFMkA==
X-Received: by 2002:a17:903:41d0:b0:154:de5:a240 with SMTP id u16-20020a17090341d000b001540de5a240mr10703364ple.32.1648199634102;
        Fri, 25 Mar 2022 02:13:54 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm9670388pjb.55.2022.03.25.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:13:53 -0700 (PDT)
Date:   Fri, 25 Mar 2022 14:43:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220325091351.5vb4p37g2qi2mseh@vireshk-i7>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
 <20220324062547.GA15504@9a2d8922b8f1>
 <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
 <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
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

On 25-03-22, 10:11, Arnd Bergmann wrote:
> On Fri, Mar 25, 2022 at 2:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 24-03-22, 11:55, Kuldeep Singh wrote:
> > > Fixed order of values is important in case of properties like
> > > compatibles etc. In case of dma-names, yes order shouldn't matter here.
> > >
> > > This patch is more of appeasing dtbs_check warning rather than fixing
> > > something.
> >
> > Exactly my point. We have seen similar type of issues with other tools, like
> > coccinelle, earlier and such patches were rejected as the kernel was just fine
> > and tooling needs to be fixed.
> >
> > > It's safe to go with this patch.
> > > I am not sure if there's a provision to exclude dma-names from fix
> > > ordering checks. Rob can help here in providing better insights.
> 
> I think it's a question of the scale of the warnings: my understanding is that
> there are only a handful of dts files that trigger the warning at all, and it
> would be rather hard to change the tooling around this. Since the proposed
> dts change is clearly harmless, I don't mind applying it.

I am fine if we want to apply this patch as is.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
