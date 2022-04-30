Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC2515C87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiD3LsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiD3LsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:48:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29760AB6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:44:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k1so581178pll.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pRe1nR5tFSwQBAo9aill1CVO8UsMYe+4wRXsoq6ptUs=;
        b=K2C+RIpaUjADVZOwmI1sW8TqOxGHMQwWDrWhJMauTnAfnjwjZrm4EAAn/ym7go7UaG
         5MOMWlmNeVsvBeRjnaFp7jcCjrthg7uheYs/87FzX9dCOsBcfg0Zred+tpCt6JSMVtxw
         grpe3GGGT/8Fg0eKsAuVDmiRYe4bEeVag6WnwHAdfKRZr7KpINZXjEeqOsv6OIx4eCD4
         CpudTYZwZILqEnSP3231XuVjLfu9dxvbTRgQcXRGXC0RqKUynUmBAljhCF2RUTu6KAQv
         K3h5w8bIpT46Nu3+eGX2hvzDN29HZcDSQD48AFjR+tBiuwvBs/rg5etjWxGc4nGuHlwA
         JDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRe1nR5tFSwQBAo9aill1CVO8UsMYe+4wRXsoq6ptUs=;
        b=e877n/F+usuF+GyTu4tWetVSn4ZIUbe4RMDEJzEOW70jWplP1KLi/0+4DMu65J1URr
         CCnaeorG60dzTaJ16Mlwu31akY/nZKdM2kAw3iT79lqF1AhXDcJJtMfVA/SwpuEX9/T7
         vw1yLvLHyvyol6OfLL2tc5du83puD/awkIu1BrDMW/aX2UwiG0ZxLXzxNR9++jR/uoux
         IACbPVnZN8IZgKdrs3StJ2sp4n6f76Df4nzaqk50k88GkETnMwjzYR6BuSCANzfqmOZX
         6iWwJjUZD+3+r0pAN3ra1I4qcKgBHxAnvnHGHC8bY7imURE69EXCiO/YMbsXYTDHCaDy
         UOPw==
X-Gm-Message-State: AOAM533WC792SQtvYvhuB7S3on0suVRQ1SoJhoshFM3ofGBUJE670KTh
        HsnWDXh6zzikLeF++gWDG8o=
X-Google-Smtp-Source: ABdhPJwpIRMXMKsfvUaCZwLWtxJSWxzZKs3qrY18J3BwF1lO7P4HxwVnuHVF0CL560NQ9MYP7GSX2A==
X-Received: by 2002:a17:90b:4c03:b0:1d2:bc27:4e4c with SMTP id na3-20020a17090b4c0300b001d2bc274e4cmr3908470pjb.94.1651319088680;
        Sat, 30 Apr 2022 04:44:48 -0700 (PDT)
Received: from ip-172-31-27-201.ap-northeast-1.compute.internal (ec2-18-183-95-104.ap-northeast-1.compute.amazonaws.com. [18.183.95.104])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902a60e00b0015e8d4eb28esm1289997plq.216.2022.04.30.04.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2022 04:44:48 -0700 (PDT)
Date:   Sat, 30 Apr 2022 11:44:43 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] mm/slab_common: cleanup kmalloc_track_caller()
Message-ID: <20220430114441.GA24925@ip-172-31-27-201.ap-northeast-1.compute.internal>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-5-42.hyeyoo@gmail.com>
 <a85a0358-fd42-a269-9bde-216a9b0520c5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85a0358-fd42-a269-9bde-216a9b0520c5@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:49:08PM +0200, Vlastimil Babka wrote:
> On 4/14/22 10:57, Hyeonggon Yoo wrote:
> > Make kmalloc_track_caller() wrapper of kmalloc_node_track_caller().
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >  include/linux/slab.h | 17 ++++++++---------
> >  mm/slab.c            |  6 ------
> >  mm/slob.c            |  6 ------
> >  mm/slub.c            | 22 ----------------------
> >  4 files changed, 8 insertions(+), 43 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index a3b9d4c20d7e..acdb4b7428f9 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -639,6 +639,12 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
> >  	return kmalloc_array(n, size, flags | __GFP_ZERO);
> >  }
> >  
> > +extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
> > +					 unsigned long caller) __alloc_size(1);
> 
> Update: in v3 remove the extern, it's not necessary and the kernel is slowly
> getting rid of them.

Will do in v3. Thanks!
