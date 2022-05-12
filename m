Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C75241D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiELBEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiELBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:03:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42F6FD14
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:03:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 31so3208446pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzFXSZxGmGSXKrpoxhKMarCqVBVEsKmErajixcy/MMU=;
        b=Z7Xz3sS26Xj8FvLqt4cX8EjKc0XNm1zZohZUe5c0G358Yb5n36jVW9H0RikEXRgfxS
         54x9k3rizbf+Wv3uutl5yQ86B5MkjRAU4fIZx1Mmg+Rw2+KYHew3fHP3sym8mAyx+W6m
         30I2o5JO2MpJM7aESRASihDhdo3IThm4mHp+iRAZBqGKIymsgGQL+R77ih+IOTmIRKRM
         bXFCUsNM7/kVSM5XCwavx2BQSomZh2Newf5/921cIfRu93hptHITn3rWbXXfLj7JQPut
         IA96QUXBhIPM+nHPK5ED2tYLm0ImajXx2YzpNVERrbrMJHQjY5jsmW4S0YCuA3YHw2Cs
         O1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YzFXSZxGmGSXKrpoxhKMarCqVBVEsKmErajixcy/MMU=;
        b=SjfdXMuyaU++dT7EFyjNwblFRD92/CYlIJDmL+pjOnPUfjr3gKBN9vfD+S0gGYmJUG
         Jo4KLLJsEFTomCGbXFg3QkUo+C1VygHfVt0VYCE16912bMLKjPUWWH9BM+ixWoPhM3Ui
         4RgeQmZXDg/ZKAuQ1rdlHuMfRMt8yWom1mZsEzq77XAvLDK1vb/PleOw/V1o+d7wSbiT
         lHc8f5m687gyd6asp2YB6EOuWu/ik21+QXRlaecZafz5DPQ+BilTbVEoSPrbq1NSDyGF
         RfvMpffY4R/lpV8IlIwmFKIgdHW926PrkVSPl+OmaYz/VTMy3ZYYQy5hD6aWxnh+8qUS
         xZLQ==
X-Gm-Message-State: AOAM530O4sPCGu/fY1D2kSo0jyihs18FOs3gAVMcXjk2j+j/Moxq8Q//
        ksCFJlms+Zyd9KgX1RimdXI=
X-Google-Smtp-Source: ABdhPJyY6dSsLzH3mjIMEuwXY4gMz4p+SK5XnFgWDsWYY31BI0/Qk36ETSD4JGyoQkWaK2KW7J69ww==
X-Received: by 2002:a63:834a:0:b0:3db:5307:6115 with SMTP id h71-20020a63834a000000b003db53076115mr1963000pge.134.1652317437032;
        Wed, 11 May 2022 18:03:57 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902b68500b0015f0dcd1579sm2578305pls.9.2022.05.11.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:03:56 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 18:03:54 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Ynxc+p4G6ju6GyHi@google.com>
References: <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
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

On Wed, May 11, 2022 at 05:34:52PM -0700, John Hubbard wrote:
> On 5/11/22 17:26, Minchan Kim wrote:
> > > > Let me try to say this more clearly: I don't think that the following
> > > > __READ_ONCE() statement can actually help anything, given that
> > > > get_pageblock_migratetype() is non-inlined:
> > > > 
> > > > +	int __mt = get_pageblock_migratetype(page);
> > > > +	int mt = __READ_ONCE(__mt);
> > > > +
> > > > +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> > > > +		return false;
> > > > 
> > > > 
> > > > Am I missing anything here?
> > > 
> > > In the absence of future aggression from link-time optimizations (LTO),
> > > you are missing nothing.
> > 
> > A thing I want to note is Android kernel uses LTO full mode.
> 
> Thanks Paul for explaining the state of things.
> 
> Minchan, how about something like very close to your original draft,
> then, but with a little note, and the "&" as well:
> 
> int __mt = get_pageblock_migratetype(page);
> 
> /*
>  * Defend against future compiler LTO features, or code refactoring
>  * that inlines the above function, by forcing a single read. Because, this
>  * routine races with set_pageblock_migratetype(), and we want to avoid
>  * reading zero, when actually one or the other flags was set.
>  */
> int mt = __READ_ONCE(__mt);
> 
> if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
>     return false;
> 
> 
> ...which should make everyone comfortable and protected from the
> future sins of the compiler and linker teams? :)

Will take. Thanks.
