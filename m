Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B561058C43C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiHHHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiHHHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:40:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72CA188;
        Mon,  8 Aug 2022 00:40:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x19so3180240lfq.7;
        Mon, 08 Aug 2022 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FjsHMZLmb/GlaNd8HwMmgPgxm5PKMOsuOi0WmrXGSlA=;
        b=JqTFHcQRg/bGHymFtU2WjDYJSsnpJgc/Lp7I7n/hQQeWcePrxqiIQR5cNxhPg2h1ut
         htB15WfjEEwuKWc7sdDDXmbzTmofeYlFPANeBKqdk1VHR9uCXwElMoM0JklCoaI3qWMN
         gQhsmb9JzoLTr87eW3W3c6OVDvF9zO3haq79hyuHy/VE9xQ8Y6yVf9y42YItsUMDAqQ9
         166ZC3NW5xtzZ3OFRejKhc26XmPizgB+upAILwR/A0sP4+vySjIucPwLU2tVdCjE4tLu
         DvpMnJl3Rc2MaeO665FBi39ofY2m5oUeJHsqE795Bb0l+ezONdj9U0TuWpJkC8vVUpO3
         nj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FjsHMZLmb/GlaNd8HwMmgPgxm5PKMOsuOi0WmrXGSlA=;
        b=fliy6sNaSJs14QvTEtZvhX3VRdOxeBI9EOUjo57y0mSNbjPZKf23wD+ZUxaku6CmIo
         gE75tmnEteGC1ZiX8cBxU7GsRzPdk5sXTHhwl6TjUfewdHiXvolhd994O6lKF+wlUqh1
         pRJCDWQ2Ilg8uaOcCXqzbavKqXNo5y+0IicEt4OB6Flr3n42rby4qG67AP7wV0MvcAd+
         5cFv4s77FMeusOp/x5gITAsdG5672a5dw9nuuURGW/T/w0rB+5ZBvgdxxuitZQJwVVgP
         jGsDPKRvEGD3Gt31jkYKHMTPMYmQ6lpRHOoj6NHygTCI42gC594FVkH1oWdMJAdj2DOZ
         Lg6A==
X-Gm-Message-State: ACgBeo1sp2lcxXValBZssae+NapUUcYxuVl3t+TL9seJB9nDrjqMegxx
        olG/lB/UUapkP9uUqIsl/mcMbekbQwSjUO2+raU=
X-Google-Smtp-Source: AA6agR40Oh1NkhpUPn/DplmuJHV4cYNWsZv3q3H5l9lDrB6jd+rIc9i/qlub2Q8awNxbIRVZPkwwKYyjZAZB/NCm7Rw=
X-Received: by 2002:ac2:5f77:0:b0:48b:3886:5d55 with SMTP id
 c23-20020ac25f77000000b0048b38865d55mr5402059lfc.668.1659944454775; Mon, 08
 Aug 2022 00:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220804181800.235368-1-tmaimon77@gmail.com> <10e93907-49ef-a3e6-e0b4-0b3e5f236f44@linaro.org>
 <CAP6Zq1ju4=PSiCuDaCi2NQTniaXBwmv5Qn6LoLayGmiayDCvYg@mail.gmail.com> <83bbcb33-1f6e-47cc-54bc-e0a5444c3609@linaro.org>
In-Reply-To: <83bbcb33-1f6e-47cc-54bc-e0a5444c3609@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 8 Aug 2022 10:40:43 +0300
Message-ID: <CAP6Zq1ggN_ep7nVLVc3d7D9Jnu2aaBTKmZnvO38-+m7gSvpMDw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>, minyard@acm.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your reply.


On Mon, 8 Aug 2022 at 09:26, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/08/2022 09:51, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Thanks for your review.
> >
> > On Fri, 5 Aug 2022 at 09:36, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 04/08/2022 20:18, Tomer Maimon wrote:
> >>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> >>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> >>>
> >>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>
> >> Your previous commit adding that compatible was simply wrong and not
> >> matching the driver and it is not the first time. I think all Nuvoton
> >> patches need much more careful review :(
> > Will do and sorry about all the mess...
> >>
> >> You forgot the fixes tag:
> >>
> >> Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")
> > Will add the tag next version.
>
> You received a bit different review from Corey, so to be clear:
> 1. Your approach is correct, assuming the devices are really compatible.
> 2. Add a fixes tag and send a v3, to get my ack.
Will do.
>
> Best regards,
> Krzysztof

Best regards,

Tomer
