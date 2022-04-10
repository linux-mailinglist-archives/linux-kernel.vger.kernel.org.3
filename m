Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455D4FB0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiDJXzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiDJXzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:55:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0325B16
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649634814; x=1681170814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+DqBwEiVFGUWEIGkaKU1IdGh45+LshzBk947/RGzAzA=;
  b=IW6+m1ONy91ci1Heq0ugZjMJDss3XaLnRiNtBmtOE6Y7+YtOr9avGSzN
   ST4ScXaBc7fdKsK2mX0lqgivbMRDWGwoG98AoVAapI0vqXa4Fi/q39O5y
   jCQleFnXAfexotScQ7hAhSRQUXGYq/gA0kiH59DiZnZZOCX4rmSATEK5G
   lohRm6fCLJ2ZFm+/ftsthSqXz4DPlEX3QFVC8rcm5KtZ0UgUtTgff+uo6
   gTAg9VnBtA+y1FxtiZmNp+xTEZJOo6iUmT/bubGjkqpEWUh20Dltth/Qv
   9dDdihZELT38YAlT3qCgQ11jTU8SrCSFaFffv06U6XzRAE6ywa5uZ1FvQ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,250,1643644800"; 
   d="scan'208";a="198470635"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 07:53:33 +0800
IronPort-SDR: L3lZoWV6DwyR85+9xWyYLfJjhp6OZuHimoBhxIMZkUAX9s1qhOyM218zogZlyGb5R5IBfi0gzY
 IkfO2wmN83Pk9E2pPtt6l2nn1wE8Vyfb7WR9zGc7E3qcNEJx8wdm5XfADyqXh7stwHQMgNlRVu
 rViskp8E1t4ViW7N68rDc4UhKyhtHNUiM3l2rUD5OlACySMBsLk+9QB8MIN3NhbAGZIpWYOo26
 ZFFNu7dWuUsqZpPFLkn7ZrZGBaIp8ek0Jr/D0nalRfHKM3CgJIW6Hq2/1LC1laBEwp6iWdYfI9
 la9GSvFq9LKFa8Uk0/Mkuncs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2022 16:24:02 -0700
IronPort-SDR: jA/8yFTQp1tDbGLEO6owpNSHUvySvi459nqz5VLNt8RjIR7W3o1p6Y9o4AOeyKgpfAr4zw6ZSX
 aOruoISIOZQsJ4sqks0e3uyYBwbXBcEmdr5Zv1rZankSZkmIV1QUMlfg4n+UYcHOx/dWV/rzha
 MD5J/aQye7iBY6D0KJ5Xm9MCv1cvjTAgiwt3NMqjwp7QOrrNzcKXSeSxU8Ps4z3uwcZhaVHqEI
 aGV43mRb+8QGyH290l3eGcVzBva9q3SMzirYxchX84ZOgZDIeZR+SBf3cCgXfDi5nxnaN4EoEZ
 sig=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2022 16:53:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kc82N0xdKz1SHwl
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 16:53:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649634811; x=1652226812; bh=+DqBwEiVFGUWEIGkaKU1IdGh45+LshzBk94
        7/RGzAzA=; b=HUp1Qjhln5j5KowlHmgcmxmREQyKPqpJhnXwbTI4DYkB8tCHTLp
        3tQdR9aOLKn9IXzMcKdCdOIVrb/kRZI32mdJUfqN7lOXG5NChK4/JLOIGBZZJcTd
        dIGnmCdUUR2+NbPdEgfhbrRy1/7gZKeaNMCfBE5lUULVOWkLVI3Bglsx59VUNGov
        b9MzNCNxdHGcRXhjtAdk57JWtd7/nfWBz3EsbF2Norc07owRmGGLyOYJxO8UBlEe
        HTMlgi+jhhhUFdWOOQe/AM9Z52u7BSW2Jhq9ncsec97Lh1K9ZE2NJ9rhqAPD/5nC
        rwHB2Hjn76MQOHQrmh8pt+7FpprJzdAnd0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8ZX73EQJ_TIX for <linux-kernel@vger.kernel.org>;
        Sun, 10 Apr 2022 16:53:31 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kc82M0fBhz1Rvlx;
        Sun, 10 Apr 2022 16:53:30 -0700 (PDT)
Message-ID: <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
Date:   Mon, 11 Apr 2022 08:53:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 15:30, Zheyu Ma wrote:
> Hello,
> 
> I found a bug in the pata_marvell module.
> When probing the driver, it seems to trigger the error path and
> executes the function marvell_cable_detect(), but the
> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.

I do not have this hardware so I cannot debug this. Please debug it and
send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
drivers set it manually in their probe functions. No idea about the
marvell driver, I have not checked it.

> 
> The following log can reveal it:
> 
> [    3.453943] Bad IO access at port 0x1 (return inb(port))
> [    3.454430] WARNING: CPU: 7 PID: 291 at lib/iomap.c:44 ioread8+0x4a/0x60
> [    3.457962] RIP: 0010:ioread8+0x4a/0x60
> [    3.466362] Call Trace:
> [    3.466572]  <TASK>
> [    3.466756]  marvell_cable_detect+0xad/0xf0 [pata_marvell]
> [    3.467699]  ata_eh_recover+0x3520/0x6cc0
> [    3.473262]  ata_do_eh+0x49/0x3c0
> [    3.473906]  ata_scsi_port_error_handler+0xd96/0x1d00
> [    3.474355]  ata_scsi_error+0x243/0x290
> [    3.475428]  scsi_error_handler+0x2ff/0xea0
> [    3.477244]  kthread+0x262/0x2e0


-- 
Damien Le Moal
Western Digital Research
