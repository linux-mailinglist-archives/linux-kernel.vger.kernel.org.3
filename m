Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A955561E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiF3Ofs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiF3Ofe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D315427EC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656599008; x=1688135008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1lmuCFJS5qtfWOZx/PuzAMaV1awq6eK9MTI6WnSHgA=;
  b=XomvkcQj8M6idTDEnVi69A94iOK87ImBiMTvhgC+nxXsDLgYbC1yxXYj
   HqrmieYG+UGJczDcQvpSA+HKI76OgN4TG8VK8qIKAdA67JXOxJqyUsVrf
   UZmB3N2i+PKFeG/qAOEqRa//ig/CU0738Ag8/b6qi5bjaH0iigCqVUAs8
   nn3SRajdodmgGyJJM/SPAtGSELe8P+ZqMVYd7WtlCx/asTqykViPQwzMc
   97/bj3VnDVHna/xc9mSzltIbOF5b9QMuf/I5RNH7JqInN9uXWnJeR+5Sr
   e5QqHQnaAk8J9EMcF6rgLtupxO9K8oXCfvumYosk5WsmBJ2fiHZ0CUSMh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262159545"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262159545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:23:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="659012366"
Received: from bhavanat-mobl.amr.corp.intel.com (HELO [10.209.17.179]) ([10.209.17.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:23:27 -0700
Message-ID: <3e39adad-3b1d-18c0-29d5-e0268c0fa083@intel.com>
Date:   Thu, 30 Jun 2022 07:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/fault: ignore RSVD flag in error code if P flag is 0
Content-Language: en-US
To:     Vasily Averin <vvs@openvz.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com
References: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org>
 <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 22:58, Vasily Averin wrote:
> Some older Intel CPUs have errata:
> "Not-Present Page Faults May Set the RSVD Flag in the Error Code

Please include a link to the documentation when you cite things like
this.  For example, this is very helpful:

	Several older Intel CPUs have this or a similar erratum.  For
	instance, the "Intel Xeon Processor 5400 Series Specification
	Update" has "AX74 ... Not-Present Page Faults May Set the RSVD
	Flag in the Error Code".

	https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-5400-spec-update.pdf

That makes it a *LOT* easier to find the actual erratum and its text.  I
honestly also woudln't mind if you just copy a chunk of the problem text
verbatim into the changelog.  Intel does have a habit of updating text
in documents like that and it's quite handy to have a snapshot of what
you were reading when you wrote the patch.
