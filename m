Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEF5A6B73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiH3R5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiH3R4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE995FD3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661882087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyMZvr6hAWXwFXLqf6lBA2tiJ+OBR6yqQ8sBvG7FzcY=;
        b=RkbGrAC5CjBmeXb588nNbAJWqSSkrcJHGJ+K1xsTVYSy4Jv+F/H6bOf88/qkGX4YW8xw4e
        iRq05IUTzbj7+zFIREdFq52VZsmynD4IT6gBgLT/aboQP3FzRsFYUekCNpXFM804sO+65K
        z01+UE2OGxBkJm45CH1NkqK7L2bpaq0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637--AsiIhEVNQu5vVGUsV0gdw-1; Tue, 30 Aug 2022 13:54:45 -0400
X-MC-Unique: -AsiIhEVNQu5vVGUsV0gdw-1
Received: by mail-qv1-f69.google.com with SMTP id u5-20020a0cf1c5000000b00498ef3bdd97so7339861qvl.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KyMZvr6hAWXwFXLqf6lBA2tiJ+OBR6yqQ8sBvG7FzcY=;
        b=IElannw8UiJ2YBaDtstU51yzrxi3ZSoCWxqzfKNnSWjBeKsSQN2aaSVDKvXPcUPTsw
         QLR1SGHvUycpVS9YqkCvA6J4ngsLDpOhnuvPHbu1OTAKQOcAqpcamXLbQtZEWqsH7HlU
         7qrHiSkAuYi1Zb753a969m7xSpNwjqah6dUqCFhPOdjjfKgK6T33VS1x0b0ehcyDF2iK
         GFaaXwuBzxJmf/KT7ZiZ7bZTeC6otiOKZLqSfbvGIK4bF/hU7E/+Iqc4fBwIbkqy/iib
         LCRdv5JAjNU/lWtV03vcy9h/FZ8Bl6oTLmrd6oZz1cVcvW+xKWX5NH8z/yqMlNMTNZxa
         6HHA==
X-Gm-Message-State: ACgBeo1YDr3DCxsAkfutnE6Yu8AnEXnl0fLNIn8ajvpvHSbCFwJ7paTv
        zHcQ+LX4RcbH1NeLwfoBbzEDIgoxEXqjhhOwVBOc9wPlPaHN+DPuO6dOvnqh77W4COvKConyPv6
        CUm3jscccSqBs8JrRD4PQqsCs
X-Received: by 2002:a05:6214:2688:b0:498:f68a:95ba with SMTP id gm8-20020a056214268800b00498f68a95bamr14179813qvb.111.1661882085156;
        Tue, 30 Aug 2022 10:54:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4qAeiQMuaFdflH8tw95Vsb1sWJJ+E2pL2XUc8mixCOYiKT+SeO0L8eikwDkJC3PjcRGTK5kQ==
X-Received: by 2002:a05:6214:2688:b0:498:f68a:95ba with SMTP id gm8-20020a056214268800b00498f68a95bamr14179793qvb.111.1661882084909;
        Tue, 30 Aug 2022 10:54:44 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id de14-20020a05620a370e00b006bba9575621sm8151252qkb.68.2022.08.30.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:54:44 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:54:43 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: correct ref_aux clock for
 ufs_mem_phy
Message-ID: <Yw5O44dxLE3+7tdF@xps13>
References: <20220825163755.683843-1-bmasney@redhat.com>
 <20220829222826.xlusmyfrdgzeo3wq@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829222826.xlusmyfrdgzeo3wq@builder.lan>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 05:28:26PM -0500, Bjorn Andersson wrote:
> On Thu, Aug 25, 2022 at 12:37:55PM -0400, Brian Masney wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 49ea8b5612fc..4117ec0ffefc 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -892,7 +892,7 @@ ufs_mem_phy: phy@1d87000 {
> >  			clock-names = "ref",
> >  				      "ref_aux";
> >  			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > -				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> > +				 <&gcc GCC_UFS_REF_CLKREF_CLK>;
> 
> I would expect that "ref" was going to be GCC_UFS_REF_CLKREF_CLK and
> "ref_aux" would remain PHY_AUX. But the mapping here is not clear to me.
> 
> But does that work for you? (i.e. clocks = <CLKREF>, <PHY_AUX>)

Yes, that works for me. I'll send out a new revision shortly.

Brian

