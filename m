Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D60521D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiEJPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbiEJPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:08:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CE64CC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652193561; x=1683729561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ddsexfesqVNdGpsCecUl34q/BH165I6eLFsFrzxutNg=;
  b=JMOjsN4NNa9LcLnMVux0pKEAVpayu7gdYXWF9H1oS3ylPQdLYPocJ/kH
   +hHlYOzSDzirmEAJbm6cdbg6JQM+crQiSXHHYrgRTsiQVPl/ttu9u8xm9
   hNEtsIuqmlkXEXAQdBYixZfqSNs23VQ+DmXyuaDGqZKsjmt2ArQh6FmUK
   zHgCGhB3JhVnixLXA67aUKF4cWR5Zzoah8ou8UflH6u4JgRk3xGpbYuLd
   m6XUEfDlzn00duQGq1UxT9ytwJVZkqJuTBzI6adnotsgXOSwQujSIhfEp
   qPf31t1QgWJOruul7CvQrw5svFnBt14PM8Uhl40tmRAaPhQEavHo4mEDx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269329552"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269329552"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:39:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541803920"
Received: from mnazari-mobl.amr.corp.intel.com (HELO [10.209.1.152]) ([10.209.1.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:39:19 -0700
Message-ID: <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
Date:   Tue, 10 May 2022 07:39:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com> <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 06:35, Tom Lendacky wrote:
> I'm wondering if adding a specific helper that takes a boolean to
> indicate whether to set the global flag would be best. I'll let some of
> the MM maintainers comment about that.

First of all, I'm not positive that _PAGE_BIT_PROTNONE is ever used for
kernel mappings.  This would all get a lot easier if we decided that
_PAGE_BIT_PROTNONE is only for userspace mappings and we don't have to
worry about it when _PAGE_USER is clear.

Second, the number of places that do these
__set_pages_p()/__set_pages_np() pairs is pretty limited.  Some of them
are *quite* unambiguous over whether they are dealing with the direct map:

> int set_direct_map_invalid_noflush(struct page *page)
> {
>         return __set_pages_np(page, 1);
> }
> 
> int set_direct_map_default_noflush(struct page *page)
> {
>         return __set_pages_p(page, 1);
> }

which would make it patently obvious whether __set_pages_p() should
restore the global bit.  That would have been a problem in the "old" PTI
days where _some_ of the direct map was exposed to Meltdown.  I don't
think we have any of those mappings left, though.  They're all aliases
like text and cpu_entry_area.

It would be nice if someone could look into unraveling
_PAGE_BIT_PROTNONE.  We could even probably move it to another bit for
kernel mappings if we actually need it (I'm not convinced we do).
