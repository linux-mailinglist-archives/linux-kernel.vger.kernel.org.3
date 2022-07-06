Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0567568814
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiGFMNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiGFMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:13:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BD2A26C;
        Wed,  6 Jul 2022 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657109595; x=1688645595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7/DjKhzqPO6N9gYPLVQhK1qL9CR/OpZCf7mHqFkJWdk=;
  b=TF7+Df6RhcribkPG/46JhHPCv2Pxetqu1G9QVpobebNCCPryE6OYJmwr
   oXry6gN+/H8YDqL2B9KBd5FxqXpKQ1QpLWmG52WbCym+ftQRiugSoHHrn
   xI0huwel3kydtCx5YYvmu/t5ILuW2afjQ6+6PYU+yxh57QRdoxzAivvCi
   lwU4RMb6gU08JuNswoJhj44r4dmui+UlweBMmiWqYxqR1XT8Y0dZ2uzGT
   nf9wyb12PLcOHH+jqlHtooOTt78Xy40d9hifvFp0Vv3drO1nKGc0svemz
   1cwGfAO0K/W+kB92arE+Tyt6CQfhRH9HxnN0UCmw6/oOgkZXvVr2VbCL6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272516847"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="272516847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:13:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="568045031"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.46]) ([10.99.249.46])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:13:13 -0700
Message-ID: <7fbae4c0-e64d-7fd5-8f8b-45ded6126c21@linux.intel.com>
Date:   Wed, 6 Jul 2022 14:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220706115529.7deea289@canb.auug.org.au>
 <YsV7jC2eoEx6G3qH@sirena.org.uk>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <YsV7jC2eoEx6G3qH@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2022 2:09 PM, Mark Brown wrote:
> On Wed, Jul 06, 2022 at 11:55:29AM +1000, Stephen Rothwell wrote:
> 
>> After merging the sound-asoc tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
> 
> Which toolchain do you use?  I've been using GCC 10 since it seems to be
> what Linus is using, anything else I try has tended to get spurious
> failures in from his tree.

I will just add that Czarek already provided a fix:
https://lore.kernel.org/alsa-devel/20220706062952.251704-1-cezary.rojewski@intel.com/T/#u
