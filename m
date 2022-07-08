Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4856C42B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiGHUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHUfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:35:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD10951D8;
        Fri,  8 Jul 2022 13:35:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z1so11448388plb.1;
        Fri, 08 Jul 2022 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9oMtVsB8lUT0YbjzM/SHMVvQBD98dTyWbO9nAQuZgA0=;
        b=oAhL1PVddOW35+VqF0q2kcCzrIQMhIk/9V1Hs3Wjk7AZ69oLC3UYGCfMxAwX1VNO9/
         OAiwIhewtH2cyu8iBmEm1+ZrawFB36pda1nUkPUj6UQmMDUKgo57Gf1dk7AGB6ADxpwN
         cjZf2DTqU8hg7ne7JcO/lwc1ffqfkD9QzjIwwrVs035Dc25ikEmc6i8wrCEVbDJN+cNy
         iCVdHDCnNKNjIrkyf9KgK3WTkLFWfhr/1s5XmxhgrQK8202qYTp60jigyEQ/X0frYZwT
         V1DfNAptEDQ7jxTbmpR8fjSwNyB2GHV4PLIQNGVXX7iHdBb5ygUwLDWI9B7h9AFyISdR
         XdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9oMtVsB8lUT0YbjzM/SHMVvQBD98dTyWbO9nAQuZgA0=;
        b=cOQMEZJH1gnAy7cUgw59w5e+TYYaJaqOEQN55pxRxKkvytS3D/OhUhBWHuIoWpCY4M
         18J8dLo7WsCppu3hBJhZmJGPbanihKUuy4mjBDuFWdfTn3IH7an+s334rzWUmtEvnrYf
         3uu5BXKk0Jons7bTQtXJpeKMc2atnR/dSHGDLgajFQXNdiKvJPXsGGsJglTp7DkUxpn8
         32iqqJTMItjso4/A2HhaMFbBc0WZZaJjzjAdwf6WU7ZPoSIjWCrZUTfmHLQ9fPYFDpRG
         yzzz8HDriSoLUPYWCjwl+FUdKCHIcwtnrp+2sVokQzI+GtQv2Lj4szEhaBsV7iRlfJWo
         47dw==
X-Gm-Message-State: AJIora8FhHjFfs3kch7BjEL8WV3uKvcSuCHBzFsYpBnDVjRy+h0yCpMi
        F+mWofGJKjNKkVi8BEHrDxWK+dE5wNM=
X-Google-Smtp-Source: AGRyM1vuk03P3xEgwbXTqUA32Dzpm3OhR0Da79S4GIwaJD3FcSH411NXstDx24be9lBdua5dOJaJbQ==
X-Received: by 2002:a17:90a:f686:b0:1ef:831d:fd48 with SMTP id cl6-20020a17090af68600b001ef831dfd48mr1833333pjb.183.1657312547119;
        Fri, 08 Jul 2022 13:35:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b0016191b843e2sm30505009plf.235.2022.07.08.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:35:46 -0700 (PDT)
Date:   Fri, 8 Jul 2022 13:35:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 0/3] dt-bindings: input: gpio-keys: apply via
 DT tree
Message-ID: <YsiVH41gCLeIMyd6@google.com>
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
 <352f27e7-0da1-4a4a-83a4-ded370dfbd7f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352f27e7-0da1-4a4a-83a4-ded370dfbd7f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 06, 2022 at 08:30:54AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 21:11, Rob Herring wrote:
> > On Tue, Jul 5, 2022 at 6:04 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Hi Rob,
> >>
> >> Can you apply these directly? You already reviewed them, but I dropped
> >> the tag so you will see them in Patchwork. It seems these won't go in
> >> through input [1].
> >>
> >> [1] https://lore.kernel.org/all/c2c1cf0c-9462-9ba5-a297-70d13a063de1@linaro.org/
> > 
> > Will give Dmitry a few more days first before I take both series.
> 
> Then let's keep your Rb for entire patchset:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I am sorry but what series/branch this series is based on? I tried
applying but there are conflicts. The latest I have that is touching
gpio-keys.yaml is:

4fda8a2df83a dt-bindings: input: use generic node names

Thanks.

-- 
Dmitry
