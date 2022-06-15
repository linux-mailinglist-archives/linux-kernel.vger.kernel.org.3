Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8B54C89E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348778AbiFOMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347270AbiFOMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:33:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E324BEE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:33:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o6so10302560plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KYV13fgGLre8uPMLDOQm5AuaXSbMGKMf6dQuecyDzIE=;
        b=FESMll9aOkfaty25hpn2xP8T16f2E5SiMKIK8MD2Q8MX8ZvAKRLTomfhqT6VfNWG+M
         cX8nAPRvUaTtYvJTA0P3fmF+zzJ03XB+KtVFvey6e4GMnKQ02YJ5q0IMyiu9uwR5QVdd
         QJwO8vvy+JXjlFRgah8MxWYYes/kpDE1VbUbfhrBROje3u9ep/320llEuaX9WOxCecpU
         7nVKPlbFFi4LjtVtukKJEYFlNQlF7vSTVIYXHBv9j7a1toWVlW1So9RsiW/0RG4sPQ8T
         XSeDLurTAvqNucYs1VXicsqOUkbhWCiMX8PtZqNpQsdTzdH2Sl8C8ZPXCghkir8GYcCq
         UlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KYV13fgGLre8uPMLDOQm5AuaXSbMGKMf6dQuecyDzIE=;
        b=FtOav/z2So/o5n80yri9x9oComcfYQ8116hDkcUv96+NASAaK11707/KVk1y19GTOH
         vYsxQAwaUCBFX0Ny2dib94IiVTv/bMCIArsEfJwiy8j7HLoEabG09aEqO/ByI1aVCmBa
         K0JwLrLo2UTHtkW/KeyeOAiyfKWVCuRCUti/rb76e+ldJf901uud8icwduz4MNi0U1T7
         MiGHwS8+mcKNoLJdTeEoeHiz5nsGjlOwwDmfW3phEUi8ZipAikvKu9l+mIxs6qW9k4p8
         BHfckog1fkfCtDSUbmktS/EegHpBOFV/2y/uYSGeEWFjK83gYOrmpAqs3mOtMm/PITef
         BZmQ==
X-Gm-Message-State: AJIora/fUscfYoLcMnoHSqQLTOrbl7OedwKTBbnthPCEBU4eWulm+y+I
        g0qOxzuC6Y7uFv3isWP0X2nN/Q==
X-Google-Smtp-Source: AGRyM1tdnl/wOeuGLVRdWp/163hE3xRu+d14niuWF/eXqr8nGaRlnbrTCAuj9wJF3GUlnmxoZ37Qmg==
X-Received: by 2002:a17:902:7085:b0:168:97dc:ddde with SMTP id z5-20020a170902708500b0016897dcdddemr9121500plk.25.1655296403388;
        Wed, 15 Jun 2022 05:33:23 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001e67e01158fsm1645438pjx.30.2022.06.15.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:33:23 -0700 (PDT)
Date:   Wed, 15 Jun 2022 20:33:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <YqnRjRJgHQYmz12B@FVFYT0MHHV2J.usts.net>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
 <Yqb2bA25HhLU/mpM@localhost.localdomain>
 <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
 <YqfUxscKfUhT35jR@monkey>
 <YqgL0ZcU5dhhO5uL@FVFYT0MHHV2J.usts.net>
 <Yqi9/4aUBBN8nOCG@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yqi9/4aUBBN8nOCG@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:57:35AM -0700, Mike Kravetz wrote:
> On Tue, Jun 14, 2022 at 12:17:21PM +0800”, Muchun Song wrote:
> > On Mon, Jun 13, 2022 at 05:22:30PM -0700, Mike Kravetz wrote:
> > > On Mon, Jun 13, 2022 at 05:01:43PM +0800”, Muchun Song wrote:
> > > > On Mon, Jun 13, 2022 at 10:33:48AM +0200, Oscar Salvador wrote:
> > > > > On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
> >  
> > > BEFORE
> > > ------
> > > [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> > > ...
> > > [    0.330930] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
> > > [    0.350450] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
> > > [    0.359282] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > > [    0.359285] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> > > 
> > > AFTER
> > > -----
> > > [    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
> > > ...
> > > [    0.409068] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > > [    0.409071] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
> > > [    1.246107] HugeTLB: 16380 KiB vmemmap can be optimized for a 1.00 GiB page
> > > [    1.246110] HugeTLB: 28 KiB vmemmap can be optimized for a 2.00 MiB page
> > > [    1.246123] HugeTLB: 512 huge pages whose vmemmap are optimized at boot
> > > 
> > > When I read those messages, I am not sure if 'optimized' is the best
> > > word to use.  I know that using alloc/free throughout the code was
> > > confusing.  But, wouldn't it perhaps be more clear to the end user if
> > > the messages read?
> > 
> > Well, I agree with you at least. "free" may be more friendly to the end
> > users.  I'll change the word "optimized" to "freed".
> > 
> > > 
> > > HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> > > 
> > > Also, how about having report_hugepages() call a routine that prints the
> > > vmemmmap savings.  Then output could then look something like:
> > > 
> > > HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> > > 	 16380 KiB vmemmap can be freed for a 1.00 GiB page
> > > HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
> > > 	 28 KiB vmemmap can be free for a 2.00 MiB page
> > >
> > 
> > Well, we eliminate the prefix "HugeTLB:" for memory saving log.
> > Maybe it is not a good choice since it it not easy to grep the log
> > (e.g. dmesg | grep "HugeTLB" will not show saving log).  If
> 
> Agree, we should not drop the HugeTLB prefix from the message.
> 
> > we combine both 2-line log into one line, the log becomes a bit long.
> > So I'd like to not eliminate the prefix but gather this 2-line log
> > into one place. I mean "HugeTLB: registered 1.00 GiB page size,
> > pre-allocated 0 pages" is just followed by "HugeTLB: 28 KiB vmemmap
> > can be freed for a 2.00 MiB page" without any log insertion in
> > between. But I have no strong opinion do this, I'd likt to listen
> > to your opinion before making decision to do those changes.
> 
> I think we are talking about the same thing.  Did you make a mistake when
> saying amount of vmemmap freed for 2MB page followed 1GB hstate size?
> 
> My thought was that it would be good to log the vmemmap savings near the
> message that notes the hstate/huge page size and any precallocation.
> Just my opinion.  So messages would look like:
> 
> HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
> HugeTLB: 28 KiB vmemmap can be free for a 2.00 MiB page
>

I am sure we are on the same page. This looks good to me.

> I really do not have strong opinions on this.  However, if we are going
> to change the messages we should try to make them as useful and clear as
> possible.
> 

Make sense. I'll do it in v2.

Thanks.
