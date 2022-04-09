Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D14FAB27
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiDIXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDIXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 19:45:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7BCDB2EE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 16:43:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g24so15865618lja.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbKyvpQHPm0kNgMAVs494Hgh1ccd/JUvncGHbdpX/0c=;
        b=FVJ72+0uXZ5+QgDax7JJqXVRky+XwJa7ewjqDd/F/ZjzrzjSF1n3eornqoh6nwYCS7
         THynzhfPinFJoP9K+AMKDfno5noxszxwgU6YNMBbY0Hsu3Oa7os7ckim5xqlQfP58HGC
         MwwxoeL8n//yaUuXIBoyf0guUcccIvA+GYmYvMk50cs+jI+mLGHuK3u1xQzF6veUt1Da
         mKOeKE9vaYsdtntOhAfR2iebc53jt3mcDeYPKXhnILhRLGPwScjSk1TsdhNzirzWxfjH
         pEBYYb6TBLF51dR1kKXHTQSX3S7hCkznxwVZKy4WA+fCiGx/O+Awq+mcjLnHK21ZEgxG
         ruJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbKyvpQHPm0kNgMAVs494Hgh1ccd/JUvncGHbdpX/0c=;
        b=ubAnNGfRupKDz4ijLTL2pIoTBXNYatwOKeC+GX04BVVYHCZINPAmCjUO0c1x8vsuAr
         aMP3jCqQSBSwebFoKH+fzEXmHrGTXzQrZj8t4UlGf/8tczWZVcgEb1lNikZYso8WZNTe
         DfvY/iufekitaDPbe3IcOo10NjGJIa1sq/ueJBTUMxMa6Pd0Bta/ul1pj6NsXk9DEQdy
         HeHdBGkk2pJnnEL20ID/Y1MJaVNd7Sg3n0gKuPyhQurbRT6xwpozp4J7GzB41aEV9qro
         d2icbsR2f7vsY1mOhw+0U73/wY0kz4S/0ECQ9sLcyjL94WH5nBrZQrmnRIwaKrPbXXUa
         oFOQ==
X-Gm-Message-State: AOAM533yCed9H8JlyAWU38k/rtcZHzwyYZ6lbku7L344rHzhR04HAhhX
        At18GtgdSW+JqH9G/NsQMZCokQ==
X-Google-Smtp-Source: ABdhPJxS1PCp/vzN2dy3Ii8M1UVX5LPIaKWjRgkLRSdf248ssxYFzHzDsfML9N16/gwWJwDQ1SZ02g==
X-Received: by 2002:a2e:99da:0:b0:24b:4607:d6e7 with SMTP id l26-20020a2e99da000000b0024b4607d6e7mr8814324ljj.519.1649547807704;
        Sat, 09 Apr 2022 16:43:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e90d1000000b0024b54a20cdcsm486775ljg.7.2022.04.09.16.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 16:43:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2BB96103FB7; Sun, 10 Apr 2022 02:44:58 +0300 (+03)
Date:   Sun, 10 Apr 2022 02:44:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 0/8] mm, x86/cc: Implement support for unaccepted memory
Message-ID: <20220409234458.ysisolzd7hktpfjc@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <95eabe79-a13b-79b1-1196-407920531f20@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eabe79-a13b-79b1-1196-407920531f20@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:02:13AM -0700, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > Patches 1-6/7 are generic and don't have any dependencies on TDX. They
> > should serve AMD SEV needs as well. TDX-specific code isolated in the
> > last patch.
> 
> Oh, that's quite nice.  Are the SEV-SNP folks planning on using this?
> If they are, acks/reviews would be much appreciated.

AMD folks tested one of previous revision and reported that it works, but
I don't remember seeing the code that hook ups AMD implementation.

-- 
 Kirill A. Shutemov
