Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2845958D652
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiHIJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiHIJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:20:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19413C7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:20:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 130so10239687pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TM3rKrhS4LLyfHFxti8/DhHThj14otn1DdV5zS7QdXY=;
        b=LMf9U/a9ziNb7cbG6L1+g7+mtSBdhW9E2JV7/hKmNuCCe+Ot1DG6AGZtI3QWQcapRv
         0LcWeIq0Mnspqh9Pip0mgmOm88hYPc/IUnBxXGqM1+shEHn8hjQK48LMoXiwewIIAKLs
         kT9OxstiYAo2cVUNygqvmr4fRrZBT5YQxlqbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TM3rKrhS4LLyfHFxti8/DhHThj14otn1DdV5zS7QdXY=;
        b=pq8F8caR9GGqEm4nmijtIbG69Ok844cqGNgnx8gJSxTXwwmV7nb6qVpTelfrpbvBxe
         hcMSvt7alHsXBYGwBDGl6+v9MDDIAoHZaU/slSPLXjQYqTtHDr9pce1ItytFBdR9ANX6
         v7V8Kp9vPT7rb2KJQ7m60pj1M3sElOO7WnCCM9ywIrzsq2NjABAzxVfk2K/hd2ESt5Am
         Am09v9VE20IaWg7uTvfZo+V3dgNPXffr2gRzsyViCyxZOOw8bFs9pj/8iNB2391+kGkY
         cIlkuL0ulufK8oMaSia6Fkm1TI3ZFIh5SpCZK3dVWc4UgZctkX2mHU+DkrNf83vD1yYt
         fkOw==
X-Gm-Message-State: ACgBeo1q1sfXv5xrM2RLx4057YVqatFh/PMxnNo5dw5YSABX4gcB7YfT
        RhuNZwjLbRtSznZ3f3qDPl+xnQ==
X-Google-Smtp-Source: AA6agR5M18LASvTvqemS5YZqJURjV197vab5L3N1s2dmlVLI48WCb1i5yrc6rDpOURSOpjHhk8IqGA==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr22266819pfb.14.1660036810624;
        Tue, 09 Aug 2022 02:20:10 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b0016dcbdf9492sm10364619plg.92.2022.08.09.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:20:10 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:20:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvImxBsHJcpNzC+i@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
 <YvIk3SdC7wP3uItR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvIk3SdC7wP3uItR@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/09 18:11), Sergey Senozhatsky wrote:
> > > > /me needs to confirm.
> > > 
> > > With that commit reverted, I see no more I/O errors, only oom-killer
> > > messages (which is OK IMO, provided I write 1G of urandom on a machine w/
> > > 800M of RAM):
> > 
> > Hmm... So handle allocation always succeeds in the slow path? (when we
> > try to allocate it second time)
> 
> Yeah I can see how handle re-allocation with direct reclaim can make it more
> successful, but in exchange it oom-kills some user-space process, I suppose.
> Is oom-kill really a good alternative though?

We likely will need to revert e7be8d1dd983 given that it has some
user visible changes. But, honestly, failing zram write vs oom-kill
a user-space is a tough choice.
