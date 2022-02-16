Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01CB4B8153
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiBPHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:20:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiBPHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:20:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1DE3C62
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:20:01 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 172533F4BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644996000;
        bh=7w2DeuDBNiRSAXfzi3M+RcvsldsGybZXzRUnLDhYfvo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YjEcJCttEwoc00rju/iqMCvGrK0JtWIo9G5/brW50HPJRO2IfWVOradwpsL63TPcA
         gh4Uk98I2laeUsfHprNok0b5PJ7ZaEpJV3kAgEtpqFObyEvKzzSqlo+ielVWXWaShb
         dbPZ22KkPx+abbGJnpYOSspf6ZI7vJyX8D1L6njmytuy/8OGt2FpuK2vDBHpESE7gJ
         nA5nsCrEPkI/osg2ljvS+otrhU23p3qEVCM16fgbncA2TFFpatscA4KzLjUrPu5ODW
         zm7b+uCf9gEsnAVOBy3qhp8/DHeCk+ofJD2TGXzMFcKNjbr2UlQXwPn3GMA+hVpx08
         /rdEm55j7UiTQ==
Received: by mail-wr1-f69.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so669714wra.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7w2DeuDBNiRSAXfzi3M+RcvsldsGybZXzRUnLDhYfvo=;
        b=NsS92/SUOxs8SSC95rAc5uEf7kAw5hFZ+VOgCMP2+md8n5RNF4j58U10R7bcT3MCEt
         RKufohqMqlCBWw7uiYa5pLNNXZugAdbZTB87uHz79bfaxFgJruAb2MT+X175EvKCigQj
         10NB2eEawLBAVlln9aTOb7/3EHjGXgdSfSj+c7d+lQQ6ed8vfx+K9qqMoDn59RZeCYSp
         4l5p3/OPNOjKG/ilqcdcz/U50GRchortcZdo4rZHEcPXGwOXznOkYx9EzeJzaf+cIP53
         OoO7lb782Gp4sJgLrn8WQtaCXj9ZCZyecx1l1EQus/tYc53En3AmS/tBYYk94O/N3+Jj
         tzRQ==
X-Gm-Message-State: AOAM53021AxkdXcD60kEFDoSMnDl7WqeHuluXAoVv8YdfGUPmwMbEfQh
        4mlAV15umbEJXr5gAnF7VttAxIF5FR5zptQ5evhS6zNbSP+EM82ukJytve6GtiFkFhkepbj4xrw
        QvhmHr7P4QHB6rHInwTPRrJoqS0o8SqxY+TSxHoqsUw==
X-Received: by 2002:a5d:5045:0:b0:1e3:20ed:4386 with SMTP id h5-20020a5d5045000000b001e320ed4386mr1219898wrt.262.1644995999856;
        Tue, 15 Feb 2022 23:19:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb1VVbNY7bGK3DwOXT5yvrd8OpjtnZcWQy8cN8iBkRu2VOhrUSKcPJ5EqScPCYI1d3U5+FbA==
X-Received: by 2002:a5d:5045:0:b0:1e3:20ed:4386 with SMTP id h5-20020a5d5045000000b001e320ed4386mr1219896wrt.262.1644995999743;
        Tue, 15 Feb 2022 23:19:59 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d6sm34450578wrs.85.2022.02.15.23.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 23:19:59 -0800 (PST)
Message-ID: <81b4dc29-1402-7eb8-d2d9-c2f09af4c1ab@canonical.com>
Date:   Wed, 16 Feb 2022 08:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: ps2-gpio: document bus signals open
 drain
Content-Language: en-US
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <20220215180829.63543-1-danilokrummrich@dk-develop.de>
 <20220215180829.63543-3-danilokrummrich@dk-develop.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215180829.63543-3-danilokrummrich@dk-develop.de>
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

On 15/02/2022 19:08, Danilo Krummrich wrote:
> The PS/2 bus defines data and clock line to be open drain, this should
> be reflected in the gpio flags set in the binding.
> 
> Especially, this is important since the clock line sometimes is driven
> by the host while being used as interrupt source.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
