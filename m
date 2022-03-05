Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5614CE28D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiCEEBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiCEEBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:01:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4655574E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:00:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so3446242pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 20:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wM3eFqrqM0GuC7lgIlL7krmA9FgA7rdYgF/tZhSxxr4=;
        b=In5oS8ygv57WDqgGEdEWpKehvtF7uZ27kO3NGv3dlP4/E/E2DaYZQRx6Ha3xK+E/Og
         YSkO2MSNpHGFHOeoIdTaAv7AhTHBAoQYFI4O7F9IsrMZxureqz4q7PzfLn4U4MOEAiQQ
         IQ9vTyjcu+ZbfsLHmj/dgIcYOhqtYlIydl+vjoY4bQQ7EZenHuXt7K3arMXa36g+1ZRk
         j2TQDJ4bkTa74hsjvyjuju2SW2RL7AaRltSEagPZycctrsf8ht0VxF2uU+IWCL9PYuY2
         9O63QUbtMZSOcp4Yi4MhDFliU6r+UJMvLOwdCGLyMIENzAJOYWlsu81zRub3E5Xi8luE
         502w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wM3eFqrqM0GuC7lgIlL7krmA9FgA7rdYgF/tZhSxxr4=;
        b=nV64BPU7pg1hJcA1JLtAV/FnSpekIOjGfP1yXOWfRrYcUMCWxRWt0fMIL+J7idJPHa
         J5L9CeehHmIUimgQ18O/PVuEaV5/qveJmsJzmNRHyNlgNU3N68NXu1tFRA1TTlysFzUf
         WiiwLICVGs40ZLNflupaC2hVlVPNA19SC2MfdA2ikXng9bqaD2bOWXI9N3UtgRtaPT6L
         uqPUrw0yfHEPW9eib4swvovUsiOccMmUrdG8AdYzzGDVtyMOeui7F6umB5EwWBx9Gmw6
         CoEii/7EdyQMKqL/izhkM9rRLIBEQXNKZz/pzTLSOfBPYrGr1Tn8HeN52TGB8se8nW/R
         p+wQ==
X-Gm-Message-State: AOAM532UZMqwM+62xxWxRxDHoK4LtJz2VX+oV5Q2F/TbAgR8owMN3shS
        Ac4223Bo/efAeeWrniO5w64=
X-Google-Smtp-Source: ABdhPJxbraCj+k+dgk89zE35TCChDzD1WRpEdRo7w/OivKhf1onKp7KlG2KgTE5p+VCGRMcdSKYLOg==
X-Received: by 2002:a17:902:f70b:b0:14d:643d:9c99 with SMTP id h11-20020a170902f70b00b0014d643d9c99mr1867666plo.18.1646452817035;
        Fri, 04 Mar 2022 20:00:17 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm7961872pfw.188.2022.03.04.20.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 20:00:16 -0800 (PST)
Date:   Sat, 5 Mar 2022 04:00:12 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] slab cleanups
Message-ID: <YiLgTNaBCzjNU5gD@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
 <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:11:50PM +0100, Marco Elver wrote:
> On Fri, 4 Mar 2022 at 13:02, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Fri, Mar 04, 2022 at 12:50:21PM +0100, Marco Elver wrote:
> > > On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > > >
> > > > Changes from v1:
> > > >         Now SLAB passes requests larger than order-1 page
> > > >         to page allocator.
> > > >
> > > >         Adjusted comments from Matthew, Vlastimil, Rientjes.
> > > >         Thank you for feedback!
> > > >
> > > >         BTW, I have no idea what __ksize() should return when an object that
> > > >         is not allocated from slab is passed. both 0 and folio_size()
> > > >         seems wrong to me.
> > >
> > > Didn't we say 0 would be the safer of the two options?
> > > https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz
> > >
> >
> > Oh sorry, I didn't understand why 0 was safer when I was reading it.
> >
> > Reading again, 0 is safer because kasan does not unpoison for
> > wrongly passed object, right?
> 
> Not quite. KASAN can tell if something is wrong, i.e. invalid object.
> Similarly, if you are able to tell if the passed pointer is not a
> valid object some other way, you can do something better - namely,
> return 0.
>
> The intuition here is that the caller has a pointer to an
> invalid object, and wants to use ksize() to determine its size, and
> most likely access all those bytes. Arguably, at that point the kernel
> is already in a degrading state. But we can try to not let things get
> worse by having ksize() return 0, in the hopes that it will stop
> corrupting more memory. It won't work in all cases, but should avoid
> things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> bounds the memory accessed corrupting random memory.

Oh, it's to prevent to corrupt memory further in failure case,
like memset(obj, 0, s);

> The other reason is that a caller could actually check the size, and
> if 0, do something else. Few callers will do so, because nobody
> expects that their code has a bug. :-)

and making it able to check errors by caller.
Thank you so much for kind explanation.

I'll add what Vlastimil suggested in next series. Thanks!

-- 
Thank you, You are awesome!
Hyeonggon :-)
