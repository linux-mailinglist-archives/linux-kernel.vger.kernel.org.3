Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F0468E35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbhLFAQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:16:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63162 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638749573; x=1670285573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ig3CsQ706VJS7oMzcOdUVXhHe7TPSG5xETLn6mphDY4=;
  b=kCKbGqEtT2TePGMS7nP6QmcIQb9Wv01cjrgmGL227cwSTiXrN5a2BbPG
   gIHndKQzLquN5R4DdxfPo74Prxjo1NMRoI/ETWMEdzTiEFrEe49ehHxZq
   znr3Cv9ZQQvzbzVLVuHjoojT/maCSPgzrMc7RZ4wz/Flxykad31kIH2UI
   4UhX9U0nrpqk8JqMswcIgpRNX9bKUJQsjmRNbmc8MSqqY4/2XgFqGlNQH
   RaFloeF1HGo1u6JM0AHhC38T2HMQ6TO3fsIGaMyrN9ZxPTol4MzOgg9gN
   aQpfqRPasOLyMcqsgGmq95LUBwScx02Ip9WQxnuRETyoXjkBHwtIxRrgS
   g==;
X-IronPort-AV: E=Sophos;i="5.87,290,1631548800"; 
   d="scan'208";a="192291903"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2021 08:12:52 +0800
IronPort-SDR: 2KFlVAFY02a103VQuztr8x9Pjbp223gq5ZZscF+IrTGlT37bNd/YovCr8juo4BXKDcK9ayenBf
 Su7nWxUuit17uAPyRdXM4Xw9JcIj3huV9itGWqvXoQlYbPxSW5xOS7wI7Nm7ZUp71nOzwojy+P
 VPgKpnekr4QbgE+No6ORGMLqCakA2mXEbSAgNToeRjYCVKwUaf7h8vvplzRr9x+oSnWCCRskPp
 WP++eR01ph/lg+3nowCx/BdfpLuM9/Jv2HNPLNJ0eNmPVUUkqm/sQ4/ukG4iROEFOFncrBbh6/
 LJMuvySt5nIWwe3PjGS5oMbi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 15:46:01 -0800
IronPort-SDR: zRlV4vfCgHYD0s1se6mHWNlcVbKBbAveRu87XEKJj7APHlhJhlLmHjALH0lMmzCPGEV1bGkXOG
 MJzTqj8hbapqeSbV6JbBvk/KtPGiL5VLe4TLqHnLgVo9YqJCC7kFBrHpxAEzWp9Zav2lWm1Ca7
 HBIurF+cbrY6PY+IU+sAk7zM7Kr/6bkyAT0Sgyl8HpgxDG0/V1CBMQ9wUzF0PT0+CA4KZt04Tg
 gYAJfenlzZqefnQ4nuyC9x9Y9gtXlvwopzPZR5T9M/h63Pae963gkuWOGNqu6P3OCvcGvq9CAt
 emI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 16:12:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J6kQt0kd8z1RvTh
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 16:12:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638749573; x=1641341574; bh=Ig3CsQ706VJS7oMzcOdUVXhHe7TPSG5xETL
        n6mphDY4=; b=TkZDTVSDEbA6Z5CnGV8rv5uz+/PfjnNwCJrTUy7SzsM9DDW5CNK
        YFRRG6UbZybBS3OBy1ihB2AcKQBihxTiggdzDUh0kzS1Caaiigj5L8T5DPtfS+Tx
        +JNyrbPsdl+MEic5ZDthmpDtSmfD0Y3SOalzoF8SWE2sK4iWf6/IDanvrdnhtni/
        t2RWjC8ZI11LLe+IbjYqMH2X0VgEHCH1FC1oqFynlIv4RAEr3puo7SUPKYQoDL64
        C6avVwhWDKZRMIXLMbauLfX8Vd8prrHEiJxE4zCQyLTW8cRSFSpevH9tCfFvy/Tg
        KVP121APEJRb2aAnmHWv1w1mt9wpvIeh3gA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HkgXthwCqL-V for <linux-kernel@vger.kernel.org>;
        Sun,  5 Dec 2021 16:12:53 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J6kQr13SXz1RtVG;
        Sun,  5 Dec 2021 16:12:51 -0800 (PST)
Message-ID: <022c3fad-ca0b-50c9-79f7-2bfa3de75a0d@opensource.wdc.com>
Date:   Mon, 6 Dec 2021 09:12:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: Need help to debug ata errors
Content-Language: en-US
To:     Ayan Kumar Halder <ayan.kumar.halder@xilinx.com>,
        linux-ide@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <df61e958-7bd6-94df-0da2-56aa1084350d@xilinx.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <df61e958-7bd6-94df-0da2-56aa1084350d@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/03 20:11, Ayan Kumar Halder wrote:
> Hi All,
> 
> I am trying to run linux as a DomU guest on Xen with AHCI assigned to it.
> I can confirm that SATA works (ie able to detect sdb) as a Dom0 guest. 
> However, it does not work as a DomU guest.
> 
> Hardware :- ZCU102 board and it has two sata ports
> Kernel :- 5.10
> 
> I have enabled the debug logs in drivers/ata
> 
> 1. Logs from dom0 (where SATA works) https://pastebin.com/2BhMDq47
> 2. Logs from domU (where SATA does not work) https://pastebin.com/fE8WZnZ0
> 
> Can some help me to answer these questions
> 1. What does this mean "1st FIS failed" ?
> 
> 2. In the dom0 logs, PORT_SCR_ERR = 0x41d0002 whereas in domU logs, 
> PORT_SCR_ERR = 0. Does it give some hints ?
> 
> 3. Any other issues or hints to debug this ?
> 
> I can confirm that in domU scenario, we do not get any interrupts from 
> the device. What might be going wrong here ?

That would be the first thing to check since without interrupts you will not get
any command completion. Commands will timeout and probe will not work.
And this IRQ problem is Xen territory, not ata.

The 1st FIS failed error may be due to some problems with AHCI PCI bar/register
accesses, which may not be working. This I think points again to Xen setup with
domU, which may not have the necessary access rights to get IRQ and PCI bar
accesses ? (I have no experience with Xen)

> 
> Thanks in advance.
> 
> Kind regards,
> Ayan
> 


-- 
Damien Le Moal
Western Digital Research
