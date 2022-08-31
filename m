Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3145D5A7585
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiHaFSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaFSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:18:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18FB14D2;
        Tue, 30 Aug 2022 22:18:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d68so11021862iof.11;
        Tue, 30 Aug 2022 22:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=OhzkqHGbSB+HsuKP/4ZGFDl1t+6drCgoBC84BpCYc3Y=;
        b=Dc9ArdeaWC+iI+r0K6YcTRWB0CXqPPhZcPiuqeuUXWsVn4skyClXIX3Nm9Ky0uQtr7
         u7DP5wMQiDzXJpVoNi2SgonvoD6alG6pi0ACmW42Fjy9N0R5OdzXCaGUYGMKu1MLA1TJ
         iUszJ4RFvwRGcQJEUhpHn+q756gdEycDrrsVs+w/3RbXuP90iIYaeYYXP60DrRQxLBTg
         txU2BPrjgAxU2YsnwDUWkSlvcstsAYiNY8w1JI8whKGIuDwO9mAlLm9xI0+Fhxn3JzZ4
         GSymZdwtxRFoLNZCZ6y9byoZpBk9Q9cWVkx6/T8cnehfyUoxN2Uhjvw3r/uN2bNH1P8w
         Iv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=OhzkqHGbSB+HsuKP/4ZGFDl1t+6drCgoBC84BpCYc3Y=;
        b=RRTtHkhCjWyx0PO05ohNNOnPtDBwNQ+jQavxSysY6OrbMc/Vwutl2G2+f493I6H9aq
         juan3Majjrj+Q4QC1lc3ABfh0WRLk8vx5XJZrZmT6MwfOcul4jqN9orIH/GWKRFIlPZj
         8KrLu49hYi6ZKsihhlmRCvLOlEHyvf8oS5HXOSWiE5Lme9LGqXTTJ8YKjl8eX4RmqIdQ
         mvZqV8M40OhwQe/Rlk3VWNV3uRm2buBZJSMkriGggnzMv/nz1Y1ACvOeDcTCE3dSjNFC
         2hjHZN2hE76odGGV/5m8GDDwaFEBSEApIguBWC+PZHI8yMYVLtgqhZh63sY/B3DE4KmF
         npmw==
X-Gm-Message-State: ACgBeo1rsIsjxRlvs+YAjm8hE4g3ibe3H7e0VgfY2JehHpwRj4IG8gEE
        +0BUuKRO/wiPAMscAH7Jy/Szs0dz1Q6lKPnB/b/PCfCZyTs=
X-Google-Smtp-Source: AA6agR73HmpKxyuhHxBXsBUIZwuP/fN/k05piWsE6mnbpFbf+Y+K0gByDChr4s14QM2KZy8u+kNSWfBS//wGY60do/4=
X-Received: by 2002:a6b:e50d:0:b0:68a:656:81f6 with SMTP id
 y13-20020a6be50d000000b0068a065681f6mr12617305ioc.31.1661923079793; Tue, 30
 Aug 2022 22:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com> <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
 <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com> <c2f86a2a-a30e-5fac-de6c-6a28edc5bcee@codethink.co.uk>
 <6d58cdeb-044d-b83f-79a2-fb9b86491c8b@microchip.com>
