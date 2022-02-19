Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751134BC92E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiBSPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:41:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiBSPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:41:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BF60059
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:41:34 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4B6E3F1D9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645285290;
        bh=wVUHMJVViT2MtzH1YEUJhqVIF2mYs/hB4+17xc4P144=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MShxyA1qZtgDWuofED1JcNw14qkXyN8VLl5bwP8E3eKvg8xrL1Ntz23XsAWFvMUP+
         RQ5pSKJLhIsSs/uyUTn4uRdqItrgFnAh3VtHU5x+YstMNHi4pG8kTBl+jXzXR0AGs7
         gS3Jn7sBIhl8fN25wQN9Oemo+zqjhcssBbInFzfQkjBXH3OaTwP0hsUiPorDFhQ9s2
         9hOEjOQOJG8MKovL4IlMrQHztoRVCKepgGgO5MYt6H/15G+bgB2N/+8zFwjjD8bMj2
         SBBLvZ9MfKKwGYC52SYMdBDW2knBSqZgQH7OTkkYTO7Uz4axGhTXond9OY3lqQkZQE
         TFHN87xVxO+WA==
Received: by mail-wr1-f71.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so2800851wra.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wVUHMJVViT2MtzH1YEUJhqVIF2mYs/hB4+17xc4P144=;
        b=AM/rU0Ye8y3mGAX6ni6/1fEDTp3ul3i0pw2LTAtMXTXwB41mOr24OqhCo/6uvFZPXj
         q9VtE4rvBOyGyUn1w/J8yCkgzyAsgUX7huFcr+/8PNl8E4Gb1cEWx6qn6UjBUb2zZ6Tr
         l3+n4osCSP7GJViI7wYoW2RneTjRcA0Sm3PCgDMHzR7zW8cgZvfgvWS0l9GgikG9TTjh
         tkWvmjSFuz7VyYdPqFCAIWrXVTqjRlrcMK+SLVKI+qibAmJmijRyMc+S5CEQ6DJ3krAM
         zVMaaGgAY5gGKSVGQSlRtPY77uu+0Eyyogl3lGWj2IDuviR4CokggSsM46MPeFlaWNZJ
         bTjg==
X-Gm-Message-State: AOAM531z0905r7G4N18Dx91/zi6MOo4IYuYrzenHjoF9TfsentomrC93
        /dITCmdRZjRzJAIEpKaO0wTL/xq2v0ATGRzETe+370dCGeKdDa+5sB3CRzMZ7WB39OHluSfmY9k
        B5mKDtqLBarsu8HZOq5x4Q/xhQz0S+Xn89mVusOg77g==
X-Received: by 2002:adf:a45e:0:b0:1e7:7348:45a3 with SMTP id e30-20020adfa45e000000b001e7734845a3mr9948265wra.32.1645285290108;
        Sat, 19 Feb 2022 07:41:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVwizRupAclUY7A+ZD/YSEVUkhffmcUEWcFX/2fiVD7wTSvBgpDdolg7LuorSVTAOME2ccGw==
X-Received: by 2002:adf:a45e:0:b0:1e7:7348:45a3 with SMTP id e30-20020adfa45e000000b001e7734845a3mr9948253wra.32.1645285289887;
        Sat, 19 Feb 2022 07:41:29 -0800 (PST)
Received: from [192.168.0.116] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r2sm3203332wmq.24.2022.02.19.07.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 07:41:29 -0800 (PST)
Message-ID: <9d33314e-97da-dc47-8361-2e45b75fa566@canonical.com>
Date:   Sat, 19 Feb 2022 16:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220219012457.2889385-1-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220219012457.2889385-1-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2022 02:24, Julius Werner wrote:
> Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)
> added the properties `revision-id1` and `revision-id2` to the
> "jedec,lpddr2" binding. The "jedec,lpddr3" binding already had a single
> array property `revision-id` for the same purpose. For consistency
> between related memory types, this patch deprecates the LPDDR2
> properties and instead adds a property in the same style as for LPDDR3
> to that binding.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../memory-controllers/ddr/jedec,lpddr2.yaml       | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> index 25ed0266f6dd3d..37229738f47271 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> @@ -30,12 +30,23 @@ properties:
>      maximum: 255
>      description: |
>        Revision 1 value of SDRAM chip. Obtained from device datasheet.
> +      Property is deprecated, use revision-id instead.
> +    deprecated: true
>  
>    revision-id2:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 255
>      description: |
>        Revision 2 value of SDRAM chip. Obtained from device datasheet.
> +      Property is deprecated, use revision-id instead.
> +    deprecated: true
> +
> +  revision-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2

You need maximum value under items.  See:
Documentation/devicetree/bindings/arm/l2c2x0.yaml

> +    description: |
> +      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
>  
>    density:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -164,8 +175,7 @@ examples:
>          compatible = "elpida,ECB240ABACN", "jedec,lpddr2-s4";
>          density = <2048>;
>          io-width = <32>;
> -        revision-id1 = <1>;
> -        revision-id2 = <0>;
> +        revision-id = <123 234>;

Don't change the original values.

Plus what Dmitry pointed out.

>  
>          tRPab-min-tck = <3>;
>          tRCD-min-tck = <3>;


Best regards,
Krzysztof
