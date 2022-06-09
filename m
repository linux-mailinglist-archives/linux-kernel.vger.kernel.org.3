Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3354536D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiFIRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbiFIRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:51:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9131AEA7;
        Thu,  9 Jun 2022 10:51:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h19so32235035edj.0;
        Thu, 09 Jun 2022 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=cfnFNEELhJfGAq/OjhFTkSl+Ek4qHu5L5VyE1+b7HTY=;
        b=e93IIVKnlvb402Ftt9aZOW48kNScNs12uI9NjAPZ6RBwjOYTq0TFHjOZgSelyr1pqY
         cNXCnzB7pde0fmWKvaUI6X2jJLkMgc3MAJye6X1fGCMgl0EpLqZ2oCIZOFe+ItaV4X5/
         YYux3bUNFJo8dgz75sq5W44HGybT9VSXohjQUox1cWKnM/Wxf2gIpm9N1aMxuxGk6wZ4
         JFWES8SeePyv2NNsQFI/szWWIWfpVfnofb8ejHPiYfC1LUUTGwrHXE7pvdMB+Ea7xAS8
         AZhrlqL7wqo8E4Go4FOmqxZnYIMwNvJeUEkMTPBe/crVfVInGg5C+EIPj55+b3g1D4TM
         yYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=cfnFNEELhJfGAq/OjhFTkSl+Ek4qHu5L5VyE1+b7HTY=;
        b=GaTAlxUj9f1N5AoiBSS/fem0lOmD8emFvSNJfVQP+CAoMwbV30UINNiXj2KGmzmRcU
         drJ87L/2pzT71HF3CC/HlyTKhHUFtOHNfZP9WMgP0FvYtazcI9QDBWw1FdGwxknBAnWc
         4qg3sKbxWaziFMIFC8rrjXWwE81PRJhZkwzaMOuBmTnyydCbe7IZ6u5FafhCOImCQdAf
         VglApO/nU7xTpC5dlcWxx1B5rKJmo3mMc9FGctG4OaEvn8WLZCG7cpoKPjP+IWEzbGAi
         8SHN3U0uNXJvJOjN/k0Ju8V2+ldpOxhzt3yaGaMTK9fQuRS90LeYnlOh361S4O3pEB8r
         190g==
X-Gm-Message-State: AOAM532p+H4yw1Jf5SAwaZb+nPfNgJkqNc8gsHAZqCpg/SU8guxf2nkV
        lYxx5vYb7RyyPoe0vBe1aIY=
X-Google-Smtp-Source: ABdhPJw517rOIR4mHIiR+isPEkhFdVM+dJvQny5LZ2Cl9wto1cn5fPQdgomcbox5pf/JWlfD+KF62A==
X-Received: by 2002:a05:6402:1d4a:b0:42e:93de:17f4 with SMTP id dz10-20020a0564021d4a00b0042e93de17f4mr38464878edb.8.1654797098116;
        Thu, 09 Jun 2022 10:51:38 -0700 (PDT)
Received: from localhost (92.40.202.100.threembb.co.uk. [92.40.202.100])
        by smtp.gmail.com with ESMTPSA id a9-20020a50ff09000000b0042fb3badd48sm10678142edu.9.2022.06.09.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:51:37 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-4-aidanmacdonald.0x0@gmail.com>
 <d5465a36-f18a-ff48-b13e-e5f9c48a398a@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/17] dt-bindings: mfd: add bindings for AXP192 MFD
 device
In-reply-to: <d5465a36-f18a-ff48-b13e-e5f9c48a398a@linaro.org>
Date:   Thu, 09 Jun 2022 18:52:41 +0100
Message-ID: <SAOEKBJz99Moqt4btaOY5IlUjs9zZAvh@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 07/06/2022 17:53, Aidan MacDonald wrote:
>> The AXP192 is another X-Powers PMIC similar to the existing ones.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>
> You got here ack, didn't you? Why sending without it?
>
> https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/process/submitting-patches.rst#L536
>
>
> Best regards,
> Krzysztof

I'm sorry, I'm pretty new to kernel development and I forgot. Will make
sure to add them in future. Thanks for pointing out my mistake.
