Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9B50ACBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442920AbiDVAWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387931AbiDVAWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:22:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274144A23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:19:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y11so7681472ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cN9ZhLUrf8Ngv6pdmP79a/DexlpcMLtixNmmzcyV9hA=;
        b=LArRVF1L5S+exersvD6njieFFNEV7araYOj8gZPObmLO8klh3ABsCS7aDto0KIkFkA
         gryZTmKRKKRbeKGinEDIvMghJVBVWVhHFoTru2RteUmqEI9N4Qz86WJJ+xBMxpWYi2hj
         X6UQcrAo0+Nsqn+uEsdJ3rb1t2r6SS1RjuGdi3XRhqWYu0EBuWptIuWdI3dqWciJWBw7
         /601VPw5EC1WGlFgW7XG5/aOrD1ePUtb0cDN+nHXaQZnZS0QWmDy96aKVGUQRrDsCZSI
         a523+6DyR7nRYI63ugyMN4sQCCgdAbFrdJqwQxTm4KL/NiPBAzv7T6N5wmNRJcQvXVK1
         18QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cN9ZhLUrf8Ngv6pdmP79a/DexlpcMLtixNmmzcyV9hA=;
        b=KzBlMEBef87kb6FX9ifsvaZQGIyLhCSugU0jAfvDeFg+6KMY2KI6JD3G+s4G9UZ2nQ
         hqdu0bV0UMTS0tLZ4pDmHfUK9tevS8BOV883/W1VULEwRvcaMRtBNjuyZKLuhei7a4Og
         hcUiKNEdqzqIJy+nDTm687iA+ulew0ek24t3P2qSreiYQXrXMhUnOl4lXkmio8C6Oayg
         +TcBz7roPPQkC44dZQXQ0ssmM6b1VoLeJ5bU5q4tg3A7X/NJ+PRoE0LuCl4UDSj8YoQX
         qZA4GgjxJ2rSZMHBaf9J1nKXL9+uq9nAQ64BWuI2vcWWMDb5TksN9egUyOdzgAp5yv+m
         zYew==
X-Gm-Message-State: AOAM5336+aWLuCdYqAfBAiz0K8j4fLTlZJhNJkrI3DkmnD43yR0jaiRH
        5LV35XHxKeWJeTchWcM/Kb7tkw==
X-Google-Smtp-Source: ABdhPJzMTYxtDeWJy9+XjUrtkBWIIe2HSlGBUf31nW/YAGzyb6TtF4NhfgICChBTw+MWha7yN0hDJQ==
X-Received: by 2002:a05:651c:12c1:b0:249:7e8c:d5fc with SMTP id 1-20020a05651c12c100b002497e8cd5fcmr1203744lje.33.1650586786839;
        Thu, 21 Apr 2022 17:19:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u25-20020a197919000000b0046b4f7553dcsm50363lfc.295.2022.04.21.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 17:19:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 67241104429; Fri, 22 Apr 2022 03:21:24 +0300 (+03)
Date:   Fri, 22 Apr 2022 03:21:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
Message-ID: <20220422002124.lwd7b56zko24gbll@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
 <Yl5nSSC4HpSWqfY7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl5nSSC4HpSWqfY7@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:39:53AM +0200, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 02:50:15AM +0300, Kirill A. Shutemov wrote:
> > I find it strange that you go after <linux/bitmap.h> which has limited
> > exposure while <linux/acpi.h> and <linux/efi.h> are there already.
> 
> Funny you should mention that:
> 
> https://lore.kernel.org/r/YlCKWhMJEMUgJmjF@zn.tnic

There's still #include <linux/efi.h> in misc.h. You removed one, but
there's a second one for some reason.

Any plans for <linux/acpi.h>? It includes <linux/bitmap.h>:

In file included from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/kernfs.h:11,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from arch/x86/boot/compressed/misc.h:3

We will get name conflicts if we try to copy <linux/bitmap.h> stuff.
Hm.

I also underesitmated what is required to be copied because of the
indirect include. The list was only to compile bitmap.c. mem.c (former
unaccepted_memory.c) would require more.

BTW, do we have a white list of linux/ includes that allowed? minmax.h?
math.h? What is the line.

Maybe allow what is included directly or indirectly now? (Yes, it is my
poor attempt to slide under closing door.)

-- 
 Kirill A. Shutemov
