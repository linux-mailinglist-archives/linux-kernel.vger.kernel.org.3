Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E911535725
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiE0Ahk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE0Ahe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:37:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787332FE68;
        Thu, 26 May 2022 17:37:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so3049633pjb.1;
        Thu, 26 May 2022 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8YtTw+oDCXU/4zH8awJvWQVJSa2A0oeSPAlTFu35oc=;
        b=XysUOxsCZTA4tY9LMzb0tMf+3Q+xmUq8iL386QEmY+GPfU5w0ZDUuhP8a7/bk0pLP4
         iKk2pQ+bqHy0mHg9MLGvB2r8XnZFkKmle+A2W7bqbtpUxDKzghor2G02oa0dn9OmGLrv
         SRn/25vXXOSBzAavHMbf8VavHPLLrIWi/r0zrsY6gCsa+zSuoXMb57SeEMtnfOuzXEgy
         0ZALNkPYwL8l1TWuQ4OiZSS23scBBmjRPwXh92M4yjJ7wclxwtnzumuTnWPwHsLpWkAe
         2d812mErgNGeiW74n4tc2PGTYZ03ay6a92jC79uVGiUoBB9U21SZRU6u8IIX21CTs35R
         q0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o8YtTw+oDCXU/4zH8awJvWQVJSa2A0oeSPAlTFu35oc=;
        b=cQZVKRl1+30DIEjsNb8HeBNAHDe+1symEBzI5ICRc29gvQqwg1KgPSIAbr9XMA5je+
         5/dIlPP2GiAFXFwjrfdnvr/emvzD67wQpsnKoPU/c6Wzp3wQ8eBKpOG5pE0JqYcKTBg+
         BcxQaGgTE+atzSwHIwnCe4EbqvAAy8uFZNnFaPXi/uNNPJ0OUNsqtdl8zdd2/6Dx9BKU
         lQB34UEiNR5RxBAtN2VTWl4wl8L0oZTREFvHMFdtcvolqrf9tcSKSEQfsU4iYTWCZlaL
         D67zLaaSNkUPRg0aR9xLOY8UWvishSo6hUQCthu5Q73GidykutCAWWGe4yDZOotaJJty
         XrRg==
X-Gm-Message-State: AOAM531201tmaM51Qg4/63D/1YcOePRpvqUvrT8kNgdinl5742Jb+ZmP
        rekM1CC/8prXHpAqc9UpHQg=
X-Google-Smtp-Source: ABdhPJxv24rJD58rDnyXaJGBU6rRUJs7YcEj2PS7/yxvHNWfDAx2pYPKbR8RP2moU7m/x+FiYxiQyw==
X-Received: by 2002:a17:90b:3510:b0:1e0:b82:7558 with SMTP id ls16-20020a17090b351000b001e00b827558mr5354821pjb.21.1653611851658;
        Thu, 26 May 2022 17:37:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ac0e])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00161929fb1adsm2176193plg.54.2022.05.26.17.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 17:37:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 14:37:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <YpAdSW8JXVPOoNJl@slm.duckdns.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
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

On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> I am thinking along the line that it will not be hierarchical. However,
> cpuset can be useful if we want to have multiple isolated partitions
> underneath the top cpuset with different isolation attributes, but no more
> sub-isolated partition with sub-attributes underneath them. IOW, we can only
> set them at the first level under top_cpuset. Will that be useful?

At that point, I'd just prefer to have it under /proc or /sys.

Thanks.

-- 
tejun
