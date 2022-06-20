Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5B551152
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiFTHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiFTHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:18:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2325116E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655709513; x=1687245513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A4kt9sY2srM6EfBhMTZ2baCA7wXV0W7moRi2KSHI++Y=;
  b=HqpEoDKsbqCzEsBu3w4F+YMaCUcdmF3xKM+7oRGsDZ7wn9HRuAZO+aAD
   aPCCIYrfDWMxOV7FPskAOid6OX7uZlZbUWIoNwjCqJ6fYdu2nrotATLrr
   t7CJhQz/PFzGZ9E0S2FuuSllPPtGjkXsmAM074qYWWam3QwQg1PSTb6fR
   mTs9dATvc0xBb8fMlD8gp9Zmp270H7iz7vMYqTrn4pkNh2EwAFgQM4vwp
   967DhrRPyzAnjw6mbG5ckvAify7JNjVtZZ3+VK4etqKH2TYRFKVUMi6V3
   UDmnOx8Emrb76/8RNjjk9mSs+/4GGQVUphlnM5uAFgaH4lNqJ2zRPB9vd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259647348"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259647348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:18:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="561829661"
Received: from echeresh-mobl1.amr.corp.intel.com (HELO [10.209.15.145]) ([10.209.15.145])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:18:32 -0700
Message-ID: <04db74ce-4e43-1edb-34e6-ca162f483680@intel.com>
Date:   Mon, 20 Jun 2022 00:18:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: "Bad pagetable: 000c" crashes and errata "Not-Present Page Faults
 May Set the RSVD Flag in the Error Code"
Content-Language: en-US
To:     Vasily Averin <vvs@openvz.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     kernel@openvz.org, Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aae9c7c6-989c-0261-470a-252537493b53@openvz.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <aae9c7c6-989c-0261-470a-252537493b53@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 22:29, Vasily Averin wrote:
> Some (old?) Intel CPU's have errata:
> "Not-Present Page Faults May Set the RSVD Flag in the Error Code

Do you happen to have a link to the actual erratum document?  It's
usually a "Specification Update" for some model or another.
