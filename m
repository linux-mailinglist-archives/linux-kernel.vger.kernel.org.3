Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5234E593136
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbiHOPA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbiHOPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 963CADDB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660575619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gkp6W0UnvJNbc+E/frEsC8/SAoG8aGkv8tG/23+JfF4=;
        b=fGgRzCLgMlHBTFPP/ECfWhT91fL+hkyHsqcyvgRYPqs2IGb3XpJvGdU6zBByFIGmLM1TVF
        fDU9S1/9ufMPzzkVrsla+1coWvrtBZmc/+70eD9sQWsLzfyOAkClAMFsrbDHPS/MPVnMDx
        3J3dK0L1fx3JoDM+XPLpWBGkenPfVic=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-PNgsjx8gPISyjhuccCf9fw-1; Mon, 15 Aug 2022 11:00:18 -0400
X-MC-Unique: PNgsjx8gPISyjhuccCf9fw-1
Received: by mail-qv1-f70.google.com with SMTP id nm18-20020a0562143b1200b0047b33c1e57eso2662239qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gkp6W0UnvJNbc+E/frEsC8/SAoG8aGkv8tG/23+JfF4=;
        b=K7SqyMTsQQLdTJkxel40EnpvSyxwFPC9CCL26GDixeInTTo92lRHivYtO+8fPArexc
         Tib9CozWRdb0zdgJZ2F8uDb9Kx3C5XE+CminpNIe9ygXTdV9obu330DJ/YuAxFTXLJLO
         mrheBQhSq7/aUWHfK1Fy26Eg3ur/HcUkDbwOV1GBsNkP2PuTADrQrXUSMzDGauYuHyeh
         1mVe+F7Dmh+skQwYAU2f/ak9Ci75ctRMmg78vTO7gUu/WGOaRMvXkYhEh/y06dVAArlw
         eLkTefrcpdi6RlsEM0hq8GjUqrxbJYylozKbzN6+U1yHGead4KNyqD5LTxtPPiQxTdYr
         DAhw==
X-Gm-Message-State: ACgBeo3Y/xTuTeqEQVKvREhRY7hr8fe4oA9qHpAlA40q/FjxW5caDAsi
        v8CIwzo5LMMVJoZ/p8FhbvcivDjNz+mZILTUuwB6Eh8YHYpTRFjlDBe1v4HFIkFitQZnD2xQMXJ
        CfKyXefkYX2eitz947oJ+6fr7
X-Received: by 2002:a05:620a:459e:b0:6ba:c5a7:485c with SMTP id bp30-20020a05620a459e00b006bac5a7485cmr11298138qkb.267.1660575617712;
        Mon, 15 Aug 2022 08:00:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5vLK2IsSc5T3esQZcOlGhUNLYtZ2weQin9eem0kTWU742yhnPNdz0yjaOkJuyqisTE/LZdfA==
X-Received: by 2002:a05:620a:459e:b0:6ba:c5a7:485c with SMTP id bp30-20020a05620a459e00b006bac5a7485cmr11298120qkb.267.1660575617465;
        Mon, 15 Aug 2022 08:00:17 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id fb6-20020a05622a480600b00342fcdc2d46sm8312778qtb.56.2022.08.15.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:00:17 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:00:16 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <YvpfgGh7T7jZTn2R@xps13>
References: <20220812165453.11608-1-quic_ppareek@quicinc.com>
 <20220812165453.11608-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812165453.11608-3-quic_ppareek@quicinc.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:24:52PM +0530, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes to sa8540p-adp.dtsi file. This will be base for many ADP boards
> to be introduced in near future.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 377 +--------------------
>  arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi | 384 ++++++++++++++++++++++
>  2 files changed, 385 insertions(+), 376 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp.dtsi

My understanding of the sa8295p auto board is that it has a single SoC.
The sa8540p auto board has dual SoCs (same SoC variant as the sa8295p)
with a PCIe interconnect between the two SoCs. I hate to bike shed on
the name but perhaps the name sa8295p would be more fitting like you
had it in v2, but ultimately leave it up to the maintainers on which
name to use here.

How will the dual SoCs in the sa8540p be represented in device tree?
I assume just document the PCI endpoint to the other SoC? Then run
the two SoCs independently and let them see the other SoC through
PCIe?

Brian

