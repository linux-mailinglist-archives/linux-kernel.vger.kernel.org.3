Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7404BB9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiBRNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:01:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiBRNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:01:33 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC12B4051
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:01:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d07c4a0d06so65465607b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYyLc4IH0ANNIsB/psBxiotNSUOVb/aQHzaP0Me/9TA=;
        b=Ge1hDFkkzGp9J4GrZHJA8BCxzVqbwg2vJseoylQBv2nQnO841dVcd056S2TfrEO9kW
         3k8MmXEk67ZTxa2SZcqM2aw2H/QQBWu6bpd++xs+ma3wMTzSKjLWYrVWviXsKqScjGIy
         JBEI/zu22lbB/KleMt2ckXoj3NvwxIlz22arsXGj2Jfrq/Qm6/4wwyuCY5gkNC6iH0Ng
         C6zmSbFs0KCazV+dwBLFkK5EdyCgy9bpoQsGsbetRtUbqFsbOkJjjP6VMguZQUMJAcL+
         TUCMMWWme7Lm07sC4OMPGrU9OUzIAQM6aF6rEgkHXtTwIEUwx8M8TqKl7bVNEWL449Hi
         QOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYyLc4IH0ANNIsB/psBxiotNSUOVb/aQHzaP0Me/9TA=;
        b=Y/d3G+DWi873y5POD5CXsikOhJXFUrz2MFPm0kF5hQlqDk4DGaB5AAniKDJzRHcKKz
         tM10bpoDqdrGlPWFvVET+7PUd5Vuy4If9aCcQtRyOHvYUH4jn0WcnjTin+tRSVRcN6VW
         3+CffBgJ9cOT1VadJB5s7OY5+XQKt/APUHg0I+6Cw4Zq8ulsx8UXlM6lTCIof1Bz5BCN
         lfUQWhZHhYgF+Pl7+jXtNhfLaMG+azkRWTnlDSCR6jH+wtKp0wImSY3A7eVz9P4xMIUd
         uxertnzI4NJSadCjvZtwSvumn/i2Vy+UqscSd7JNBS/42kzK0+JxsTQTquQLPNVS52rW
         VXpA==
X-Gm-Message-State: AOAM532JS3XyQPvewkX9rx0ikWZgSJkjGaJPa6qV02Nmztf54c2u7b0f
        1GPLoKl086GP/vQ/1b7NE51UNrJGytajxZww1HpdFA==
X-Google-Smtp-Source: ABdhPJx5BaCIdooqbWjruWTtUUDC47+tdWkDlNMYn+20tj10zAQ1ZbZrdq6HmMfOq79Xwu39p4eKXdpoFDV58JG1Sdw=
X-Received: by 2002:a81:1d5:0:b0:2d0:e2aa:1ae0 with SMTP id
 204-20020a8101d5000000b002d0e2aa1ae0mr7282027ywb.278.1645189276021; Fri, 18
 Feb 2022 05:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20220217140441.1218045-1-andrzej.hajda@intel.com>
 <20220217140441.1218045-3-andrzej.hajda@intel.com> <CANn89iKgzztLA3y6V+vw3RiyoScC3K=1Z1_gajj8H56wGWDw6A@mail.gmail.com>
 <199aebfb-f364-cd9b-5d2b-dbe42b779a41@intel.com>
In-Reply-To: <199aebfb-f364-cd9b-5d2b-dbe42b779a41@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 18 Feb 2022 05:01:04 -0800
Message-ID: <CANn89iLS5oqOvafFy9SW0CDiyv9GGJYsE8MpE200K5NaA8h0xw@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/ref_tracker: compact stacktraces before printing
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev <netdev@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 2:55 AM Andrzej Hajda <andrzej.hajda@intel.com> wrote:
>

> OK, could be faster and less invasive.
> Other solution would be keeping the array in dir and update in every
> tracker alloc/free, this way we avoid iteration over potentially big
> list, but it would cost memory and since printing is rather rare I am
> not sure if it is worth.

printing is extremely rare [1]

We want to use ref_tracker in production, we need to keep the fast
path as fast as possible ;)

[1] If you think about providing access to the traces from sysfs, we
might need to make sure we do not hold the dir spinlock
during the expensive generation of the output data.
