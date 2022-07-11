Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A645709A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiGKR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGKR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:58:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3FFF0;
        Mon, 11 Jul 2022 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657562315; x=1689098315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vzMEXbbbTZku2X+5Bo9S/hj+ODiBZz1T4G2KY3usj+o=;
  b=KzcRuVECUprJJD9MxlBjdns0AHLC6x78ewxsZwjO77mM4V0aF2uzml4D
   XTQrO8nR7oPqVW8NLnJIgcsWHsQHonaClASSYlqiKalRpViXUu/eoyOp7
   Jt66+/0mTf6Cn5m26DxkHjwCazg4XRoIs+Dv16s5CBWnQgCQSZDU1zh+Y
   wkYMKdVH2/NxfJ9EMAlMVFR8iCNtL9X85mBR3FVVJjSCRME65Jb140YoY
   9hJOXNRf01GicUoGuM7/7jognJUnlQ/OLQHq4SHFBvUZa+Q0dPreNENtf
   Ot7ybZWF3Fo6Qw2O5WpIzG39Kmuofl6NzrIHjzynMsc/JOspfKqWiRmnq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267769931"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267769931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:58:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697717582"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.212.162.191]) ([10.212.162.191])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:58:33 -0700
Message-ID: <1eed4bc7-fe26-a302-461b-33439f96779f@linux.intel.com>
Date:   Mon, 11 Jul 2022 10:58:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] PM: hibernate: allow wait_for_device_probe() to
 timeout when resuming from hibernation
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
 <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
 <YsvbgxJ80kMP5juv@kroah.com>
 <601436f2-b13e-6c24-bcfd-29548e288f23@I-love.SAKURA.ne.jp>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <601436f2-b13e-6c24-bcfd-29548e288f23@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2022 3:44 AM, Tetsuo Handa wrote:
> On 2022/07/11 17:12, Greg KH wrote:
>>                                                         creating a
>> locking loop like this should be resolved first,
> 
> Rafael and Arjan, can we agree with removing wait_for_device_probe() from snapshot_open() ?
> 

we can probably remove it. the "fun" is then that devices you need might not be ready once you remove it.
so if we otherwise would panic, we should at least try again after some delay...
(since a panic() is very nasty to debug for all the obvious reasons.. especially is the screen isn't on yet)

