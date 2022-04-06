Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030714F6DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiDFWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiDFWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:30:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14221D074
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649284112; x=1680820112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yg83I+kC50RMwR1HRe5Jn4Gkhm6UoCyb88aTHqcfQX4=;
  b=DtC9D6ptJks9lL/YAskqgLAd7lVOLPdGq6gkpZGPvV14b4A7YhNX/dxu
   nPEL1tJ+z6OKx0HUM+nWLbH7ajAx4UsWEUcd89CehxaEcqZPV2SRdIZlR
   h64a5cMg0hMdS5p+TCWtomU1wWaG99vz5f0e30LZP9BrDGSWpMev+JWD/
   HZ+6ZGqJHSC30uJkjbtqGWTi538N7dlN03nxfhK5oTUNi+M5KLsE5Ub6R
   svaF82KihwVxNZozNEe9DPGpc+7KwUHMGzLWHa2OAB3nxPJf1rCz5L53y
   +qLLsWHYvDRWvGcSxvxYIQrLqN764dQfCiFcLHGEDcaKOlFWAL7Nysb9O
   A==;
X-IronPort-AV: E=Sophos;i="5.90,240,1643644800"; 
   d="scan'208";a="196154443"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 06:28:30 +0800
IronPort-SDR: xMpaz9vvj0XXo5eNPUPzDn4h0Pjby3tZZM/n7yodyAJ+d4g55VzRA9oYL27AX54iwqrZ4kZsLL
 SluOzlWjwgxLqhIsLfJJBAx1vO4QjRBuCtRbwID/F+i0Ufi6NI2+xgOBpHmueFch+X82f2mnjU
 pxxhyLxZUtQ9CJefSUn/wC6I+0Mf8bqz0ZWo9Wb0lFWl+O+tTFg9AokwCp6sChS3mhVbVpUO/o
 8VE+b++QjSFTMIuiMi7lAs+xRXJarpZPDiFuZeUk5DMJA+4CkpMhE+VvpUrR9MdxQqHQbBmLBZ
 Cl/OPccVYU0CFxUgva3OLWfe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 14:59:12 -0700
IronPort-SDR: X9IEwsKRod4Gr9xkHNZz5evVpEjl/+zICYzpWKQGJgQlXhQDjxBO8SPrmszX9KMtzKuti2HLn4
 EC/kA2r3EYj0rhjJIxbcI5m2lweNvH0/fLT3rqONB13AW3gmYbbnhULAkDky5eiLUhzxCm+AWd
 aFvkc+9IGiL4qWybS0yrG8InCMFXj4p+C1wy4qDGBjGUgeZoc34m9Xi7tHSfQAZMgoweRwR8w8
 L0fZpPn+b/kolkT/xcnPsDZOx7Qm/WM8BQ7jxXextDmU4bQiFJHmd+KqdpDQQrpKK/UTNS/0Q3
 vNI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 15:28:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYfL655Ntz1SVp0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:28:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649284110; x=1651876111; bh=Yg83I+kC50RMwR1HRe5Jn4Gkhm6UoCyb88a
        THqcfQX4=; b=oWUbqePfU5rE68CCMr4kKzIzl4+YlyOZ4kJexsSm+d/yBECGtbx
        ixe84XRmjeI8ggZ2ZFlCOVKJAQLubPELnfJC6cPDRfWFNfDDm8Y1rww2Xz9IME+y
        Pix8rSLs7yvmPF3hq0o2Chs5GvA+T7GfzlEnChe4sG9mLR7uOd3FfoOMQ555zv+G
        QE8wmsS9CkJvtx2blYZaKY2quJ6ArSJ2u8z4DRNaMQOWXeLkzDyhXmC0zXkV6N3I
        JA2WPUdGwFPaT3UkSE0buvgZEKAzxHskUhzy7shzlI4m5qQrzAi8pLY8Zu8bAV5v
        p/7ivHVBTki9ptKaNEnOVsunkwFN+VfNPIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cxjPRjVb1EnA for <linux-kernel@vger.kernel.org>;
        Wed,  6 Apr 2022 15:28:30 -0700 (PDT)
Received: from [10.225.163.4] (css-nuc-sbp2.ad.shared [10.225.163.4])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYfL52w07z1Rvlx;
        Wed,  6 Apr 2022 15:28:28 -0700 (PDT)
Message-ID: <835cf881-56ce-93b7-3182-ae35eda2691d@opensource.wdc.com>
Date:   Thu, 7 Apr 2022 07:28:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
 <da15b34f-2f13-6c97-29f1-9f26c8ec5a3d@opensource.wdc.com>
 <BL1PR12MB5157C86CA05C4F64435152DDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157C86CA05C4F64435152DDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/7/22 01:59, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Sent: Tuesday, April 5, 2022 21:11
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
>> hdegoede@redhat.com; Christoph Hellwig <hch@infradead.org>
>> Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
>> configuration item back
>>
>> On 4/5/22 05:02, Mario Limonciello wrote:
>>> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to
>> CONFIG_SATA_LPM_POLICY in
>>> commit 4dd4d3deb502 ("ata: ahci: Rename
>> CONFIG_SATA_LPM_MOBILE_POLICY
>>> configuration item").
>>>
>>> This caused some pain as users would invisibly lose configuration policy
>>> defaults when they built the new kernel.  To help alleviate that, switch
>>> back to the old name (even if it's wrong).
>>>
>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I applied this manually as the "default 3" is from the first patch,
>> which is for 5.19. This one is queued in for-5.18-fixes now. Thanks.
> 
> Ah I didn't realize you were not going to put default 3 in 5.18, otherwise I would
> have re-ordered them.  Sorry.
> 
> Which branch did you push what you've applied so far to?
> I checked libata/for-next and libata/for-5.19 and didn't see anything yet.

I pushed the patch to for-5.18-fixes and will send a PR to Linus tomorrow.
The for-5.19 and for-next branches always are in sync and currently based
on 5.18-rc1. I will rebase them on rc2 next week to have the name revert
in and avoid conflicts.

> 
> As most of my patches recently touch the same code want to me make sure
> any more follow ups work from the right base.

Use 5.19 + the name revert patch for your work. That will correspond to
for-5.19 next week.


-- 
Damien Le Moal
Western Digital Research
