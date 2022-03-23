Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720594E5A36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbiCWUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiCWUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:53:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3538710C6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:52:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h1so3339196edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBE8yRVXK2Z1d+6Q66nzcvjggIJy0c862g21NoTUHlQ=;
        b=KAzCUv63az1N4YOSrRi1smJsfOq/r6GI+qprsin5ohyUodV9JV/TMROjwXbDH7mkGp
         3bvgjbIeySI2A672p0NA+HLUIkm0Rf7b8zb+pg2FzRUxSfUeYC6Xoec0BHG4P++yBz0n
         4g3uXsasz57ELC1In9T0BY0cbM29MZH+RILFuYz/hKArWanXA7AYhvGj766SYuYkSG7h
         T5bwBuLwb16uqlg8GJOnqNWrQbjFNG05Z4qffRRUjntRms1zdfy9GP3KrSm+/SwCp2Ht
         2zEjm8jrdHPttGsLbze53F+xXG3gvxH4xS5ld+z2rS6LogLISLddisxC96YZP3DPvwcx
         J5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBE8yRVXK2Z1d+6Q66nzcvjggIJy0c862g21NoTUHlQ=;
        b=jL9ws9OoME8bNt0V2DNnSoJZ5/7Up6AHDaC+ZklaEFLgcGgfiofA4C8ka9ZwBVtOvO
         OE1Da+uxbP2GIt9U/Yu3ep9n7nhdKmbXmRflZhZkoPTRZBSchex4Z3ncNnEwKf1X1/sQ
         pcizvwolAlmZqcIRXDu0ecb7bhLevLhb81Sh/SXdhwP4+XwY1NxIZjkLGiuOD6c4LgaR
         iBC//qfJMr8pGqVTBSaz/Y1Dabq1fh26oDWjydvdL8E9rbR7mPviVbp6Cxe6i5C6PSvX
         Thv5YrdnmfgccA2OFbZ6E5w3BMjEig1hAYeO+EZx63frd1jO5LeM9TBNOuJALPn7LnhZ
         C+eg==
X-Gm-Message-State: AOAM533Uy7+VRIeu0vsYmUOafIkPpdu9icMPFydVnbi1Nq+OP+t0nmKH
        c1iYw5r9T9tPMee0IPbUYAoBjWYEHKe1sTEgjyBPGV9vt+L7nw==
X-Google-Smtp-Source: ABdhPJyNe/YgbboX15f5yKbq32JYm2T6eI69MG03cEoDePkZrOlyNnzHwmz9VyU/XeG5wcn9QIWAlNajZh38c8f51EM=
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id
 ck30-20020a0564021c1e00b004165b93eacfmr2586533edb.302.1648068742283; Wed, 23
 Mar 2022 13:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-4-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 16:52:11 -0400
Message-ID: <CAFd5g45r9gcYCya0A-sP=MapvbGPSCxX4oFYxDNSPC=_F_bZ7w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: tool: drop last uses of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Tue, Jan 18, 2022 at 2:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Since we formally require python3.7+ since commit df4b0807ca1a
> ("kunit: tool: Assert the version requirement"), we can just use
> @dataclasses.dataclass instead.
>
> In kunit_config.py, we used namedtuple to create a hashable type that
> had `name` and `value` fields and had to subclass it to define a custom
> `__str__()`.
> @datalcass lets us just define one type instead.
>
> In qemu_config.py, we use namedtuple to allow modules to define various
> parameters. Using @dataclass, we can add type-annotations for all these
> fields, making our code more typesafe and making it easier for users to
> figure out how to define new configs.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