In-Reply-To: <6d58cdeb-044d-b83f-79a2-fb9b86491c8b@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 31 Aug 2022 13:17:48 +0800
Message-ID: <CA+ZOyah1Dwf1L9Mn50+v5tLToyktmmASeA5CutW5uwNybDG_Ow@mail.gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3 cache
To:     Conor.Dooley@microchip.com
Cc:     ben.dooks@codethink.co.uk, ben.dooks@sifive.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Conor.Dooley@microchip.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A81:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 30/08/2022 17:49, Ben Dooks wrote:
> > On 30/08/2022 14:49, Conor.Dooley@microchip.com wrote:
> >> On 30/08/2022 13:58, Ben Dooks wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> On 30/08/2022 13:56, Conor.Dooley@microchip.com wrote:
> >>>> On 30/08/2022 13:51, Ben Dooks wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now the content is safe
> >>>>>
> >>>>> With newer cores such as the p550, the SiFive composable cache can =
be
> >>>>> a level 3 cache. Update the cache level to be one of 2 or 3.
> >>>>>
> >>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> >>>>> ---
> >>>>>     Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 =
+-
> >>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-ccache.=
yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> >>>>> index 1a64a5384e36..6190deb65455 100644
> >>>>> --- a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
> >>>>> @@ -45,7 +45,7 @@ properties:
> >>>>>         const: 64
> >>>>>
> >>>>>       cache-level:
> >>>>> -    const: 2
> >>>>> +    enum: [2, 3]
> >>>>
> >>>> Do we want to enforce the cache level like we currently do for
> >>>> interrupts and cache-sets?
> >>>
> >>> Not sure on that, for the P550 cores the ccache is going to be level3
> >>> and my colleague has said it does confuse some tooling if the level i=
s
> >>> not set correctly.
> >>
> >> What I meant was:
> >> Currently we enforce the correct cache-sets & interrupts based on the
> >> compatible string. Adding enum: [2, 3] relaxes the enforcement of the
> >> cache-level for existing compatibles and does not prevent someone from
> >> setting an incorrect cache level for p550 cores.
> >>
> >> I think that on top of adding the enum, we should add some enforcement
> >> so that the cache is not incorrectly configured for both existing l2
> >> caches and for the new l3 versions.
> >
> > Ok, we can add some enforcement once we add the new bindings, but I'm
> > not ready for that today and I'd rather get the current queue sorted
> > out first before we come in with newer silicon which hasn't hit the
> > market uet.
>
> SGTM. Maybe this particular patch could come at the start of the
> series. And then we could add something so that the end result looks
> like the following (white space damaged) diff:
>
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml=
 b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index ca3b9be58058..994e4b143485 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -33,6 +33,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - sifive,ccache0
>                - sifive,fu540-c000-ccache
>                - sifive,fu740-c000-ccache
>            - const: cache
> @@ -45,7 +46,7 @@ properties:
>      const: 64
>
>    cache-level:
> -    const: 2
> +    enum: [2, 3]
>
>    cache-sets:
>      enum: [1024, 2048]
> @@ -115,6 +116,23 @@ allOf:
>          cache-sets:
>            const: 1024
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              sifive,ccache0
> +
> +    then:
> +      properties:
> +        cache-level:
> +         enum: [2, 3]
> +
> +    else:
> +      properties:
> +        cache-level:
> +          const: 2
> +
>  additionalProperties: false
>
>  required:
>
>
> That would keep the enforcement for existing caches and allow you
> the freedome to do w/e you want for the ccache0 compatible.

Thanks you all for bring me here,  we actually have some core series
with 4096 cache set in ccache, should we need to extend the cache set
as follow? or we only need to focus on the DTS which is already in
mainline.

cache-sets:
-    enum: [1024, 2048]
+   enum: [1024, 2048, 4096]

>
> >
> >> @Zong, could you please incorporate Ben's patches into your V2? it
> >> would make it a lot easier to review what's going on here. It may
> >> also make sense to add the compatible for the p550 cache while we are
> >> at it...
> >>
> >> FYI, there is also this patch here outstanding against the l2:
> >> https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conc=
huod.ie/
> >>
> >> I intend taking this into 6.0-rc5 or so as a fix, so if you could
> >> rebase the series on that so it is not lost in the dt-binding rename
> >> that would be great.
> >
> > Do we need someone to take charge of this series?
> >
>
> Can I volunteer Zong? (since all but two of the patches are theirs)
>

It is ok to me, but I'm still refining the patchset for V2, and I'm
not sure if we will need the V3. Do you prefer to take V2 patch set
first and replace the dt-binding patch?

> Thanks,
> Conor.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
