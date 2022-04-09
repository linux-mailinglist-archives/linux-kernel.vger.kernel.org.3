Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC184FA7B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiDIMhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiDIMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:37:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43168C16;
        Sat,  9 Apr 2022 05:35:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c64so696923edf.11;
        Sat, 09 Apr 2022 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F3H28syRAW9Yk8B6K22CaQ9bKsRYRwYHM8AZg2nTTg8=;
        b=dOeN0Le7pIzazYF9XMsOEzUATiknJIh/v6KWPn5+gf/98EpS/UojUsMQ3kk+Fz1MbM
         EXlu5YCZIAzDj4ka5vXjMzZB+lLw1yuhjdOPgrtihHNMriZ/lWixLDyGzRxeJpMFdNFP
         15F7jfOEbdX9huyf6i5DBbqgc96KJqxMCk6yrnF0TiZ3H0o52tHzxSs780Lnm+jqC9+J
         yZzq9tVuiWosc/Tvez2WBOUjRe5AN+Tcok6eh+cSO3CXG9TNnbOVj/8fWGlY+QIxhrLZ
         xKSyZiOViOTyt3MFMUVdwPNec02H1KXdiQGBElgvfWKuTqpoGE5My2hcGWfDONyCO00c
         gQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F3H28syRAW9Yk8B6K22CaQ9bKsRYRwYHM8AZg2nTTg8=;
        b=QYAx8obbjMofotOjClw095GXWcQXHmU397CwzH58Azomd9O5icnduqQG7KOiDs932j
         FpTjyV6PQDBqpoG3Vg2gkK1DvV9adnZAaqI60u3+DZjdYFKjcEztu2BC97gmpajPF53W
         LWOe6HKA6e5G6fywm6WMia4HtvSWJzrgo2OqNCkZMSByxqNoVSomxeNyw6T8GYPgo8r5
         i6yH9fgWohZU5fSKx1X2hBmcne2X1zJDkgwkF5amYhiJOh1smDDuL5mRq0mjtH8H/hgT
         PFHYpXSARJGR+rwtYlb6UOq5iXEzoE4VqQZNCi28T4c4qHpMEhMZja40Yp5yrCS5nJX+
         A5vQ==
X-Gm-Message-State: AOAM533iNQp3uBb3wDlLHvwuG/At7KEpJ509F9MMOKQumZ7pGZgEAJPc
        EutRxYCULp5UmWjSqdWf2sU=
X-Google-Smtp-Source: ABdhPJyxfWA6vAGDY6MSvC4xFoAahBQI/WuzWYLCHoffLpzNvCCkGLZhiBGVdaCFKXvPfJ0N5pOH2A==
X-Received: by 2002:a05:6402:4496:b0:41d:715e:6598 with SMTP id er22-20020a056402449600b0041d715e6598mr591975edb.407.1649507704858;
        Sat, 09 Apr 2022 05:35:04 -0700 (PDT)
Received: from ?IPV6:2001:470:9898:9eac:f1cb:6e16:4fc0:c830? ([2a09:bac0:79::82a:3425])
        by smtp.gmail.com with ESMTPSA id l19-20020a1709067d5300b006e8488d9a80sm1866676ejp.59.2022.04.09.05.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 05:35:04 -0700 (PDT)
Message-ID: <9cf4e596-83d7-00cc-afcc-585309cb4852@gmail.com>
Date:   Sat, 9 Apr 2022 15:35:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm
 parser
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Karim <Karimdplay@gmail.com>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <1649339427.653492.795407.nullmailer@robh.at.kernel.org>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <1649339427.653492.795407.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 4/7/2022 4:50 PM, Rob Herring wrote:
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.

Thanks for your great explanation how to test! I found and fixed a mistake. 
How I have only one WARNING: 
"added, moved or deleted file(s), does MAINTAINERS need updating?"

I hope it doesn't require additional change. What do you think?


Best regards,
Mikhail

