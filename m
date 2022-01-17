Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335D4910F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbiAQU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbiAQU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:26:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F340C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:26:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v2so7501536ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX5BDdPmD+NPI6WaR8s/OfKSkKWqboFHvMNVeJ4mtho=;
        b=BJHo0ew6lxRnbn+aN6pFlwQsdGTqnRA9NKFS6jblkxWxLayQuvtV333n7ZthAwgJnT
         AXrDQvKS4+fj/sL/B1JrAkbxVoYUSWv+dNmoQiZ9CkAKJHZZE6iUXL3wElW5o66iMzyX
         SDBnTISDGMd/utWP1KY0CK/G50WGQsCA/fUB6O5pCq9wE7v/zIMcsS0ldOfTGmslCNb/
         gy0EWqOKlY/5t5UaXqYbhiqefybF7MLzq2GBsWuOb9+nYnudDoiw1o9Qo8Zw5q9OrmtP
         lG2fGZEc6quxHMcBFNv5LsB1MZLspOb7joO3eS/Ta/sl/aQKXuffCQUAxFRFicczlZBU
         /B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX5BDdPmD+NPI6WaR8s/OfKSkKWqboFHvMNVeJ4mtho=;
        b=ZHM6L6N8khTIUN6WkN+Zmu30Ga7jo0liJrSWicO5T646ZGa7pjLZTt1pHUArPEYwlh
         R3FDIxzSb/gKMu3xqenVUrkbohGTL8HahTpDMm1o/dM6VwUXMP1iYp16RY45zW3uxbnO
         v5U44utXKfnnPnY67sar9dWx7QMv1HE48xgoCRdCaIjlYV2xVUSTu1XKRmyr2+cvH3oy
         LSjFhIUYk2+RWjHjyfP+8X1XkqFW5lEyPM+/8hjAjHRLsxBKbPnQs3LlMTn1X4oVgHmR
         rC3qlJ0VmF14OEv+/da0rMJ8P0aUw8zFcDfDzh8SXjxPGLvr5EhtHD46w/TPsLQCnY1J
         2SVQ==
X-Gm-Message-State: AOAM5332jIfgdgJSiaa6WKsW7+T0B6W3PSluJtWC68rnxME7XWjAAFNg
        97e6dlF245v4ijYl4UwI200Sj2vvuOVltzK8/EewTA==
X-Google-Smtp-Source: ABdhPJzs4NFch1IbJoePzGpRGSPF5a/BDJH4NeuYNKzRO9JLl6Xyd9LRCb0ktA169IQmhMKLm8A1K6VtC3RjJ2m+I+8=
X-Received: by 2002:a17:902:b947:b0:14a:a6aa:4fa6 with SMTP id
 h7-20020a170902b94700b0014aa6aa4fa6mr10975861pls.149.1642451176378; Mon, 17
 Jan 2022 12:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
 <20220111201722.327219-18-krzysztof.kozlowski@canonical.com>
 <CACRpkdYTXSOW+sOX3wVtF4jj6xm0jr-F3HKQPGHOdAVjbasP3A@mail.gmail.com>
 <5047da7c-d3a6-5472-b0ca-7ed3dbe8a5fe@canonical.com> <CACRpkdbhmJ91EW395C5F2WYjWJQdJ-SBHaDm7XnQsxMuyoMmLg@mail.gmail.com>
 <77bd8fa4-2b35-352c-da07-ef91fcbed454@canonical.com>
In-Reply-To: <77bd8fa4-2b35-352c-da07-ef91fcbed454@canonical.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 17 Jan 2022 12:26:04 -0800
Message-ID: <CAOesGMg2eH1B94h+etPBDW3B1LMeHBytz0v2e0GfVRDv8gU0YA@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] dt-bindings: pinctrl: samsung: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 11:45 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 16/01/2022 22:38, Linus Walleij wrote:
> > On Sun, Jan 16, 2022 at 6:10 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >
> >> Anyway DTS and dtschema will have to wait for one release, because they
> >> depend on samsung pinctrl driver change (patch #2).
> >
> > What about I put that (and maybe this schema) on an immutable
> > branch so you can pull the commit into your for-arm-soc branch and
> > put the DTS changes on top?
>
> That would be a solution if not a policy for arm-soc of keeping DTS
> separate. Arnd and Olof since some time are not happy when DTS branch
> receives any driver updates.
>
> Arnd, Olof,
> This is a set of dtschema conversion + DTS alignment with new schema:
> 1. Driver change necessary to accept new DTS (driver depends on node
> names and this has to change because of dtschema),
> 2. DTS commits depending on above, which convert node name to new format,
> 3. Finally dtschema requiring new naming of the GPIO nodes.
>
> If I got correctly, the policy of not mixing drivers and DTS requires
> that #2 above (DTS changes) will wait for one more release. During the
> time, if dtschema (#3 above) is applied, there will be new warnings
> about non-compliant DTS.
>
> Do you see any chance of merging driver + DTS + dtschema via same tree
> in same release?

Our general guidance to separate DTS and driver changes is to avoid
large entangled changes between the two, and to discourage a developer
mentality of "the implementation is the binding".

I think this is a good example of when it makes sense to bring in what
is a fairly small and clean driver change to deal with this. So the
right answer here is to stage such a stable branch and merge into both
arm-soc and the pinctrl subsystem trees as proposed.


-Olof
