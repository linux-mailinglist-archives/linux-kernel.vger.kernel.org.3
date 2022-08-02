Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBA587625
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 06:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiHBEHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 00:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBEHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 00:07:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F819C06
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 21:07:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so767010pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 21:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=emO/aP9ZnO5urqHffk6lerV5ez7+dpluevKxfTa0sAA=;
        b=S9eDn9MACGkGmQZevnj8OUtbdZaFOTCcoa+UnYFQDneci6YxnbWl1Ot6Zra89/tGnA
         Gepsk0kwUTtBIAl24pDFUYP0NR3Xhzy8mrgxTAzHMbfb338s1bbCb/saCQ4n55WqXPkY
         FoO1a6LqkgkS6zxcfGhw2lnTO828tndHTvdNwrv+aA/vXgbEiZdB1xMOWy5m10QkQ2jn
         /SIh+FGjy02Db4+ITybOIwWTp3jVB941blo+aiekQyAR+ggK1VlzbE7XMLhSFzYZYU2v
         w/rosNhVR/xuyYePZ9FYsf3Qwhlsv3jSNFlFIUdv9x2XIU1XStpArW+l02LyvDCdM7HR
         Xf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=emO/aP9ZnO5urqHffk6lerV5ez7+dpluevKxfTa0sAA=;
        b=wXbFuykiD/Li5lfIHQfQW/Qb8jxW9T8SbA0aN9xjU08IgyBz2VNTwcAP944dv8A1pz
         oeRxNLZdhAKgM9mpeSQT0BqJqfbH7+dtPPdqcXgtjC74/RyXufsKG9ZA+tcRlcNshZ74
         E6XQa/MZu7dTkmVPLu9x0re3DOypfAXADoWJDJMocSycbZtSXbKmn9qLPfOxwiJtf2py
         elAyHckLiahIiOFpEg6Eli3VBil4xZMdMz7twUZ6sHQMW4JB5TVccf8vw6ruTqKaAvQs
         hYCH07P9AIDfg7Ytsex8Wc4nvekePYSwh4zX3V28NHKdkyoD0bQwtREAqp5pnZY/r1nN
         sNIA==
X-Gm-Message-State: ACgBeo02vTUIW5UwxFiU4t9hQRqF0GEXAn4bV6EAQCLd+wsLOxYHwggO
        inlTxlDks2KQYEQrxYYjFlziSg==
X-Google-Smtp-Source: AA6agR4vg6qQ4b85zrYYO14O4I1bqZTmfxYJ3Ne7C27VNWDSim5B08aGZQH3drFtGDFcZhYijmb/CA==
X-Received: by 2002:a17:902:ccc7:b0:16c:484f:4c69 with SMTP id z7-20020a170902ccc700b0016c484f4c69mr19851864ple.118.1659413225213;
        Mon, 01 Aug 2022 21:07:05 -0700 (PDT)
Received: from localhost ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902e39100b0016dd0242e22sm8654790ple.156.2022.08.01.21.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 21:07:04 -0700 (PDT)
Date:   Tue, 2 Aug 2022 12:07:00 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [bug report] mm, hwpoison: memory_failure races with
 alloc_fresh_huge_page/free_huge_page
Message-ID: <Yuii5FnAXe/q7fx/@FVFYT0MHHV2J>
References: <3c542543-0965-ef60-4627-1a4116077a5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c542543-0965-ef60-4627-1a4116077a5b@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:00:50AM +0800, Miaohe Lin wrote:
> Hi all:
>     When I investigate the mm/memory-failure.c code again, I found there's a possible race window
> between memory_failure and alloc_fresh_huge_page/free_huge_page. Thank about the below scene:
> 
> CPU 1							CPU 2
> alloc_fresh_huge_page -- page refcnt > 0		memory_failure
>   prep_new_huge_page					  get_huge_page_for_hwpoison
> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
>     hugetlb_vmemmap_optimize -- subpages is read-only
>     set_compound_page_dtor -- PageHuge is true now, but too late!!!
> 							  TestSetPageHWPoison(p)
> 							    -- We might write to read-only subpages here!!!
> 
> Another similar scene:
> 
> CPU 1							CPU 2
> free_huge_page -- page refcnt == 0 and not PageHuge	memory_failure
> 							  get_huge_page_for_hwpoison
> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
> 							  TestSetPageHWPoison(p)
> 							    -- We might write to read-only subpages here!!!
>   hugetlb_vmemmap_restore -- subpages can be written to now, but too late!!!
>

I agree this race is possible, I have proposed this race in thread [1].
But I didn't think more how to solve it.

[1] https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#ma094a7cea7df8fd9a77a91551bf39077d89e23bd

> I think the above scenes are possible. But I can't found a stable solution to fix it. Any suggestions?
> Or is it not worth to fix it as it's too rare? Or am I miss something?
>

Luckily, the system will panic at once, which encountering this race. However,
we don't see any bug report. If we have an easy way to fix it, I think it is worth.
Just a quick reply, no suggestion/solutions from me.

Thanks.

> Any response would be appreciated!
> 
> Thanks!
> 
