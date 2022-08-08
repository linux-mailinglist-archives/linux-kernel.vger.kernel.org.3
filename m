Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FFF58C9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiHHNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHHNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:55:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6DFBE05;
        Mon,  8 Aug 2022 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659966903; x=1691502903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rj7S2o0i0FnNpMd3hXj9URZkZ3RMds4iYIgoV1QF3YQ=;
  b=g32FAJPCAlQv3cEBE4ne4qH63RuBXS+/2uAoNHTNH2cF/ne5r1p2LNmT
   oh1vco9mrZcT9UX+zqAQ1eRu2gNv0OzoOh5F2mrzOZeor37kYQ8b2XMY7
   PUxGJqIrcR0SBbDWdbKe3NGLOcYAto8uAEVanK4uGm/y0tNPUltxZjFon
   woxY2GiCIawQT63YROuYyBc0VJBlWA47xWA5n2lS0XS21kPE8iF+Ho46j
   aNo0ilF67slPEf5IfzCoUEEHV7oNJgh5gNEz44O7xyorOJQXCLJXSSM+k
   hMIINUe3V3JTXRAH2hBFsWQwE1jue1NhSQO3fbcj6kTdpH96oi11TU/nn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291830698"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291830698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 06:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="932063223"
Received: from mylly.fi.intel.com (HELO [10.237.72.177]) ([10.237.72.177])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 06:55:00 -0700
Message-ID: <dd1a74e1-4a26-7aec-e3ff-d42e01737700@linux.intel.com>
Date:   Mon, 8 Aug 2022 16:54:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 2/8] pwm: change &pci->dev to dev in probe
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-3-ben.dooks@sifive.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20220805165033.140958-3-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 19:50, Ben Dooks wrote:
> The dwc_pwm_probe() assignes dev to be &pci->dev but then uses
> &pci->dev throughout the function. Change these all to the be
> 'dev' variable to make lines shorter.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-dwc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
