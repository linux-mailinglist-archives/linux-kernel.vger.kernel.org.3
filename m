Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483FB50BB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449347AbiDVPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449340AbiDVPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:19:23 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE514031
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:16:28 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e9027efe6aso1615918fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=46ALeKzd0IFj5VWKeGIv6vysrvZd6kvXkqYlg2eppOM=;
        b=v1V4Xy7vq+gsCarfOHOKIFnScMvDmomLpQW8suZaTLw8At1krVCkIbp27NHUiXM9W/
         Kx/Mwsl4YN4YouTnBD3irXnQ79KXev/TWkt66kfLkBxGziZ/sjHz9GQHukE+IhwMB20d
         YzR+CkTS1p/Gzmszy6iC4isYLZNfpZd1dPTuHwsgqDf9l3eVIKB2Mq4gCoyZ2T1PTomV
         zpLH65G5wcDD4+/Prdg/+7cOSHoYO2dG5E+i6Qbs0TJLNZiEJl+6mODeEIdXKdQXw4j8
         JNzi/Sb5KB7cKPQn0oP3LCUz1aiDYjasuisPCwNCJczoAoNBtBcLDl1ie0u2Jys3nZJ0
         XZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=46ALeKzd0IFj5VWKeGIv6vysrvZd6kvXkqYlg2eppOM=;
        b=HtXEkBhBka2vfpfE0MTqVKThnQtiix8hFeS7p3WBQSqtVbPt1iitc8682wIyksNKhY
         a0xFrZbwyrpxWjnH771r+9yFKLWSJBb6HCyMRlJcP9XpaX2KBrm5W2p5vJBElziUqAME
         9pXe43An/VBqFVvfpdJrmC1wbFqxliVdq6J9LATq0/SSnk4RTca5h5T7NEX7JAs/yxvJ
         xEKjNTn5weRXQ1yYFYIufpBOppj/Se89KkT/UxrpMoZrzj/pOdc/YD/+l9mstFeTXCkY
         rKwJL3MruwsnBYPa6zQ9wojcnQNKUOG71bI7BwcCem/oIpkb+JAbkZ11EEN35i/iSPHo
         KBpQ==
X-Gm-Message-State: AOAM533rQQ/4iGxuJTwme0/l3av/BWC7X29zQNhd21DkvAeijdYlFIFn
        7fmjZiN9rzr4jAT03y/SGNkxag==
X-Google-Smtp-Source: ABdhPJyljeQgjHrCPpzEbOJ5Ve6w2vzSSfOb46fgEWxtHLHwjUqmFOaGwW/u2GKHjNuvtVV+snqvYA==
X-Received: by 2002:a05:6870:d0d3:b0:e2:d945:985 with SMTP id k19-20020a056870d0d300b000e2d9450985mr6008888oaa.185.1650640588164;
        Fri, 22 Apr 2022 08:16:28 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v36-20020a056830092400b006045a6c8047sm827759ott.12.2022.04.22.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:16:27 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:16:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "N?colas F. R. A. Prado" <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 0/3] Fixes for Mediatek dt-bindings
Message-ID: <YmLGyIOStJJAGSJG@builder.lan>
References: <20220225225854.81038-1-nfraprado@collabora.com>
 <20220404152256.mkksr4oqjt65ytlf@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404152256.mkksr4oqjt65ytlf@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Apr 10:22 CDT 2022, N?colas F. R. A. Prado wrote:

> Hi Matthias,
> 
> Maybe you could pick this series through your tree? It addresses some dtc
> warnings that are introduced with the new nodes in mt8192.dtsi that you just
> picked up on your v5.18-next/dts64 branch.
> 

I don't see a reply from Matthias, so I've picked up this (the
remoteproc) fix in our tree.

Thanks,
Bjorn

> Thanks,
> Nícolas
> 
> On Fri, Feb 25, 2022 at 05:58:51PM -0500, Nícolas F. R. A. Prado wrote:
> > 
> > This series has some fixes for Mediatek dt-bindings. It solves some
> > warnings printed by dtbs_check, both for already merged Devicetrees, as
> > well as some that would be introduced by the changes to mt8192.dtsi in
> > [1].
> > 
> > [1] https://lore.kernel.org/all/20220218091633.9368-1-allen-kh.cheng@mediatek.com/
> > 
> > 
> > Nícolas F. R. A. Prado (3):
> >   dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
> >   dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be
> >     optional
> >   media: dt-bindings: mtk-vcodec-encoder: Add power-domains property
> > 
> >  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml     | 3 +++
> >  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml      | 3 +++
> >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 1 +
> >  3 files changed, 7 insertions(+)
> > 
> > -- 
> > 2.35.1
