Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3458AA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiHEL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiHEL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:58:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14876470;
        Fri,  5 Aug 2022 04:58:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d16so1821033qtw.8;
        Fri, 05 Aug 2022 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc;
        bh=12EUweBf0CXLW8+gSAKKg9xplGZSYosR37oZCD2Y1Eg=;
        b=VT9RgJ+oVb09HdRQa6Lq62UkO+czbOAM9zhFz3mQzPOunpvHA/Dup3iDIDNBrSTcRg
         ISw6ghOW+btNX/HqH0k2wNgSXpUg9bL7XcttzO3HDDNNozk+y3dM1mVPrsLCuGG1wDEB
         zPDESdIoCLKl87M3ZHZOLwvWZcZCGfdRYxSeLVkv1UokGzv1nB/bnYzWf+ZQw+cvxeeO
         puAKsVq9rrDGTJ2pP8KskFUBBm5iQIXGPWMPTn0Fzqb9UMJ5bQb/k0gtuQPFCBlS4+N1
         kK6jb8sG7doAKbDSIiJhVitTkmnihXzpan+QM+ytoVxdChvksAv2+bOnb1FKMbKjMQbE
         tC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc;
        bh=12EUweBf0CXLW8+gSAKKg9xplGZSYosR37oZCD2Y1Eg=;
        b=wDByAgHNHZJ03deDYW2vEKKN/OA1nnGtxUt7DOTrHR/lVsi8rMVlIEMlGVgH88E5GU
         A8JenB0e7ck384WpGVpOyKwjHwWnAclWHSVPn6ZEe6aHKq92+9BiXKGcKUasVVJZjloj
         BE9uQGzUnjWznEV+XKSplBqZDmGxntS6/vc4osTcXOqMjeKYzvFFO2khP8HIp5h8ThLw
         ZuObo52DhhJtb+bOWWN+HDgb2+l7fn0poUJQzIHZQTpoUmxMzUKa/ANwpUalcA6cAfWP
         /pGPXM+T/fwqvAY5hK5LCvnRpoJ29Nb8+6JePLV15ZKre5summq35N5wvDNhbFQ4fxcs
         9Ufw==
X-Gm-Message-State: ACgBeo1gQoX60o65JtOKcTQN9vl6/Y8R8BCfCgBgE27gaHvzH+dXlOEI
        TpCiniKe4Jqg62HbgiuuwA==
X-Google-Smtp-Source: AA6agR4yn9VOrQApcMy/JIE89HsYzBMvrpAkEphl5ssbELPYZNrOf1zrKpwK4oe95pmrgYf1HSEKPA==
X-Received: by 2002:a05:622a:346:b0:31f:c40:eac0 with SMTP id r6-20020a05622a034600b0031f0c40eac0mr5373701qtw.326.1659700711064;
        Fri, 05 Aug 2022 04:58:31 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id c8-20020ac85188000000b0031eb51dd72csm2491484qtn.85.2022.08.05.04.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:58:30 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8c5c:a823:f5bd:8751])
        by serve.minyard.net (Postfix) with ESMTPSA id 4CFC71800FA;
        Fri,  5 Aug 2022 11:58:29 +0000 (UTC)
Date:   Fri, 5 Aug 2022 06:58:27 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Message-ID: <20220805115827.GG3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220804181800.235368-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804181800.235368-1-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> index cbc10a68ddef..4fda76e63396 100644
> --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
>  Required properties:
>  - compatible : should be one of
>      "nuvoton,npcm750-kcs-bmc"
> -    "nuvoton,npcm845-kcs-bmc"
> +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"

This is just wrong.  The compatible is supposed to identify the device,
not the board the device is on.  I think compatible here should be
"npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
used on a board named npcm845.

-corey

>  - interrupts : interrupt generated by the controller
>  - kcs_chan : The KCS channel number in the controller
>  
> -- 
> 2.33.0
> 
