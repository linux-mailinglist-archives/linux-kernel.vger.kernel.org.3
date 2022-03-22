Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011CF4E3E95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCVMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiCVMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:37:52 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B83E0DB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:36:25 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by gnuweeb.org (Postfix) with ESMTPSA id 4326A7E2BC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647952584;
        bh=zaO3f9MqO+jyU3/PSQufuaTwNiwMTpP9slV5vtpUGQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CN+3kFgpCahxQCFE2/8IVa7DhTgsK22ryIcMeDSq8wNPSKZVa8GPKkH4vacPmzIEe
         TyLiJb+Lt1j4jUhGiS9lCjSv1eIylLW782hk9yegdXfB8Kze3z3VRmoyReCY86HF22
         YgRG2eWt8R079C8yPhwkfngRTNaH1fNkDQi0kERKELZXtOVelAtfb68TNFWr9X4c2X
         M8hk+pbzE8LzuRyycg7JvC0hFinbYk8PbVfJo0cnE1EpDMX+odKWuiLnol8ZfA7nEy
         PmlnUgA3TN5Yp0BKmi/v22iswZxu+D/ibG5jFOGFNZLZL4xc2LyNSl6N/t58W/2mID
         4IyyH0AsGLJ6Q==
Received: by mail-lf1-f49.google.com with SMTP id e16so15341719lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:36:24 -0700 (PDT)
X-Gm-Message-State: AOAM530JAyOgq8h4mM6NygkMUhzKM1jbbSjbL6VURNgvq88RW5nGNLIo
        X6F5QMwCEuQh4X8rQDWmi8E5HfIzJgg8vnG1k+Q=
X-Google-Smtp-Source: ABdhPJzEbQlDjpVTXWmS7ePPfXTDNcuGBC93PTWZNLb6GxYsm1QyP1VqWjJPbZDZebqLPCcpINZX1m6Scoe/hAjxWxs=
X-Received: by 2002:a05:6512:c06:b0:44a:2a0f:9d3c with SMTP id
 z6-20020a0565120c0600b0044a2a0f9d3cmr7475894lfu.136.1647952582433; Tue, 22
 Mar 2022 05:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-7-ammarfaizi2@gnuweeb.org> <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
 <28dd5f67-0c59-8ea0-8798-55757a6b05f6@gnuweeb.org>
In-Reply-To: <28dd5f67-0c59-8ea0-8798-55757a6b05f6@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:36:11 +0700
X-Gmail-Original-Message-ID: <CAOG64qP2qiyOQaTJ56Cg2w=Q=euDbSjqkOVOLKJHMq-xAS2U7Q@mail.gmail.com>
Message-ID: <CAOG64qP2qiyOQaTJ56Cg2w=Q=euDbSjqkOVOLKJHMq-xAS2U7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     David Laight <David.Laight@aculab.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 7:18 PM Ammar Faizi wrote:
> Rounding up is not useful here, because we don't have any free list to keep
> track the unused block of memory. I mean, even if it's rounded up, the extra
> space after rounded up cannot be utilized with this design. There is no
> book-keeping that tracks it.
>
> Though, the kernel still allocates the size in multiple page size.

BTW, what David meant probably, don't call mmap() again if heap->len
is greater than new_len. Isn't that simple enough to give it a go?

-- Viro
