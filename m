Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7627C4B807D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiBPGGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:06:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBPGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:06:22 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3B15B995
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:06:10 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so1348812oob.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDBQKjrOHx1jFqanGpjTZz0mkLi+B8rGvMm6ZK2mah0=;
        b=ANYaNLWFCQkj69oiskZkSh6DjZmPGeiq9PrEgU2cP3v3dn1nkwLwYm7cx+4vS6oOKw
         RwNzEIyq3NLxuuxq6/pXX241+VkGVJtb86AlOXZXiNaOF+o9MwFTZ3Ial6STIS1UiAA5
         dhBgfFPAMgGgTKfxv7tknbGcdLXT5auCslnVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDBQKjrOHx1jFqanGpjTZz0mkLi+B8rGvMm6ZK2mah0=;
        b=wgHhQk8R3gdDhW32y0vBYZSQ4nh+Oa62SQkZ5whSFdQ9rAZ9o5xSymWJCxNDWtoYZn
         hnUNbtzTwc+kHCtIKG7/ffGLmgbcV4S+/2hhuKPAq1zPKatHzrFj+dN+FEcZlidyweb5
         l7x3CiyokN4oSvCxN30uPp8BrKJASY1XHhaewywd2uEME6fkrlAZoFOdR2u6L0YbjNgC
         +wCvPgK0W8254FgMTTsC+Rl7RH3bTrpZgcpNeGykL2hUEs7V6v2KRbynvz3wir5HcQY2
         dCQisHu/8lGwpOZ5/VRzTFjt0BSf/Xzg5PQVrvb44gCa4lYKObBRKGaZ7vjPIywdcugV
         PSLA==
X-Gm-Message-State: AOAM5313vqIgaBUp47OEG0XSsMZGq54c07oFEEPP6xu5cDNjgyGU3gI7
        GfvY5d8zHpn8CSgpuhvQqTpLqLB/h3CJjpPHkbE=
X-Google-Smtp-Source: ABdhPJyvdoaa4OxoS2tNvxqo9C0KlIDVywMK0LzHhYsWui4twUzQvOt2jHQLeaE+zoG3OxNVw7TVBw==
X-Received: by 2002:a05:6870:30e:b0:bf:9b7f:7c63 with SMTP id m14-20020a056870030e00b000bf9b7f7c63mr11622oaf.84.1644991569849;
        Tue, 15 Feb 2022 22:06:09 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id x12sm14646616otq.6.2022.02.15.22.06.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 22:06:09 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so853269otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:06:09 -0800 (PST)
X-Received: by 2002:a0d:c383:0:b0:2d0:f04e:7ada with SMTP id
 f125-20020a0dc383000000b002d0f04e7adamr1070020ywd.229.1644991156422; Tue, 15
 Feb 2022 21:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20220125085634.17972-1-yong.wu@mediatek.com> <20220125085634.17972-9-yong.wu@mediatek.com>
 <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com> <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
In-Reply-To: <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 16 Feb 2022 14:59:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
Message-ID: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
To:     Yong Wu <Yong.Wu@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 2:55 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno wrote:
> > Il 25/01/22 09:56, Yong Wu ha scritto:
> > > No need zero for the protect buffer that is only accessed by the
> > > IOMMU HW
> > > translation fault happened.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >
> > I would rather keep this a devm_kzalloc instead... the cost is very
> > minimal and
> > this will be handy when new hardware will be introduced, as it may
> > require a bigger
> > buffer: in that case, "older" platforms will use only part of it and
> > we may get
> > garbage data at the end.
>
> Currently this is to avoid zero 512 bytes for all the platforms.
>
> Sorry, I don't understand why it is unnecessary when the new hardware
> requires a bigger buffer. If the buffer becomes bigger, then clearing
> it to 0 need more cost. then this patch is more helpful?
>
> The content in this buffer is garbage, we won't care about or analyse
> it.

I think we should zero it for security reasons regardless of any other
aspects. With this patch it's leaking kernel data to the hardware.

At the same time, we're talking here about something executed just 1
time when the driver probes. I don't think the cost would really
matter.

Best regards,
Tomasz
