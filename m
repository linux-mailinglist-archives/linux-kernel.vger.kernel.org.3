Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8F4FA9FF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiDIRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiDIRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:52:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A21CFFB5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:50:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b21so20019866lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BJwi+4MUHVrKX308NfOg46ABCdrEGwFNuCfJTM4PEA=;
        b=MN50HswbicjFFL7K5mQ5CImChULXEkQz0FzkiaI3+yYKdPBrcrNzQMylJQdy8TjEQf
         5wcmnqtlY6cIWr4Xwwhf9qfp8YDXgnNp89sliELF/wPXIOODX3w4yMpkdZo4HBh1nycu
         HS84zY9faBsIE5HwW8AqridmwGGbjA8ZCFMdSkmf8q+yET0bkKRsutZOyVTnJxI0XK0X
         zT8+sXdketeYf0lWkZ/JTEURmbHJhouPvYqBYKM/lXukoPLyzU99u0RB86e6XN0moGGi
         Y5ih3+OSgtBEuDPI8SUkl+4qC2exssdnliXZ71YfnkSnuCm5gudeyMUsppD01fj1gAeH
         0xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BJwi+4MUHVrKX308NfOg46ABCdrEGwFNuCfJTM4PEA=;
        b=d0/q9ZgsLrPyMR6vRDyrUzIbID4JzvSxQjGu2CbQuNIlH2TOAc1S/FAA9kvRPEiXt7
         28/G4HezwoAsixHwQhAlECrleDrAUA22Zwy+qgA4AJBtlTv8+T2+HCg2yjS38xhECbF4
         EtJ/mZqB66ZvdWdiFsPTsqtrkTr/PUazSJEjHgwMEagRLwE1zc9piI/ZZqLnpM5uwN2A
         14p8PqGUBXE+fzmW4i6SgVwea79PvxANqBJbeMSSD7bUkQaJF69epWtHVf0++BKG74gQ
         Z18allygGGFQMiYkrU18xba2Ckrn4fWpa6pzXIkCcnnEgi49v5XDzfVTuTmxf2sQudJk
         Yscg==
X-Gm-Message-State: AOAM5309uZUbGA77YRgUThC/DmLEp5x+AbQadYx2u9Yfv7eq81J7nl/e
        kBv/EDpaBxiakNIBdbBYSdpW4Q==
X-Google-Smtp-Source: ABdhPJyiKDi7TSfRV/vRqhjM4G5p2LRlKpj4VTzoGYJmpsDau3aBPPbEKGpuhXEfzoNTsoN8W7+JPw==
X-Received: by 2002:a05:6512:ac1:b0:46b:8fd0:b030 with SMTP id n1-20020a0565120ac100b0046b8fd0b030mr2977704lfu.372.1649526639318;
        Sat, 09 Apr 2022 10:50:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h24-20020a19ca58000000b0046b9dbfc809sm65098lfj.56.2022.04.09.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 10:50:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1747B1039DB; Sat,  9 Apr 2022 20:52:10 +0300 (+03)
Date:   Sat, 9 Apr 2022 20:52:10 +0300
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <20220409175210.xik3ue3shpagskvi@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:11:58PM -0700, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > Kernel only needs to accept memory once after boot, so during the boot
> > and warm up phase there will be a lot of memory acceptance. After things
> > are settled down the only price of the feature if couple of checks for
> > PageUnaccepted() in allocate and free paths. The check refers a hot
> > variable (that also encodes PageBuddy()), so it is cheap and not visible
> > on profiles.
> 
> Let's also not sugar-coat this.  Page acceptance is hideously slow.
> It's agonizingly slow.  To boot, it's done holding a global spinlock
> with interrupts disabled (see patch 6/8).  At the very, very least, each
> acceptance operation involves a couple of what are effectively ring
> transitions, a 2MB memset(), and a bunch of cache flushing.
> 
> The system is going to be downright unusable during this time, right?

Well, yes. The CPU that doing accepting is completely blocked by it.
But other CPUs may proceed until in in its turn steps onto memory
accepting.

> Sure, it's *temporary* and only happens once at boot.  But, it's going
> to suck.
> 
> Am I over-stating this in any way?
> 
> The ACCEPT_MEMORY vmstat is good to have around.  Thanks for adding it.
>  But, I think we should also write down some guidance like:
> 
> 	If your TDX system seems as slow as snail after boot, look at
> 	the "accept_memory" counter in /proc/vmstat.  If it is
> 	incrementing, then TDX memory acceptance is likely to blame.

Sure. Will add to commit message.

> Do we need anything more discrete to tell users when acceptance is over?

I can imagine setups that where acceptance is never over. A VM running
a workload with fixed dataset can have planty of memory unaccepted.

I don't think "make it over" should be the goal.

>  For instance, maybe they run something and it goes really slow, they
> watch "accept_memory" until it stops.  They rejoice at their good
> fortune!  Then, memory allocation starts falling over to a new node and
> the agony beings anew.
> 
> I can think of dealing with this in two ways:
> 
> 	cat /sys/.../unaccepted_pages_left
> 
> which just walks the bitmap and counts the amount of pages remaining. or
> something like:
> 
> 	echo 1 > /sys/devices/system/node/node0/make_the_pain_stop
> 
> Which will, well, make the pain stop on node0.

Sure we can add handles. But API is hard. Maybe we should wait and see
what is actually needed. (Yes, I'm lazy.:)

-- 
 Kirill A. Shutemov
