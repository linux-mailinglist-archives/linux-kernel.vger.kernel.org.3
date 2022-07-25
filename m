Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214C057FF56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiGYMxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiGYMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:53:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE2711444;
        Mon, 25 Jul 2022 05:53:13 -0700 (PDT)
Received: from zn.tnic (p200300ea972976f8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76f8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B53C1EC050F;
        Mon, 25 Jul 2022 14:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658753587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bVyez+KaivaZkgkelxLjIWo6gk1pzXjts4b4tXUfE5E=;
        b=AHidmyfFxdXR2dBq+boERfOhawIGJo2oSkzqgMeK9Pho+BveJMbsqrEXQQj0wi0jbHcucQ
        zukVMxUDwR1MUr5mEzksdDD18I73EbF5WDAd170PQSRrR5icGjeSnnSHQZURb/aN4nftPo
        7/K8iVTmbBqXUEwDGoZe9Bf16jdaIyM=
Date:   Mon, 25 Jul 2022 14:53:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <Yt6SL8+nr1ESSZDh@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic>
 <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
 <Ytr4FCV2xPGUBLqs@zn.tnic>
 <707ca113-c2a2-8fe2-a22c-5be13adc7bb4@intel.com>
 <Yt6LOD9Ae2NqyG1N@zn.tnic>
 <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 02:38:57PM +0200, David Hildenbrand wrote:
> The less core-MM code to handle unaccepted memory the better. Meaning,
> that any kind of additional pre-acceptance (in addition to what we have
> here) needs good justification.

I actually mean to have a user interface to have the core code
pre-accept. I.e., interface to what will be already there anyway.

Or is that frowned upon too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
