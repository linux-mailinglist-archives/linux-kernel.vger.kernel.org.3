Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D45846EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiG1UQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1UQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:16:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC56A7539D;
        Thu, 28 Jul 2022 13:16:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3301321pjl.0;
        Thu, 28 Jul 2022 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nx0lYFPeFGBGctf9BUntX+MOfiVo2RC3lsZGIMCvKQ0=;
        b=M3jDbJMCKlYXno8dkQeGXH53S+ZT87D5pxt67t4rk1Kbmv9cLqsEtye6Vbz9QPdBXz
         0pGTHtkD6DPzx+dWbg1DsGHhvcddk53AsjaAkhwQg2z1FvorGPW4NN3OFCnCUjJ2g58h
         ga9h8V69nbt6lb31BU+t5VHQ/NwDd+wj0+29rBOwXnUTnvtEonaXKs5v/rcnONPuDxiT
         VBhxvGeTnFBTCseTNYm5y8zT5zRZQG7cdbuFx6O7jnc+TFWdXHcMTEypSdF8WahzxSPT
         Ag7EBmPSsx6wmZrO8stEYBvVQMXhKcG3uSQkUMTCc7OqO+jcWZT+WRjtOzbSRj+v1hIO
         /Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nx0lYFPeFGBGctf9BUntX+MOfiVo2RC3lsZGIMCvKQ0=;
        b=gOxpvNnlBwpZYBBbN64UjGDgufOvlnLmDOhcBR76h8XfsOAHUkXo8heTwJsUI7sPEC
         6E6KSYxESDuZL67+JMwdUHJTl4wieuP6ANOjxCt5o9GJxPmxwBlbcaB+6DCmgNpwH63F
         zTd9neI/mIWdDLxCk/2fMc10QybAYu6UjHzu87B2Fcixt6vNH7R9oKn4CpjWtI3BUxXp
         wPFLWsVAc9hwFXm2PW6HrlIBdij5YVAVt9x2eWj0mOQnasX3ZowR7hEsq5QmJ2nNuwBV
         q+4EFGrTLeeyANLrD60g6hqqej6e1UQ7FtY1B/VLwFn57kGgPoWpoGMPm72XWmtd7HIB
         piPg==
X-Gm-Message-State: ACgBeo2I1ON5IUt4bc34POc7LC2t67xrRiAFAOnVstR/FeNt9w3/Z6No
        dM+uL08WfqNk85ehxM2HR5I=
X-Google-Smtp-Source: AA6agR6QcO3uoiz26HvijSC2UBcobfHVPmy1T1pNv1JJzPmfjmB8e/Pw6HTAQXj7Z1Ii44gJA7w47w==
X-Received: by 2002:a17:90b:4c4e:b0:1f0:48e7:7258 with SMTP id np14-20020a17090b4c4e00b001f048e77258mr369041pjb.223.1659039388087;
        Thu, 28 Jul 2022 13:16:28 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:46dc:1a7c:6135:8f96])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b0016c4546fbf9sm1792494plr.128.2022.07.28.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:16:23 -0700 (PDT)
Date:   Thu, 28 Jul 2022 13:16:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: ariel-pwrbutton: use
 spi-peripheral-props.yaml
Message-ID: <YuLukz4H63om4dXH@google.com>
References: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:42:30PM +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.a
> 
> The binding references also input.yaml and lists explicitly allowed
> properties, thus here reference only spi-peripheral-props.yaml for
> purpose of documenting the SPI slave device and bringing
> spi-max-frequency type validation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Applied, thank you.

-- 
Dmitry
