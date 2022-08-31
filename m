Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A475A769F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiHaGa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiHaGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:30:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9AA9F0FB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:30:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z29so9975621lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WiaXfyuv+kgJFsOiubHH/NEcYq977WbeyAkqhNkB3Zg=;
        b=AncO6HHbkCn20ckslrlufvxRnBrOE/deoPgwzhdWiequpJlmrGjtK2ZHzMIcuRqaCT
         kyVggepsOBYl++4JHkkAovkE3fEngTbS8dVoyIDm+JGHINKhmDnFwTzw7kwBlE5qHJj2
         WigKh9BdGXNouCn8ifoF+eL/R9xdvZeKDgPj9VdbuAG9LSlmy5S8VGt7vIJ4Lsw/tSrW
         iTWUxbx90yPbObb7m009SLjnVnfdHd3uVm7zEZmckdgOTMA+1CHDDnbnqdkQ+JQ0mK0c
         LeOu3NwwE/ecszU3taGSUYtGi4jCi/4tvsmWJN4fUJKzqSPMVCrzlDZ36/kc9dWFy39W
         E3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WiaXfyuv+kgJFsOiubHH/NEcYq977WbeyAkqhNkB3Zg=;
        b=T39NRXzFeK9TUH9byhmMEPdXOYfFRpc/1GoUn81Ad1xtgGUpZSgJ3AESnwP96U9+AJ
         AnfG9hLEea/lj/OIjECwpzml+z7hgx3+7LUZNQb+6aWTvdupQ3YRV3imcxsNNs9IpvJc
         RrJFm0n97V7TZVf/rK4TrzJIsFM1L4suS6gZr7wGSKy/NNBRm9ONjRf4cVbNu/Gf48Dx
         q0bpyF7iLrseUDf2/AYiqWsUN1bTcEJq44DtLIEkvKUaqvJd+xBHbTrESJ/wPkVxjLOM
         qX19TzaM8Qds8GEIIpB5kD4YZ9Z5ITH3awaMgMgieDfZ2oJxEEH3Zxwk8dGZ7I65oJjK
         +nTw==
X-Gm-Message-State: ACgBeo1svHqxfE5p7/k8LcjwFuNmUTge3KKbUNB/kubmn6pQZRM27ucg
        qOr17TjG892xs1rSxBcXXv5C8w==
X-Google-Smtp-Source: AA6agR7Mfb50bktOxvDNqRirNcXkEGV/f9atPFgSSc9cjp1S+7dims1dW+OAwbO4KyMLocNw1BhPXQ==
X-Received: by 2002:a05:6512:22c2:b0:494:80e0:3315 with SMTP id g2-20020a05651222c200b0049480e03315mr1519978lfu.369.1661927431008;
        Tue, 30 Aug 2022 23:30:31 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512114400b0048a9e899693sm1885198lfg.16.2022.08.30.23.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:30:30 -0700 (PDT)
Message-ID: <b601f692-8283-ca10-b62f-d040f03940b4@linaro.org>
Date:   Wed, 31 Aug 2022 09:30:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: memory: Factor out common properties of
 LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-2-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831013359.1807905-2-jwerner@chromium.org>
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

On 31/08/2022 04:33, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> This also un-deprecates the manufacturer ID property for LPDDR3 (and
> introduces it to LPDDR2), since it was found that having this
> information available in a separate property can be useful in some
> cases.

Why do you need to un-deprecate them if you have this information in
compatible? This was not exactly the previous consensus. My statement
was ok for un-deprecating if you cannot derive them from compatible. Now
you can. This should be the same as USB device schema.

Best regards,
Krzysztof
