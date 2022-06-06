Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E014E53EA14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiFFQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbiFFQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:05:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F672166447
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:05:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-30fdbe7467cso112520017b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkb/bGVyuMqTZRXVw6tHXbfDJb2Rv/dx6ERatAJ2rC0=;
        b=sWnen0QbVrpHJrYP5g4e/CpughJv5Xsf8460mMdBKUx4OTmW9Qr3EJjZH24KgWua78
         7SO6mkI+7tUe89LfbJsvCFDzlzdNeMw/gz1PVyPzlV50tpFc3IhJK1mSOpN9IJnBXgIg
         e0zSuMMRoHlevEhKJFjxeieKivjrkcWH3fivpf+3ozagiT6DrvjNMAmWx+uWXx/QH3Yb
         hKQPIrtydMfIlf4AGKk5CQ8cjr3EG1XPrlTBkEkTQbKjS6zhKIElw0kkgYB+uUipIsRQ
         qrBsNJCuvIfH2Ro5oe7HsiF7IpkIq6163YEEyjL0hHD0J0b/x/cAuqcGxch9bKP3rKD8
         8n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkb/bGVyuMqTZRXVw6tHXbfDJb2Rv/dx6ERatAJ2rC0=;
        b=JKfg88H1Mtn3EuUpSYRjh3l338vIGgyuSr16RpuJYKplkhQeB/uqsAgnRkuBHnUOx3
         2U5aODHZ2PETm6q2pzksBXml6MbgzYxrs4Kjlj2CECS9KDW3xa2ZIlTS+aWYMwwzh/3J
         JM+bnIU2iv8F/9M0ziwZBFoBMHYvJ4+BbMPnaX+UMOvXD+RClrIC+v8EDntv0nNJ3Nxc
         /y1aeKACAUb8k4f0QJ3tXPhNSaoJklPPebQt7gb1YAgsmHFRqhDDpWm7sxtRUvtFtBLu
         ltwgUJTe3W4hn70RF9dvM9AqRduH2ed/OcVBp1dqnPKxJIesz54BOSb+NN7+++4QuL3x
         aXQQ==
X-Gm-Message-State: AOAM533WtQ0s1qBX1Y/3uy0OO4uTdhosSGiwpZc9WpDduieeDlxBXsCu
        C/YzQMoxwWKSFmX6iZY6i8C0Xw2fl8VPtQDsKZVnjw==
X-Google-Smtp-Source: ABdhPJwva2zNMNdY7W28yUe2zvaMfHOUFz8u4sZGR3aghRSe9HFp2eMiDV5XEb1NIf2ZbVxtbmqrDyTidCAc4E0ed5s=
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr26771026ywa.47.1654531520769; Mon, 06
 Jun 2022 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220606070804.40268-1-songmuchun@bytedance.com>
In-Reply-To: <20220606070804.40268-1-songmuchun@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 6 Jun 2022 09:05:09 -0700
Message-ID: <CANn89iJwuW6PykKE03wB24KATtk88tS4eSHH42i+dBFtaK8zsg@mail.gmail.com>
Subject: Re: [PATCH] tcp: use kvmalloc_array() to allocate table_perturb
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
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

On Mon, Jun 6, 2022 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> In our server, there may be no high order (>= 6) memory since we reserve
> lots of HugeTLB pages when booting.  Then the system panic.  So use
> kvmalloc_array() to allocate table_perturb.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Please add a Fixes: tag and CC original author ?

Thanks.
