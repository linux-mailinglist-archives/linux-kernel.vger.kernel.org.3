Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978E146C002
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhLGP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:58:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45672 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhLGP6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:58:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4681ECE1B83;
        Tue,  7 Dec 2021 15:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7963DC341C1;
        Tue,  7 Dec 2021 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638892490;
        bh=ml7yqq7yqyYeVse/0iHre3f11/9NJ5q9XMKUjfkRQVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sdHEtKwFaKGwlPgvuzDlLPIHg2bEfrQgp3CzHcVTA7ennZehTW9b5K68Na4fymx5J
         rY03CpQVMbYIPO8Y7cdRrFlgx+XYL8IZuwKH8XFB7iESpXb2gCFcDkbRLUG79kD9MS
         NN/aKK/12aDaWAIXBTOrENUXqBSr0nvB68hJMqd1EGP1tJqlinpQKLuGvr1sO+QXEs
         ZRnpNQjTwUJEjau1OiUdt0VvlR7aix5ua563th7C7MVZASlYuwNMr2jKfkWTttkDJg
         Gaeo2a6Hd+O6hz3xUlP3T3bNsuxMVdXAmpERtdKpyHhJWwg1x+1Fq2yowNW9ZOBhPw
         xgPpg2StoBkHg==
Received: by mail-ed1-f52.google.com with SMTP id t5so58800457edd.0;
        Tue, 07 Dec 2021 07:54:50 -0800 (PST)
X-Gm-Message-State: AOAM532rXZqnbmnXt6pXkAv6oaiD5sEajsAb0RQfM9iKLCeedLpE3bwj
        jiLkTDZeuYl/qM2fpaAQmVDGotvn48BKFLHYYA==
X-Google-Smtp-Source: ABdhPJzECztRAh8+Ww3o/uaGbfXERCtaFTuWEaEtW++NQ1ytY45kzl9v1Zw0edX5p5nnUIwMRVu+P5e9EJEa3/j+Z+8=
X-Received: by 2002:a17:906:fcbb:: with SMTP id qw27mr275216ejb.320.1638892488478;
 Tue, 07 Dec 2021 07:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20211206174215.2297796-1-robh@kernel.org> <9400d57e-7db7-0f58-b391-417e103576cd@canonical.com>
In-Reply-To: <9400d57e-7db7-0f58-b391-417e103576cd@canonical.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Dec 2021 09:54:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBE5p2hA0F4DqrzA1ERA484kzDsZP2u1nq79yTG2nM+A@mail.gmail.com>
Message-ID: <CAL_JsqKBE5p2hA0F4DqrzA1ERA484kzDsZP2u1nq79yTG2nM+A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect unevaluatedProperties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 3:12 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 06/12/2021 18:42, Rob Herring wrote:
> > With 'unevaluatedProperties' support implemented, the TI GPMC example
> > has a warning:
> >
> > Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: memory-controller@6e000000: onenand@0,0: Unevaluated properties are not allowed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partition@100000' were unexpected)
> >
> > The child node definition for GPMC is not a complete binding, so specifying
> > 'unevaluatedProperties: false' for it is not correct and should be
> > dropped.
> >
> > Fixup the unnecessary 'allOf' while we're here.
> >
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Roger Quadros <rogerq@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml      | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
>
> Looks good. Rob, do you want to take it via your tree or I should handle it?

I'll take it given there's also the somewhat related "dt-bindings:
mtd: ti,gpmc-nand: Add missing 'rb-gpios'"

Rob
