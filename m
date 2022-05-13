Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B55526374
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiEMOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiEMOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:09:43 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE221116C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:09:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7c57ee6feso91672837b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCXM+3GRl7eC4BUeEhMl6/2Z9riSjU4WXO+ln6A3V7w=;
        b=iF239hiig5yy4SfYQD0INxyKfRsUamnGXOMkktzXAkkn10MQnGbqWqg6oNotFWPBeS
         NVC8lXk1nB16LBxAgvZvQan0Tp1G79db2ZgeSraXuYnf74ybib6BaGChUMlX4NdKAhwF
         xB9KDAI4bH9KE3213Ws+3djIGy0UY/0z8G0aCCUTkGJ6BZk678HODDDbZXqGJI0LAV7b
         vHihPc9tHW3keSSufH8DKZtemGr9BY1u2wnbdIJUotexVvTgFGVytAfBtJlyJXBVIPZQ
         SRv2OjUqxMfWzfNZkQttV8bMEgqwh1jTTIyvg398EYCvA0V67QPr7fdXhJ7u4hiqy2xN
         CH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCXM+3GRl7eC4BUeEhMl6/2Z9riSjU4WXO+ln6A3V7w=;
        b=fXbRB7o5XVpDtk97ya9A0ppogUkGtu2vZqcMKQ1ZqmJtDj2n2iQsFGq5KxR2KIu/j5
         5j+6lUUf3HRkR27eBRINH38Gy1FOHO0Du2ZYa4Jw8YWa4OEAaxnL6ZIul2hhLqNwqExK
         Hswa7p6CYeuI81vcHfxtBm7XSGnOribQaygzvz/hyJavcJbrUDtGX1t8Y05dcd2j8Dq1
         fFE+qOe7Aq3YmOkoP5Uci34o8ayQQhiRykFBgQ7FGikf/fXYtkAtQoHTvdAiGnx/exZS
         TdIscmkEjWwMWaqaoo9QMVwWabF71zWgwM6mKPvSxlJWDF7r8ROpdnE5Ys6dvftfuAyO
         5lcA==
X-Gm-Message-State: AOAM530QMAwuNrV9ftDGgtOplH/ETf1SHstwTWPhTqMcUI64ah7wvlaK
        Z1ptuMX5rH8PpOkUw3+ffjZ25X3NIYYP+7+VaJ7Rig==
X-Google-Smtp-Source: ABdhPJz2V8zZvBMU6G3F/9R2jJevjr/icGDMryNkI3uRMje+AZLxrnAcL66yFf9xnszg/LVlRVVApFx/yk0AwBnxBOg=
X-Received: by 2002:a0d:e946:0:b0:2f8:e7d8:8270 with SMTP id
 s67-20020a0de946000000b002f8e7d88270mr5794254ywe.344.1652450981681; Fri, 13
 May 2022 07:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com> <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 May 2022 16:09:05 +0200
Message-ID: <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread features
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

> +
> +       /* Handle ARCH_THREAD_FEATURE_ENABLE */
> +
> +       task->thread.features |= features;
> +out:
> +       return task->thread.features;
Isn't arch_prctl() supposed to return 0 on success?
