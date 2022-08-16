Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD8595A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiHPLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiHPLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:44:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E295A2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:17:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w5so14467388lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DnBcbykCjgjoLCVXUKOX/+T3fFd+3MmvxDCHpKOOzXY=;
        b=DZxwtA4FyMl0z6PuJe5QAb+MASfLY57qimpbuVts1iYoLObAkpHlyCBK/IQE7tWGOr
         ihXUa9Y8VSgJoCmtYvfgvVZUjCtvWfwS78bjL8LGWk7WZKohUqs/cJ4ccR4tsWH4C2yH
         R64R4ux7EDnVTDdTaslRTB3X/y2NjhagfPDsGnK1Fk6qwQNoZIzYzJtJuQ6QPe/EYvRI
         5P9NhuUFAKVriM3Jc51BMhj//DrTiB37wx49pHlYxUgrnhh7neVoNA+FYbbmpm1MvhRQ
         2/WS+jowuBhf9KHo/9ZZqUfhdkCdD8ZQ37EdriweYSNdKS66IP1dRdBAcpkG5e5tWaLR
         VH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DnBcbykCjgjoLCVXUKOX/+T3fFd+3MmvxDCHpKOOzXY=;
        b=VvtJVntQEz1hBaiF492OhFbYF1atzuFhD0ip++AMTRt3bkVBQ1trbNycOFzxBP3gG/
         2WxVTqSJxu/acG53p9fEcfPse+YLwHd3Le0pqc4ZzaWE4ln8RBR/GVcXfbNbsPBL4aNQ
         inktKeyoBFsOiZdz0j7lUGvV8ixI8XTOK814RP1e7IbcHVhfNRd+wLaXnjqvdANp0ZCJ
         X1PzOD7GvqX8AZAjIdCQJrvWrK+5choQ6kWuW4gL7+JcKh2pyCEsyLzdOfPdM4RP8oDW
         Q5sQwqeRDuwV5/H1f77El0qT5QsbtiVxJXgMYPuU24bYnhRPOg3qiOhRJ8WAyczXEcpA
         LyWQ==
X-Gm-Message-State: ACgBeo3fYJr3gGays0RYyLv/caV3GvkPXlc8Qp97GFVoPGWWl6Pj4b3K
        q9p6Qa7DXcNKpCcv0cZwsDcsuQ==
X-Google-Smtp-Source: AA6agR6xjFFQtSED8gZoiFVO4nfTINML2Fbso7I7IHeF7JLH+EokSoD61FgiZY4mfRhy7u12dRcFBQ==
X-Received: by 2002:a05:6512:4004:b0:48b:363b:fdc6 with SMTP id br4-20020a056512400400b0048b363bfdc6mr6505378lfb.448.1660648652293;
        Tue, 16 Aug 2022 04:17:32 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b0025e5755fd16sm1752920ljn.36.2022.08.16.04.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 04:17:31 -0700 (PDT)
Message-ID: <f518afbd-be7b-283f-bdb2-7c7cd9d20ae5@linaro.org>
Date:   Tue, 16 Aug 2022 14:17:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: microchip: use "okay" instead of "ok"
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20220816103613.22806-1-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816103613.22806-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 13:36, Robert Marko wrote:
> DT specification only allows "okay", and for projects like U-boot
> status = "ok" won't enable the device at all.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
