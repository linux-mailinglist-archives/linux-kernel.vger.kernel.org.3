Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE4948BADF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiAKWmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiAKWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:42:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48220C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:42:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w7so990627plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwqBNYhhx4LE2Q00Aa+qVN3GUI2qvxluJTLGPSUcyrY=;
        b=dk1c69wDz94cB+AtBa6EngbMy8gi4wtrEwYbwANuRyE43zZLaH36pEPqFpPJ6xMoOB
         0yw/6glpIgoVNDtgetOp4iCCaYXUU1ex4vE5IrpnCUcW4ZhWfRytw+dRSqODEHZg/drE
         I0gY80Ee/kiDJ+uC2yjWdne2XThUzw8H2gjky/X0IYPdZWqBYj+BlzZtDpAwk86f7+Fl
         Pk4VCWS1+Kzp8YlkXYbcsyl/0Gk2oW99RsPE4REneZtX5lbL0GGbgjl5nHVm22PDig1u
         USBA7lSvf/AoLYulAxUT7JdASHMJS7M6YV4CXFuqbes36/dzqBC/5+88LAWjZ10RYcpg
         yMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwqBNYhhx4LE2Q00Aa+qVN3GUI2qvxluJTLGPSUcyrY=;
        b=JLpkwmAk2Nh4pUHTEH2CvNUSZwC6TqmWnQXUcImB8pSU6uMJ6z0dKKXdO7imIijgWx
         WHKVQpMXV0mlrNaStw4aisWLMCcsaczUqz+N5Z6cU7EYD6N3wdOBXubR4oSCkxGssHLy
         kvN+DEFcqOKIqXaU6oyO+z999baRRkyhqdg4LOoa509Ob9XdJU/Vhv/jyLS8b5ov6lqO
         cGERUdBncB+u/Pf7bFr1J3IsOLPvw5bA+TpQLYWrrplsmP7zzFJuVUIJTBSehgHeCdpD
         dXoygrHMTIJzuUoaaNygdJ6ZWOSgPZiL8TGUmWAMlsrQpB4a/vpdoNPWriAi/Yp6K0AG
         EAnA==
X-Gm-Message-State: AOAM530w+oz6YPdca4bq6m/YDbrL18ugsQUTxSM2DkM1Sthyj0xhXiU9
        ahAPtMUdinUY4GLUgTy+DUnsbyIczXcoLpUeJAfNyA==
X-Google-Smtp-Source: ABdhPJwCPWZ1hi/U13Gu4RKBQPDXeV2RrfcrRKri5cqEHFmAq4J88AI+Gs5lqvMdaWYCb0ndPk3liRfCrky6Vnx27fM=
X-Received: by 2002:a17:902:8601:b0:149:ee23:890a with SMTP id
 f1-20020a170902860100b00149ee23890amr6361943plo.12.1641940940584; Tue, 11 Jan
 2022 14:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-7-dlatypov@google.com>
In-Reply-To: <20220111194231.1797841-7-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jan 2022 17:42:09 -0500
Message-ID: <CAFd5g47LdAp2xn4GsRBz7RCqQq-6NZO-ESNNFL_AKasG1D7ARg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] kunit: drop unused assert_type from kunit_assert
 and clean up macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 2:42 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This field has been split out from kunit_assert to make the struct less
> heavy along with the filename and line number.
>
> This change drops the assert_type field and cleans up all the macros
> that were plumbing assert_type into kunit_assert.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
