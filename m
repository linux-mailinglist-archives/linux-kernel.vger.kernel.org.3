Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B904FC0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347950AbiDKPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiDKPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:33:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4933EB1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:31:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j9so19234578lfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xjS2P4qPRuklgAWHvx4nddXDONB01ig+sjZdob2rUZw=;
        b=FV3bsbjWahU5dJ0sji7/IJLbsnx56//V4Rko+5Sg47dXy4c+ztKWDHA1RNVD7WvPgr
         yK/qGVOHKnh25F0KE05KBV9H1r9OI30310p5PG2PDV1Va+D7E+zBPyJQ3GLPd+ArztSz
         lrPNi8EiBdyRuWMQK80WfVgqDFmgS3k2Y9eK88CTC7O93hqJ35i8F5cEA6skMGujcbeA
         8BD+pN6zgnu4xfwTVNBKJBt2m4qBDjJnaxI/fb85Yf6i+HshEOjYKqNAq3V5w99m67cG
         eL4nyyZ+vUt0LJJW9FtrCg8OMzKVImZqDlCviEztwjVLYF/N6A1zGFbLaP9VZXnGa6f8
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xjS2P4qPRuklgAWHvx4nddXDONB01ig+sjZdob2rUZw=;
        b=TS5n2+/jWNIWPxYgfMvKvyZSeyL/RRNxz4ka02wqlfw8PzPuJ91BkboE26XEkHW9Hu
         L75FUlEkh4dUC5JsNNmZX4WSNAUyWFNqcxWQhyt/sJe5SbmRUEAg5f1YLZiso6W/ADwz
         27ZkJyuolyezOofXbdoKh1J0hpFqIU7mF17bJPRAo8P52kGHaoWW+qhyw5bMiKLW+eF5
         JNoNk/AOm+V1VY5WbG5EOwBS9bwtH49bVagJmGvaqYdNnAi9jw2o4noyKu/bPtQbzweR
         uaNzlb9cjFyy5CbzO8E/zHorhGSjzspEKdtWKq8t14lXG89IpeBEDHdOrT1tANG8veG0
         gpqg==
X-Gm-Message-State: AOAM531uac8u7Qv0hhQIEMIjNP8QEXAOyycYr1b5RidDh9xK69i0Hfh3
        PsRaw9bP8SEdIrP3ke6cADG1TA==
X-Google-Smtp-Source: ABdhPJyyKel4+BxKnE8zItkwufzaPuu1o/Qdf3y9wLaeW/pMks9H6z/sxphXdamwlvCAG9JGwj2NPg==
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id e12-20020a19674c000000b004483f49e6d5mr22543031lfj.518.1649691061797;
        Mon, 11 Apr 2022 08:31:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j4-20020a05651231c400b0044ac20061ecsm3351801lfe.128.2022.04.11.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:31:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BF102103CE0; Mon, 11 Apr 2022 18:32:33 +0300 (+03)
Date:   Mon, 11 Apr 2022 18:32:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220411153233.54ljmi7zgqovhgsn@box.shutemov.name>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk8L0CwKpTrv3Rg3@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:05:36PM +0000, Sean Christopherson wrote:
> Hmm, shmem_writepage() already handles SHM_F_INACCESSIBLE by rejecting the swap, so
> maybe it's just the page migration path that needs to be updated?

My early version prevented migration with -ENOTSUPP for
address_space_operations::migratepage().

What's wrong with that approach?

-- 
 Kirill A. Shutemov
