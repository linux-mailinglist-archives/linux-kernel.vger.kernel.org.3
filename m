Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059D4B8589
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiBPKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:25:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBPKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:25:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D412206DE2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:24:52 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3EF6840811
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645007091;
        bh=rqHY5+dH47bdmvTAOE4I27WoThPEsLrYxKjIJ+9uRPc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=t2K5SaTyM0+QBm9B17TqJ60JWDVecCoAM77N2OQczzEkXqdf4orAom2La9/BV06b8
         Q4sYtWXbv0MzDUC+293xCoDga+/5mIt09R1vM1LYewbmellbyfPSl6KzCplLuobQgF
         /LpPI8dmol6fLfP10bgejNKCCdLFtWCiAfMH1Z7Alvofe4qWBia0yb8KQpmtcRVjsZ
         MagCO0T2rwZlsY03ip85NhV2QAqS9rnyzsQP9hDen8HcLCyPo5cKxYYc8UvSFYrvRp
         ry6ekmQC4ZRLuYcY2E0zDUF3D7t4sk9edy/UMV+Mo89rJG7ZYn2EAwtnB+NCoQPi2N
         QXcpmdYbEORFg==
Received: by mail-ej1-f71.google.com with SMTP id la22-20020a170907781600b006a7884de505so624542ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rqHY5+dH47bdmvTAOE4I27WoThPEsLrYxKjIJ+9uRPc=;
        b=2nhQpU5I89C50AAVOabo9c8LGuTxI02PHUCBc7cvYwNE6ke6gfs3xgqCZbj+utq4aI
         UjzROGW7uvlGXj+xZklC9XNscdmcYyyhHnPwXI2QxH1E9yhz6gHwmTLNajgN7g+a9el8
         QGLCSlt+T0B/aYnJlHlQweKdV42eCYrRZQlJwT8xevRRTAqE5UdQioPc99PpKhZ0Vs5m
         lDRahqnpEXnRnrBJxPWbLCiv+hIWx82SOdWP1yjlaOk+OXM+gyZjYRZMrEgjHp8iNWQn
         5cjMmnB9RaPIKh9jvcfVC4f0MmuDFs1p+kIdnBvz0iImYqFIcnYmY0AyLfxFY1/WCQ56
         kw1Q==
X-Gm-Message-State: AOAM531lcUxAQuI048zVsc7/dYYVKvNEvGZWD9lXnm49/ivVKurDbhft
        FdHAYMXqursECn3jahr0RW3E9A7bCj0/f0SlwUGnql1UsXqZnLjmBZ5FgpRuUv6jLIpkkR5Lgnd
        8Ss70UJmyE0kjH0lY0RbHWo1Q/YARYgTkNjjuoOac3g==
X-Received: by 2002:a17:906:4698:b0:6ce:470:b423 with SMTP id a24-20020a170906469800b006ce0470b423mr1645429ejr.103.1645007090698;
        Wed, 16 Feb 2022 02:24:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjS3anZMmuOoVB1rPmpKsUJ3j2HrcgXBDQgzSEahKYbh2GBNoejxW3vRXYop71p/5TLP3Aug==
X-Received: by 2002:a17:906:4698:b0:6ce:470:b423 with SMTP id a24-20020a170906469800b006ce0470b423mr1645414ejr.103.1645007090555;
        Wed, 16 Feb 2022 02:24:50 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm5054733ejn.50.2022.02.16.02.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:24:50 -0800 (PST)
Message-ID: <d229d163-223d-7481-cfdc-c83bcc2a2eb6@canonical.com>
Date:   Wed, 16 Feb 2022 11:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2,2/4] dt-bindings: pwm: Add compatible for MediaTek MT8192
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     allen-kh.cheng@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-3-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1645003971-16908-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 10:32, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8192 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
