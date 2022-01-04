Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B25484A02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiADVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:41:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:22400 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbiADVlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641332462; x=1672868462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V5GBLO28HA1qHefPgttUTWzbts5Zi2s1QaOWvDNcSqc=;
  b=aGYaJ1ZoMB5hPYc1xoNM/qSEaLRg8qy9pMEvW3BWgqnRg1VrJWftfPB6
   YP17zmOL5lp1JGvha82qaaFvn/9pPL9P6JvG/DUv18NhDUixE7ILVDIqW
   FEkWt3O0aS/629iXE/igMKx7TQ7ACoO7pjzj9K9Pr1l6hlU7o0bCJvFtN
   ZAM8WhBC+W1WS23ZgLjefiA8n1prctEObMWmg7vfa2A9SClol/jEGPEx+
   /ND9h3aC7pkyukGK2N3pQFH48zLMzpF6FUSbx0a2NBOZ6gIgV8GoJETTP
   dLpvNBFp8MXlRio3ZK+XSaxz+Lc/bIjuBzmr9w9d8lt5f0D4gDmZ7Ye+9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222980236"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="222980236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 13:41:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="611227532"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.114.22]) ([10.212.114.22])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 13:41:01 -0800
Message-ID: <36975790-c9f8-a6f6-cbc2-493da4bdd8c1@intel.com>
Date:   Tue, 4 Jan 2022 14:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
References: <20211214172437.1552740-1-broonie@kernel.org>
 <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/28/2021 2:09 AM, Geert Uytterhoeven wrote:
> On Wed, Dec 15, 2021 at 10:53 AM <broonie@kernel.org> wrote:
>> Today's linux-next merge of the dmaengine tree got a conflict in:
>>
>>    drivers/dma/idxd/submit.c
>>
>> between commit:
>>
>>    8affd8a4b5ce3 ("dmaengine: idxd: fix missed completion on abort path")
>>
>> from the dmaengine-fixes tree and commit:
>>
>>    5d78abb6fbc97 ("dmaengine: idxd: rework descriptor free path on failure")
>>
>> from the dmaengine tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> diff --cc drivers/dma/idxd/submit.c
>> index 83452fbbb168b,569815a84e95b..0000000000000
>> --- a/drivers/dma/idxd/submit.c
>> +++ b/drivers/dma/idxd/submit.c
>> @@@ -134,20 -120,32 +125,43 @@@ static void llist_abort_desc(struct idx
>>          spin_unlock(&ie->list_lock);
>>
>>          if (found)
>> -               complete_desc(found, IDXD_COMPLETE_ABORT);
>> +               idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
>>   +
>>   +      /*
>> -        * complete_desc() will return desc to allocator and the desc can be
>> -        * acquired by a different process and the desc->list can be modified.
>> -        * Delete desc from list so the list trasversing does not get corrupted
>> -        * by the other process.
>> ++       * completing the descriptor will return desc to allocator and
>> ++       * the desc can be acquired by a different process and the
>> ++       * desc->list can be modified.  Delete desc from list so the
>> ++       * list trasversing does not get corrupted by the other process.
> traversing
>
>>   +       */
>>   +      list_for_each_entry_safe(d, t, &flist, list) {
>>   +              list_del_init(&d->list);
>> -               complete_desc(d, IDXD_COMPLETE_NORMAL);
>> ++              idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);
> Is "false" correct here?

Hi Geert, took a closer look today. I believe it should be 'true' here 
since this is a normal completion that needs to release the descriptors. 
Sorry about the previous incorrect response.



>
>>   +      }
>>    }
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
