Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF715211A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiEJKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbiEJKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:05:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852465C67E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:01:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c11so16285373plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dKd6PeE6IoUKq5eCY4sziXe/k6yepX5DHoIEP3vKroI=;
        b=p6Q9lZbwn2txxQit8nNlpATWOpBAOzcZa8fKxyWqZAa/9+k1fNNzSiiu2QwKypIGJ+
         1LI375tPYG6AGJXq23nOIZ8fmx9Do4c20ehHoypDJ5L/9RbWK9KMd/p2qbkMNw2K6INC
         Hzc6WD0QdebWx3Rp20yoyLfWXgwHEg0JGxnS/c+xuTQyXofTj6noo6Q1nJiU4WbYg+I3
         4W8R/y1ThaRCLOXONMwD7oTG2Yh5QJlpmxxr216c0Q0aSBXAz09rSQ5FEG4uLazteNkS
         ww+qVAhJzS8pLLC6gG8V7TqhcFV5W73wys74hRXZ/i63B+mkHc3mkEbe6O+OiXnDEsiN
         bI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dKd6PeE6IoUKq5eCY4sziXe/k6yepX5DHoIEP3vKroI=;
        b=ooZsas1P+kNQAlVBsCyAqU2Z9AOxZPJAQSj4bL4FPTOOwnS5oJMm1HK5GyMj5ikfz9
         3We67ENwn0AU8LQAiAVjzCSngyBZG2Vpa5AF8EwqeEWT/V1Dpm6Dwhdyf5sV0GHQ3EJx
         Di40yNQG/hDhQ+1GH5Rr8sj6b/LHfA5Fn+E2eyVVmmu4LuP05TMePgsBFHf+SaP0SJQZ
         4pSipgNNHqF9dZ52NzFhBkNeER9T9NxijH8JiPx0siHTx3EDT5m++AINMbmhH79LHxzT
         ulXcZ4YPeNowNfgj6UAQXO5dmrwl0jtiSf6IM3W4Nz9uBoByhHDi9rFs+x8REU2+E/eA
         4dkw==
X-Gm-Message-State: AOAM532cVF3DuAI/TEcCo6kXnDw0mhf8czHDvYU8RX/fpi064FruY/BM
        II0WbxgWCMMI4/ChuXoHFyU=
X-Google-Smtp-Source: ABdhPJwhBlOh8c5+Do3yO77gT/Bb4S3/knIx47b5lw6oc/UX26n0E7WAAoaKPg5Ya/cfRKW2qBV9RQ==
X-Received: by 2002:a17:90b:3a8b:b0:1dc:4eb4:1f2a with SMTP id om11-20020a17090b3a8b00b001dc4eb41f2amr30991656pjb.50.1652176897983;
        Tue, 10 May 2022 03:01:37 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b0050dc7628153sm10413812pfl.45.2022.05.10.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:01:37 -0700 (PDT)
Date:   Tue, 10 May 2022 19:01:32 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for slab
Message-ID: <Yno3/I/lBeQTNJ7A@hyeyoo>
References: <20220507073506.241963-1-42.hyeyoo@gmail.com>
 <42799bd1-2c5a-d2ae-65a4-76e7de4f68a3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42799bd1-2c5a-d2ae-65a4-76e7de4f68a3@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:09:24AM +0200, Vlastimil Babka wrote:
> On 5/7/22 09:35, Hyeonggon Yoo wrote:
> > Recently I was involved in slab subsystem (reviewing struct slab,
> > SLUB debugfs and etc). I would like to help maintainers and people
> > working on slab allocators by reviewing and testing their work.
> > 
> > Let me be Cc'd on patches related to slab.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Added to slab tree, thanks for your efforts!
>

Thanks Vlastimil, you are so thoughtful and nice.
I enjoy working with you ;-)

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index edc96cdb85e8..c21e6221513f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18103,6 +18103,7 @@ M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >  M:	Andrew Morton <akpm@linux-foundation.org>
> >  M:	Vlastimil Babka <vbabka@suse.cz>
> >  R:	Roman Gushchin <roman.gushchin@linux.dev>
> > +R:	Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >  L:	linux-mm@kvack.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> 

-- 
Thanks,
Hyeonggon
