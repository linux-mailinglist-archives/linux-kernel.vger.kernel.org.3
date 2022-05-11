Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8953E522878
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiEKA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiEKA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:28:47 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39005266078;
        Tue, 10 May 2022 17:28:46 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24B0SCDT013623;
        Wed, 11 May 2022 09:28:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24B0SCDT013623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652228893;
        bh=eoeQyILNpAXHdNEnfGHfs11GuDgXL7bPchGKRjAAw/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oa4CHnFgoUwqh5qOVwUo7M6QWN9GHHmtQKsTUHfEPvHDmgdBy9erJ8R6yUI9CQp69
         ZEKru8cY/Ah9GPAxx0HymBHPP5+YGFTTiag8lRfgd2EtNz+EDItvNC35z1FjA4c6KC
         czGUB25WM5WQxJkbp0AkDnfkKYfWiOwwB9jltJspfK2C5O/+WNTTlvWM5WWTMqyXRX
         vgkMXh8usu4z8E4PUrM9wJ89F2spVkg8km5CvBakcbpT+VNWi4y7eLVe23VlfGtil8
         ZNGV9nOEdgiEpN8xCS8vNA7vX6lDJUQnOBk6F9oMOIWHUeYBzyhOhzE0EVFPZ4xTbm
         Ri/fg9XbNwDsw==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id g8so576415pfh.5;
        Tue, 10 May 2022 17:28:12 -0700 (PDT)
X-Gm-Message-State: AOAM532wF7tTKHUpbMdICM30s1Vsyrv1OiXjcO1Dd06SL2mRluO5j7+Y
        d17axDOtOnzIUVxiDV8fBIjZShoFt/Ghm8+zPKQ=
X-Google-Smtp-Source: ABdhPJxTv910Z4TUpWxaA3EipGYAci26TlKtfsPlxzRcDpkrWHv54gLEcM88SqMzPFqOcFjQPgqLbgGADw0M7Ww93W4=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr22970054pfj.32.1652228892080; Tue, 10
 May 2022 17:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220510221333.2770571-1-robh@kernel.org>
In-Reply-To: <20220510221333.2770571-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 May 2022 09:27:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
Message-ID: <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove example file on dt-extract-example error
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 7:13 AM Rob Herring <robh@kernel.org> wrote:
>
> As 'dt-extract-example' writes the example dts files to stdout, a file
> is always created even on an error such as Ctrl-C. The resulting empty
> file(s) then cause unexpected errors on subsequent builds. Fix this by
> removing the output file on any error.
>


Did you really set it?


The target deletion on interrupt is automatic
since the following commit:



commit 9c2af1c7377a8a6ef86e5cabf80978f3dbbb25c0
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri Jul 20 16:46:33 2018 +0900

    kbuild: add .DELETE_ON_ERROR special target









> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index c9953f86b19d..c9fadff3dd74 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -20,7 +20,7 @@ check_dtschema_version:
>         { echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
>
>  quiet_cmd_extract_ex = DTEX    $@
> -      cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@
> +      cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@ || rm $@
>
>  $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>         $(call if_changed,extract_ex)
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
