Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5194E4EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbiCWJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiCWJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6507523D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:06:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d15so614808qty.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXKJox2Om6etwhk7KJudaau7HUz1EpjmJZ/s63T4/k0=;
        b=bm/LCnkLnZw611V9fsvsjCOv4UdBglqU2xwn9F0GdNmft3KRdpuArXrTqUlAZr1GfI
         EMhMVS9AnMUfwKK2rZNZbLV11Q5tIPzC+SCr+3FPP05iQV7Qam3S9B4y53rUHTs51jlR
         SxXybEdYfprHXi/F8oeiTLQyPpns8q2FLTVfpq/2i8WG3uY/5N/qgB2D8OZDDUDnxTMO
         sjqJyqH/YEQk63jF/ifA3HYmZ+VrxQNCZL/CxU4rdKyeG16PUd8TtHKUka1mdVQJTL1z
         R1K0XaUNWH0XRaQErsGKjkS5+ofNUsQFb6lpPRQmec7o5m0NtERx6NHVhY+imQup79Bn
         027g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXKJox2Om6etwhk7KJudaau7HUz1EpjmJZ/s63T4/k0=;
        b=hoS8WVWOdTcTRZO6HtEUzuKU+83SRPCUMIfPijv50FwuYM7841d5NGlt/eyHm8fa3d
         CK5BCMoqqeN3ITfCKRQGrv3pwFxFU6lzdh0OGwf9fGzTuKRAeNpq45Q4E9RSMF29WNXt
         9YDek3B3BdW8xlgMBw4YULYB02XW2H3lieSvUJFKgYeC76RxYaT+AVwfFHqhG/9L8l8r
         xwt7hfBwA2UciQ3ryhVQLh95y5hapsvQ5lofLJlq4tASftgeU4fxfYLhNa8xxqDuVGyt
         XojVFLvF2dr8wahJbMTKHSyCG1bGMiFhH+K45pejMzoPKR/tpKq6NSlITsgwRWM8H5bE
         aIIA==
X-Gm-Message-State: AOAM530Iq6uP6nZoYVjgfGDteDpvhk0Re3JZ54/gpfodAFh2nSSSLElg
        zlNg7+kRRXz37uj7xFl3fhk=
X-Google-Smtp-Source: ABdhPJx0jnj942+IQDs3MSGcp0tcvBVn7ITkv+Q6pQ7GaRiUtb5yBiAnCoj/AlWDZZI22lJo4htAXg==
X-Received: by 2002:ac8:5d94:0:b0:2e1:ce44:5041 with SMTP id d20-20020ac85d94000000b002e1ce445041mr23459241qtx.356.1648026362515;
        Wed, 23 Mar 2022 02:06:02 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm15350634qtd.24.2022.03.23.02.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 02:06:01 -0700 (PDT)
Message-ID: <623ae2f9.1c69fb81.28ae2.21f3@mx.google.com>
X-Google-Original-Message-ID: <20220323090558.GA2345975@cgel.zte@gmail.com>
Date:   Wed, 23 Mar 2022 09:05:58 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, bsingharora@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] delayacct: track delays from COW
References: <20220322110444.2340748-1-yang.yang29@zte.com.cn>
 <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9ddbf7-797a-58d8-2903-beacb2698329@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:49:46AM +0100, David Hildenbrand wrote:
> On 22.03.22 12:04, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Delay accounting does not track the delay of COW. When tasks trigger
> > much COW, it may spend a amount of time waiting for it. To get the
> > impact of tasks in COW, measure the delay when it happens. This
> > could help users to do tunnings, such as decide whether to use
> > ksm or not.
> > 
> > Also update tools/accounting/getdelays.c:
> > 
> >     / # ./getdelays -dl -p 231
> >     print delayacct stats ON
> >     listen forever
> >     PID     231
> > 
> >     CPU             count     real total  virtual total    delay total  delay average
> >                      6247     1859000000     2154070021     1674255063          0.268ms
> >     IO              count    delay total  delay average
> >                         0              0              0ms
> >     SWAP            count    delay total  delay average
> >                         0              0              0ms
> >     RECLAIM         count    delay total  delay average
> >                         0              0              0ms
> >     THRASHING       count    delay total  delay average
> >                         0              0              0ms
> >     COMPACT         count    delay total  delay average
> >                         3          72758              0ms
> >     COW             count    delay total  delay average
> >                      3635      271567604              0ms
> 
> You should also update Documentation/accounting/delay-accounting.rst
> most probably.

I will update this documentation immediately if this patch is merged.

> Overall LGTM and this might be of value not only for KSM but for anybody
> using fork(). There will be collisions with [1], especially [2], which I
> want to get in -next early after we have v5.18-rc1 (after rebasing [1]
> on top of this).
> 
> We'll have to decide if we want to also account hugetlb wp code
> (hugetlb_cow), and if we want to account "unsharing" here as well under
> cow (I tend to say that we want to for simplicity). For THP, we only
> split and don't copy, so there isn't anything to account.
>

Thanks for your reminding, we will work on that too.

> [1] https://lore.kernel.org/r/20220315104741.63071-1-david@redhat.com
> [2] https://lore.kernel.org/r/20220315104741.63071-14-david@redhat.com
> 
> -- 
> Thanks,
> 
> David / dhildenb
