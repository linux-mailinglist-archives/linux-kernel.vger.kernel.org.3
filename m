Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D157D234
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGURIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:08:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8558E0E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658423280; x=1689959280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TjK26D/4bfGsPxWI5114c1jk08cGDBt0fZxxEkWj7jc=;
  b=faMvKfmmthApCBe3L6lXpoXoq9xE8xZb5xTVGELiNeqnk9F/FOTLVxqH
   KZFoHoUSJlXpqJY8mLYU08Pg5DCZlO6//3tQctp6z1U8ZHBWW4WVnEgqk
   z0qrpGmxLKwwHshGm9JVaDKVb0cSNIVyAsZS0RwBh8GbBBFEJQ6A2+yWi
   Z4ACR3Ihvp8qkGVaq1qYHPJBa9h17R1AVDG8hpOqjb5NRVGBE1b9TezlE
   OM8Qh0AVKy15Mw6AMoteUWG2+M7vScZqGA57i0zY2tuKEb5YPkjhaLifH
   1wV7+q7IGwsBSLtFm5GbJ50pELLDKB2Llz/kjJw8Djpa++Az/AAJk8Npm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267506819"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="267506819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:07:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573823188"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:07:52 -0700
Message-ID: <c5dc0415-8c2d-8c9c-5bdc-824c267aa960@intel.com>
Date:   Thu, 21 Jul 2022 10:07:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv5 00/13] Linear Address Masking enabling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=WR3s3UMh76+bibN0nUpZk9AS_M18=oxP+pc_vtqKt34A@mail.gmail.com>
 <20220720005950.fonulr4kkwbh6kbz@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220720005950.fonulr4kkwbh6kbz@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 17:59, Kirill A. Shutemov wrote:
> Dave, Andy, any position on this?
> 
> I wrote LAM_U48 support to prove that interface is flexible enough, but I
> see why it can be a problem if a distro will pick them up ahead of
> upstream.

My position is that maintaining distro forks is troublesome.  If you
held a gun to my head today and made me merge *something* I'd leave out
the U48 patch, but reserve the right to add it later.

I'm not sure whether that makes the distros lives easier or harder.  I'm
not promising anything either way, though.
