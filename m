Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25D4DAF11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355434AbiCPLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiCPLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:45:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845762D3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647431046; x=1678967046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PdV9UxK6PmHCCzOX6g9P8eVdwqPH4qT3bhTy/o7cQ2I=;
  b=Se9FxXQhBAGWoOUbrcM59uKNGmFIfePkRaERSV0Ng0MeuNinpxzQ76gG
   GE0k/847MjWtu0Kqc9SgEH1PQHYmegk0LIftzgUXwGSljFNTOcKfbcptF
   YjryakKgdpFGL/gNLv22ABVCIiKI0E+/9+Keei1YAClopbILji7aC4OjM
   ANCOqiAV9YHSGUBgDQLA0IKWkBJ4w7m/6PEjA9daLI4aFOujJzFbYVmBK
   +Qvwb6t7rXhgfhvKrMpuNopM9VqU2N0UxIr/RL4rH7UVYBUc9F1lT2Dn9
   V3y6A759wSkfuomAY4Lr/YYYy1jMF6/tb41tee6MT5BBeMaF9QhWHbuKA
   w==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299647711"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 19:44:05 +0800
IronPort-SDR: IF8vvpdCC62hvMyrFDaCmxx/5AOx74dMOjxtLkRBXHS2h7gKXUoQlYONCNBlkxqM/pWy5RGGSt
 NDfPyhhTVwTZ0cpT8uAp4tRlkqwOWEQRuCOHQDmu9rWM43lMMkpDWT0gN6NN9yZVG1B0vUD17r
 dp7/ZrdGmUXqL7bfG3OGGa0ckXwh5HnV86k/k7UV4OhBNW7L1KDIazPTXzqHO0ca4EfLOf37xR
 bS3H+V21IXhE0RVSpi5YNjMzcX+rimM2UBGAUFaP6CKOim6jgAm223bWygdJvZawjR4FOEBmIZ
 bpZ7/qhlEikvkinjQSYP2ras
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:15:11 -0700
IronPort-SDR: t0GT1XYiI8TnonBZ+UIaS+zC4LE/5lCsbfR1G/eXFrKnTbyoB5llodlVdi+5xEkB0p/BakMm1e
 uIWuhyXCWuWf9WfnvaVbo5yaxKcQoMNYrpy/OpanPsTy7Op0gxh2WS0tjFC0wX1G3ADqOMjxHI
 cW1bz8I48FDDmyQvBsfHcId5HvyxCQlK4Jj6QUVgWcONj7m/hG5JiRnZx8b5zDDzKnJlglohbn
 +V0iM/n8kziMV6MHxnpqeHlij9cTAGimX0dm/eod6Yh0hV9z6SciWqtLgdM6UkJb3xcQIP42Mw
 3SQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:44:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJT2D2rwfz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:44:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647431043; x=1650023044; bh=PdV9UxK6PmHCCzOX6g9P8eVdwqPH4qT3bhT
        y/o7cQ2I=; b=N4V7WDXyj/wMC9HgjC9lduq/GJilDfgI3JgxEB8dydre95OoqwI
        rlDlXMDr83zUcxJpcGcpy+LUMPrSCPQydvtrZ1h+yhwRtllLyFyf60UBTXR3ouJk
        ZAUpT6lPoTHKIuxu4T/7RUmiLELVFmo/ayPVxWFhmoL0OyVdsgJzrv8vU5LpXOnF
        2rLx+RcYDTmaCat7qVfpyw2z2fuXdMlAcPmTW63AEnvoNhbD9xwcYKa89f+06LFe
        bJmQkfP11dK9p31zFRpNl94Dj/QWe8PxRa7aE1kLQ7e8aSRe9UFejdmIDdC6TGQ1
        RZ3JKb+K9yMpv2zkp15YMnLJ9tm9HS15VjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 10QOvGlljgrX for <linux-kernel@vger.kernel.org>;
        Wed, 16 Mar 2022 04:44:03 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJT2B0Bv0z1Rvlx;
        Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
Message-ID: <0015ea51-b3e9-924a-2714-61b159fc7b98@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 20:44:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202203132219.59100.linux@zary.sk>
 <68e572f6-e1b6-8d04-900d-8621f607f3bc@omp.ru>
 <202203161228.05700.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202203161228.05700.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 20:28, Ondrej Zary wrote:
