Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64D551128
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiFTHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiFTHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:14:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141DE089
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655709269; x=1687245269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LQCjkc8AWo140OOvRLywKCQJ1P+ERh6S+u9P0Z4sSUA=;
  b=oSIpz1gJWz/nkKeSUBNj++vfT5+O3wu6ypaiW2aMPGwgFjvoSxF0igyn
   kv+usNIlTUXgfP4Nv5w7lBzXGBb/cpTQRupfEnc+ku8HrwiLI9EvLK/jw
   w+aLNS5/zFilnvvezSa8YvpnTqwWlobRCcynyO11Xlv6TslreipN+9elT
   RzA+h0jEXMvp+DuAOMmekuKkQGwnZRvbRnqGiaREpqOBQ8niEHf/ZPuRn
   fkVsqGs03IozClShf4PENkUQnt+vdIJ75ZOEYAK6/JW/lbJhOCUrQRtT+
   zOHk6vkyRZY3Q41Vi9QwFAkpPBZB0+zgjXy3aj7Er/Xgg1Y94ndBq2y8l
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202304787"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 15:14:27 +0800
IronPort-SDR: rfBHtfmP01uE6vUxksP/akP8ecefZJvbH2fu15IWUb2yv+EfNleFOXYDVQqXcIrFCNU3I2vz/A
 eDoaMcrSsBZowzyc/PbenSftforSZ48gmSfNbwktz4eZXmXvv/FpJcQcKQUIPfRixgDwXVeOP9
 dwE/+ZSkSJDDTxYDrjxm3TzuFqNryhi/fRdb8i6TGw08eDkG63CcCaPTsU3Xf9DdxXVAIHeLFV
 RghMpEPQdbwwWxzs1jiVEtFlgAQZ9mhh0/3iWu/CJJEtKjQ/nLJodPVEjrMFuHMn+/58ogrzJa
 57bR+mJi+8jRzo1OFBk1WMfg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 23:32:36 -0700
IronPort-SDR: AqckFeSuzkabvBjzCs6He42spYjlZhkENd8UfhH3pJzkqIQjcX5K3nAMSSBho0d9CILlphKZb/
 OqkvTtEfn+hmZB4E9Ix1ql8Fq8lC5WaZirExAEhsDnQVHNDbIN9lSClr76ryWTMtHDPsjR3op8
 GQcsPOXMmgkur4jg4Fkd8w/f+6tQ9LlnsFUV82nnd0KzxYnLiOBa8Uu9KoKTi/WUBrBTTrPuml
 9e8qcsY+yU8VjdfTuUq+uQdmGDgUzWV6VoJytNKDAuJap8VwbsM9rB5Eve5kqlBiTDa3DZmh9S
 Hqg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 00:14:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRLVp6XhRz1SVp3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:14:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655709266; x=1658301267; bh=LQCjkc8AWo140OOvRLywKCQJ1P+ERh6S+u9
        P0Z4sSUA=; b=hE5C4cse7H91CDizGdPcKqgBtuJyeKrdEbOK7pIEVMhmK97zrbm
        8JTGvYQZyWz1G1I1xUTLjnlnlfeOrXnJIwoo5e1HuuFJAvcnXQftMBqsejWeaaI9
        fab1VyHXwfUOI0eD9ZnvCwGcEqytsrLglQGPnDEXyHVNYtuqRY5vw8aSZ7XQ5rUP
        bDHGCNqN8zVuT4Ucbui2ay/o2LGdEroUGsTuH+y+TngDG6vHuQe6iQl7vS4VgBJK
        AiRDbvcHTnTHUTeqBb7UFAdcT1uCwhnO/APJVCLVl3zLN10czwgguiwzty4IWiYZ
        kdyC79lCAIyMrJ2j5HPFi7rf9tyeBpUV6jQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fYrW-yYwPSei for <linux-kernel@vger.kernel.org>;
        Mon, 20 Jun 2022 00:14:26 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRLVm18lkz1Rvlc;
        Mon, 20 Jun 2022 00:14:24 -0700 (PDT)
Message-ID: <113c8918-1d11-b3e0-0435-19405d103e0c@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 16:14:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
 <20220620062828.GA10753@lst.de>
 <2ea41701-8be5-f981-d178-0d8e703962e0@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2ea41701-8be5-f981-d178-0d8e703962e0@suse.de>
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

On 6/20/22 16:03, Hannes Reinecke wrote:
> On 6/20/22 08:28, Christoph Hellwig wrote:
>> On Mon, Jun 20, 2022 at 08:24:24AM +0200, Hannes Reinecke wrote:
>>> So my idea for SATA is simply _not_ to use reserved tags.
>>> Any TMF functions (or the equivalent thereof) should always be sent as
>>> non-NCQ commands. And when doing so we're back to QD=1 on SATA anyway, so
>>> there _must_ be tags available. Consequently the main reason for having
>>> reserved tags (namely to guarantee that tags are available for TMF) doesn't
>>> apply here.
>>
>> At least in the non-elevator case (which includes all passthrough I/O)
>> request have tags assigned as soon as they are allocated.  So, we
>> absolutely can have all tags allocated and then need to do a TMF.
> 
> SATA internals may come to the rescue here; if there's an error all NCQ 
> commands are aborted. So we'll get at least one command tag back.
> As for the command duration limits I'm still waiting for clarification
> from Damien if we can reuse tags there.

We cannot easily reuse tags as the CDL case is *not* an error. So no queue
abort come with it. If we had the queue abort, things would be easy as
that would essentially be a regular eh.

Simply using scsi_execute_req() does not work since we have no guarantees
we can get a tag: all 32 commands being executed may complete with needing
sense data, and so scsi_execute_req() would hang waiting for a tag. I
could try hacking scsi_execute_req() to reuse a tag instead of allocating
a new one... Calling scsi_execute_req() from libata is really ugly though.

> 
> But I do agree it's ugly.
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
