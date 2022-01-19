Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D529C4936CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352812AbiASJGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:06:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53005 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352806AbiASJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642583164; x=1674119164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CocAx8tlTLs37GwRSP9HoDppNe7iSxiXWXBeB57nyQ=;
  b=QZRk9DNNw2y7k2JslZVEPiD34eUm+7KzptShXyPHRUWNoNXGEqcI8cMI
   UwVVkCqTHDigV1CTRSGtJ9Zv+lZNCZJcO6ghNDOBEBwC6p/vPiS1xDmBQ
   JibOeUyIUjU3uJkdrTyhHZB7hSSx0E6uwVoICA6RAftiQS8sTc1UN0h0z
   M5Y5yxxah6UTPDp+ED8OBL9G0VmHpf6Ql9RsRZkV/epUdSFbnQgVambeR
   rBWH4RAlr/Hi8raU84aUNcN+eDrJ/HG6FjhLUEvP6gexKkjKtWE7kA6Na
   ko/Iz88qLroccSRXZzQx5Xn9Svf17+a2/73YH2wi1+BgmyLthl5EtxwEC
   A==;
X-IronPort-AV: E=Sophos;i="5.88,299,1635177600"; 
   d="scan'208";a="195628993"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2022 17:06:03 +0800
IronPort-SDR: WPChdXNsJDZcEPZTckc7EkZFur29ZcN2LhamQ4aSLxk1GTpeGJ0qCfq5bD471UXNcXtr8SwWT2
 5FczGyKIVpWPvIhvskYGDabhXNV6GfXXwsCWN2bh88jB4rKWP2LYAE7HdscX9efhIwRF5diVOR
 +VWl+3S/5XF9vCEozpENsV+k7ROkV9tqrGzRpXWeMIZ4q4DietIcffwwVA44ZiDV7iWcdhM3ai
 pLlXbEQMaF3KH8k1/VS9a1G2RVeB+VupvldXGudX9u7V/D8hCF6zWTEe5pBRqBAzXWc/S1i6jk
 oFZks4xMd1GkmxEC/2sz75SI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:39:32 -0800
IronPort-SDR: ZSOsCUu0G30AB65F2nSINSPvny05u1Vj8DPRSvyNmnAiwPrB5Newww/Jv+nae9o5e/rXDyASSk
 dIHLYjCDKnKbDUlTYsj0mPQiwuaylCsp16jqr5PYuHL8lX09YIaEguGcng41mIWMXm6tJS9xKE
 Nn8eqrkeJqxv3i1qU0jSdrb413+qB7l4XQ0jJL+hmULo/bF0tNE6FMI4SEs3IoQfXhrRYm1WAj
 Lngz8zgb4OJ7MKr8r7dXIlRStY79T42rDM3u4iMEDm45XK/4ob/uukU7be/nNM1sep2RsP87ts
 zpA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 01:06:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jf09j5Bxhz1SVny
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:06:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642583161; x=1645175162; bh=0CocAx8tlTLs37GwRSP9HoDppNe7iSxiXWX
        BeB57nyQ=; b=XsdieHxHC/4GAplLkJXyKj2FCVpFsEPmpaL1sYu5J6TxPT16IU/
        09rP+Lts2ZwOfEOLmn8jJKmv3yQTdQPZMBhZI9GUcbVNMX+R0cVEIq7nuQaYYrz9
        bhtQoTkbtuhmlEgQk/EfscGvy7KBS6jASQnGgjZrZUyN4+Bo+VHavht45vhYDI6L
        EhCQMj4nRZtLP2YVrSllvQFXbqt09sJBpXanjYkmhovfRJYg2LQWOyqMg88cAUIK
        smXn5OdkgxdFrB4e+lLJfmoCv8SrGAnTxX6bVK9GTNglM815rHm+C4LHQbjc0/oK
        sUOPtw9yPJ1v8Su8PD6S9uJn0IuiJzmTFhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
X-Spam-Flag: NO
X-Spam-Score: 2.653
X-Spam-Level: **
X-Spam-Status: No, score=2.653 tagged_above=2 required=6.2
        tests=[ALL_TRUSTED=-1, DKIM_ADSP_NXDOMAIN=0.8, NO_DNS_FOR_FROM=0.379,
        SORTED_RECIPS=2.474] autolearn=no autolearn_force=no
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uv5ax3aM9zqL for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jan 2022 01:06:01 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jf09h1sbbz1Rwrw;
        Wed, 19 Jan 2022 01:06:00 -0800 (PST)
Message-ID: <9f5428b2-4d36-29a1-ef1a-d544cec25bd7@opensource.wdc.com>
Date:   Wed, 19 Jan 2022 18:05:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drivers/scsi/csiostor: do not sleep with a spin lock held
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, zealci@zte.com.cn
References: <f68657d6-027c-c842-ce35-5524cd782c7e@opensource.wdc.com>
 <20220119085754.932168-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220119085754.932168-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 17:57, cgel.zte@gmail.com wrote:
> 
> The might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM) in the 
> mempool_alloc function uses __GFP_DIRECT_RECLAIM.

But the call to mempool_alloc() specifies GFP_ATOMIC, which does not
have __GFP_DIRECT_RECLAIM, so "gfp_mask & __GFP_DIRECT_RECLAIM" should
be false, and the might_sleep_if() not triggering. How can you see the
might sleep warning ?

-- 
Damien Le Moal
Western Digital Research
