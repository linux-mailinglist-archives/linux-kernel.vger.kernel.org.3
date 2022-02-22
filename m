Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F734BFC54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiBVPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiBVPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E08109F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645543290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8l5PJCPnTCzVePHoOuB/aOhZkhMEfR0E0RLaLQlVdg=;
        b=AXxHIW1owQOPKQDBCftf6a/Vkw1GtI2kXdQaqDyCVD1jzjYVQWojf1tCKZyQ09wXgBsyEX
        zHOLJLDdO7Fn6vAv7fQcquayl6tVEOAtFY2etszfDtY6/aWo/QBrhNnbR3CPTyo4LKnRAt
        glfAJXx5kiC/ugA8cbZNTEAif9fYNGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-xKHwA422MaeLWhd47z2LGw-1; Tue, 22 Feb 2022 10:21:29 -0500
X-MC-Unique: xKHwA422MaeLWhd47z2LGw-1
Received: by mail-wm1-f72.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso763975wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=t8l5PJCPnTCzVePHoOuB/aOhZkhMEfR0E0RLaLQlVdg=;
        b=hByRljomTq2/JWEfrGLQ8Ep7DES1f1NIzetxpRK60y3wTeS/EXlXCmkTXcJ3vId2Ce
         /n//8vveq4Tt2hg7NSftBBhf5y6BcCyfuk/j5Y8tP45VEDWmdBI7lLhZ4YYPsBV9rp/4
         vqKZBaFOC6xLagRXjgtps9Fxuu5LI4c6sXyqO9X1xkDlK9bowzXPxHPul99K7KqK77dL
         kNU4DwvQ2lqXhhbcA3uCLBxZl/H7Q2W7VF689EjmH3XnizOK6mmLekcawU03EHVjOgyK
         3SZQCyhW/L8hivT9yvr9srM7W2u1sbRHZLtCOGPEtvhO4COGnQ6WYtl/Xdnfb2Pof6z6
         G2SQ==
X-Gm-Message-State: AOAM531gH/tuP0NIFIoZJZT6XmrJcM7kO1qkpjDyPb8kSuCTHDcSn6ZL
        NOz+7G4BsDs3ZR6U4cVkwxFFRYdtfqf5ZcdmT8+E0e9Du9Crr4zXDSXJ72a0idV0FXtoq5Ipr6f
        WVb8f1U2qZ8C/IL9O8HisSyNz
X-Received: by 2002:adf:df12:0:b0:1ea:973f:9890 with SMTP id y18-20020adfdf12000000b001ea973f9890mr2341660wrl.65.1645543288129;
        Tue, 22 Feb 2022 07:21:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqJF32bzLsgYury03YWH5n07dggag/D6Bjoypm5aoTerwO+vp29KtNOGH1QDLtFs89EHtnDQ==
X-Received: by 2002:adf:df12:0:b0:1ea:973f:9890 with SMTP id y18-20020adfdf12000000b001ea973f9890mr2341646wrl.65.1645543287955;
        Tue, 22 Feb 2022 07:21:27 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id d14-20020a05600c34ce00b0037bdd89e3a5sm4306164wmq.3.2022.02.22.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:21:27 -0800 (PST)
Message-ID: <5f96c7e306546af4604cfaddb895a089811cb99b.camel@redhat.com>
Subject: Re: [patch 1/2] mm: protect local lock sections with rcu_read_lock
 (on RT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 22 Feb 2022 16:21:26 +0100
In-Reply-To: <20220222144907.023121407@redhat.com>
References: <20220222144706.937848439@redhat.com>
         <20220222144907.023121407@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 11:47 -0300, Marcelo Tosatti wrote:
> For the per-CPU LRU page vectors, augment the local lock protected
> code sections with rcu_read_lock.
> 
> This makes it possible to replace the queueing of work items on all 
> CPUs by synchronize_rcu (which is necessary to run FIFO:1 applications
> uninterrupted on isolated CPUs).

I don't think this is needed. In RT local_locks use a spinlock. See
kernel/locking/spinlock_rt.c:

"The RT [spinlock] substitutions explicitly disable migration and take
rcu_read_lock() across the lock held section."

Regards,

-- 
Nicolás Sáenz

