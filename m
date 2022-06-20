Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726045520DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiFTP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiFTP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:27:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB7CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655738857; x=1687274857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8giL0qZv3yIElRFo4fVuIKMG5Tx+3XAwog7jJ8DWOI8=;
  b=HGkMJcnYqjyHGcfkEv9R5gWI7r/GfJbsj335jnSYq/mkbOYAkmQM2dCk
   3vvCql/v97NP8gOKVfVQTb0QQlme9PrT5cqogQ1ihUHpp6QwywejCbPF1
   l43OIZm+ja0RXfq9UAse40B7N9Zrt5qh7sNtIfHKmGfitQqGcW/hbsXmt
   nChCpq1pO+p6PNxdeQHPn0N8eulkIspqJHOZj21DouHK4VmMVomYQoX+P
   /bResCgQwRNdFk2odYv1DpuxmCGgUqHGKi/eIWTAjvhLsmUXEoVkqDCmn
   UwTKGL3BNAnSl3I0wg4rmQfJ5qxuTmXGYNZmdaigeyQv1zAMue583PoAO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280654134"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280654134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:27:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="561998169"
Received: from echeresh-mobl1.amr.corp.intel.com (HELO [10.209.15.145]) ([10.209.15.145])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:27:36 -0700
Message-ID: <63ccccac-2aa7-8850-9cd3-a8b7b89e1872@intel.com>
Date:   Mon, 20 Jun 2022 08:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jbeulich@suse.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-2-jgross@suse.com> <YrBLU2C5cJoalnax@zn.tnic>
 <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1cfde4bf-241f-d94c-ffd7-2a11cf9aa1f2@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 03:41, Juergen Gross wrote:
>> But I'm only guessing - this needs a *lot* more elaboration and
>> explanation why exactly this is needed.
> 
> I will correct the code and update the commit message.

It would also be great to cover the end-user-visible impact of the bug
and the fix.  It _looks_ like it will probably only affect an SEV
system's ability to read some EFI data.  That will presumably be pretty
bad because it ends up reading from an encrypted mapping instead of a
decrypted one.

The

	pr_warn("failed to early memremap...

is (counterintuitively) what is wanted here.

Right?
