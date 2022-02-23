Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DBC4C1E83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbiBWWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiBWWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:33:18 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56211A22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:32:50 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id e26so269738vso.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Un83NyYwsyQqVz5WMTwBk8GycqpE8Y0aWd6Pc5ZVK2Y=;
        b=OyFhUdXUVxhjPlRKTE+Cy2XZ55YU83ExwRya3v1O6tzYZjI58QwEIQ3M7KxSF1PuEg
         zCH4pJCvYqjiC5p+Gej4wbrNsveqaVI+/tDRl7+ltV+LUWy8I1i5WJwGkbtgVq7fE6jk
         mbKob0NxoJyeSHMmL6XwTK4K/FAkqG3aB2prNfTE+r17IgzrXqOH4pCSnGWNhhYwNnGC
         me8uEOUeloflD/ItBIaEFvTdFJ59De3ek7h1cOtI2L/ZWY8fOm3mHYbCcfgq6eRhuCw2
         EpcwUVjZi6h5MS39w97S1wt7WfapMdLh/FLhdAYAnJCReq/LKnEocx6QQtsbepMNGlMC
         gEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Un83NyYwsyQqVz5WMTwBk8GycqpE8Y0aWd6Pc5ZVK2Y=;
        b=tSQP/M2vdRf2ZXSGMJUm07lrXtpa5lb4ORYav32eOY0klp3iP18V8G8R8zKPk3lRh/
         0l46NxpAz9DUa0A3p/A1Kh5DYXX/Xi2NAU741RAgupWqD7aC/V0U5fbo94xRBkaSUovn
         CQo6y7x5BmrJAnl6p233YGYXlZh1FPx3od3EvzoW9pTA6bLOoLOCUN3fQreSaYDULd5f
         +RTARUzo84NQrOEWGIpnsEf957qSN81pXvSjzO8TpZBfrYyAkhOjnHgDNSdduSKigNqq
         a5akAQFRSM4ukKXw5bffKbBZtMyvACWt47sv3xO1XJXOO1yn9/3nP/xjEW0T8x7wCsxw
         Bi4A==
X-Gm-Message-State: AOAM531LkfIaE2d7XxfCzKSUn5SgVG0xO9cTWRd3sfIudV9ckWK1h1CG
        fL4RqH8ban8DWi9N4NS3rMojzFCzqITbD07S1niuFQ==
X-Google-Smtp-Source: ABdhPJwBn7VSMc/jeOFaz6AIbEPjrWprB0QJsI/IcHIr/VKdh3b5LmpfxK+brKWDIVDPDgkt7Uycy3IyRLDAX7+VzHU=
X-Received: by 2002:a67:ca1b:0:b0:30b:9d28:1ce5 with SMTP id
 z27-20020a67ca1b000000b0030b9d281ce5mr772090vsk.61.1645655569363; Wed, 23 Feb
 2022 14:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20210913233325.23263-1-pcc@google.com>
In-Reply-To: <20210913233325.23263-1-pcc@google.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 23 Feb 2022 14:32:38 -0800
Message-ID: <CAMn1gO6WUATuQhVQRUgDYbytk0ohVytD_-fvOoP16xVZGJfhgg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: use correct gitroot when running from
 non-top-level dir
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 4:33 PM Peter Collingbourne <pcc@google.com> wrote:
>
> My workflow usually requires running checkpatch.pl from a subdirectory
> of the kernel source tree. This works for the most part, but the script
> will be unable to find the .git directory and will therefore refuse to
> run any git commands (so, e.g. commit ID verification will fail). Fix
> it by prepending $root to $gitroot when a root is set.
>
> This also requires fixing one root directory assumption in a git
> invocation.

Ping.

Peter
