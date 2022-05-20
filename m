Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F152E157
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiETArW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:47:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827AA131282
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:47:16 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id q135so11780862ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIoUiuZGqV7oFDLhhYUZHcVLA10ci1UfARClMRzKgYo=;
        b=FdDLvN2NTra6ypywHizY8dWfdcVjPnTiseiW035ivOw1/e8glVye6PPRdXsY8uZWxS
         LEEtdYnT77Xbjn5vD0R7h8fuAkhjk7YyXxezuI6QgH7RnkrV5QhteKzQ1z+Pf9JaNC9O
         0JUMMgyaJPHB99SmwIPETS7FNRJI+xvULMCllvqpb9JJrUxCo25uH7ZIFQhqOa1ZHYBA
         dkcVIHDx8INQqyRKWyEuBJDQKWyl5GfH/9JQLw4NS6BqHqF6ao3cwg+U3yS672ZZoGL9
         nQiVOJ77+w4ZSzNywC4k6VzOz+Un617U+Q1uPR392g0v3lVXst+dNHhZCnhbYGRZAnkm
         puhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIoUiuZGqV7oFDLhhYUZHcVLA10ci1UfARClMRzKgYo=;
        b=iSuAUQhhp4bjwCh1y6FQoV0ju+k0HYL5+wr77DIHeQbt0KF1P23HO+30a2cJjhBUpy
         pqUr2fxCHteJ1i75Ws3Gz2W0zOX15rw7A17O3wzVURRGxnr9d5/CiKqkKvixacQZzHwm
         YT2w7AycI40KNN76pzUlxbfHTHh8c7va3MZ5lmCJi4POal4YX9VmdIKR60ziJMV3sbhA
         I5V9OHrpKRhakcqqyf2aFx7DPDhsPwjXzUa0vr9EGOoOnDMmIvtde8Bca+GfMd89eCiR
         EJ7gUBjoOfq+ihgK6vCWpjweAyk5JojSETFbVudVV710TyDZU8+uYGQOPAJOPGrE8C+m
         M0pA==
X-Gm-Message-State: AOAM531VNv7O18XRn4YcdvTxK/SeZDwqfWKXZOAyqnCu7d3nj/ZynhAp
        1ZtGxaxJg4VMWjOqsXcDHS3HWHqiLtgbaJGujliyAwPT
X-Google-Smtp-Source: ABdhPJzkt5PraYGDQgB0+kBC486a4S/fxdly8I69BJVJqe0PZ3nHUepoaDwveVGapcItqMmpTgMaPZNYUH2+UjcSw/w=
X-Received: by 2002:a25:eb06:0:b0:64d:7cd1:f416 with SMTP id
 d6-20020a25eb06000000b0064d7cd1f416mr7275416ybs.237.1653007635825; Thu, 19
 May 2022 17:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com> <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
In-Reply-To: <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 20 May 2022 08:47:04 +0800
Message-ID: <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
> 'drm/amdgpu: Switch to delayed work from work_struct.
>
> I will just reiterate here -
>
> We need to be able to do non blocking cancel pending reset works
> from within GPU reset. Currently kernel API allows this only
> for delayed_work and not for work_struct.
>

I'm OK with the change.

With an updated changelog:

Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>


Thanks
Lai
