Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64455D635
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbiF1KHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiF1KHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:07:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49AA22506
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:07:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 68so11716100pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLmwHIaRbzmI3Ysy3wd3NH/Zd+yQ1mohcjSyjn86r8c=;
        b=nb2JM0pe7slLxtqpP4AdlYeQlIoORBgwrlFrBJU9QKJC2n82HV06MCGw+mGiIHtpfV
         YpVJ0pgd66SqDoXXjxsMuh0OyOsrf+W33U97UI/dh3qyNpqnW4YwqZusvBB17DVdkM75
         OF8c+21AKFvlcmNadjBkZUyngAhGL/HcgkE6n4R/LoUxV1LZUjZGMTB/5pCB6a5igBXU
         pQNXKFI5x34eDR8BUwFRHi/WhdcU9Jk1uhqBoBoeu+yLcnVMdIyQRRRlH0MCJqZ9mV9R
         471ABePDLoj2MeYn1f5BpteZwek2Vh46yEnk/b02AyOh+O8b+tcr2jJgGynbdJIHghYc
         jFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WLmwHIaRbzmI3Ysy3wd3NH/Zd+yQ1mohcjSyjn86r8c=;
        b=3KV8Nh0OXpij5CfVtMCMZTTVonRusZ/A+0QOvMrTTsLkiiTACh1udkqaCZPWLP5Adh
         ogYhGV6INWfmj6ZRP+j9gaQUziaD9AtwB4QOqwhA57XzNNaSUn6L2eE87An1psxiF74O
         5OI4VqGQ5aehjMDnzwtYjFTXYRopViuunHTUJovshjyjKWb0E9cmM39xHe783WByRbHu
         SxnEovTmB2Dgz6/wS3lGRClYeM5Z6ee4XxjMU/55fyyQq6de3K7M2JrTEhQRIYOgjY+t
         Ts9XTHRQmnEI2VAkPZt/AEnKBWuBsNGyI2Zc9EM6abWzmkWBn2anKJ/5aP3BNFJ/V5aa
         A5BQ==
X-Gm-Message-State: AJIora/C4+VZNu/tbgWDGQuZVJTAkTUTscgVj2owlFyaZWajCeUAuuJB
        4rpumFjK9miUo1qdWaZ+gAY=
X-Google-Smtp-Source: AGRyM1tavDJ/u4qKa0WrSDoZv4J/LE/iIK6Gb5GwDizQyErAP7Fu7d6cDWGqvrB2tiuG6yPreNTnOQ==
X-Received: by 2002:a65:49cd:0:b0:40d:7553:e3be with SMTP id t13-20020a6549cd000000b0040d7553e3bemr17285003pgs.370.1656410857024;
        Tue, 28 Jun 2022 03:07:37 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090ad70300b001ecdd9507b9sm9003892pju.26.2022.06.28.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:07:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 28 Jun 2022 19:07:34 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrrS5qhUxfBvbiR4@mtj.duckdns.org>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <YrrPKU2y4liY91u9@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrPKU2y4liY91u9@alley>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:51:37AM +0200, Petr Mladek wrote:
> I quess that I felt overloaded and wished a calm day
> or something like this. I agree that it does not make
> much sense.

Hey, we all get overwhelmed sometimes. I wish you a calm day!

-- 
tejun
