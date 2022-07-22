Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7658B57E4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiGVQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiGVQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:49:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB449B569
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:49:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so6529139edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP7MEMRudXRwKgSBDW2pyFDtVolBFiGCRKVHhsGRSj8=;
        b=tNmjBZ1Usrf4ccK4YF/WrUMz3HDq46WbkIE7k141ti35Sv2gBuhRuqIz+vYJwn39FS
         7qcUvgAYpwCtBWkqnsKJ3Kg7SqOXgUMmU4QE/B6zrgL25Gih9IstDHd3pK2KiR5Jpsfj
         +AFcCgGRXvvgKcZpcJNv1F96teqgs3wtnl1MARsZ/WhBj/z2pXXol8PyUUG8fU0TAxst
         IueQz65c/tzFtCq+kKyhxP/5zecAGRxCsbMEreWPfTEqRYbNwAHYEMrniQubAsENL0KV
         3bSbFD0ERJlx7BquZDH4P5pHmNwdbEWLXuCVvG0eU5sICVCh+KV4jgEZq7zrYxXqV3iX
         Xoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP7MEMRudXRwKgSBDW2pyFDtVolBFiGCRKVHhsGRSj8=;
        b=u32foJVZD6UkymvLyc4JiT7wbvjIhbdeDS7uWUpOvpvDwfJzh6zs182zJXMBGWPQjk
         7orGnJOMX/YjkqEBQFSxjBmr+fa63pMRLi4WVbkE0o6UE/2WfTg9S5JSoCR1kTmyLInw
         XUJGr6TxOhGKU+hS8m+etWPotLlTmz96Z9tC+cDWRAy/GIikPpG1YGNjWDtbk7wKbxPz
         sQ9KWd4r53kxhKHoOEUvVd6ZoPUwMMvbhtr55bLs0Og7LwXO1IrrgACPqYdd/3d7ustH
         WREA7nhJL4R6Ze0wTjgZMU9cKPGgUY057uurO2uTvKAjd8TO4ZADsVX/ABBlMiEwVeRZ
         gvtw==
X-Gm-Message-State: AJIora8OX/ZSwI17clDspk2/m4Gho/BMA3jRjkVeL0TiSwoMxJhzYNWS
        eE7lnAKOXaVZPe5TIhpt9n6Dhd5iGrmuieHKB54iWg==
X-Google-Smtp-Source: AGRyM1vcn/28782HvbC9cKhuzw/Aic/XBRmSoWAth+f6xncN8ljrfB4smlykey6AuiNZAICimfKOS2IKLgXed4BXFns=
X-Received: by 2002:a05:6402:4507:b0:43b:b8df:571d with SMTP id
 ez7-20020a056402450700b0043bb8df571dmr780259edb.230.1658508553649; Fri, 22
 Jul 2022 09:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com> <20220721180214.3223778-4-dlatypov@google.com>
 <CABVgOSkHCDt4DPRTCpSgWUSa5_5adEoqwW1fNnXyev9fK1eiuQ@mail.gmail.com>
In-Reply-To: <CABVgOSkHCDt4DPRTCpSgWUSa5_5adEoqwW1fNnXyev9fK1eiuQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 22 Jul 2022 09:49:02 -0700
Message-ID: <CAGS_qxqV0Con7XL0P5XVvdJY73aSLWDu_WD+3DKn2UfD+=rsxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: make knuit_kfree() not segfault on invalid inputs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:35 AM David Gow <davidgow@google.com> wrote:
> _Maybe_ we should no-op if ptr is NULL. I think it's legal for
> free()/kfree(), and while I don't see much use of it for kunit tests,
> maybe it'll save someone confusion down the road.
>
> But I could live with it either way...

That's a good point.
kfree(NULL) is indeed a no-op.

I can see someone writing a parameterized test w/ some code like
  char *buffer = NULL;
  if (param->use_buffer) buffer = kunit_kzalloc(test, 10, GFP_KERNEL);
  ...
  kunit_kfree(test, buffer);
and they'd have every reason to think this should just work.

I think I'll tack this on as an extra patch and send a v2 w/ the
commit subject for this one fixed.
