Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A224840ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiADLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:34:30 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59601 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232340AbiADLe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:34:27 -0500
Received: from [192.168.0.3] (ip5f5aecde.dynamic.kabel-deutschland.de [95.90.236.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EE73661E5FE02;
        Tue,  4 Jan 2022 12:34:24 +0100 (CET)
Message-ID: <66edbfd4-063f-b995-0d15-982d365dd7d7@molgen.mpg.de>
Date:   Tue, 4 Jan 2022 12:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: ata: For what PHY was debounce delay introduced? (was: [PATCH v3 3/3]
 ahci: AMD A85 FCH (Hudson D4): Skip 200 ms debounce delay in
 `sata_link_resume()`)
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Garzik <jeff@bloq.com>, Tejun Heo <tj@kernel.org>
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
 <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
 <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
 <c6748a52-fc8f-3309-31c2-973a9e69a7e8@opensource.wdc.com>
 <33deca4a-abed-123c-9530-3f15740a3261@molgen.mpg.de>
 <27da2f5c-ca6c-1d64-3d05-5453f11e298f@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <27da2f5c-ca6c-1d64-3d05-5453f11e298f@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc: +jeff, +tejun]

Dear Damien,


Am 04.01.22 um 10:08 schrieb Damien Le Moal:
> On 1/4/22 17:49, Paul Menzel wrote:
>> [cc: -dmitry, -guenter]

>> Am 04.01.22 um 09:36 schrieb Damien Le Moal:
>>> On 12/31/21 16:08, Paul Menzel wrote:
>>
>>>> Am 31.12.21 um 01:52 schrieb Damien Le Moal:
>>>>> On 12/30/21 20:08, Paul Menzel wrote:

[…]

Jeff, Tejun, in `drivers/ata/libata-sata.c` contains a 200 ms sleep 
delaying the boot noticeably for optimized setups, where Linux takes 
less than 500 ms to start:

```
int sata_link_resume(struct ata_link *link, const unsigned long *params,
                      unsigned long deadline)
{
[…]
         /*
          * Writes to SControl sometimes get ignored under certain
          * controllers (ata_piix SIDPR).  Make sure DET actually is
          * cleared.
          */
         do {
                 scontrol = (scontrol & 0x0f0) | 0x300;
                 if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
                         return rc;
                 /*
                  * Some PHYs react badly if SStatus is pounded
                  * immediately after resuming.  Delay 200ms before
                  * debouncing.
                  */
                 if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
                         ata_msleep(link->ap, 200);

                 /* is SControl restored correctly? */
                 if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
                         return rc;
         } while ((scontrol & 0xf0f) != 0x300 && --tries);
[…]
}
```

>>> It would indeed be great to have the default as "no delay on resume" and
>>> add the delay only for chipsets that need it. However, it is unclear
>>> which chipset need the delay, right?
>>
>> Yes, it’s unclear for what chipset (PHY?) it was added, as the git
>> history i not available in the repository, and I have not found it yet.

I found the historical git archive [2], and Jeff’s commit 4effb658a0 
from October 2003 [3] with the commit message

> [libata] Merge Serial ATA core, and drivers for:
> 
> Intel ICH5 (production)
> ServerWorks / Apple K2 (beta)
> VIA (beta)
> Silicon Image 3112 (broken!)
> Various Promise (alpha/beta)

adds the code below:

```
void sata_phy_reset(struct ata_port *ap)
{
[…]
	/* wait for phy to become ready, if necessary */
	do {
		msleep(200);
		sstatus = scr_read(ap, SCR_STATUS);
		if ((sstatus & 0xf) != 1)
			break;
	} while (time_before(jiffies, timeout));
[…]
}
```

Later on Tejun refactored the code in commit d7bb4cc75759 ([PATCH] 
libata-hp-prep: implement sata_phy_debounce()) [4], and clarified the 
comment.

(Sorry, if I mis-analyzed anything.)

Jeff, Tejun, do you know, what chipsets/PHYs had trouble with being 
queried right away? Only ata_piix?

>>> So I think we are stuck with switching chipsets to "no delay" one by
>>> one by testing. Once the majority of drivers are converted, we can
>>> reverse the default to be "no delay" and mark untested drivers as
>>> needing the delay.
>>
>> For easy testing, a new CLI parameter to skip the delay might be handy.
> 
> You mean a sysfs attribute may be ?
> I am not sure it would help: on resume, the sysfs attributes would be
> recreated and get the default value, not a new one.

No, I mean a module parameter for `libata` like `ata_probe_timeout`. 
Then users could test it during boot, and, if there are no issue, tell 
us the ID.


Kind regards,

Paul


>>>> [1]: https://lore.kernel.org/linux-ide/20211227162658.11314-2-pmenzel@molgen.mpg.de/T/#m697d2121463a4c946730e6b83940e12d6d7e6700
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=4effb658a0f800e159c29a2d881cac76c326087a
[4]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7bb4cc7575929a60b0a718daa1bce87bea9a9cc
