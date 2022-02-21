Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638B4BE375
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358415AbiBUM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:58:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiBUM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:58:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F01EAD4;
        Mon, 21 Feb 2022 04:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645448278; x=1676984278;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=G6uPDsLPXAgZNQCtVqi3S/5UdXZRLfU1CWAz2itzvuA=;
  b=fPca6omaRm69OL81DHC3tf/BR3Fl+VW9n8XnTFCGaZsQ8HzK6DJ+PAL6
   cno3DU/H6+R2/mqpo+4N3y/ZF9y5DZeTr+EIC0JRHENCy3My48kDMc6tk
   kgAhVZJ0FG42jMJRjZ4edo/R+lI/PKYYmKtQCv+B+82+2b0HFijR1Zb0f
   VApAzGwIiemvsuA7BhwrQw9uHRzo2yGrrooFqY30ybpuwLj9omZkI6Nwg
   5VRirTMqM94aaekD9r7VuTS4BY3UM5hT3UeEZ+4poV0L3Y4d5UyZ39JPb
   g2zZw5OdAqiQoewbTv1aLs0p3Kg7ECSHtAYDgkMiSwLx/BaR9ych6Ifq+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314765767"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="314765767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:57:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="547326671"
Received: from ebruchet-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:57:55 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
In-Reply-To: <Yg8NWrvooEDbKg49@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220205233945.7a4d22d8@fuji.fritz.box>
 <8735ki2x62.fsf@meer.lwn.net> <20220217163247.03e37c9b@fuji.fritz.box>
 <87bkz51l2g.fsf@meer.lwn.net> <Yg8NWrvooEDbKg49@casper.infradead.org>
Date:   Mon, 21 Feb 2022 14:57:53 +0200
Message-ID: <87k0do8jhq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Feb 17, 2022 at 10:04:23AM -0700, Jonathan Corbet wrote:
>> *I* prefer Python, and the Sphinx side of things is necessarily in
>> Python, so I'd be happy to see kernel-doc move over.  That said, others
>> certainly disagree.
>> 
>> Markus's work was here:
>> 
>>   https://lore.kernel.org/lkml/1485287564-24205-1-git-send-email-markus.heiser@darmarit.de/
>> 
>> At the time, we were just trying to get the RST transition done, and
>> swapping out the kernel-doc script seemed like a major distraction that
>> we didn't need, so this never got looked at as seriously as I would have
>> liked.
>
> Personally, I'd like to see us switch over to
> https://github.com/jnikula/hawkmoth
>
> but I don't have time to work on the rough edges.

Basically Hawkmoth is my idea how C documentation comments should be
incorporated to Sphinx *if* there is no legacy to care about. In that
sense, I never wrote it with the kernel documentation in mind, on the
contrary it's a hobby project where I can just not think about the
kernel at all. ;)

With that in mind, I'd really like to hear what the rough edges are that
you see. Or are they kernel specific? Preferrably as issues on the
project page if you don't mind.

> I really hate the kernel-doc style; I think it makes us write very
> stilted documentation, full of parameter descriptions like:
>
>  function() - Do the thing to a page.
>  @page: The page.
>
> which really serves nobody.  Being able to write:
>
>  function() - Do the thing to @page
>
> is easier to both write and read.

I tend to agree. Though Hawkmoth does not take a stand here, basically
the assumption is that the documentation comments are pure rst. And that
was one of the goals, no parsing of the comments beyond removing the C
comment markers. It's up to the users or projects to dictate what the
comments should look like. There's some plugin support for users to add
their own filters, e.g. there could be kernel-doc format support via
that.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
