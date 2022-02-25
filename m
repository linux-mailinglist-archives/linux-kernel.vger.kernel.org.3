Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626ED4C4A86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiBYQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiBYQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:21:58 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57756F4B6;
        Fri, 25 Feb 2022 08:21:25 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee37.dynamic.kabel-deutschland.de [95.90.238.55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C2D261EA1928;
        Fri, 25 Feb 2022 17:21:22 +0100 (CET)
Message-ID: <c8d83507-3ef7-5de6-6c1f-721757afd3b6@molgen.mpg.de>
Date:   Fri, 25 Feb 2022 17:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Mario Limonciello <Mario.Limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225061113.223920-1-mario.limonciello@amd.com>
 <Yhj9Pdp/sHASmBw4@infradead.org>
 <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <e65c4fbb-95d0-5c5a-2b15-414b519d3319@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans, dear Christoph,


Am 25.02.22 um 17:16 schrieb Hans de Goede:
> Hi,
> 
> On 2/25/22 17:04, Limonciello, Mario wrote:
>> [Public]
>>
>>> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
>>>> This board definition was originally created for mobile devices to
>>>> designate default link power managmeent policy to influence runtime
>>>> power consumption.
>>>>
>>>> As this is interesting for more than just mobile designs, rename the
>>>> board to `board_ahci_low_power` to make it clear it is about default
>>>> policy.
>>>
>>> Is there any good reason to not just apply the policy to all devices
>>> by default?
>>
>> That sure would make this all cleaner.
>>
>> I think Hans knows more of the history here than anyone else.  I had
>> presumed there was some data loss scenarios with some of the older
>> chipsets.
> 
> When I first introduced this change there were reports of crashes and
> data corruption caused by setting the policy to min_power, these were
> tied to some motherboards and/or to some drives.
> 
> This is the whole reason why I only enabled this on a subset of all the
> AHCI chipsets.
> 
> At least on devices with a chipset which is currently marked as
> mobile, the motherboard specific issues could be fixed with a BIOS
> update. But I doubt that similar BIOS fixes have also been rolled
> out to all desktop boards (and have been applied by all users),
> and I also don't know about older boards.
> 
> So enabling this on all chipsets is definitely not without risks.

Exactly, even requiring to update the firmware would go against Linux’ 
no regression rule.

When new chipset are added from now on, we should ask the submitter to 
test with LPM first though.

Mario’s patches look fine to me, and other changes should be done in 
follow-up patches.

All are:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
