Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6584FC0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbiDKP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbiDKP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:28:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97771A3A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:25:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so20598555ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFr6s0nrZU/l/rYSbRMVpOLqR853sTAxGnl/eB7rqRM=;
        b=vqJYdIQWv8WkNNNn9dPXtN92UFDTRrKywzC32jqHUXQPd0+vkYBmnq9rZ4NZXVIxFT
         qFZtKKzAXyLtgRUtZW0cMECXBtK3dk3Wyx0Mmsh8UZ/OzlNIFCM15Boa0s9MFTZnFSN3
         8zObizgXQHcCLVp6LDk/Jzo1jR2NDPvFFPY4ogEXWUB70897ie3SGoK0vWAAx5unyy9n
         6j5A9PCMQnyGGwVeSCqGXUcxMULTqx2b4wpel2RMEuBXrpI2Je1yyPDmgKNutqRQhKPF
         E3eAJ4YsBCcURT61ntTfs2vYmJhK1nZzXt1rqLkINEtuod8EjW60nrtXooL3LRDyK+/7
         0TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFr6s0nrZU/l/rYSbRMVpOLqR853sTAxGnl/eB7rqRM=;
        b=1hv6RyfjlVO2QXpR9KVIO/8G4/1tj2am99NkCOCuFncNrg/OsRptSBPnBdo4KTkogt
         v6tVNCLNl4XRf8EWw/8NJjJdB4WwzTxyT7EkPDmlFef2ckEXLYpbvA9GgRo2qIjktFKF
         FuEbdxemUDxxnLq5AKD2xQvmkvqlUdMHB3C4k0T8BGaSWfEiM4ZG+Z+rawxhJK6SwLMF
         pxUr0k4Y/7ttofBSWOiDRAjWeyyPEsXsR1//Gy/yusz4VBfg1Wu5O1BPGAeOfayyKpW1
         imWC/OsQaksXbZSdvJztJssEsnOTDWilpxzaCqVlAH18oEiBgk++JTgt8jfVZt9n5vbl
         8GfQ==
X-Gm-Message-State: AOAM533HIleI5GmK/JpVuw2QiIjdQF9k8iXvvcWCeeUx1lAi29kQAoJm
        PfeWjKxmNohQuDC3yStj+USAuw==
X-Google-Smtp-Source: ABdhPJxUo+KOo46oZZC8/G3tHjCARN4FX+eDd1+/GBegGd9jDdlQ537rMvPHZViYY23J0dOhGwiqZg==
X-Received: by 2002:a2e:80d7:0:b0:24b:bd8:b89e with SMTP id r23-20020a2e80d7000000b0024b0bd8b89emr20019551ljg.174.1649690715205;
        Mon, 11 Apr 2022 08:25:15 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z6-20020a056512308600b0044af5ea2be1sm2837295lfd.274.2022.04.11.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:25:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 189A9103CE0; Mon, 11 Apr 2022 18:26:47 +0300 (+03)
Date:   Mon, 11 Apr 2022 18:26:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        david@redhat.com, "J . Bruce Fields" <bfields@fieldses.org>,
        dave.hansen@intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        ak@linux.intel.com, Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Steven Price <steven.price@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Borislav Petkov <bp@alien8.de>, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Annapurve <vannapurve@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
Message-ID: <20220411152647.uvl2ukuwishsckys@box.shutemov.name>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-4-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-4-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:09:01PM +0800, Chao Peng wrote:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9b31a7056009..7b43e274c9a2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>  	return page ? page_folio(page) : NULL;
>  }
>  
> +static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
> +#endif

All these #ifdefs look ugly. Could you provide dummy memfile_* for
!MEMFILE_NOTIFIER case?

-- 
 Kirill A. Shutemov
