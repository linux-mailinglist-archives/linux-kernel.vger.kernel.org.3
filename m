Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768C34CC95F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiCCWqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiCCWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:46:16 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3A15C67B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:45:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 8so5320028qvf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ysKBNxNLKT+vRt9gn94ucU0jwaoAouI3FbJF/PEULzk=;
        b=sXWeRbLq4UaAh17wkVQx8uuykP8lWSZeZ1dyvi17P0USyM6x0HZAmMz8ssRLIzxQhj
         lvBnrlYFdI+KxhGdhWGFs1Iuu6cNSk7AvmhmNUwtZlZNHZsJToaEPTbSNgK9sNJN9NGl
         onWemrqQRXW6omvo90HpnQPtZ6IlAocKzXMW3WXamWfkwp0nHBxZquhoSgUQMFCzDKfM
         ZmFuYUDzGc95uNvzaVTetrPBNEz+9enSuoL77/kVedq6mgQOwIcWChvB1/ysYB7KTJ/k
         JeeSTLt1O/o7MMJs3aPg+nd04/yxMBzqiXBLz0V4AQQ6ruzcunjPM+6WNOME3HUf4/4d
         KUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ysKBNxNLKT+vRt9gn94ucU0jwaoAouI3FbJF/PEULzk=;
        b=EZSYZOvHuGaueFCDY8JuLJAGjQVjif6IVlESb0/0/l4iTRikjQJHjD5naPBUX95h78
         s5nVMOrni+xWhtqT+OhGhmoyKyfGFNsdCm6BfeID88Ljbl3ZaOz3YXUI6EHoaL/XWUw1
         tx6yEnk8NCf2AcY9kDJW392J3Znq8fVLhAjiw45/M7Wf2og6WSoyOKWAPN1BjqzxrllL
         XM3ofeQ5F9iKhNp0Jw7o1gnYbu6B4mkFzXM/rlowlapAroTqs07GiIycsY8+YdDHBCLm
         enUl9dCWL6aKHXM/EN/fCyYl/N7evdWRV5lwSGrb2YnEBn0/qQgTCRlmtYkatExjhKDA
         Rk2w==
X-Gm-Message-State: AOAM533iV+wfBb6JP1Qokud8IgeDDiAWMFVi8SOuvc0Ox+rHbyjgjy3j
        7Kn+FgjsQVUjGrH9+qh4/h5cKQ==
X-Google-Smtp-Source: ABdhPJxhJMD24ooliUoMuYhm3iPyw4jcHyKNSLQ57nc6x0R4tlGMAULfCW/XD3OnCeNRhMurk1Wldg==
X-Received: by 2002:ad4:5bc1:0:b0:42c:37be:6ac3 with SMTP id t1-20020ad45bc1000000b0042c37be6ac3mr26114521qvt.18.1646347529079;
        Thu, 03 Mar 2022 14:45:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o18-20020a05622a139200b002de25b59013sm2418690qtk.84.2022.03.03.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:45:28 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:45:26 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mm/thp: refix __split_huge_pmd_locked() for
 migration PMD
In-Reply-To: <CAHbLzkppwEBSkd2QFAHkRfQPsLqzRqPegbNUg_bnY62ai2Emyg@mail.gmail.com>
Message-ID: <72bcebad-b1e3-efd-ab72-9a86c76f70c1@google.com>
References: <84792468-f512-e48f-378c-e34c3641e97@google.com> <CAHbLzkppwEBSkd2QFAHkRfQPsLqzRqPegbNUg_bnY62ai2Emyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022, Yang Shi wrote:
> On Wed, Mar 2, 2022 at 5:43 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Migration entries do not contribute to a page's reference count: move
> > __split_huge_pmd_locked()'s page_ref_add() into pmd_migration's else
> > block (along with the page_count() check - a page is quite likely to
> > to have reference count frozen to 0 when a migration entry is found).
> >
> > This will fix a very rare anonymous memory leak, after a split_huge_pmd()
> > raced with an anon split_huge_page() or an anon THP migrate_pages(): since
> > the wrongly raised refcount stopped the page (perhaps small, perhaps huge,
> > depending on when the race hit) from ever being freed.  At first I thought
> > there were worse risks, from prematurely unfreezing a frozen page: but now
> > think that would only affect page cache pages, which do not come this way
> > (except for anonymous pages in swap cache, perhaps).
> 
> Thanks for catching this. I agree there may be anon memory leak due to
> bumped refcount. But I don't think it could affect page cache page
> since that code (bumping refcount) is never called for page cache page
> IIUC.

Yes, that's what I meant by unfreezing "would only affect page cache pages,
which do not come this way".  But then remembered that anonymous pages in
swap cache also have non-NULL page_mapping(), and involve freezing in the
same way that page cache pages do.  Now, offhand I forget the status of
hugepage swap, so maybe that's impossible, hence "perhaps".  Easier to
fix than to think through all the ramifications of not fixing, as usual.

> 
> The patch looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

Thanks,
Hugh
