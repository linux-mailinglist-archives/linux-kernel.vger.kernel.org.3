Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259D525414
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357296AbiELRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357300AbiELRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:49:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD71FC7FD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:49:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh6so11804318ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxjUSnXGIp+LcadhUklxf1p/q+y9181EApLyCaGSqK8=;
        b=AUbwiiK3NRbqsNi0r1+ALkJ0iMRp6O+56QYUMEgQj8W+pb0cHP2IPD1qvdY+8ZYj05
         SGexijpfcPmxfR2MeaJ/aUM4INCyRfLSgJYPzMZlCycwdvvMWIiHD7ncOP1qzXzACwQf
         q1OhizbiuwuicMRJlauscgSC74vZ562NJj42J/OKJmriU8qyH7D0FS3cvzVeABwSi9jQ
         Hd39NOYgDGnSfw/nik+CAelnCTGcIXCnBdvfT2qC3OdqGfvCh9WlY4Cl8El/PLIXsL9+
         leP78muTbocCCvZsrFinmRzqaW4411NMoG5gs9qy793ocglcfExX40yWSkk0WW9Ptx5B
         xWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxjUSnXGIp+LcadhUklxf1p/q+y9181EApLyCaGSqK8=;
        b=D4C3pOCp7B7D3WO92PCFk8xwPBU3FCch3cX04pN+AOfiNAsc0cA2l+M1eSl16+xkzf
         JiBcBAgAXEer7PDW5SzbUGoWhOWr2GZJg2Q5ihCA//N5JuSsqh93jloS8RVQmApr16cu
         Htb7vxEDOmZ7f6K9yE5UlyRkhSL1xCFST3aBm1wChFD5q/NnICbilTDimrhIGF95Z2Pf
         oEpshr/iiojZZRbvOxIhKGS2WuToyMWyEHwliPYk10PTfyl6GA6yf3zfeFuhyuPfQQI8
         8lC9Prt579nWv3wjmRiOuFdiIeuEqnEyYkp4Zj7wOHIql3gKO5s8AA5rKv2BRnFkF6y7
         /8+A==
X-Gm-Message-State: AOAM532DldgJOkJB7pl/91cZ9UCm6VjAnxBoFHC9IuBq+emt/rCDTWey
        faqNx48Ptde2y1sfNQBpc/9DlV/6FraTujOC1R2ASg==
X-Google-Smtp-Source: ABdhPJzSrSgG8yOO0WtPga4iMyKd7F5XTZUZsCfc/LWCnVWSxUzYNnxDbQSDPM5UZ88puIX+5Tq3CGaSY4WfguwgXTw=
X-Received: by 2002:a17:907:968d:b0:6f4:9f9e:3e5f with SMTP id
 hd13-20020a170907968d00b006f49f9e3e5fmr965233ejc.540.1652377790529; Thu, 12
 May 2022 10:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 13:49:39 -0400
Message-ID: <CAFd5g45v5=j7h36asTekM2UH71ycv0BJPV6xJ9XWyTsK00tBGg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: remove dead parse_crash_in_log() logic
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

On Tue, Apr 26, 2022 at 1:33 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This logic depends on the kernel logging a message containing
> 'kunit test case crashed', but there is no corresponding logic to do so.
>
> This is likely a relic of the revision process KUnit initially went
> through when being upstreamed.
>
> Delete it given
> 1) it's been missing for years and likely won't get implemented
> 2) the parser has been moving to be a more general KTAP parser,
>    kunit-only magic like this isn't how we'd want to implement it.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
