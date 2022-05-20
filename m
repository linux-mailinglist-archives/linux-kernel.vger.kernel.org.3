Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69F52EACD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348540AbiETLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiETLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:30:11 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F41EC3CC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:30:10 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by gnuweeb.org (Postfix) with ESMTPSA id 803F57E4A5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1653046209;
        bh=YfGkukxiI9NdB5uZmq9l5JnIO/B6pKFHg541ag61jVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UduQS/xeeDdo8uGSVr+7YIZRxCuC4Ll50KiINTOQKs6U3ZNRMgAiH6w/RY1pgJOub
         5DcoGxRavDViH0CJYK6s4xfrFtGHMn2BmHQJbHb7kGIPpht9nm+tUKm7yS0t3eE8Zj
         CwtQieK8snVU3ITCjQW5OyREuYAZtAqWCsxXU46HMsMBBPmoHHjg7H8oFuBkYDucNa
         /ED5gXrJUWHQv610aIuf698eVymk6RJ4Ox+N9owRqd/ozYpqFTMOPZoBirw6fd/52a
         cJY2o5cW1ZvtzvzysNanvevsMPO0aiFAxtgt4lpUPhKfjr/fS/046I7znY9daCjLMl
         kUxnwAsBxO7UQ==
Received: by mail-lf1-f42.google.com with SMTP id u23so13831340lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:30:09 -0700 (PDT)
X-Gm-Message-State: AOAM530yKSu1279AkATwBAr2SFntsPtGckV3knbmKUbCxaurEkKSBQtf
        fFgxBPp6kRDCguygJjXuuahxsYrCBd9T6WcbTI0=
X-Google-Smtp-Source: ABdhPJzT12I7iYIUbIEXo3WYPp4EJegEjIEuHSRkMgcluCxYOtwOwEjQz//oUBSb66eDFiGgSXW3dRiWRfiG8dOZvjc=
X-Received: by 2002:a05:6512:3d8e:b0:478:545d:da06 with SMTP id
 k14-20020a0565123d8e00b00478545dda06mr1693995lfv.610.1653046207588; Fri, 20
 May 2022 04:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org> <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Fri, 20 May 2022 18:29:56 +0700
X-Gmail-Original-Message-ID: <CAOG64qO3B_FmaLS9=C+EuWcJhsw2Tr1Cci0BL1=eAkLWG=NDnQ@mail.gmail.com>
Message-ID: <CAOG64qO3B_FmaLS9=C+EuWcJhsw2Tr1Cci0BL1=eAkLWG=NDnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools/nolibc/stdlib: Support overflow checking for
 older compiler versions
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:21 AM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
> Previously, we used __builtin_mul_overflow() to check for overflow in
> the multiplication operation in the calloc() function. However, older
> compiler versions don't support this built-in. This patch changes the
> overflow checking mechanism to make it work on any compiler version
> by using a division method to check for overflow. No functional change
> intended. While in there, remove the unused variable `void *orig`.
>
> Link: https://lore.kernel.org/lkml/20220330024114.GA18892@1wt.eu
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

tq

-- Viro
