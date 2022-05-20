Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8852F419
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353382AbiETT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353373AbiETT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:58:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4619CB6C;
        Fri, 20 May 2022 12:58:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c19so2995931lfv.5;
        Fri, 20 May 2022 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOJusE8NHNqjKMNStmuZRo9RH3cwXzoVFMfF94/t6Ck=;
        b=bQ+WBLuzBq3aGizqD1+Kwm5uAKpENycXAljdLzTGsAaeq+eESfeAhCSUpZDT5IDNb+
         P9zTFv7zoTRkmT/uwyhlZyXGFyiERjKOPBEBQWG4V9rlz1NhEyOqJTV5P3IKQAqYnxva
         zVb6UFNRlCa1blmb2JCzrbWtoKSq9JCYY/sYf8dT32VU3RaA+dRV/Nq6TJYgh6kmh5LD
         kSmEw+or1PbtqHPMBqBSOAbmKlV0V+u4GmL78rngDoFH2mA1oDxVQT4Iih9170vjUhFw
         ebTXGxF75uA7HdFslnlPt6emZADNR7A8pIHxil/1PZB17Xr8krOhd2E1J1pblpk+5/Ar
         NAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOJusE8NHNqjKMNStmuZRo9RH3cwXzoVFMfF94/t6Ck=;
        b=mgGVOZjulemk2VqRjHC5Yom16+rHbpFqOLBsa+ueRQSQVVEdrPw5h4i8iFjaCGoiLT
         B1GPQp6Nkd6RiziP4cLoOGebRbAIT/P2MryYVe2ZQM4Y2CErOdOPT6xrXIFbFLMu4D+4
         U6YaZfIEEm85ap9ICIhGfUH78MqcsYIKpYYbP8lLX8PtovChonP5KGhaxr7F1lyM0X3s
         YUtQO6uScGygIU8tkIiLtFfWEyDhACAfPFwNNk+XoGxb5ojqenWCktlojkn3sM39vtzE
         EmkeTzMJqciRNHx4abfc7h1XysYhexmcHKx06dOI56jAY5lO6qxlDuW/j7y7WTFcfZt1
         itKw==
X-Gm-Message-State: AOAM532UqEkOHP3sDhMgUz+X9BrbleTr/UI+qdqAgOzU2CNpjVq83A62
        7StHZ8BHv3JvouE3I3uQczU=
X-Google-Smtp-Source: ABdhPJzUt2asX4E8YYHlbCTQJA7I8CTGGnYx5OzSOW/hCyHXdcIZDrwis8BM2kQq338jS7Wsy2a/7A==
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id o11-20020a05651205cb00b004720f7ea5f5mr7867956lfo.358.1653076689178;
        Fri, 20 May 2022 12:58:09 -0700 (PDT)
Received: from pc ([104.28.198.246])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e8545000000b0024f3d1dae7csm422051ljj.4.2022.05.20.12.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:58:08 -0700 (PDT)
Date:   Fri, 20 May 2022 22:58:03 +0300
From:   Boris Lysov <arz65xx@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        ck.hu@mediatek.com, devicetree@vger.kernel.org,
        fparent@baylibre.com, ikjn@chromium.org, jason-jh.lin@mediatek.com,
        kernel@collabora.com, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, paul.bouchara@somainline.org,
        phone-devel@vger.kernel.org, rex-bc.chen@mediatek.com,
        robh+dt@kernel.org, sam.shih@mediatek.com, sboyd@kernel.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795
 clock drivers
Message-ID: <20220520225803.193bcda9@pc>
In-Reply-To: <a253f338-c162-17b8-f412-95cd63195151@collabora.com>
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
        <20220519045340.11198-1-miles.chen@mediatek.com>
        <11bf21cd-85c4-f64c-2af7-7695e71aee07@collabora.com>
        <CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com>
        <a253f338-c162-17b8-f412-95cd63195151@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'd like to chime in with some feedback.

> >> Hence, the usecases for this kind of splitting are:
> >> 1. Somewhat rare (corner) cases: someone may not want to compile in any of
> >> the mm/venc/vdec/mfg clock drivers because they don't need the
> >> functionality at all (probably, including the other related drivers), or;
> >> 2. It would be possible to compile as built-in only the "main" drivers
> >> (apmixed, infra, peri, topck) to achieve a boot (ex.: you need eMMC to
> >> boot, at least) and then compile the mm/venc/vdec/mfg as modules to be
> >> loaded after mounting a rootfs (where you probably also have mediatek-drm,
> >> vcodec, etc as modules).
> > 
> > I assume you mean split them into two groups:
> > 
> >    - essential for booting to a state capable of loading modules from
> > storage So apmixedsys + topckgen + infra_ao + peri_ao + imp_iic_wrap
> > (maybe?)
> >    - everything else
> { snip }
> > IMO having two Kconfig symbols for one chip is still much better than
> > having ten though.
This sounds good.

I think it would've been even better if selecting a Kconfig option like
MACH_MT6795 would automatically select the base clock driver for booting to a
state capable of loading modules from storage. But a quick check showed me that
arm64 doesn't use such an approach unlike arm.

> For MT8195... and 92, 83, 73... and others from the same era, being them for
> chromebooks, iot, smartphones and whatever else... yeah you're totally right.
> 
> The issue starts raising when looking at older SoCs featuring an older
> bootloader that does have a kernel size limitation; for example, to make the
> loader happy on MT6795, I had to strip the defconfig a lot and keep the
> Android-style boot.img smaller than 10MB (that's Image.gz-dtb + ramdisk).
This issue gets even more relevant if/when we consider older ARM32 SoCs such as
mt65xx series. As far as I know, most of them (with a notable exception of
mt6580) have bootloaders that restrict max boot.img size to 6144 kB.

However, I think too much granularity in Kconfig might cause unnecessary
confusion. The "essential clock infra" + "everything else" split sounds better
to me.
