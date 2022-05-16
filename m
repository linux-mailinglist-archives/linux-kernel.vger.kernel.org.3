Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF35283CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiEPMEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiEPMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:03:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181F1EC65
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:03:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pt3-20020a17090b3d0300b001df448c8d79so3012023pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R84IxflJzQsjcs6liOC1xGi2RLfZVO/J/zvMOYtMBKI=;
        b=W7DK2qATwEyfvh21pVCPdp+fSj3B28j0KvO+lqsOPxPZIH7RUOgXti2vLaZX56uPLi
         Zf54oYdtq6IyZAvY5uSVv4DttuV81ENkrczCOrwjaDIK6BuZ9TEuvUnmtPYCDQda5SK1
         2UJO3Wpu94Gdhwd/Yp8g9Rz4sXJ3VK/C2xxsZHY0ElYNMbFV7cttoOT3unYS/7uyE5ZQ
         PCp8z3w4j1eNrioDSgF9sfHye+GKmDpwe/cqZLfIukhxqI9gEH+uocUTdY3ZuzdW8+Rr
         8/PJoYZ+p6cGNJWT50couq1k2JPjXlYhEQyNWCCb7k0tVbkNVfl77lsAuuK09mYxx+sm
         4Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R84IxflJzQsjcs6liOC1xGi2RLfZVO/J/zvMOYtMBKI=;
        b=6ZCr5RcXFOGCeyaf3w8fOr0NFKPoKeu8dkBtmDMVkjosVXzm6557ffZfnCfYmoc0Xs
         e7iTHBA8m5dvZNZl7KIRxpXxpsFBTAGjgjSoNAwRZgz5NQgM56ZpgbW78UTQZwNwliHP
         Pne/tcYJ6ZN08ROHWD/MHAGJQFYw+0LLAqdhVJLBgjH26Io/mzZsHjCye4/cm+ULr2Sn
         ShBqFyWYOMkkBfBMG68ijk5YeExQhr9+vrfWhNeXN1wcCVuuJ7fnrsUkhuRJ0yplQgRq
         DNvvPN2Dazqmqu6Jhv7IUFIbnwF7MiE3Txr1uj65RWPhmoP3dLqyRZ6AaX2PgFMfejPT
         jWSQ==
X-Gm-Message-State: AOAM530PRrDP6kbR4cVoZ9cEMppgQ1ot26NT2Qg+DCoHwi2vevL/Unn2
        9PUi+U0DbhwceVejWi9IJyjh+w==
X-Google-Smtp-Source: ABdhPJzxfHYjLSn309uprN3vFeZ39gfOTL/8yBip6LIvpYKa3y23U3WenfTaxzCyUzgFpLJTj7UIKw==
X-Received: by 2002:a17:90b:48d1:b0:1df:4fc8:c2d7 with SMTP id li17-20020a17090b48d100b001df4fc8c2d7mr5686526pjb.45.1652702633331;
        Mon, 16 May 2022 05:03:53 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b0050dc7628139sm7015117pfu.19.2022.05.16.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:03:52 -0700 (PDT)
Date:   Mon, 16 May 2022 20:03:49 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 4/7] mm: hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YoI9pdLzB/V9Kw1y@FVFYT0MHHV2J.usts.net>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-5-songmuchun@bytedance.com>
 <YoIptjs65NgT1/ed@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoIptjs65NgT1/ed@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:38:46PM +0200, Oscar Salvador wrote:
> On Mon, May 16, 2022 at 06:22:08PM +0800, Muchun Song wrote:
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -913,6 +913,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >  	ms = __nr_to_section(section_nr);
> >  	set_section_nid(section_nr, nid);
> >  	__section_mark_present(ms, section_nr);
> > +	/*
> > +	 * Mark whole section as non-optimizable once there is a subsection
> > +	 * whose vmemmap pages are allocated from alternative allocator. The
> > +	 * early section is always optimizable.
> > +	 */
> > +	if (!early_section(ms) && altmap)
> > +		section_mark_cannot_optimize_vmemmap(ms);
> 
> Because no one expects those sections to be removed?
> IIRC, early_section + altmap only happened in case of sub-section pmem
> scenario?

Right. The commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
has more information.

> I guess my question is: can we really have early_sections coming
> from alternative allocator?
>

We can't. The early section does not consider partially being
populated currently.

> I think this should be spelled out more.

I think you mean add some comments here to describe the case
of early_section + altmap, right?

Thanks.

