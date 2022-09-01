Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F45AA3A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiIAXVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiIAXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:21:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC69F0CD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:21:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so261953plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4WHDLqttfF+EoF52mCrZf4boyFiM0BT/dfZZLnC9DCY=;
        b=lB8ojeh/+EaeLl+eJ9d1FhOJI7q7heqy4wGRR0YXouOvwILiz4PbKEeVrF7s/Cwwu+
         rRkYnl5tzoLnPRSGQRJaSLd6r5u1wsfjNtAqH4865nL0lqIDtJT3cb6NASp4PSts7cfk
         7DAyXA3I6HNgJVhQY9dc+QiUvTUZf860wXaPSzQJjvvdnvJjWKTbPvzaFnvcgGIpoEHC
         MFsWxfAdBfCddPZUR66GOhR/FHeJ1gfAzFYE4iyvLAM+nu2dxq8MoBKYPXVsbNoKsPAW
         bG+4Yj4olQmGOKD7HQasEv+0lWENnFJrw4kJ6kzlmmizUNCUeowM9Uw++CyC0NuU6165
         8tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4WHDLqttfF+EoF52mCrZf4boyFiM0BT/dfZZLnC9DCY=;
        b=dK6B+bsnwdaiheu+hg0z4vpBn7yNfqLMHaZxpwx3cgud7zk7UKHzbT7Rn3poMLbgoL
         UXthjp4tpYvJRkcIVjXWta0PmOgkFyM/WW5lmiVmqoWYMjFftF+Jai5Zw/z7WxvIyDN4
         +m03xEDjGC4hNkfmml6nFfqdRrFvEw72JIH2aFxzYuLesdKagvw3vnJNhhUyJSCGg0WC
         ly2TscQSLQ/RDdKnB2anYFV8VUs2wZZusP7XpFI1+9g10dVND0kIrLz9r2PzCKaBMS8l
         9UBK8QtD+6g+DrnM1k2kwfqHzg1Ct0uQmw3ldXhwvShsbQjudAsr6Z1FZE9jWwEb6Hgr
         jvZw==
X-Gm-Message-State: ACgBeo30bxs2BN2XF6MTXQsJdKAzS99LFKrEZDWimFj0NEWnqppCJWGA
        wPQOd3RfbQzf8515SuT6qTJHKQ==
X-Google-Smtp-Source: AA6agR7CeHu7YH7JW/sDAsmMwzaor5vIm3hXXsQc316o6UKgIUwL4xz/ML8U96xZVGMTQlcLegLqKg==
X-Received: by 2002:a17:902:8c93:b0:172:bb10:214c with SMTP id t19-20020a1709028c9300b00172bb10214cmr33027929plo.135.1662074471777;
        Thu, 01 Sep 2022 16:21:11 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m3-20020a63f603000000b0041a6638b357sm69851pgh.72.2022.09.01.16.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 16:21:11 -0700 (PDT)
Date:   Thu, 1 Sep 2022 23:21:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: fix memoryleak in kvm_init()
Message-ID: <YxE+Y1ZDaPgChrrS@google.com>
References: <20220823063414.59778-1-linmiaohe@huawei.com>
 <Yw6C+tBZrbP5IX+e@google.com>
 <5f15a3a0-446f-59a4-6bef-8be0e5630f5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f15a3a0-446f-59a4-6bef-8be0e5630f5b@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022, Paolo Bonzini wrote:
> On 8/30/22 23:36, Sean Christopherson wrote:
> > On Tue, Aug 23, 2022, Miaohe Lin wrote:
> > > When alloc_cpumask_var_node() fails for a certain cpu, there might be some
> > > allocated cpumasks for percpu cpu_kick_mask. We should free these cpumasks
> > > or memoryleak will occur.
> > > 
> > > Fixes: baff59ccdc65 ("KVM: Pre-allocate cpumasks for kvm_make_all_cpus_request_except()")
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > 
> > Pushed to branch `for_paolo/6.1` at:
> > 
> >      https://github.com/sean-jc/linux.git
> > 
> > Unless you hear otherwise, it will make its way to kvm/queue "soon".
> > 
> > Note, the commit IDs are not guaranteed to be stable.
> 
> Hmm, I was going to merge these memory leak fixes for 6.0, but no big deal
> since they're mostly theoretical anyway.

Take them, I wasn't sure and was anticipating possibly dropping them anyways.  I
can easily adjust, and was deliberately a little greedy for these technically-a-bug
memory leaks so that we would't miss them by thinking the other would grab 'em.
