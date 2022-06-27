Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880655D9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiF0XTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiF0XRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:17:24 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B421E237D0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:17:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v185so9782592ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOgbheeHHLx9uc+m1bX9bnF0itm2DUuG6BGXmAFqbGY=;
        b=HLHQZExevJDo8Y1z5GpwsfTYJGywU8z5kmu59kREUxEbT88sqolNfwoDFSOOK/13+f
         rh0q4q0W+BsJxJOCscpuXaL8NQSzW7GWDP7dTqf0NADnfMvGaQ2mEcRg6RBtsCuARl9Y
         CZ80yP1yUbZIttCR65kc5ZRC9gqWYEkaL2kXcv2wIvexT+Lw6cQt5LLoyxYPZgMSq7v7
         hCFdLghtJsFQ0l5XlOyr6ugRNwnkuJ25kChv2EvLVJXBiAzhEAvI7fl0kgkGsid3cAX7
         kuXF+Q2QWoMv1CpqtLSwbVAvT4VpfvhdsVv+SV94rfWIZ9OJZOG5bSadzdHJ+j0GIE0h
         P4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOgbheeHHLx9uc+m1bX9bnF0itm2DUuG6BGXmAFqbGY=;
        b=ObUGq7XYdbro7UmHxUNTHtFWwzv80Pf6oJg8jdE4KWQzW9CcnG6zrN/kKApOhMS6im
         EFDAMCZihwCEQ0vD1VDBM9Oxcsn7/VVvWoXJwz6VeWqxrfsUKCv4AGJH4SDRh+hyd1D9
         +Az3v79jr8DLjjjOgG4P8LRqKKGCgZkKa4AwYOxgIP3gEFzmdG9eY3cUfJQJ+KIf0VbD
         ELlEbLZ2IeEDOgqwPlnVFlDi1odzC3b6jOAo6be6X5XqQpjAshkht1Rmjc2xdDyaMIOo
         tdhRWCpBBMTGN/MMj9Zno8FtuniATnzMuvFnOoDyK5J1krMKVH1emX2BrkZucT6mDPkV
         SYFw==
X-Gm-Message-State: AJIora+LzXmRVtJ4r6secoLIw16tKyUTozRUm3qK24fOUnErkiJSr8Yl
        hjOvNRWvFX9+zRSnjRCA62qyXsazZlYtMhyHmihTIw==
X-Google-Smtp-Source: AGRyM1v6Dk2Qv7A4RssdrCAPUCr8IHhm+4/uF/DqBgXC0b8TGnzsXd0pqOR8Vs+yJQ+R8GlAivav01HXpQYEownlNG8=
X-Received: by 2002:a25:3bcf:0:b0:66c:815c:a58f with SMTP id
 i198-20020a253bcf000000b0066c815ca58fmr17269199yba.352.1656371841684; Mon, 27
 Jun 2022 16:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com> <20220619120451.95251-3-wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-3-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 16:17:10 -0700
Message-ID: <CABk29NvHFxCxmZBnB5ozjqDQGVqBQQeneC-mi-W6KyYfX8ENQw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] sched/fair: remove redundant check in select_idle_smt
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> If two cpus share LLC cache, then the cores they belong to are also in
> the same LLC domain.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Reviewed-by: Josh Don <joshdon@google.com>
