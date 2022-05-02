Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD25170AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbiEBNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385370AbiEBNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:40:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C49140F3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:36:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so25271661lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sPNChsGYk7kHE/rCDooMX11EJCDPE+Ox4AJuqojjAS4=;
        b=oMyzTIQDDDkGSqMMk6jcH3Jg3mOWazFOFwqR8EyExlL855INKMIuaBkCZwvdgRpQSD
         biuD4BmyhgnU+ANzhEkwdNHyFuPiASTFGfXH7JoHfMhBtseilEctTctKHd1Z5QYpIeyh
         XCBKI9nH1N78fYzf8GPhsTsXjmLO8rakFYZrfwhEpi9DGSBHuyM7Kyzd7RCTX53lpQV2
         AAgicbO0zVpm57tZpTUKqHTOhO/EJQ9lQ16JCpzBQasFSbKey6Q9NKDvke2t9g+Su53U
         XrVFnmOMFo0w1Fu6ajlfu9QgB04IgkrRWFpyWkdh+dnaXEjEmg6QDV7a4CYqhpLi/K7r
         jzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sPNChsGYk7kHE/rCDooMX11EJCDPE+Ox4AJuqojjAS4=;
        b=2FqaQaOe9iKzppzDxPWKUIW4toa1De2oeY4fW6kEawanZBMiNnfV2/6aihQk4/YH5c
         05f1jluOC+N2tUqLKZydMVkZcIboTrcozN7dGPKkF5KA0n+yhxNl5TUa6VsdFlVrymTU
         GTQnWHx7D803iAF6EstKXNr9RISJQFfKTLU3JoqYGZi2LZWfd5g/SJAEXX5adNBxlgy9
         3aXZwkvNFr+VNQOusBPsbgGUOzYVVMBsotpiddhYiPuFo0Mdrnufc4A3nPYFzRIDd/Do
         3zK115EJKtmBD5EHw3htctg9Xzyct+vQ4MUILs5iqMxAJlZmliFzYbbPkVBS0BNamOa1
         PcNg==
X-Gm-Message-State: AOAM530fSIO2VlwuMiCyx6WaAqVmwMn/RL3RJvDB02XFM3vSW4FaAzl1
        TTav4cW0FIMkB19VkFgwHYyDIg==
X-Google-Smtp-Source: ABdhPJxn5B/JuXc6CCfatjGdv/+EBL9v9FlbJORmKz12IPtE+wybn1otAHjNPLgeBTtopFpf2dEoaA==
X-Received: by 2002:a05:6512:3986:b0:472:4f5:33a0 with SMTP id j6-20020a056512398600b0047204f533a0mr8679514lfu.341.1651498587285;
        Mon, 02 May 2022 06:36:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18-20020ac25d72000000b0047255d210e2sm704383lft.17.2022.05.02.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:36:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6096C104AD8; Mon,  2 May 2022 16:38:10 +0300 (+03)
Date:   Mon, 2 May 2022 16:38:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 04/12] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <20220502133810.gvmaqxvspzdvzrhv@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-5-kirill.shutemov@linux.intel.com>
 <YmvExncBpvDdfTjd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmvExncBpvDdfTjd@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 07:58:14AM -0300, Wander Lairson Costa wrote:
> On Mon, Apr 25, 2022 at 06:39:26AM +0300, Kirill A. Shutemov wrote:
> 
> [snip]

As I said in the commit message, all that code added by the patch is copy
of the battle-tested code from the main kernel. I'm not sure what the
value of these review comment. Hm?

-- 
 Kirill A. Shutemov
