Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED8525179
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356047AbiELPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiELPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:43:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659856231
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:43:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652370179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJMSQMAYOqjlOrVck6Lf44hI9r9y1hhTrqfXrgRag60=;
        b=QBhnRH7Tzm0dBzZ6HfLY6zNXD//s9dyQbgL5e1jaXzPWiD9gSRgFkYXRfqjxsLmaWMY9bv
        /dL93oCopwhZYNXCdlWriPW5m762gw5KvUmZmsvHstcYkmwyUqtXF1Dqp6VGvIWDBnRloR
        n1GP0O/EuoDpWXbP+cBLe3ex/usG7X0g4K9S+XmCwDifTgw1k8M/CPwqzYjTFRvY8H1ncg
        fpIMekaAHCyeVVNOrSdJLsH3HQBplMzinxcfScJQiew1lXe634mY8C/0Z3KHhYFu8dkKz/
        nHIvyjfg6ImpEWdft28wbyUvrZHFULmj305Ajxbv3QKAGo17ZhuEtG9Cmg989g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652370179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJMSQMAYOqjlOrVck6Lf44hI9r9y1hhTrqfXrgRag60=;
        b=lcmWtNHFzkfy+KNsR3x83IgX/lN1LP/vq/mkPgubu9aGgWC8sxJikIjATnmSSZlhXMEMzb
        3u/K4K7ggNxJGEBw==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
In-Reply-To: <20220511064943.GR76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
Date:   Thu, 12 May 2022 17:42:58 +0200
Message-ID: <87pmkivjst.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 08:49, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 05:27:40AM +0300, Kirill A. Shutemov wrote:
>> Hi all. Here's long overdue update on LAM enabling.
>> 
>> # Description #
>> 
>> Linear Address Masking[1] (LAM) modifies the checking that is applied to
>> 64-bit linear addresses, allowing software to use of the untranslated
>> address bits for metadata.
>> 
>> The patchset brings support for LAM for userspace addresses.
>> 
>> The most sensitive part of enabling is change in tlb.c, where CR3 flags
>> get set. Please take a look that what I'm doing makes sense.
>> 
>> The feature competes for bits with 5-level paging: LAM_U48 makes it
>> impossible to map anything about 47-bits. The patchset made these
>> capability mutually exclusive: whatever used first wins. LAM_U57 can be
>> combined with mappings above 47-bits.
>
> So aren't we creating a problem with LAM_U48 where programs relying on
> it are of limited sustainability?
>
> Any such program simply *cannot* run on 5 level pagetables. Why do we
> want to do this?

More bits are better :)

Seriously, I agree that restricting it to LAM57, which gives us 6 bits,
makes a lot of sense _and_ makes the whole thing way simpler.

So supporting both needs a truly good justification and a real world use
case.

Thanks,

        tglx
