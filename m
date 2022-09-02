Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E05AB4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiIBPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiIBPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:17:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36005A61C1;
        Fri,  2 Sep 2022 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662130231; x=1693666231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IfcmcDyZGedEV2F81LC74u+mbSHwKTFMejAo0aMOmFk=;
  b=mj98jTD9NDVUknPCke903QAUVjR/5p1g609LZ5eVuG3jrnMKWuKrhjs1
   QLSOHPqw4iGF76HgTnFvwvmLpgrrXQR7iV5IhgpjoyoEjClX+B0J4/GCe
   NyfFXTjG0BAgaOtNTDlYStQNco12VryVvG87pNWp8mO8Iqj5nAR2nHH+J
   tpyIdUYV59VcRsbGZAiSDuv9SFskuUBwvonGV1IfZv2LUGuyXLHnViajm
   0aWBI+W0E0SGitGgZ5nEoSq70HYJYZSxy1EnvHkiSPZL1X1R1Kv1TuEPs
   CC5407yXHjG8RRqk7PpugvbZ/6lfHBMyfwm0C/jC7vy0cyCNYGyRmXtfW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="282981858"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="282981858"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:50:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="642930461"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:50:27 -0700
Message-ID: <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
Date:   Fri, 2 Sep 2022 17:50:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Content-Language: en-US
To:     =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/09/22 17:46, Tomáš Trnka wrote:
> Hello,
> 
> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
> processes using "perf top -p". The tool fails to start with "Failed to mmap
> with 22 (Invalid argument)". It still seems to work fine on single-threaded
> processes. "perf record" is also unaffected.

It has been reported here:

	https://bugzilla.kernel.org/show_bug.cgi?id=216441
