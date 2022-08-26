Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B35A288B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbiHZN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiHZN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE57D99E4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661520566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyOYiH8iFRFdQ9WUABlh8E7Nflw5YGAiJGOckPykOu4=;
        b=d4nKnJy5RVIz8421bVMKtdOPfQ9oYN+qHODLf6sw1OtIeNd0BYmh3J3hWubGKtvCD3GEBL
        k4/6HFrmakeKdvARaByc2HAHAeK1Dn8ON3sRjhHg0v9UVzKcOzofr9n8BhzWOYSEamWhef
        62h89c37fyuVE2JP5SYcVUWzmcGiZHU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-iy5wQigUOb-J0Cm4eKnS6Q-1; Fri, 26 Aug 2022 09:29:17 -0400
X-MC-Unique: iy5wQigUOb-J0Cm4eKnS6Q-1
Received: by mail-wr1-f70.google.com with SMTP id a7-20020adfbc47000000b002257209590cso170815wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JyOYiH8iFRFdQ9WUABlh8E7Nflw5YGAiJGOckPykOu4=;
        b=ZOgpEb6qpWm6fMFdsCk4Ftba6VoDwij7+zUNJXOWVpSTjImLiqTV1RYd7OnDU47STB
         HnG/daS0bwW0IsQie/eVhWm6CTVhc0OwzZL+4rQQtHXe4hyTetHJgJCSPUg4FEkdf24D
         PUUy8vCWF7w/4umzGp7/00TJFEQ7AQtKbpGf6o8Q0q4xfGTKM9TYStaXB5N9MvCat/Ki
         wGSmoPBM+nFXb2vM3QCLA3RHCL3S32m3y7h0rcjn+Z1NSuz0IBiqpwmj4tVaO7ZrRLYB
         kvwtCpDJgMJDKn4hvpzyxAwkMU3pkIzMg8+QwydqXLZ4vgwrawTvwGLvTBZfP7RCEBWh
         z+Gw==
X-Gm-Message-State: ACgBeo08awHR8pxKsmeUGDS1QbFezZvSIQo8pZ7DduP+0qS+FEHCDOV4
        4bTMH6WFYIQLwmSa/YLG7S6POmOe3Elo/FGwOnCvCpsswcPbfFqOYS5t2utTagwZbb9UzQwTSc5
        Kf/9A2fvD7xersqvfCmT6QO0=
X-Received: by 2002:a5d:6d07:0:b0:220:68a1:9ecb with SMTP id e7-20020a5d6d07000000b0022068a19ecbmr5276406wrq.116.1661520556609;
        Fri, 26 Aug 2022 06:29:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7SKH8Ic0ZS2D06PiFXVipnW2vE66/mTXlbBQAv87GY61fOpzUZs37CFvoKq6aDOGdy9DEYqg==
X-Received: by 2002:a5d:6d07:0:b0:220:68a1:9ecb with SMTP id e7-20020a5d6d07000000b0022068a19ecbmr5276392wrq.116.1661520556403;
        Fri, 26 Aug 2022 06:29:16 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bj22-20020a0560001e1600b002251639bfd0sm1928626wrb.59.2022.08.26.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:29:15 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:29:14 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, frederic@kernel.org,
        cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 1/3] mm/vmstat: Use per cpu variable to track a vmstat
 discrepancy
Message-ID: <20220826132914.ia77vdzhi7dna6ww@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220817191346.287594886@redhat.com>
 <20220817191524.140710201@redhat.com>
 <20220824132054.54ec0472496db153223282c4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824132054.54ec0472496db153223282c4@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-08-24 13:20 -0700, Andrew Morton wrote:
> > --- linux-2.6.orig/mm/vmstat.c
> > +++ linux-2.6/mm/vmstat.c
> > @@ -195,6 +195,12 @@ void fold_vm_numa_events(void)
> >  #endif
> >  
> >  #ifdef CONFIG_SMP
> > +static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> > +
> > +static inline void mark_vmstat_dirty(void)
> > +{
> > +	this_cpu_write(vmstat_dirty, true);
> > +}
> 
> If we're to have a helper for this then how about helpers for clearing
> it and reading it?
> 
> Also, vmstat_mark_dirty(), vmstat_clear_dirty() and vmstat_dirty()
> would be better identifiers.
> 
> Then those helper functions become good sites for comments explaining
> what's going on.
> 

Hi Andrew,

Fair enough. I'll work on that.


Kind regards,

-- 
Aaron Tomlin

