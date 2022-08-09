Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF458DAA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiHIO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHIO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA68E1B7B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660057167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qs24elduxwmKkvWpu/vcasLN6Bebi5rixcEIdq2uT34=;
        b=HBQVi7Y3rB3mSaL5NcsVF5syZDTfkVGGdAk31qtYHlEK++qbgClMci/umrx0Pd9ooST6GJ
        fgBHnJNaLf8oq0V3OFWF19XUYCXmV9J1L8kT12iavGIAcpsctIf/9zlFi2z7JGc0OpnHXa
        mmN7ZKws1QQ+twjNIAKA6k3zQecpuS8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-67u3Zs4pNbWp9Ncf7BHJnQ-1; Tue, 09 Aug 2022 10:59:26 -0400
X-MC-Unique: 67u3Zs4pNbWp9Ncf7BHJnQ-1
Received: by mail-qt1-f200.google.com with SMTP id h13-20020ac87d4d000000b00342f6c363afso5093915qtb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 07:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qs24elduxwmKkvWpu/vcasLN6Bebi5rixcEIdq2uT34=;
        b=lUE3ek9erRBWLeTPn7r69VuXSUjpor+vhDiEuztyQW+liV4jClbL2eXbjB2rCco4J9
         DgRI+BTsWPpz7CFYKvthtfaahp5yXjlb+7uvggNamINxsZNbAeq+Joy6y597VjIvqdLz
         d2U2VVH+jZ1jVavKOT5JmlY3jPJWFn6W94RrjqDJnE6Ddj/AWn8u199TLdsS8xBagQX7
         0mg8bhjLbmvSqKelJgsLqD9oeKY0Kd7TE75LcZvyiGd2vOFPpXDNVokE9QGg/P2wXCFE
         /c42Gp2M2FgsqJI2XwCU+N69nDU6qjpnm2MQpYUkMrSST5qwuXVyXJMdhRMNxSD30EVc
         f4HA==
X-Gm-Message-State: ACgBeo0UFKmZp6x5PUDRMhCE2SoMR29HPgUfu4e/CnyV/0iwM0H5un6L
        CkLTPJsCyHF8gyugvKzpEtUpoOy+NbRjgwC0RQSsY64nW5qYsC9mQ+S/xaPQcinUM6w9RiSJTl2
        l9BF4+/OE7YTv4ofR+MqivwDg
X-Received: by 2002:a05:622a:3cb:b0:33f:bb53:f041 with SMTP id k11-20020a05622a03cb00b0033fbb53f041mr19745427qtx.135.1660057165805;
        Tue, 09 Aug 2022 07:59:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PT70Zgc/UE+P84IPg1Zz2LDf/m6IfK1bB4BWmJUnXcK6KOR/FICD5mJBqgM/ji2TMK0LovA==
X-Received: by 2002:a05:622a:3cb:b0:33f:bb53:f041 with SMTP id k11-20020a05622a03cb00b0033fbb53f041mr19745411qtx.135.1660057165560;
        Tue, 09 Aug 2022 07:59:25 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id j18-20020a05620a411200b006b8f8e9bd00sm1066121qko.5.2022.08.09.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:59:25 -0700 (PDT)
Date:   Tue, 9 Aug 2022 10:59:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
Message-ID: <YvJ2S8X4tAqM4oZ4@xz-m1.local>
References: <20220804203952.53665-1-peterx@redhat.com>
 <20220804203952.53665-3-peterx@redhat.com>
 <A84CB6A0-86C8-4CAB-A977-47495D877C31@gmail.com>
 <Yu1FkCkjJ00+H0sF@xz-m1.local>
 <8735e5hkk3.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735e5hkk3.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 04:45:32PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 04, 2022 at 03:40:57PM -0700, Nadav Amit wrote:
> >> On Aug 4, 2022, at 1:39 PM, Peter Xu <peterx@redhat.com> wrote:
> >> > +
> >> > static inline bool is_pfn_swap_entry(swp_entry_t entry);
> >> > 
> >> > /* Clear all flags but only keep swp_entry_t related information */
> >> > @@ -265,6 +285,57 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
> >> > 	return swp_entry(SWP_MIGRATION_WRITE, offset);
> >> > }
> >> > 
> >> > +/*
> >> > + * Returns whether the host has large enough swap offset field to support
> >> > + * carrying over pgtable A/D bits for page migrations.  The result is
> >> > + * pretty much arch specific.
> >> > + */
> >> > +static inline bool migration_entry_supports_ad(void)
> >> > +{
> >> > +	/*
> >> > +	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> >> > +	 * We can support the migration A/D bits iff the pfn swap entry has
> >> > +	 * the offset large enough to cover all of them (PFN, A & D bits).
> >> > +	 */
> >> > +#ifdef CONFIG_SWAP
> >> > +	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> >> 
> >> This is an actual a function call (unless LTO has some trick). A bit of a
> >> shame it cannot be at least memoized.
> >> 
> >> Or at least mark max_swapfile_size() as __attribute_const__ so it would not
> >> be called twice for make_migration_entry_young() and
> >> make_migration_entry_dirty().
> >
> > I didn't take too much effort on this one since we're on swap path and I
> > assumed that's not a super hot path.  But __attribute_const__ sounds good
> > and easy to get, thanks.
> >
> > Perhaps I should mark it on migration_entry_supports_ad() as a whole?  Note
> > that unfortunately SWP_MIG_TOTAL_BITS may not be a const either (see how
> > that define roots back to MAX_PHYSMEM_BITS, where on x86_64 it needs to
> > check 5-lvl).
> 
> I think it's possible to memorize max_swapfile_size() or
> migration_entry_supports_ad().  Although they are not constant, they are
> not changed after initialized.  The challenge is to find a clean way to
> initialize it.

I checked it up today, the conclusion is I think it's safe we initialize ad
bits for migration in swapfile_init() and I'll do that in the next version.

Longer proof material below.

Generic max_swapfile_size() is pretty much a constant except x86.  x86 has
two dependency, on (1) X86_BUG_L1TF, and (2) l1tf_mitigation.

The other challenge is the reference to MAX_PHYSMEM_BITS, which is also
only complicated on x86 with 5 level page tables.

Luckily the cpu bits are all setup within early_cpu_init(). The setup of
l1tf_mitigation variable is later but still earlier than most of the init
calls (which swapfile_init belongs to level 4).

A full graph for reference:

- start_kernel
  - setup_arch
    - early_cpu_init
      - get_cpu_cap --> fetch from CPUID (including X86_FEATURE_LA57)
      - early_identify_cpu --> setup X86_BUG_L1TF
      - early_identify_cpu --> clear X86_FEATURE_LA57 (if early lvl5 not enabled (USE_EARLY_PGTABLE_L5))
  - parse_early_param
    - l1tf_cmdline --> set l1tf_mitigation
  - check_bugs
    - l1tf_select_mitigation --> set l1tf_mitigation
  - arch_call_rest_init
    - rest_init
      - kernel_init
        - kernel_init_freeable
          - do_basic_setup
            - do_initcalls --> calls swapfile_init() (initcall level 4)

I'll add one (or maybe >1?) patch on top in next post to optimize the
fetching of these states.

Thanks,

-- 
Peter Xu

