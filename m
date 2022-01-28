Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9F49F3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbiA1GhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:37:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56702 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiA1GhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643351839; x=1674887839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f0aF2YEl6Gt/wfhd0sYDp8dpaOwGv98M9EizSp2BmQQ=;
  b=YA+ZG7jr2Oyw4Dq89ooxf1HWAGss85JuH9LQfUdLc4W2MKOUH4yGiLpe
   /d0siUBosyx1S1nRuRNGbc3JW7JfTnvbIg82eugs2zQ6d2GGTHw7PdgZk
   SsO4h3BCyvvQfsc0Vh7XlYFOmrTDIGLq2/MjdO2J/dw19tSqmnvVkvnvv
   gLUjsunlHzD/tJJaNHqGJc/0GRn42Cg16iZBoNoVJ4jNTn8MpoVyU6C3r
   H6oolQruaHayLRdOsriL8wkL6+MHfpOKMeAgy2JmERh3GoXo7kXgwi6Ky
   n57Fnt0cZ3S+Ewy6i7mBuP2VZ3c/PSW1oiKYCkyrMexHGmSIzDtvng92K
   w==;
X-IronPort-AV: E=Sophos;i="5.88,322,1635177600"; 
   d="scan'208";a="191604890"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 14:37:18 +0800
IronPort-SDR: 3nBG/efeQOInlrGmte0/CdAMu019dhG+FssHcxM3m1JGYRz9MhRP/BVXzVId1lcvkf1/dVS0ci
 9WlVe9WdfpKu2/f0x8Sz16MvNrm5AxBFa2WKLy37yqEVL4fTAV8Hb2hAICYk9EEbsZGpTSqeDx
 5rkh6EUzYKiOc5bVo3xfDLRCiiqLAWgGFzS617sdFdH+upy0KOx36SR1O1//8mgHVR8K+5V3iu
 a+H4y72ojvqpSnnY+R/+W7YP5TbjcvFFhe924roYliqYmd5oWD4ECOhwwJBY+Hc1cskwSvF9Xy
 5mnZR1OdPtTd6c1H1rdnFzbI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 22:09:22 -0800
IronPort-SDR: bwVTF43FIm2Cp1S4rMtm2ymCzeQNbnudFSqy85mEgGyFfGFDmPL33nBc/uFRki4LPsNHbGbeS4
 em5zAplTnyxrAkBrv9uBVlyMgOh0xKWY8+aU/3Rg1RvFU3iSdIqZf2ypJNUu/DpOdmVq+S5ovy
 JgJwroIbIbUpgOmJe7znVVwvDw25AAc7cFmjhbIxCw/e3jqKmqLbiH2d3cLW8JlONrbCXYQFMa
 gwWgcgn+LFCr+Fr+D4g7UPnlARkOB4YUPMSmi0hLgGm419LeGzZJwR7hbbzwiR9nc8Figryh19
 B6w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 22:37:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlSRy0Lvzz1SVp1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:37:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643351836; x=1645943837; bh=f0aF2YEl6Gt/wfhd0sYDp8dpaOwGv98M9Ei
        zSp2BmQQ=; b=XEi1HUevJFY1ebQbnLto/b104r8EQiiVKHCfIY19aA33c+unTOv
        WjWYNoPYoUu8Qj+2mlsCzEaNbKP7bcz23LCZ3eN/HTAUdGK7Rs9Z8Hh+krOaZ0/U
        L5y834TR/uGVlT7Wqb8Qk9l6N7xNd/5Fn2zK0yivroQUAqmo2GlvNymFyv3vnOYf
        A39qH502asHYRioyeQOOQLagcmhTOAEGmiapUlqzc98SRbyc36IX6bc1DgeG6yl7
        B5vXLeUEFPLdbE+Dtq/Lto24/MsDIgW1cPKTyo79R04n8/GGQbGaxw4yxAPnip+a
        lOgaFlPpAI0y7qoOEGOW630qBTB8Tiwqfbw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nCYpzNniNCmL for <linux-kernel@vger.kernel.org>;
        Thu, 27 Jan 2022 22:37:16 -0800 (PST)
Received: from [10.225.163.58] (unknown [10.225.163.58])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlSRt5W1bz1RvlN;
        Thu, 27 Jan 2022 22:37:14 -0800 (PST)
Message-ID: <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
Date:   Fri, 28 Jan 2022 15:37:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com,
        Ajish.Koshy@microchip.com
Cc:     yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 19:17, John Garry wrote:
> On 27/01/2022 06:37, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>> I did some light testing of this series (boot + some fio runs) and
>> everything looks good using my "ATTO Technology, Inc. ExpressSAS 12Gb/s
>> SAS/SATA HBA (rev 06)" HBA (x86_64 host).
> 
> Yeah, unfortunately these steps prob won't exercise much of the code 
> changes here since I figure error handling would not kick in.
> 
> However using this same adapter type on my arm64 system has error 
> handling kick in almost straight away - and the handling looks sane. A 
> silver lining, I suppose ..

I ran some more tests. In particular, I ran libzbc compliance tests on a
20TB SMR drives. All tests pass with 5.17-rc1, but after applying your
series, I see command timeout that take forever to recover from, with
the drive revalidation failing after that.

[  385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[  385.108026] sas: sas_scsi_find_task: aborting task 0x000000007068ed73
[  405.561099] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
timeout.
[  405.568236] sas: sas_scsi_find_task: task 0x000000007068ed73 is aborted
[  405.574930] sas: sas_eh_handle_sas_errors: task 0x000000007068ed73 is
aborted
[  411.192602] ata21.00: qc timeout (cmd 0xec)
[  431.672122] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
timeout.
[  431.679282] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  431.685544] ata21.00: revalidation failed (errno=-5)
[  441.911948] ata21.00: qc timeout (cmd 0xec)
[  462.391545] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
timeout.
[  462.398696] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  462.404992] ata21.00: revalidation failed (errno=-5)
[  492.598769] ata21.00: qc timeout (cmd 0xec)
...

So there is a problem. Need to dig into this. I see this issue only with
libzbc passthrough tests. fio runs with libaio are fine.

>> And sparse/make C=1 complains about:
>>
>> drivers/scsi/libsas/sas_port.c:77:13: warning: context imbalance in
>> 'sas_form_port' - different lock contexts for basic block
> 
> I think it's talking about the port->phy_list_lock usage - it prob 
> doesn't like segments where we fall out a loop with the lock held (which 
> was grabbed in the loop). Anyway it looks ok. Maybe we can improve this.
> 
>>
>> But I have not checked if it is something that your series touch.
>>
>> And there is a ton of complaints about __le32 use in the pm80xx code...
>> I can try to have a look at these if you want, on top of your series.
> 
> I really need to get make C=1 working for me - it segfaults in any env I 
> have :(

I now have a 12 patch series that fixes *all* the sparse warnings. Some
of the fixes were trivial, but most of them are simply hard bugs with
the handling of le32 struct field values. There is no way that this
driver is working as-is on big-endian machines. Some calculations are
actually done using cpu_to_le32() values !

But even though these fixes should have essentially no effect on
little-endian x86_64, with my series applied, I see the same command
timeout problem as with your libsas update, and both series together
result in the same timeout issue too.

So it looks like "fixing" the code actually is revealing some other bug
that was previously hidden... This will take some time to debug.

Another problem I noticed: doing "rmmod pm80xx; modprobe pm80xx" result
in a failure of device scans. I get loops of "link is slow to respond
->reset". For the above tests, I had to reboot every time I changed the
driver module code. Another thing to look at.

Will try to spend some more time on this next week.

Cheers.


> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
