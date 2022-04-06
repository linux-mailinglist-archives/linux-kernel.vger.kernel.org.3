Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A34F5E27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiDFM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiDFM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:26:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853F23A3BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649232651; x=1680768651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OXlW7XMsm7YkB8BmULX0rKO6acP3cTihzhxzw0jjfqc=;
  b=kcN2TUI/+EzjGey45MWuvNtbkq0FK4bRBy9dV160jhDrxzn9yNsH5bj4
   B7bfiPpKquM9Nnnfby3+8b841JgC8BxezPhc82pfaIJG455O04Uw+rBHM
   IWFSgEcDDI7QJ8jNYoGa7yKsB3Jr6e57RylVXv4pC8n+firxQGPWtbJnT
   3h2ii8hyO0yFc+3q6vSQHEb9b/5x2JRR4h8tviHeuM5b2QPCICMg2rWxN
   U9aYJUybM+kw6hQYFlzo8gRvh1edjR4UJIA0GAqQCBtpQOe2DkcUFhPMw
   M6bB0ZMfrdSOBvj0tAdhwvuRX8fVA2iibTJOq7eR+zwiA4AtuMOPi12wg
   w==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; 
   d="scan'208";a="197220759"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 16:10:47 +0800
IronPort-SDR: nF4bIdbir6tW54lJVvUQyRZIS3rw6aVEmfkYoyQumGdLxvjXuyntHiVOdNUGB3oibnUMyam31o
 vE2KW82SA/tcY1F9Ic3sNVNExy5VD5fqVkDOAGLPoR3mC05rC9INWqJXvZQQU0snWQdxVeKvAN
 FxQhwA0AcJjCrhfN5OTHSZxNyNWm8Aq3Hn/3euOVWw4FyEhjkDQGwIc8UKC2elHazJms4UWlxA
 comP//c5KkNpkJjYAfj2JFIgp/42mDJMrcPoboljKg1iX19vNL2U+Rgye5sh9rGf8ix1NQR86N
 n8Ev3/IStfDPP9LOCs5HPS8y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 00:41:30 -0700
IronPort-SDR: zogS5gFxZKZDzO+nS7PyogULYokmOHnthX3HAgZXpvseAocuZGokAB0VrGO6iSh4MwidrBg3I5
 6MZq7gFFjBCfHMUeLLjoac62A9JaoSSPBn3qAnEO9NZ4gSfi6M/HXegCt0YM6IbI0hKVHtf1os
 ZjK56zti9zt6RBAOpFq/g/jrDJr2W97XT2rvx4oQsR26Z0KDY5cHSNR7KxDUMA5FsVdoYo2eCj
 soKyixMgCNvg+Pr+pk49yPXnEXL39FT2Tk099JTuokEZDR0V//4CoTZE731/eP0EVgPbA7eRNO
 RiI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 01:10:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYHJS2Mg7z1SHwl
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:10:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649232647; x=1651824648; bh=OXlW7XMsm7YkB8BmULX0rKO6acP3cTihzhx
        zw0jjfqc=; b=o4BCjSaKcmUeC3V/ysxboezAk7mt0Fxzqh0MWkY8sT2l+gU7jPB
        Kdld9C6XDIdwdhu6MiqU1d/sFMaFZp1s88kGT8889lanvnwC5C8AIwciYM+n0oHv
        v8DNdpfzNAnjxkMmWc8SAOte06L8HEC5Aaq0RJ3++HsG5s0JRjox/1O/RVWyl8QV
        csjgkizdLNStKiwYAn6XM9sdJYrB3kTdTlk3xh1VqjcLqZnatbHvvIiBNcoawOPo
        TlPhnPSSi8mM80a14xE+5tRgZNdUKq+STK7pG4aKau780AYeHKeAm1wTs8z6wem3
        vskcmDgDMic33lD85Uly6zeGQTyojauhR1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t5kjtjyLHI90 for <linux-kernel@vger.kernel.org>;
        Wed,  6 Apr 2022 01:10:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYHJR0CwQz1Rvlx;
        Wed,  6 Apr 2022 01:10:46 -0700 (PDT)
Message-ID: <a984b4d6-bc7d-ef81-8bd6-34d50127174d@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 17:10:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
 <20220405055252.GA23698@lst.de>
 <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
 <febb03e4-ea1d-c7e1-58a6-fa564c902af0@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <febb03e4-ea1d-c7e1-58a6-fa564c902af0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 16:16, John Garry wrote:
> On 06/04/2022 02:48, Damien Le Moal wrote:
>> On 4/5/22 14:52, Christoph Hellwig wrote:
>>> On Mon, Apr 04, 2022 at 10:53:10PM +0800, John Garry wrote:
>>>> From: Christoph Hellwig <hch@lst.de>
>>>>
>>>> It is a bit pointless to have ata_qc_new_init() in libata-core.c 
>>>> since it
>>>> pokes scsi internals, so inline it in ata_scsi_qc_new() (in 
>>>> libata-scsi.c).
>>>>
>>>> <Christoph, please provide signed-off-by>
>>>> [jpg, Take Christoph's change from list and form into a patch]
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Although I still think merging the two patches into one to avoid all
>>> the churn would be much better.
>>
>> I agree. Let's merge these 2 patches.
> 
> I'd say that they are distinct changes.
> 
> Anyway, if that is the preference then who shall be the author? 
> Considering I did most effort I will be and add Christoph as 
> co-developed-by - please let me know if not ok.

Works for me.

> 
> thanks,
> John


-- 
Damien Le Moal
Western Digital Research
