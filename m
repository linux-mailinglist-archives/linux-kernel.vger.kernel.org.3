Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8C557364
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiFWG7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiFWG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:59:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BE45040
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:59:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1642497pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWXRy4yaBbGLOb3VHZrtrJxxwapjIbRhxQbw7lQ4SBk=;
        b=1r5lHudGp52tka1PWyaQPdskyd9z8tqLkAFT6HLveZA3hydGs7vGPj3T2fqbIZ9WMs
         yndwxuCKJXZS236lT5oJaq5pmXXtunPF8DCONq3QPSsJD2C1LrrQIBVa7GuG+FFAGUiw
         W8ydDuvmuN6SM8VtsUsUtfoeY+voF2sY70ltxmnFUQ+jajvR0o5ANcGR1NsYKqScLhiN
         r60lSKtbYNqscjdgjiWD9bMaQILSMngJj4kaYTwuSS7LTUEJymMCRXt1pKTQPHgYSN3e
         XXz4OgWMFUUbFbxgRZpthhdDDf2JRshqgJ2tPujSMGxPwsPDAcqL2oYzB0nNoo5IzsFx
         iYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWXRy4yaBbGLOb3VHZrtrJxxwapjIbRhxQbw7lQ4SBk=;
        b=1KkugyOWm58DrhP1/HJL2lQJiIw648hb+VUU3sybqz6wOnPM2q9bw6kRFMFvUpp1q+
         7f58bBahR5ioeozpzdhEjnZi/e8KkuxJOB9bH2CtrulKKN7ZOnkw/l3oshUOENmbi0xY
         pF7rRVpYvYzBpt9gSv0ilI4arYYFyqk1Oj2W8Bk7rgsygk83Syl1tK9yv4Rg1HrrfGw2
         Dz8yuTtku+dcwApllLQd/eOTsSL52JQ3PP5hNkUS+z3AwndMFY5S+O70pbee4Ly5zrlo
         kI3YcrjK5pjF13Lu6uLNjRkPY7+A7LY74s+8l3cZ7BhsKF4Colw0EjWXf1qNwxuZ13k5
         n5rw==
X-Gm-Message-State: AJIora86quubd31MAF3zQ7p1SqkH0iYFXuNA9h7VytKubsZ/qXiHYBhw
        /sCHeaZgu+yq4byJTBNlzVD47iHuEFhot8NOoAo=
X-Google-Smtp-Source: AGRyM1uMnzlhoEa9kIAtDaxofn038vQ8pG3w3g3dbvxIL6BQElUIv2kOI2IowBawBPBcMfyzKc88Jg==
X-Received: by 2002:a17:902:aa4b:b0:164:11ad:af0f with SMTP id c11-20020a170902aa4b00b0016411adaf0fmr38179608plr.54.1655967567713;
        Wed, 22 Jun 2022 23:59:27 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id w4-20020a63b744000000b003fd4831e6fesm14317947pgt.70.2022.06.22.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:59:27 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:59:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] mm/huge_memory: check pmd_present first in
 is_huge_zero_pmd
Message-ID: <YrQPS4mhos5a+6ZB@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-11-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-11-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:21AM +0800, Miaohe Lin wrote:
> When pmd is non-present, pmd_pfn returns an insane value. So we should

Although it does not cause any problems, it is better to check pmd_present()
in advance. The change looks good to me. So

> check pmd_present first to avoid acquiring such insane value and also
> avoid touching possible cold huge_zero_pfn cache line when pmd isn't
> present.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