> On Wednesday 16 March 2022, Sergey Shtylyov wrote:
>> Hello!
>>
>> On 3/14/22 12:19 AM, Ondrej Zary wrote:
>>
>> [...]
>>>>> The pata_parport is a libata-based replacement of the old PARIDE
>>>>> subsystem - driver for parallel port IDE devices.
>>>>> It uses the original paride low-level protocol drivers but does not
>>>>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
>>>>> behind parallel port adapters are handled by the ATA layer.
>>>>>
>>>>> This will allow paride and its high-level drivers to be removed.
>>>>>
>>>>> paride and pata_parport are mutually exclusive because the compiled
>>>>> protocol drivers are incompatible.
>>>>>
>>>>> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
>>>>> chip).
>>>>>
>>>>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
>>>>> drivers - they don't handle non-multiple-of-4 block transfers
>>>>> correctly. This causes problems with LS-120 drive.
>>>>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
>>>>> or 8-bit mode is used first (probably some initialization missing?).
>>>>> Once the device is initialized, EPP works until power cycle.
>>>>>
>>>>> So after device power on, you have to:
>>>>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
>>>>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
>>>>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
>>>>> (autoprobe will initialize correctly as it tries the slowest modes
>>>>> first but you'll get the broken EPP-32 mode)
>>>>>
>>>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>>> [...]
>>>>> diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
>>>>> index e1ce90af602a..e431a1ef41eb 100644
>>>>> --- a/Documentation/admin-guide/blockdev/paride.rst
>>>>> +++ b/Documentation/admin-guide/blockdev/paride.rst
>>>> [...]
>>>>> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
>>>>> new file mode 100644
>>>>> index 000000000000..783764626a27
>>>>> --- /dev/null
>>>>> +++ b/drivers/ata/pata_parport.c
>>>>> @@ -0,0 +1,819 @@
>>>> [...]
>>>>> +static void pata_parport_lost_interrupt(struct ata_port *ap)
>>>>> +{
>>>>> +	u8 status;
>>>>> +	struct ata_queued_cmd *qc;
>>>>> +
>>>>> +	/* Only one outstanding command per SFF channel */
>>>>> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
>>>>> +	/* We cannot lose an interrupt on a non-existent or polled command */
>>>>> +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
>>>>> +		return;
>>>>> +	/*
>>>>> +	 * See if the controller thinks it is still busy - if so the command
>>>>> +	 * isn't a lost IRQ but is still in progress
>>>>> +	 */
>>>>> +	status = pata_parport_check_altstatus(ap);
>>>>> +	if (status & ATA_BUSY)
>>>>> +		return;
>>>>> +
>>>>> +	/*
>>>>> +	 * There was a command running, we are no longer busy and we have
>>>>> +	 * no interrupt.
>>>>> +	 */
>>>>> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
>>>>> +	/* Run the host interrupt logic as if the interrupt had not been lost */
>>>>> +	ata_sff_port_intr(ap, qc);
>>>>> +}
>>>>
>>>>    As I said, ata_sff_lost_interrupt() could be used instead...
>>>
>>> It couldn't be used because it calls ata_sff_altstatus().
>>
>>    And? That one used to call the sff_check_altstatus() method (which you define)
>> even before my patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=03c0e84f9c1e166d57d06b04497e11205f48e9a8
> 
> OK, I was probably confused by ata_sff_check_status which uses ioread directly.
> 
>> [...]
>>>>> diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
>>>>> new file mode 100644
>>>>> index 000000000000..f1ba57bb319c
>>>>> --- /dev/null
>>>>> +++ b/include/linux/pata_parport.h
>>>>> @@ -0,0 +1,108 @@
>> [...]
>>>>> +static inline u16 pi_swab16(char *b, int k)
>>>>> +{
>>>>> +	union { u16 u; char t[2]; } r;
>>>>> +
>>>>> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
>>>>> +	return r.u;
>>>>> +}
>>>>> +
>>>>> +static inline u32 pi_swab32(char *b, int k)
>>>>> +{
>>>>> +	union { u32 u; char f[4]; } r;
>>>>> +
>>>>> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
>>>>> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
>>>>> +	return r.u;
>>>>
>>>>    Hey, I was serious about swab{16|32}p()! Please don't use home grown byte
>>>> swapping...
>>>
>>> This crap comes from old paride.h and we can't get rid of it without touching the protocol drivers
>>
>>    I don't argue about the *inline*s themselves, just about the ineffective code inside them.
>>
>>> (comm.c and kbic.c). Maybe use something like:
>>>
>>> #define pi_swab16(char *b, int k) 	swab16p((u16 *)&b[2 * k])
>>
>>> but I'm not sure it's equivalent on a big-endian machine.
>>
>>    These functions are endian-agnostic -- they swap always.
>>    If you only need to swab the bytes on big-endian machines, you should use cpu_to_le*() and/or
>> le*_to_cpu()...
> 
> swab16 swaps always but pi_swab16 does not on big-endian. It's probably a bug but doing the correct thing by accident. Other protocol drivers completely ignore endianness, probably because PARIDE was meant for x86 only.

Fix that. ATA/IDE uses little endian. So all command & replies fields
should be handled with put_unaligned_lexx()/get_unaligned_lexx(), or
cpu_to_lexx() and lexx_to_cpu().

> 
>> [...]
>>
>> MBR, Sergey
>>
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
