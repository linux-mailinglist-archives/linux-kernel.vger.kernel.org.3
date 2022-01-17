Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E4490310
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiAQHpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:45:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58162
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237632AbiAQHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:45:38 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11048402A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642405537;
        bh=BnlFRfnEyWAxe1fw6gmGyUXzbXb/Exxy2EiruYyTAbQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=StB5wBV1XLTBI84hCIoZtLuROo0ozvFtdtwF3vN4ht4NUjcz3nnjfl9k15XGhYHCq
         lNhO7y40gxfI41FrSGRqeVyXaHwIIVkgJWuQYqdQR0jJbMOEypykpJOhyUeN9YBjBB
         pJ5CaoOplMEFvSUSEwjaj0b+/bx5dzcMjx1H7RKpen8Vs6loq5B1xnm+FNPnOuAJ5m
         Bn2q5/qCL2HxWrPYdeTUQ+E4TUauSpKuwlD3/Xth44M2hlR2j5WSLZ3YqTApJFR8Yg
         mL5M6TyBdax002cSbGiwHZ6JR1fEJ5SArvMa3mWB8S1K1uVPBzEb86niC9WNRVuMPn
         UiXQBSAWAgCYw==
Received: by mail-ed1-f72.google.com with SMTP id cf15-20020a0564020b8f00b0040284b671c6so2295741edb.22
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BnlFRfnEyWAxe1fw6gmGyUXzbXb/Exxy2EiruYyTAbQ=;
        b=QkVZZaqtdMhprUDaH/HFbqAidzK72G8bPjD+aMH3b5S6RFo1l68DYkH8eg5jadf2sp
         vjSV7i4U9LUnQahm4KMv+Sw6ZgLDMw3upS2D6t6+ypNbZaqeom1FOiQaSCeC4PSrJm7k
         4aYIqRKgYcAapK04KE95eMh1BstZ4e+uroIAYB+4/qiObSb/wr8KyOcfniJznCe1RATv
         KCgYU63M/1aPQOzdA1WCy7gIvDH33YxLlck4xS2TdV3N7mxetj3pqAaDQ0K1+FVfuv0i
         ggihV6tot6q2ehZG7HA3qaC/W61uY56tbSDMWttOsbZ2iTPYrWKa0GM14z5U+sZ4Kvb5
         h82Q==
X-Gm-Message-State: AOAM533cHhRLNSpl+LfH7zMR94RsuLTUdo7CefoN1MpfhBflaXaGETLt
        wbl/tR/xnpdELGqRg8jjjG/izVEj839rfjWvdU1k6gsz0DFzHolVP5WMGOARbV5IDMS2yXpJm9G
        CrX2ETy8PGT0k6b/PwGiIVna5r3Rjt10YNS/7A+Jvqw==
X-Received: by 2002:a05:6402:50d3:: with SMTP id h19mr5266030edb.346.1642405536679;
        Sun, 16 Jan 2022 23:45:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMuqDcqMplgNTykVRmag/eEAnjZ76C8iPXMJNJiJNejm5c5xQel4/ESmkmvuy3yxY7PGuFQA==
X-Received: by 2002:a05:6402:50d3:: with SMTP id h19mr5266017edb.346.1642405536552;
        Sun, 16 Jan 2022 23:45:36 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hp14sm4151387ejc.97.2022.01.16.23.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 23:45:36 -0800 (PST)
Message-ID: <77bd8fa4-2b35-352c-da07-ef91fcbed454@canonical.com>
Date:   Mon, 17 Jan 2022 08:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 24/28] dt-bindings: pinctrl: samsung: convert to
 dtschema
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
 <20220111201722.327219-18-krzysztof.kozlowski@canonical.com>
 <CACRpkdYTXSOW+sOX3wVtF4jj6xm0jr-F3HKQPGHOdAVjbasP3A@mail.gmail.com>
 <5047da7c-d3a6-5472-b0ca-7ed3dbe8a5fe@canonical.com>
 <CACRpkdbhmJ91EW395C5F2WYjWJQdJ-SBHaDm7XnQsxMuyoMmLg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CACRpkdbhmJ91EW395C5F2WYjWJQdJ-SBHaDm7XnQsxMuyoMmLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2022 22:38, Linus Walleij wrote:
> On Sun, Jan 16, 2022 at 6:10 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> 
>> Anyway DTS and dtschema will have to wait for one release, because they
>> depend on samsung pinctrl driver change (patch #2).
> 
> What about I put that (and maybe this schema) on an immutable
> branch so you can pull the commit into your for-arm-soc branch and
> put the DTS changes on top?

That would be a solution if not a policy for arm-soc of keeping DTS
separate. Arnd and Olof since some time are not happy when DTS branch
receives any driver updates.

Arnd, Olof,
This is a set of dtschema conversion + DTS alignment with new schema:
1. Driver change necessary to accept new DTS (driver depends on node
names and this has to change because of dtschema),
2. DTS commits depending on above, which convert node name to new format,
3. Finally dtschema requiring new naming of the GPIO nodes.

If I got correctly, the policy of not mixing drivers and DTS requires
that #2 above (DTS changes) will wait for one more release. During the
time, if dtschema (#3 above) is applied, there will be new warnings
about non-compliant DTS.

Do you see any chance of merging driver + DTS + dtschema via same tree
in same release?


Best regards,
Krzysztof
