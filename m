Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4619C470F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbhLKAIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:08:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12953 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243876AbhLKAIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639181097; x=1670717097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xEgeQ/Mk2e4FA08czcoHG5Hp46F5amIhTyxfqhk+t+k=;
  b=nVoTg3uFOHrAP8SM4YKSr5ZbELAzRMaLNu8NwXReBrzKjiEh8CfRXZm2
   pnCpkzLhytI4lpvV8qqgnUMJRoC/rr7jq4ZzGv0IlIRVJT/htdNsQshtG
   e3KDrV9tWb91uyfzFgZzK4/QVm8qAg7B9YXYPX+kgqhTNvgLKwmvhV6I3
   h7CJjj8anFnpJPoClZBZY2v/uIOoaYCC6qqvCcJ8veSeZ5uDWiZmT27fy
   j9vh1Xva3ddIOvNs4eUIoC5BEPzO5CiGryW79zSUtTmNd38qwyIOAbQUn
   Y0tEe52MdHfpLsdS13BmyW3yo3sMhnf6ZcA9nkgW+mg2m4iEdiH6g6h5Z
   w==;
X-IronPort-AV: E=Sophos;i="5.88,197,1635177600"; 
   d="scan'208";a="192763312"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2021 08:04:57 +0800
IronPort-SDR: IqqyPnQnVEKfkJJ14UVACVgzpTwlLEVGPKZsiB2f9VIRlVRkmc/lcmyiAkfWyR/3M3o8rPySnW
 WtLWDQKC/h8kyxTwmllU7RZKY1Io9RT+l6GhRXjDGGbjfchfaDx54v9D/KUVNcZekOPmu16ZJW
 4GAGeA5qMfg5qDDdOuHPeSQevQlAxiLPO/mH8Pdgzlz0aQC3h/Zd97RhozVC0SeLMHb7ZjyeOH
 lDycVocJl8zkgitBzjpcWEJD2PU1bX7zL5Vhaf1wqa4TYtr/s+b9jCTAGjp0y9hRSKpD9ELKdn
 kTpgpA/s00rnJcAAVM+J4ERw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:37:59 -0800
IronPort-SDR: UEqyHcKXUhylZBvzREb8NbW31xVmkrYWd9FOp0MGKfePRlUKChv9cE5Fv4Nj7l9Mlqd850Eavf
 PYTObhMxiwOHgnvPp7v5yEokpXgdRMk6YroDSLOJuY6D1cmF/fY2sNUgrELvKWf9Ssi6F9vm+W
 pIfYGDv4VVQfoh9SJ9epLACvvO6sBNM6ryEOfuWI/M7S9n2zYd1QrIvF7dHf/MYuHthJ/XlgUp
 BlqjE4o22RrDosNEVTfN4/h+amchkHvFxV+oCzm98Lrwwph1JAsCNRcUoF6g+0kbtHng7/1hMw
 bM0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 16:04:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9p1Q43Qpz1Rwns
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:04:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639181098; x=1641773099; bh=xEgeQ/Mk2e4FA08czcoHG5Hp46F5amIhTyx
        fqhk+t+k=; b=H68JC5acb2gyp1NM51k/IDOW1mgoyM1B+LYvxYYnykfRHl4u1AB
        jjOh09dl9HiKwgYu5blzyrisA6k/Xul8PVjpAQw2WwaX9m8/Nra87hDp0bbjDclX
        8bY34UJlivO2BxJeniUOh8lWtI+5U4Pdy66VOnpVbzWXG556n5zB++9vtrjmyIEW
        NFggpTVNw9wJTn3O5opBHmXpID1XhiQR5QOaM7QWEXAVMzoW/yd4wmIf2JsfocGk
        rMISd4gdY6QftKjcMlFVGhOG//RleYJT4F2er9PmF/vjimAY8MGDPueKEW1JrSb3
        CvJp0KtFHE9Pit+fTjYTzM46xtcKP+UJF+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yvl3Tt8zHcoC for <linux-kernel@vger.kernel.org>;
        Fri, 10 Dec 2021 16:04:58 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9p1P2TPNz1RtVG;
        Fri, 10 Dec 2021 16:04:57 -0800 (PST)
Message-ID: <b5c109c5-9338-cd95-ae6d-b4bebd86a210@opensource.wdc.com>
Date:   Sat, 11 Dec 2021 09:04:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/2] ata: libahci_platform: Remove bogus 32-bit DMA
 mask attempt
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <20211209145937.77719-2-andriy.shevchenko@linux.intel.com>
 <YbOr0Y7qacDmCg73@smile.fi.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YbOr0Y7qacDmCg73@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/11 4:34, Andy Shevchenko wrote:
> On Thu, Dec 09, 2021 at 04:59:37PM +0200, Andy Shevchenko wrote:
>> If 64-bit mask attempt fails, the 32-bit will fail by the very same reason.
>> Don't even try the latter. It's a continuation of the changes that contains,
>> e.g. dcc02c19cc06 ("sata_sil24: use dma_set_mask_and_coherent").
> 
> I understand that some people have nothing besides bikeshedding, but this patch
> seems fine to everybody, am I right? Can it be applied (it's independent from
> patch 1 anyways)?
> 

Yes, this one seems fine to me. It would be good to get a different review
though (I know hard to get reviews on ata patches...).
I will queue it for 5.17.


-- 
Damien Le Moal
Western Digital Research
