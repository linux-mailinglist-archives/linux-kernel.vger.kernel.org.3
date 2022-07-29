Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6987E585575
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiG2TIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiG2TIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:08:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651F12F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659121719; x=1690657719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qjcVM8mE/4KKr2AbzDjZ4JT5g02rfXfdHRMcCiuIE+0=;
  b=eaKtlBGxtO5TAjr3N5VSq8mssbCFPkg7T+QkIAfCnAQ0alAufCkmjxXd
   MO5GhLBy0CGwg4KILU0Z/HFhNecNP/yd5O69YRy+uKuyz0/0beiS70oJL
   CNoOf7a8n9ZAnIq+3VeA64kyaRf44xLHJMWyGftYh5AAioH0GU5ER6D7v
   iolFXi3N+M8eKfDj8gKPNT0YVbRe8LJLN5BbVozW2helNbWiTD1YFHeaT
   7ALNpC+eqDzOUgae34/Kkwpwc8r7QJrVqX1CY4+dSziwfmlr+Pgm7rhx+
   CjwyL2JAO8tSUwkyBIqTpoPprlBQgm4RhdLtujKDPfzAxTsDhKhFkgb3n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286386378"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="286386378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:08:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="669365319"
Received: from svdas-mobl.amr.corp.intel.com (HELO [10.209.20.175]) ([10.209.20.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:08:38 -0700
Message-ID: <377f6c30-bdfc-55a4-bda7-f29c60c53300@intel.com>
Date:   Fri, 29 Jul 2022 12:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
 <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
 <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 07:25, Tom Lendacky wrote:
>> Considering that runtime acceptance is already single-threaded[1] *and*
>> there's a fallback method, why not just have a single copy of this
>> guarded by a single lock?
> 
> This function is called for more than just memory acceptance. It's also
> called for any changes from or to private or shared, which isn't
> single-threaded.

I think this tidbit from the changelog threw me off:

> Protect the use of the per-CPU structure by disabling interrupts during
> memory acceptance.

Could you please revise that to accurately capture the impact of this
change?
