Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550B55DE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiF0H5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiF0H53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:57:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456160E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:57:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 68so8359394pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyqDF5Hpn2EUBCZeMxGZtJnLwcRJ4sS1ucd+2BRdDk4=;
        b=qzPhTTdiRDFzMFpwSdyKg8WpEavFtchGHpONzR7KAUt3FNXZ5+gup4HUqmgGm1ShjR
         cVmoJXM4C2NMJPbwsZxSQzBcyxRtIySH2B2CpFoa7uRPwEpPZ9UPPBOiPL0d9tccG6an
         2KB8Yw46giMPSF6DpW7z7dkklmbQMOqQQylX+YZ7+yBwTP0rWPMlygxf6tm4l2R9Ior5
         9LaJdfmQpr/67qZpPCmS3okU49W3CRUPsD0elkSwsH+m3Ke5+C01OnJ480UCXsUa9GMi
         BZm3j9qs2UeLTBZBAHXfAyFK5C3hEt4/sgzOb8d9ID0/tetPn6iUPrhRhEj1WM0k4TU1
         XSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyqDF5Hpn2EUBCZeMxGZtJnLwcRJ4sS1ucd+2BRdDk4=;
        b=MThoNcHkALfXqs+s10NHh/WPoKrj/LUcMKzzU2ApPfJuRTSQB2SybDH2g1qx4KuguZ
         nFUqReLYe/0nakT0Z2rhNLkBzWkK7YsE98dIstXq8usxTqGQM7hNQcgLuT4HP4GKtc1v
         4hc57U50a30D6VISeOqNWdZhoc1s3xx7zFksOsjIfEc9HV8zc6FW65YwVDYO2gsz7RhD
         PsjHBwTwiLUVsQEqvzp2mtIr+Pob9iRRDq4ahORk5x9DyjP4TbCZMlGdkWzqNtQwWtl7
         Z+E3s2IERFeDIGDV6nJT21PKvHkee+3wjlqXYIT94vcHuRy6xwWBjh/Uw5bYZB6JE0G3
         G4qA==
X-Gm-Message-State: AJIora/w2V+VajfQuHemBQJUovXoJyBcVqyUYDDJEfaD++I635XpSKBV
        DBJBxDwTULQuijpUSedpgTYF5g==
X-Google-Smtp-Source: AGRyM1u7yUn3oLBcN0sCyNbL8gMeo0rCW5lez9SUotOMvwnCNp4G/4WfC8fpwA9lomLmUUyyAXH4fQ==
X-Received: by 2002:aa7:9f9b:0:b0:525:1e0a:a6b4 with SMTP id z27-20020aa79f9b000000b005251e0aa6b4mr13623307pfr.5.1656316648483;
        Mon, 27 Jun 2022 00:57:28 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm6491342pfa.130.2022.06.27.00.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:57:28 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:57:25 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in
 copy_hugetlb_page_range()
Message-ID: <Yrli5c0A8oKqF4EG@FVFYT0MHHV2J.usts.net>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 08:51:46AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Originally copy_hugetlb_page_range() handles migration entries and hwpoisone
> entries in similar manner.  But recently the related code path has more code
> for migration entries, and when is_writable_migration_entry() was converted
> to !is_readable_migration_entry(), hwpoison entries on source processes got
> to be unexpectedly updated (which is legitimate for migration entries, but
> not for hwpoison entries).  This results in unexpected serious issues like
> kernel panic when foking processes with hwpoison entries in pmd.
> 
> Separate the if branch into one for hwpoison entries and one for migration
> entries.
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks for fixing it.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
