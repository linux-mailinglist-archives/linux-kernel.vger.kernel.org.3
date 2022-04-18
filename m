Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22966504B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 06:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiDREDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 00:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiDREDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 00:03:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470018B31
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 21:01:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u2so16637369pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WDL1LdNCgcBojb3ge+3pVQIK1RVySUq4qbmbuvDh6aM=;
        b=h7h1nXmldfg6Ma6isM9+5oIdvEdeoX6annXY4zG+KmSd+Oo9+OyzgT7R8J40vSH8lF
         VKIzoLdn4opHnUt+zP0iYwz4qZCzDcawKprYLI2jPxkepfUry+WAFc2GvbDtObPsK01L
         3t8yaLPHPn7C35fNEAK5wqET+qShNKc7WFeDt6lyWIYzJZ4phfV0pS6+vFTTLpdjaYVt
         JGQ/Wcr/ahflqcJpnw1vZ8x9oJNJqzz8Qe02w/42dPlx91y92uwRuQEfh/4j/9ankgGE
         PHGN6zRs3vCDTA1hV5d1HuVU8Z+uu+ELmkNy9CX/QjPieEB3ww5rxoSum9nv7OD+WTc/
         /vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDL1LdNCgcBojb3ge+3pVQIK1RVySUq4qbmbuvDh6aM=;
        b=F2r8YJIbm6Nn8zRx9WrKwPgiridzPAQmxJod2rBFfgX74ZIaq2Z2JXC5Yq0q4DUhPt
         VMzfMNTiXnFY3YTps1Q5e2kMR64to36faEar6o2Q9ivkXi6DuzCkyAkPEiSBAOCsyf4h
         q85yRU9O2HyG5fB1eM9akTE5MvaDbhcfWx+GBSs3cy6Egxc5yJe4vBin81i/YlNVxxO7
         KsVNXyPzZxjQRRt88i4xPAA5KE8+wz1YDvQYo+G5qionU4oOy9FMdx2iv4m6RKNHVPn7
         MaDIs0O64Y/dk7/BY3+HrYQ6IbbLKSTvIxonfhqgL0g8RmFZVsidi60JZOU8bm5AljCQ
         VM1Q==
X-Gm-Message-State: AOAM530ZBIk4/gx3t4c8gMHJTy5UkBSvtNwctXYp6Wc+jmrnl89kir/s
        zirDaYomdQE1dl1cuAvil8U=
X-Google-Smtp-Source: ABdhPJykXDe0gp+/XzGRlhpFer2xNQGb2VKm+tH66pl2cpaeyf8rwhJ5Y+rXsRprsibUqrLemIE8kw==
X-Received: by 2002:a63:fa06:0:b0:39c:f169:18e6 with SMTP id y6-20020a63fa06000000b0039cf16918e6mr8667168pgh.129.1650254462888;
        Sun, 17 Apr 2022 21:01:02 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm10935762pfl.148.2022.04.17.21.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 21:01:02 -0700 (PDT)
Date:   Mon, 18 Apr 2022 12:00:58 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Message-ID: <20220418040058.ws6ijoeggnycs22y@ppc.localdomain>
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <68484555-f763-bc42-eb4c-9cea2ee8dadb@gmail.com>
 <20220415095741.3zfuztivtgidvpqc@ppc.localdomain>
 <5d9181be-0a02-0623-7741-1d4352d62610@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9181be-0a02-0623-7741-1d4352d62610@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/16 01:57PM, Pavel Skripkin wrote:
> Hi Wang,
> 
> On 4/15/22 12:57, Wang Cheng wrote:
> > Hi Pavel, thx for your review.
> > 
> > Sorry, this patch is just confined to fixing uninit-values with
> > modifying the original code as less as possible. It sounds good to
> > refactor r8712_usbctrl_vendorreq() with better API.
> > 
> 
> I understand your idea, but this will just hide the real problem until
> syzbot hit it in different place. So, I believe, it's better to fix the root
> case instead of hiding local cases.

Of course, I agree on fixing the root case. I will think about replacing
APIs properly.

thanks,
- w
