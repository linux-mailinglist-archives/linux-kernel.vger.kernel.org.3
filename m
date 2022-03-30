Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6204ECFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbiC3Wc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiC3WcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:32:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19CA5BD27
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648679439; x=1680215439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j5/+7NjVRG9pSqEJs+3YZQ+s6jwWs0SKfwoc0psMQ+M=;
  b=Kiqw5KcZip98oOJLGREfdiHsq1rNMjwSx8RbDkrchsOQE0BCoV63p5m5
   xhiW9RGnbUbnJbVfGAYf4h3cXkLmnEYYKYpgt/Eqnlm84VCRjVROR0Cbw
   C8qC1KkpAdPXgRSlqZU5iNqe09HLzH9ok5mZNGIPYqMtAk26LukF36/iZ
   Qx8K8k6/80aOru7aQFU8EmJvtqSQxWSuuBb7s6BO/yxeXKp33W28D5H8o
   Pi1jFXPnMzObcJ49Jc0xJRIaFCORjOap3IjuR59nlS9S51Om7dnrFzzg7
   XRzwdX3k9jQsMEpilOQDYcuW2kQH7RTTAJgOckvLEKWYrhyofbc9eacqG
   A==;
X-IronPort-AV: E=Sophos;i="5.90,223,1643644800"; 
   d="scan'208";a="308631221"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 06:30:39 +0800
IronPort-SDR: pF4pWISwS0L3dcWNKzX9Wc8ozFT1OVtCUkZrUbLHAfenyGMI3yuoZR50P/lmy5gyYjOtydVT58
 y3EUFuMzSxfXjkvqIf7Y7VUdcsBACR0vVI4wr+ZJshdIq4s/HLq8KXKxyIcDSk2nxhMO/UhmQY
 FdaY2VQyPokpHPUWuTW+gFyGjjE1AKMqHpfn2IyH1G0gQrWCxxWgLDfQNIK4mhL9pIBr0mYWGg
 aH6UNwSj9ttoL1WLaenIWOHKSXKYlnvA5/dj8Aoq91HcKEgK95d6fHTr2jKQtlNUId4smqGqwN
 TDzWOaxTGhkRxuhCH1zhbCAu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 15:01:29 -0700
IronPort-SDR: U1HA0pqg8spb0ksYPM47b2nrmxWWC61UVYHPKmRraKtc243n7BofHa1LeyWnzgf31+6sxU+PJX
 m5DnRQoa+7qZdCEkWt0PYtTB/A11lCd8P6//ZByGx5V6CnwHSWmzb6SCULzBFmxq+3dayScVB5
 LEbv4dx7nMiluBTey3LQBnW3T7+SFO4IhdExShFzxGpSO6fKt+qO2DSTp6FvJ8aGGI4NTiHpg0
 XAhqWgTSuZ8wwv8wcbG1znCm7iRZOdGEnJJlrfkQbmt6TQfBYoD58BGJIIXxxwiRmKWaQY+eMT
 LSw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 15:30:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTLjp6vmnz1Rwrw
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:30:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648679438; x=1651271439; bh=j5/+7NjVRG9pSqEJs+3YZQ+s6jwWs0SKfwo
        c0psMQ+M=; b=qhNRTS8qSTMNHIgXO1kWagzYlKg+EvQ/crJuOZAc01Bth/0UZ8t
        kvEZM1QOmWFrUMR9f7kyRvoUyLfgD1sQgcCu17/+LtceoLDZ0ngeypnahSiHT/2X
        iJShARZdKwzs4CwqPCp47LgMNAsTzQcb9uTl4p+NNpkSOn6SJjFttd1c2dlsY4G5
        TZxv1MiVK9nX8QIq5+ntmhYwVGtI1FhxxlSEXTrnmUlfs0JB4xWKYksYT3pvBY29
        zyARL9dDOFnonTs9b+xdyRQekwORLdRauRD0NGIoh6XmKyCj83hj4fS15l8lzKUk
        zGxLYcETMgswy8+cEPk30l2RTzJYtFlxAQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qvvgXIKhMN21 for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 15:30:38 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTLjm5HCsz1Rvlx;
        Wed, 30 Mar 2022 15:30:36 -0700 (PDT)
Message-ID: <ba090f1b-a767-46a1-5728-82d9c587ef3c@opensource.wdc.com>
Date:   Thu, 31 Mar 2022 07:30:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
 <YkQ9KoKb+VK06zXi@arighi-desktop>
 <08717833-19bb-8aaa-4f24-2989a9f56cd3@huawei.com>
 <263108383b1c01cf9237ff2fcd2e97a482eff83e.camel@linux.ibm.com>
 <YkRfrjgNpD+S2WpN@T590>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YkRfrjgNpD+S2WpN@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 22:48, Ming Lei wrote:
> On Wed, Mar 30, 2022 at 09:31:35AM -0400, James Bottomley wrote:
>> On Wed, 2022-03-30 at 13:59 +0100, John Garry wrote:
>>> On 30/03/2022 12:21, Andrea Righi wrote:
>>>> On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
>>>>> On 30/03/2022 11:11, Andrea Righi wrote:
>>>>>> Hello,
>>>>>>
>>>>>> after this commit I'm experiencing some filesystem corruptions
>>>>>> at boot on a power9 box with an aacraid controller.
>>>>>>
>>>>>> At the moment I'm running a 5.15.30 kernel; when the filesystem
>>>>>> is mounted at boot I see the following errors in the console:
>>>
>>> About "scsi: core: Reallocate device's budget map on queue depth
>>> change" being added to a stable kernel, I am not sure if this was
>>> really a fix  or just a memory optimisation.
>>
>> I can see how it becomes the problem: it frees and allocates a new
>> bitmap across a queue freeze, but bits in the old one might still be in
>> use.  This isn't a problem except when they return and we now possibly
>> see a tag greater than we think we can allocate coming back. 
>> Presumably we don't check this and we end up doing a write to
>> unallocated memory.
>>
>> I think if you want to reallocate on queue depth reduction, you might
>> have to drain the queue as well as freeze it.
> 
> After queue is frozen, there can't be any in-flight request/scsi
> command, so the sbitmap is zeroed at that time, and safe to reallocate.
> 
> The problem is aacraid specific, since the driver has hard limit
> of 256 queue depth, see aac_change_queue_depth().

256 is the scsi hard limit per device... Any SAS drive has the same limit
by default since there is no way to know the max queue depth of a scsi
disk. So what is special about aacraid ?

> 
> 
> Thanks,
> Ming
> 


-- 
Damien Le Moal
Western Digital Research
