Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B9596A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiHQHqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiHQHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:46:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7B7C1EC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:46:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l10so12782883lje.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6BuNS9KqOjvtc7XbSSlIG6uXhAeWvKuL+ywpXemmpt4=;
        b=NEIEFh84FTjEE3hoQnBHGsHnaml+UzRG01ulZUBdBSPLfmtu9cAh9yB3kLXEb7LJeE
         yN0LDW4bsQPRBtJ3VdL5/mNd8P1D9WPPFwsiUq6PHZNEEBcc2cj2FMGm+AdQf6j/X0Pq
         br/nZF42BY83RTe61zGApXTy8rFTrDP3Vq4N781RggEjZZIlKg2tV9LTlsMIYdgeyVXY
         djq7euigLcDRRwW/Sze5J6+Ez4khEzp4dfQeDzZDK6eHwymbd83ILn/6dNQIsYxEv/Qv
         LPwZ7gLsUWhcYjq+ljDrIRDVlJsEj8acd5WDj1tx024HECd3+5RmVRH935EPwTvT/jLe
         9TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6BuNS9KqOjvtc7XbSSlIG6uXhAeWvKuL+ywpXemmpt4=;
        b=PcUpf276H7iXqFt39rgGZ7CJ3JA5aJyorK1uEl0SetRx7OAJa5GN/Ym2Au3bvj0py3
         68JAGufO3W8qZxjuLBtnDolYvQ7Xb2NqFm5Ib2oJolWjFdPE9EVZgWGaovLps869PtGe
         DjM1yM3BZHShW04VTzF+zP46l0wi61dbhTu8+6G+awOCyUbyoosgP42LLOgYuLch718g
         U8iSFU3yS6l9K64faSVUhcAaFPaHB33s6Hq++c+O7AGuRgGanA/qWOlgskRu+4sxEB8n
         yWoBLkYLQQmeY7DRdPUM1PZg7boWoJqeCwF/v5dZbrmz4A6Ro/bQOGjqgi5B8fdLeYoj
         PVFg==
X-Gm-Message-State: ACgBeo1rSAVIuo+3kI3nPS7Cky6nKcapNoUCzipxm6wBJFu1VH6ZoIvM
        9mdVwM8/8YYFC0QVVCpGKVtFMw==
X-Google-Smtp-Source: AA6agR7+bPFR57iuqYAZKnMHO1NMowGeL+VPcAK4pDjgtRZ+eqZjZeD9JBI30m3jn8ov9firTW4gGA==
X-Received: by 2002:a05:651c:4d1:b0:25e:5c72:43f0 with SMTP id e17-20020a05651c04d100b0025e5c7243f0mr7916432lji.164.1660722391873;
        Wed, 17 Aug 2022 00:46:31 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id b25-20020a05651c033900b0025e4ca99066sm2094142ljp.139.2022.08.17.00.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:46:31 -0700 (PDT)
Message-ID: <ee117d95-615a-e63b-64c9-c11f89b51123@linaro.org>
Date:   Wed, 17 Aug 2022 10:46:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: document Ampere
 Mt.Mitchell BMC compatibles
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-2-quan@os.amperecomputing.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817071539.176110-2-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 10:15, Quan Nguyen wrote:
> Document Ampere Mt.Mitchell BMC board compatible.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
