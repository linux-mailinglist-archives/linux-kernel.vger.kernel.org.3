Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B444AD2B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbiBHIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiBHIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:06:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923EBC0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:06:34 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E94D3F1C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644307593;
        bh=aIg1Mnd0MsRuc0b6irLRzxjnBZ54DYRs4G49zbj+BN8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Pq9qtTaAdCIQMvmypimTLZK+57hC+xGI7atOVLJHEAdlmRgQwpMP3RbgxmuVB+nGY
         LICu1GJoBDo5S6i9EstwBzl5ibPvVLt3v30az2pVzEao2lswGKH2EVhMO41/yEhkcS
         BxcOgU7H3kC7qCI+RKOND8BC+SnX2kEoP/l6tc3Tj4oYv2YWXKem1aEPvzzMSK5GrD
         OhbwJJmzSpI21O3Mu6N2COKL7AmRmRJfOwiPqGSO+1CWzd8+AXKXqlK5ewO8KL369p
         E9M64JzobaoGJWw5mBkaSC4lC+31ZSq/nZogf9t0MVG+Eg/Eh1fSB+ElC4aOlmnFfn
         TEO8L6FOwGjCg==
Received: by mail-ej1-f69.google.com with SMTP id mp5-20020a1709071b0500b0069f2ba47b20so5306817ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aIg1Mnd0MsRuc0b6irLRzxjnBZ54DYRs4G49zbj+BN8=;
        b=LQ36wfVGPYAojU0IlZTRfofgww81fZUIdW52okSKUbBpLxSORzrP7U2sI0U45Wpaby
         s8Ma549+P2Jf8lueVOq9mRpQWbvo7nbCtJF4bV4Y2fA5gxXUNRBeVRNKx3DgSQAJpG6u
         kUF/4pE5Rgaf36XM2tcWxsDtpj1oAF/tU54zMs1tEjZ5Kvf1BGjOTE0whgbZWKqZVer3
         T6J7xjaYLyN6tyl1REsBU65NywtNdz21hFYFg1jhkjyib4043pVXdcAXxeWbI6C20Yki
         tD1JY0rwrppK7LORYjFU3ySFIWdcHJGFIwscKJOBHECgIw5LmUNIqEgMkKiVsqITpW2l
         WaCg==
X-Gm-Message-State: AOAM5332DbWMBKepztKzrSMA0UmbsSW9hcOjoNiqY1HA6pqqvDZVpWDl
        AHMKZ53UaVwh7LSV5asv10nUILIk1L04OW43ZifzuxFpbIrpTMcKP/Ga3vwc5D4zPwFmxvx6bpd
        KdOInaTZGJkXI6RfmDQrxWyAsIidl5gmyLIj74kEh4w==
X-Received: by 2002:a05:6402:3608:: with SMTP id el8mr3063568edb.193.1644307592986;
        Tue, 08 Feb 2022 00:06:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUnXSjO8YsYH4lTQanThADpWVbnUnKzPBIL4Kb+jInbdPZKr0jkNmWBDoAZPQEa2lUtSr5jw==
X-Received: by 2002:a05:6402:3608:: with SMTP id el8mr3063558edb.193.1644307592844;
        Tue, 08 Feb 2022 00:06:32 -0800 (PST)
Received: from [192.168.0.92] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o18sm6312104edw.102.2022.02.08.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:06:32 -0800 (PST)
Message-ID: <9d31db2f-6754-6e9d-3bef-57cf9d5f9cf6@canonical.com>
Date:   Tue, 8 Feb 2022 09:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 2/4] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU
 support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
 <20220208063046.2265537-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208063046.2265537-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 07:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
> between Sentinel and Cortex-A cores from hardware design, it could not be
> reused for other purpose.
> 
> However i.MX93 S4 MU use separate tx/rx interrupt, so update
> interrupts and add interrupt-names property.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.yaml   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
