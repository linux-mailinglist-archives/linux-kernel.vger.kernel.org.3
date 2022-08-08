Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C658CA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbiHHOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiHHOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:36:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3711C00;
        Mon,  8 Aug 2022 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659969390; x=1691505390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3CTIu1dHRegj0jDNrfOOz23DeoBWwNuFjBgHHApUwk=;
  b=AGY/ufwC9/xICfhkIohQzGlyKn7aV0q4RUFhTtlHRy5x+s03KFDZiDEl
   XZw5oyIG2jIA6KWqjEgXZwRJixWJxtlT8IWEIUILHuQABs0ovQ8oft1SQ
   OcyV86yk3xf8KyrUO3udjM+JtU2eMwYDC4E0l34R85fHXEA6sEK40mlK+
   G2YChX/WrNZfxZqe0+0kA1tDzWoNbu3/7sL9ObE4beDqAdgi4IBr3M9Mj
   8XoMWYQO3/t4otzGtdQn9EQM/s+Vn3d1nzDA33bRq9hk+qP8jrNf+2Cu9
   5VTsQDV60wcCTPLzsYAYNWbBPX7YXa30CZAJ7SvtGP0x6cp20OeSrIIdb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291385787"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291385787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="932080631"
Received: from mylly.fi.intel.com (HELO [10.237.72.177]) ([10.237.72.177])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 07:36:26 -0700
Message-ID: <6ecdfca0-61fc-ad75-67d0-e49efc7b3f6d@linux.intel.com>
Date:   Mon, 8 Aug 2022 17:36:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
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
 <20220805165033.140958-5-ben.dooks@sifive.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20220805165033.140958-5-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 8/5/22 19:50, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v3:
>   - changed compatible name
> ---
>   drivers/pwm/Kconfig   |  5 ++--
>   drivers/pwm/pwm-dwc.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 2 deletions(-)
> 
...

> @@ -319,6 +320,58 @@ static struct pci_driver dwc_pwm_driver = {
>   
>   module_pci_driver(dwc_pwm_driver);
...
> +module_platform_driver(dwc_pwm_plat_driver);
> +

These module_X_driver() macros cannot coexist in the same module and 
ideally the same kernel built should support probing both PCI and OF 
based systems in runtime, i.e. putting those macros under #ifdef is not 
ideal.

Usually this is solved either by common code has the platform device 
probing (with or without the OF support) and the PCI part is in another 
module which adds the platform device(s) or both platform and PCI device 
code are in own modules and call common code.
