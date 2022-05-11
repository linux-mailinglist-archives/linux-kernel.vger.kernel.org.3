Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BF52409E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349074AbiEKXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349052AbiEKXPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:15:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CDA16A11C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:15:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so3335743pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2PZ7/ergchDUvDU1q/dXdJquLBZCPQq2ci7Ijk/I3o=;
        b=M4QjA4SkWhdKZ4VkoGA74I2zNJd01CKQqCeov3Rkl/dmflAQtAHHVHBQnwwB9rFKXX
         U6Z3nkjmpZnQr/91j8VdrH45ohKSPdMwKq6BhiC6VP6/GD3BXg/9AfpT1WgRO7kjj93M
         rOhelHLMXeiJZKg/tO1XJtQGbatXB7evVCU9CyU93gg19rIKiAR5DZp9mJnnq8sqS1Cq
         c3zHvjYOhujXQ+RHgpVVn3z/kV6dK26AJIPkolYP2xVoEaI7FS98EWVekkpCihlIE1lW
         ledrjajj/M1I29UdJHCEqgB31G87bTYP0JEMnWC3CGtJCEtCi3FtdhSwpeRepgtfV9p7
         Co7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m2PZ7/ergchDUvDU1q/dXdJquLBZCPQq2ci7Ijk/I3o=;
        b=WgAYo0o1ck0sGukApp6t9WKbIf6eM9BQr22KUiCttD+sHQ7i1KnZApLsuO6/gG9nRB
         i3nfeqg+mONqDILhK+xBy8QxFW+KVxLpEWcjJGGcasYV2gVcsrZLcQnDXI1b93wCReLt
         BOycjkmY0onuykVV2Mu9sdiSxY9c5PQbJK6LengMwaFNxeDrthToMZVH9BwndcJyr3ds
         O26vi/OoYGlXLAzRJMR2EJRAgtZzFFzRd0IEUktq6nTi6c8WzG9przVgKHdmROJMemOs
         fV95tiZyE3oiqSs81nyfqNxo2eorBlZLpLBxhqoeMUkHYfhqeEf/ym9IRJjiDMbeSRl6
         fwDw==
X-Gm-Message-State: AOAM530tNAoTd3+Xf9SDzVopIsROV/ZC94CIiLEbOHq1STOuIRrS0j+W
        OPev/Q6mwJ3pjKipi7MhtQ4=
X-Google-Smtp-Source: ABdhPJyNqumh4+qTIEHzWQXH0hRJocp+/otL3WWip/bkqkQSkvQunCDy6QkojaGAb5hPjyW96ejSNw==
X-Received: by 2002:a17:90b:17c5:b0:1dc:e0a6:340b with SMTP id me5-20020a17090b17c500b001dce0a6340bmr7816101pjb.34.1652310919815;
        Wed, 11 May 2022 16:15:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902b68500b0015f0dcd1579sm2498181pls.9.2022.05.11.16.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:15:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 16:15:17 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnxDhdb4YCo19Qx0@google.com>
References: <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
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

On Wed, May 11, 2022 at 04:13:10PM -0700, John Hubbard wrote:
> On 5/11/22 16:08, Minchan Kim wrote:
> > > OK, so the code checks the wrong item each time. But the code really
> > > only needs to know "is either _CMA or _ISOLATE set?". And so you
> > 
> > Yes.
> > 
> > > can just sidestep the entire question by writing it like this:
> > > 
> > > int mt = get_pageblock_migratetype(page);
> > > 
> > > if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
> > > 	return false;
> > 
> > I am confused. Isn't it same question?
> > 
> >                                                      set_pageblock_migratetype(MIGRATE_ISOLATE)
> > if (get_pageblock_migrate(page) & MIGRATE_CMA)
> > 
> >                                                      set_pageblock_migratetype(MIGRATE_CMA)
> > 
> > if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> 
> Well no, because the "&" operation is a single operation on the CPU, and
> isn't going to get split up like that.

Oh, if that's true, yeah, I could live with it.

Thanks, let me post next revision with commenting about that.
