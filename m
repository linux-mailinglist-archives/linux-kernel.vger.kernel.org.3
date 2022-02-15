Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CED4B6671
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiBOIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:47:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiBOIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E880A1133E2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644914861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4UdifMYSS3/zhcng0VskO4a/iClBAxoJzpoK0nsepA=;
        b=F/tHojAW2eEE8PC+9J4U6rcRqlOXjw9PAMOJgoRBbCLltuni6C9Lf0JmJ2tf7F6QTbu4vE
        zC2MZ8ZpBYIVXwOtiyQ9SKyMHsEAH15AP9EC1aJyGSGqzEli8ND2i3cTti8LLFeRMWRIAT
        g1UT0CsLjQUoPPExaSUx5Ymt8i6og7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-11NlNAkQNZmz92VV5Bjngw-1; Tue, 15 Feb 2022 03:47:39 -0500
X-MC-Unique: 11NlNAkQNZmz92VV5Bjngw-1
Received: by mail-wm1-f71.google.com with SMTP id r11-20020a1c440b000000b0037bb51b549aso258837wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=a4UdifMYSS3/zhcng0VskO4a/iClBAxoJzpoK0nsepA=;
        b=WhtwNryI6YksRh/OgTbBcc3AOsaF+J/AJcTNSGt9gKhQEyrzop1A4gPJiOus9FvgMH
         JRBDxRbGYVNgrVGGNNxcJUJnsZO3uXGOO9WyS4Va3wuqPemnxNwzhPHrWbzjFXSV3OYg
         gayfXMheypXqVtoU885ScqzkvMRC2FMFFUiFju8ku6YTkG+tzAZRkObIGnwh89mEPcph
         L/68IrbfF/0rMHIESrEdVOayeyYZDEsIZJNwAbn1aHzdwL6pKZLj1T6g2Lj8ASZwoWpn
         awDBI0lgrSFyqHshnrBHS5nGZdRvHBCQvZcU5lngtuxKWPZbzf2RYdPtwGE4ZNXNJhgZ
         JooA==
X-Gm-Message-State: AOAM53095/aLVsDtBqbs1BrlFZALkGtp2AxlL2wBJ9X1Iv5IPtFOwhXd
        9XLyAXZuFj//U1bOMpTXPKpIyx6ZWCXrxyoeGWmvqDHEwZFQ7iClAao6qlFNrPZJOsXlCDaEKk1
        rwsMe/J/HeXQq5UrH4PuW5Hzi
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr2160348wml.11.1644914857874;
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQH/cUi47rF7Dz/C2hD5pM34xuVhSFpBfvoq9RjatP0EnS4lddQ+g8Lgo9AlCHPsD4UxJJfQ==
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr2160335wml.11.1644914857642;
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id p15sm17252917wma.27.2022.02.15.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:47:37 -0800 (PST)
Message-ID: <2374bbca7651b671ec934fa5c630cbe3eed3b496.camel@redhat.com>
Subject: Re: [PATCH 2/2] mm/page_alloc: Add remote draining support to
 per-cpu lists
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org
Date:   Tue, 15 Feb 2022 09:47:35 +0100
In-Reply-To: <YgKQfsznPUDN34un@fuller.cnet>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220208100750.1189808-3-nsaenzju@redhat.com>
         <YgKQfsznPUDN34un@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 12:47 -0300, Marcelo Tosatti wrote:
> > Changes since RFC:
> >  - Avoid unnecessary spin_lock_irqsave/restore() in free_pcppages_bulk()
> >  - Add more detail to commit and code comments.
> >  - Use synchronize_rcu() instead of synchronize_rcu_expedited(), the RCU
> >    documentation says to avoid it unless really justified. I don't think
> >    it's justified here, if we can schedule and join works, waiting for
> >    an RCU grace period is OK.
> 
> https://patchwork.ozlabs.org/project/netdev/patch/1306228052.3026.16.camel@edumazet-laptop/
> 
> Adding 100ms to direct reclaim path might be problematic. It will also
> slowdown kcompactd (note it'll call drain_all_pages for each zone).

I did some measurements on an idle machine, worst case was ~30ms. I agree that
might too much for direct reclaim, so I'll switch back to expedited and add a
comment.

> >  - Avoid sparse warnings by using rcu_access_pointer() and
> >    rcu_dereference_protected().
> > 
> >  include/linux/mmzone.h |  22 +++++-
> >  mm/page_alloc.c        | 155 ++++++++++++++++++++++++++---------------
> >  mm/vmstat.c            |   6 +-
> >  3 files changed, 120 insertions(+), 63 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index b4cb85d9c6e8..b0b593fd8e48 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -388,13 +388,31 @@ struct per_cpu_pages {
> >  	short expire;		/* When 0, remote pagesets are drained */
> >  #endif
> >  
> > -	struct pcplists *lp;
> > +	/*
> > +	 * As a rule of thumb, any access to struct per_cpu_pages's 'lp' has
> > +	 * happen with the pagesets local_lock held and using
> > +	 * rcu_dereference_check(). If there is a need to modify both
> > +	 * 'lp->count' and 'lp->lists' in the same critical section 'pcp->lp'
> > +	 * can only be derefrenced once. See for example:
> 
> Typo.

Noted.

Thanks!

-- 
Nicolás Sáenz

