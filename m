Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966446C0AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhLGQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:30:59 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55564
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239631AbhLGQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:30:58 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ECD6B3F1F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638894444;
        bh=xM0l6E3jMAiAL33QZvvnbCIHqgFt7ZY4OmXToVTpadE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ObgLC9LZJ/iwPo3Tte5xYQO/4ThNZVpvrWfOX4ItFgrLvj1N6SW3AdU9F4aTbGdZM
         1cToYTp54XUISo2F/R36hjqnBF3Y4JWlxuU1WdIRcW5muoRp+0UX/f52mScGCsLZeI
         MuizMMqbdR4axJLa6vEr0mEZobsQv8Eq8W2TTQSr++Vw9eAHlCprLd508FY/lGp01s
         U+05e8C93KlIDsBUwR7njOpHB0nGmvltC6LC68gQyfx5A8YV7uLP6aT9uNV0m+ovKP
         Pbmmq+4z0q550splcmId/8l3Nkadni37f+XewloScA2i6Fr0SCOJt5JEHoxCy96LT7
         WYC7DTcJTsOQQ==
Received: by mail-lf1-f70.google.com with SMTP id j9-20020a05651231c900b004037efe9fddso5575686lfe.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xM0l6E3jMAiAL33QZvvnbCIHqgFt7ZY4OmXToVTpadE=;
        b=gaL36bOZzORI7/2fzL38Gw8LqBBYxwSzcAcClLCtHbybuETYiql1Vxbtqw/g6E9miH
         Oa5x5jFrGwcZpzuKPsFxqKZvAoDW0S/59mRXYV149gGqINp/FZfOhVccvUmSC3fkGOWi
         frVAgx1IRAgyIjGzs1rsXycLy7/UhoTULUsC/T0FjWqoPZf63akjkIid0lYdzhapcH1A
         KllgJH9BSlsii8zNFrLoLpu8qqeR8vq8nCfe0bmLHln5ZPONGvuZdLRZjjvR/TlhDt5g
         tf8KVe/KMSwx8FS/Pmw1XgTiTguaypJ7tresX5ouwZJYimvQWiwwjfTkOOP6opvTKqfu
         WK5w==
X-Gm-Message-State: AOAM532tpSik1WMrD60jikf0J65kyRRzgplZK8EscID3RsULXPK+5PLC
        RszJVIR9JEqv6zwtn/HEvg4oBNykW6z5zjmD8pDqYqKR57yX45SP5c6BJG0hDwc0JUt9Bggy+G7
        07mrJhlcMxT39qSe+W2VTB4Z9upAZpV+1amgqANJ8ow==
X-Received: by 2002:a05:6512:3251:: with SMTP id c17mr40905497lfr.440.1638894443827;
        Tue, 07 Dec 2021 08:27:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPlvTlKBjaqxG6K7rwhBvJnMmqJFIA3cH7OtYj4hNRFmF9NhNCnZdVDoq/XHpFZc+BQBwwpQ==
X-Received: by 2002:a05:6512:3251:: with SMTP id c17mr40905480lfr.440.1638894443619;
        Tue, 07 Dec 2021 08:27:23 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w6sm4208lfr.11.2021.12.07.08.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:27:23 -0800 (PST)
Message-ID: <9a412f16-9375-32ae-cbda-ae9f38332887@canonical.com>
Date:   Tue, 7 Dec 2021 17:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect
 unevaluatedProperties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211206174215.2297796-1-robh@kernel.org>
 <9400d57e-7db7-0f58-b391-417e103576cd@canonical.com>
 <CAL_JsqKBE5p2hA0F4DqrzA1ERA484kzDsZP2u1nq79yTG2nM+A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_JsqKBE5p2hA0F4DqrzA1ERA484kzDsZP2u1nq79yTG2nM+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 16:54, Rob Herring wrote:
> On Tue, Dec 7, 2021 at 3:12 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 06/12/2021 18:42, Rob Herring wrote:
>>> With 'unevaluatedProperties' support implemented, the TI GPMC example
>>> has a warning:
>>>
>>> Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: memory-controller@6e000000: onenand@0,0: Unevaluated properties are not allowed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partition@100000' were unexpected)
>>>
>>> The child node definition for GPMC is not a complete binding, so specifying
>>> 'unevaluatedProperties: false' for it is not correct and should be
>>> dropped.
>>>
>>> Fixup the unnecessary 'allOf' while we're here.
>>>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Roger Quadros <rogerq@kernel.org>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml      | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>
>> Looks good. Rob, do you want to take it via your tree or I should handle it?
> 
> I'll take it given there's also the somewhat related "dt-bindings:
> mtd: ti,gpmc-nand: Add missing 'rb-gpios'"

Sure, then:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
