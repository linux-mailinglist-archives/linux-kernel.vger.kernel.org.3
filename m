Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92204715C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhLKTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhLKTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:47:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B5C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oCRoL0wkxtd6CyWt0pw8dKdIinI9wJ7R2QtxSZ0s8SY=; b=BSj0bVul7PRFFgDTLdZLVlHMed
        anvjtqYKOOjoCyZijhizMF5MuoFpl1y090QJzJrMtD1YoCqSq1+cU+5jx4nFQe2d68yFPcYNyroCP
        NxVw3xf4HpJJ9sntLYMsR7ZP0Uz+Cmyi8bEX6RdteZOuhQUHZ889igdQFAIcLCCK1Kvy4nz47VhAA
        3ValcEL7rubVi3mxRJnyPiUHqJ+j5vLnNd/mE79bLIqXnuKRZ/ZlN7LjuaKAqEkgqKHod2CTY34an
        EEng8ypg/9ZYKywIhFBzcq1nFOxpnOShnTXFqj1bvEeyHFbFjZ4cyfghHrIW31unQDvRezx632djz
        mHIBS75Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mw8Kr-000nDA-PS; Sat, 11 Dec 2021 19:47:10 +0000
Message-ID: <3f53c496-cddc-7d2d-cf2d-a492eb5be9b2@infradead.org>
Date:   Sat, 11 Dec 2021 11:47:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: rockchip_i2s_tdm.c:undefined reference to `clk_set_parent'
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202112070621.TnLPiADU-lkp@intel.com>
 <13326272.At7iLaMNiz@archbook>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <13326272.At7iLaMNiz@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/7/21 03:32, Nicolas Frattaroli wrote:
> On Montag, 6. Dezember 2021 23:46:38 CET kernel test robot wrote:
>> [...]
>>
>> All errors (new ones prefixed by >>):
>>
>>    mips-linux-ld: sound/soc/jz4740/jz4740-i2s.o: in function `jz4740_i2s_set_sysclk':
>>    jz4740-i2s.c:(.text+0x3ec): undefined reference to `clk_set_parent'
>>    mips-linux-ld: jz4740-i2s.c:(.text+0x44c): undefined reference to `clk_set_parent'
>>    mips-linux-ld: sound/soc/rockchip/rockchip_i2s_tdm.o: in function `rockchip_i2s_tdm_calibrate_mclk.isra.0':
>>>> rockchip_i2s_tdm.c:(.text+0x10d4): undefined reference to `clk_set_parent'
>>>> mips-linux-ld: rockchip_i2s_tdm.c:(.text+0x1180): undefined reference to `clk_set_parent'
>>
> 
> According to some previous conversations I've stumbled upon[1],
> this appears to be due to certain MIPS configurations not
> implementing the clock API properly, so they don't provide a
> clk_set_parent despite advertising that they have support for
> clocks.
> 
> So my question is: do I need to care about this? This hardware
> will never be used on MIPS, and a lot of other drivers (as seen in
> the errors snippet from the test robot) have the same issue, and
> the problem is most likely not in my driver but in that specific
> configuration's clock API implementation.
> 
> 
> [1]: https://lore.kernel.org/lkml/8a41b718-a6f6-6b7f-1699-18ab619884c3@infradead.org/

Yes, AFAIK this is fixed by:

commit fc1aabb08886
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Sun Nov 14 17:20:51 2021 -0800

    mips: lantiq: add support for clk_get_parent()


I can't reproduce this build error with the provided config file
in a current kernel tree.

-- 
~Randy
