Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B155EA55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiF1Qzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiF1Qyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:54:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF82B272
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656435215; x=1687971215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=btsKwvH/DJEOr0VAnwqYMJeRJHamouJbM/1L9sC1LpE=;
  b=bnRC9rI+fqx1dIqQSfcWtvd22R/Eg8mK5yXMBDf96HsEDsJ3jiR+37aE
   NQXFh+s/VeKZjLOHzrb9evYrutEXZn/cv6l1hJNckaVmzz8Ewjrkq5Ihn
   f9nc2TvtVoGQn84YJFTUyUfYWAR74JVCJqOOxtiHMlHAj4Jgqo1Wm6rXV
   7Cx+DVsBtAQ1gKKm0Ex1kkD2jpM2MuqJMrRALp/iqGNahZRS7owJlfxr0
   JfYLdUG/qYuBry+y6vu9qOqLkl+dESIKXjAGfsroc4PX99hUUhsT9CcbN
   SdK6jvb0Hg0Zgza9b8qfGFjukZgdHUyLJT6LUKXF4fQvC38L2geHgnNpf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282529109"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="282529109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:53:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="587932914"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:53:32 -0700
Message-ID: <de8d1830-9553-dd8f-8b12-308985c98b40@intel.com>
Date:   Tue, 28 Jun 2022 09:52:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with kernel
 5.19-rc1+
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Alexandre Messier <alex@me.ssier.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Andrew.Cooper3@citrix.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
 <YrrHwxtD2dpts7PF@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YrrHwxtD2dpts7PF@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thank you for bisecting this!  I know those are a lot of work.

That XSAVEC patch modifies the AVX register save/restore code.  There is
a set of x86 AES acceleration instructions called AES-NI.  Those
instructions use the AVX registers.  So, it's at least a plausible
connection between that patch and your symptoms.  But, I don't think
anyone's been able to reproduce what you're seeing yet.

The kernel XSAVE buffer formats also differ slightly between AMD and
Intel.  That *should* be OK, but it might explain why I can't reproduce
this.

If you get a chance, could you apply this (ugly hackish) patch to the
userspace 'cryptsetup' utility and run it?

	https://sr71.net/~dave/intel/cryptsetup-memcmp.patch

On Ubuntu at least, it was as simple as:

	apt-get source cryptsetup
	apt-get build-dep cryptsetup
	cd cryptsetup-1.6.6
	./configure
	make

Then I could run:

	./src/cryptsetup benchmark --cipher=aes-xts --key-size=512
and
	./src/cryptsetup benchmark --cipher=aes-xts --key-size=256

With that patch applied, you should see some output like:

# ./src/cryptsetup benchmark --cipher=aes-xts --key-size=512
# Tests are approximate using memory only (no storage IO).
memcmp12: 0
memcmp23: 0
memcmp13: 0
memcmp12: -173
memcmp23: 173
memcmp13: 0
#  Algorithm | Key |  Encryption |  Decryption
     aes-xts   512b  4592.2 MiB/s  4192.0 MiB/s

The "memcmp13:" lines should both be 0.  That means that an encryption
and decryption cycle didn't change the data.  You *might* have to run
this in a loop if there's some kind of bad timing involved in triggering
the bug.

If you see a "memcmp13:" with something other than 0, that will narrow
things down and means we'll have a pretty quick reproducer that doesn't
involve luks which should speed things along.
