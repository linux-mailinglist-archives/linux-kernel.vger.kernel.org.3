Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8404E571C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245629AbiCWRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245665AbiCWRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:05:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D2517E3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:04:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id v2so1699000qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xnq4bRc3cz88ytLQgShmjJNQac+AYZh8iK8Px2OMFPU=;
        b=kNJF0xfmaBtRkYelsVEtH2PuynVN0qClkTty/AJqdCdvjWNfq2Xk2V4TNeY1tHRasf
         CTPK60t1bo6F9GX0IylFdyy0xJliGLDWAs7nUST7tNctmZzYcpVjzH/fak4ZXsxXO+S8
         5jeejGeZpe5zVlWxy0jTumjLbwoLSDWAS28Mb2tPR983RMexa9B8B94uGt5Se317TlzA
         fU3WtHm9SV29L423AHw8spl6E8QxF+tMOI9rNhgvsxAgFQqdYolSOo6RHmtyy7VdSVHq
         kc2rJfdw5nu5tN4AsX1zAwXNsLQb3MEqwVrJye4pnhAnMx4BfdV47f/DQXRcjpQRr47j
         0b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xnq4bRc3cz88ytLQgShmjJNQac+AYZh8iK8Px2OMFPU=;
        b=5dngY9jIDzioSBBqY6fZ56Q4U1BoNZHu+GLCgTflgP2PdIuCSpgKY3sQRRJhhH34+I
         g9rge9lO6VsIztFUnbDFdGJi2+40/oo6zoTM2lZAiyjsgVbCTRk940sEU8RqMbW8SkYe
         VbibaiJT2mOqSNG7pa1YQecU9MsmVTRhHnHfm6u3LhNyq8mUWohVzeaRWShVGAO/xEKy
         q66A+24mhrb8oIgVGoXQwanAZBborRZ5ZWtKK8OZMUp64jWt1WsdreC74VLv7C94FM8g
         4HVQEjnjOuZfh9pe09F7rGmyGISsEqjRdwdukBTffSTnjpvJknMft2Xw77YE2ABpGgwh
         YmVQ==
X-Gm-Message-State: AOAM532awb7hZEZwapXDoMzBs/PzNedeNtCScSV7N7TlgTaiAxY/RQ9P
        KgdkmN9u85gPPJrUdZCWWxCmSRI0kx6frA==
X-Google-Smtp-Source: ABdhPJyYEQE0CYp6+og8QZG/WuYeFw545rz58LgI1p5Yq3Rl0fLB9/5tGE3gp9FdXtFsBCDq8JuXBA==
X-Received: by 2002:a05:622a:28f:b0:2e1:cebc:8c44 with SMTP id z15-20020a05622a028f00b002e1cebc8c44mr679876qtw.648.1648055045822;
        Wed, 23 Mar 2022 10:04:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e7-20020ac85987000000b002e1b7fa2201sm390829qte.56.2022.03.23.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:04:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nX4Oy-004y0H-9Z; Wed, 23 Mar 2022 14:04:04 -0300
Date:   Wed, 23 Mar 2022 14:04:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: blocking vs. non-blocking mmu notifiers
Message-ID: <20220323170404.GK64706@ziepe.ca>
References: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
 <YjrsOnxaPYc3rbdj@dhcp22.suse.cz>
 <20220323163146.GI64706@ziepe.ca>
 <YjtPpxlE/zWwnJ0W@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtPpxlE/zWwnJ0W@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 05:49:43PM +0100, Michal Hocko wrote:
> > The bug here is that prior to commit a81461b0546c ("xen/gntdev: update
> > to new mmu_notifier semantic") wired the mn_invl_range_start() which
> > takes a mutex to invalidate_page, which is defined to run in an atomic
> > context.
> 
> Yeah, we have already identified that but quickly realized that the
> whole mmu notifier overhaul which this fix depends on would be no no for
> backporting to our older code base. So we are trying to find our way
> around that.

IMHO you don't need everything, just commit 369ea8242c0f ("mm/rmap:
update to new mmu_notifier semantic v2") which adds the missing
start/end outside the lock for the page callbacks.

Then you can take safely a8146 into gntdev.

Jason
