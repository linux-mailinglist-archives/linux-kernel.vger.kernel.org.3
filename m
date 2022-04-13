Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305F4FEDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiDMDos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiDMDop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:44:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BB2716D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649821345; x=1681357345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4cMtm8gzKr8femcwqZ9TWB6EmgLUbPVxA3RSWnKB4tk=;
  b=i9+ic87eFHFZL8HItnRf+Vf3HnuhlYTtDLFtZqi0b7+pyvsW5K0WfPsi
   yhqeoJbaz7s1KU+/yD2KafpRfybygB6i4SKj5WCGfmPmuSc6354vMUqt/
   NGkEEkzKeLOy6JJ5AIP7nownrzS0aIUETnarL4f/pnHfxGKV3vCaTTfhe
   im7oeRGby1PYSEnWE9V8Yttjfdo4rayHjKhnxyhxDJfKh53qiOls62R7M
   1o/T8nJE97omyGdy5YKOtJjCKtO7H79eFE5ETidxX+YvQRdlYOequ30kh
   28fP6Wxb9S4ChRT0RHhemhleBiLvrD/VjZzo77Pa4gqFwNEfUfPvVdWYf
   A==;
X-IronPort-AV: E=Sophos;i="5.90,255,1643644800"; 
   d="scan'208";a="197788236"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 11:42:22 +0800
IronPort-SDR: vKpEJXspHjgSzB7MRmlCjVsPB87wqUaUTrUtyvA1l1AjANce2PQGtE+LprWFSVGvYpLyrTsP43
 FVI6I8ry0rXKML+/ETFQlFGa4dX+GudCCJAZV4DPiX9tSCvVO6DGmSKwUidETM9aZEUDHVKvLb
 dFHHgDGtaWngflH5nEK0d6x9oj6SkrmvSbIhw/Ykz8gvRZa7RX0leQJyVlJpJwDNBRny6VWLMR
 8XpknYeEzLvRK3XfvZYdGivaC8+5iFjdOZTJopqaLn3qkzA0h882vNA4rSGStU3++20NiDD1Hh
 enKULmlc0hU1CebsbK0Kt9du
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:12:51 -0700
IronPort-SDR: /+2qvExhjsRPO9OjJVKulVi5vnI+b8yv8FV7UmmeSwaSE4mUeSyOiEMFMFSrBuwnF4oGh3N1d7
 lyLpEmMKp0tUrDsJW61JDcy/NPyMbeI7DcBod9DitN8ytYYV2kmMZLmkrDmD5NufwNh/u0hYyo
 rKEHAMf0GmpAkz67hlh+P3woTcnY0tTSxWbzVjZr3EtB63m+Sb0iz1nhd+dhvmmablPVBrYu0L
 66HsT0l+XHES69p+Iea9da+nAVD8iKv2ZPeEoLQZ6K3vrdXpPjQfVUDCHBf4KVmoQJb7tusAJe
 KSg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:42:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdT1W0KZfz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:42:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649821342; x=1652413343; bh=4cMtm8gzKr8femcwqZ9TWB6EmgLUbPVxA3R
        SWnKB4tk=; b=Oyuc6f80kFGcjEq/dmN9Z1pG5yi/rIzOOco3WRgCZn38uJc2jBr
        Am5fPeMXkYrbZfBsnutmsnVcE3DBo2ZlusPsPAzeZNLyY25AWnmar0HH1U2Y9GTu
        SGaQEWhFL7RL6LuqXvgiDNiLLq+E4jDEizwldkpL+8QaulVAITziu4zlOlpBsJWa
        zeMbU4ZJCA4fUtoLRG3ruPCj1nn3qiGFEpoE+q1L5P1f6AWxeEJn0EykJazh7Aws
        kweeqL/z4ZF20EEQPHuakiZ4J1yEfdRjmqg22vdiNsVs55D4o0bOBNEdfyzjIAY0
        /g3ILjM79uHT1zB8s5ecbWvijwU9c6ww4+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id phQKVP55ZOnM for <linux-kernel@vger.kernel.org>;
        Tue, 12 Apr 2022 20:42:22 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdT1T6ckfz1Rvlx;
        Tue, 12 Apr 2022 20:42:21 -0700 (PDT)
Message-ID: <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 12:42:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
 <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 15:34, Zheyu Ma wrote:
> On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 4/10/22 15:30, Zheyu Ma wrote:
>>> Hello,
>>>
>>> I found a bug in the pata_marvell module.
>>> When probing the driver, it seems to trigger the error path and
>>> executes the function marvell_cable_detect(), but the
>>> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
>>
>> I do not have this hardware so I cannot debug this. Please debug it and
>> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
>> drivers set it manually in their probe functions. No idea about the
>> marvell driver, I have not checked it.
> 
> To be honest I don't have a good solution to this problem, because
> other drivers don't have similar behavior. The marvell driver doesn't
> even initialize 'bmdma_addr' before calling 'cable_detect'.

Then this is the bug that needs to be fixed, no ?

> So a simple idea I have is to check if 'bmdma_addr' is 0 before
> reading it and if so return the error code ATA_CBL_NONE.

And if indeed, even after it is initialized it is still 0, then yes, this
change seems sensible.

> 
> Zheyu Ma


-- 
Damien Le Moal
Western Digital Research
