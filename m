Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81B55AD6F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiFYX00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiFYX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:26:23 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452D61146E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:26:22 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3177f4ce3e2so55136197b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQOyEVvkOJL2O83DI3UYBzVtSEaEMIpzCqozO0F2ehY=;
        b=LUGhV1hM4lSiMfJut49bsCyWlxE9bBgIv0BYhD/c68f0dyP4chEex43VO0HjGECLn8
         vC6LJWh5KX0Y+5JPYFbP1Y8wjcBrdLnF285kh/OTROeylflSMu1vDbGZHwtM6oRS29LV
         bShm3gxKztrn65SmCKmmyUhdqnrYIqiOBIYFlNv5ocKBrvNS2GoAn2bj1xgfGwbwsKdr
         569lMbYnZt+idn4Ucx/SzIhvH7PBzewwg/uaMWU4nYnZ+UQ5aSxditS1jcX9njz3sne2
         p1NVFgErVGxYzl+YuSSOk0tv/SdgWJXOj/wYVGPkhDQ9nCbCYwj/mZbEDPDO5GsBdgtG
         D8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQOyEVvkOJL2O83DI3UYBzVtSEaEMIpzCqozO0F2ehY=;
        b=clldyfsjGuOSFbZ6AxRaVuWVCYtvHLi/82w4cYr8ldtjV/7+MYkGXFM4yQU17GmXfQ
         tMJPLNAtmqmKoThBQaO5gjCpPuoW50RLx2t2wRXJf2BAgJKYmPNopsZ/e8FVOroIqg/u
         07d5ntKsHzJO0CJijtfsSa3ew7rgrs06wb+sefn7oc79UlPgO50ZSUcmwEEQKjUr5PHU
         pyowTdHRmzD+vWr9xBWE4uoL7zXshB9W0s6ervRLhuouMQgDxoqivGF0LOsRpaxgj99n
         gTNsPSvyqGFSFBevInJZAqIslseLoB4UuXq5z2PFuPOY7YnAfgRirSKcqXnBKAWZQxaX
         SAhA==
X-Gm-Message-State: AJIora9AAdp0IDHE0p+EVB7gEp/VcDR98tlyLniEyD/ppZv/j/mahI0Q
        1o7JD/BMbW9f/PvkdbSmcF9ecqTZRsUUnabUj6AMJQ==
X-Google-Smtp-Source: AGRyM1u38IgiG0U5f2CoPUsFms818bBD2ITxCAUhVuGu7Ttqjznp9wPrDXECN0JNJA3aCRZ/2Q/4pDq9x1jfenFR7jc=
X-Received: by 2002:a81:6587:0:b0:318:38c2:2fb1 with SMTP id
 z129-20020a816587000000b0031838c22fb1mr6855740ywb.118.1656199581552; Sat, 25
 Jun 2022 16:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220624133700.15487-1-guodong.liu@mediatek.com> <20220624133700.15487-2-guodong.liu@mediatek.com>
In-Reply-To: <20220624133700.15487-2-guodong.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 01:26:10 +0200
Message-ID: <CACRpkdaErxz-D6XQbTsAvPWAc+YSxGzzD+UfyP+Wv8YDAx662Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: add generic driving setup
 property on mt8192
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 3:37 PM Guodong Liu <guodong.liu@mediatek.com> wrote:

> 1. The dt-binding expects that drive-strength arguments be passed
> in mA, but the driver was expecting raw values. And that this
> commit changes the driver so that it is aligned with the binding.
> 2. This commit provides generic driving setup, which support
> 2/4/6/8/10/12/14/16mA driving, original driver just set raw data
> setup setting when use drive-strength property.
>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

All patches 1-5 applied, thanks!

Yours,
Linus Walleij
