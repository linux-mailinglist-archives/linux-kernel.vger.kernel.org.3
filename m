Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2D4CE3FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 10:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiCEJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 04:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiCEJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 04:38:02 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089D23D032
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 01:37:12 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x200so21563319ybe.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8YRPKtxEMPdU6+Q3B6e4fqO0sPdCeK3qQDcbu/LSDI=;
        b=lHnnCFcHOLqcqZMm+7wQDnMfORjxrlVmpEtEJuS6gqKBKU+vVsAsu/j2DDL/uk7k/4
         vnoJald/c6ZzlLjFH0RiIW6L4/ClW47utWEV4ymBywMHUbQ31+5jSCXbNVOGEZMB+ALy
         7Qd2TCsiTF+jFtlMtgK0GzOZz0abu2MV4x1XAdr1CalMppFy7btDAv8CuSENnArupIMq
         Hp3va2VbOL9LRQN6ahlW/H5+aNj/smQDh49mLjExKFZbzv5CLdqOJF0YhVzC29GJOfkX
         XgYn2Vu+HmHcFwlm1hjPtRMCdnkR5C2ETrWUjxvf+/3acp2xLbOMjHRB4h/mtAt1uDvz
         p4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8YRPKtxEMPdU6+Q3B6e4fqO0sPdCeK3qQDcbu/LSDI=;
        b=K8Xwst+PXJsldTySR4rAETQSIlYt6LvhQAf9Q9Ccafj1M/HT3tzXnGKuMgpre2G68A
         I9wfbHhxPmXVkpF3MLsPbNTuep6jPTXxr1oJjD4qja2maLYylp6fXAuGH27wKRXFNjQm
         Vp85UCXb4KGPOV+ESlI33qwsFN5TgBQtoTwNEU+e8ztHNbGSdiUtAcrdjNE1Xt6B1jfU
         ZNh8s0aWouxlQ79Q02KIvQTGJneJv7LQKWTdHczhItpwle3REib1j5V1RnObp3DO3MWn
         ok7dKs6N+IRNnbLd0C6x8yn61xD+OOCo6VdXHi+cvySSUzxzXQXB4IuA4gJ2r2T99cx+
         pwBw==
X-Gm-Message-State: AOAM533DPyM7rvq1gfoNa5sLHlStpPIeY+k6B5eX1u9nmHAziThSh9/7
        tDimaQzMdK/n9ne0f5UszNcpxpozP0kK6G+0TDbeyA==
X-Google-Smtp-Source: ABdhPJy+3sPb+vFJFSCeYOx7Nqrxnm/kaHNaW4YkZqqdkW9gvOQjFuD4x1RcsXjG04ZLnGqcIy+NhRNvP9lJp7Cy7bg=
X-Received: by 2002:a25:6994:0:b0:629:1e05:b110 with SMTP id
 e142-20020a256994000000b006291e05b110mr497927ybc.425.1646473031701; Sat, 05
 Mar 2022 01:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
 <20220303031505.28495-2-dtcccc@linux.alibaba.com> <CANpmjNOOkg=OUmgwdcRus2gdPXT41Y7GkFrgzuBv+o8KHKXyEA@mail.gmail.com>
 <ea8d18d3-b3bf-dd21-2d79-a54fe4cf5bc4@linux.alibaba.com> <a293da49-b62e-8ad1-5dde-9dcbdbcf475e@linux.alibaba.com>
In-Reply-To: <a293da49-b62e-8ad1-5dde-9dcbdbcf475e@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 5 Mar 2022 10:36:35 +0100
Message-ID: <CANpmjNOZSuJTMQRW9LbsKTcak2Qyx_VdTp7Fu99MK1GxPmwO=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kfence: Allow re-enabling KFENCE after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 at 07:06, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
[...]
> Hmm...
> I found KFENCE_WARN_ON() may be called when sample_interval==0. (e.g.,
> kfence_guarded_free())
> So it's better to add a bool.

Yes, that's probably safer and easier.

Thanks,
-- Marco
