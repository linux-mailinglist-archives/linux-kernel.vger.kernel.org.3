Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0352C14B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiERRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiERRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:45:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FCDFB;
        Wed, 18 May 2022 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652895942; x=1684431942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/MoSLRj2DcpOgWl7GCdrN80cWuUgwatF4OfOyEpMYzg=;
  b=Emm0867kWW9mtega68cic9/Vm5L9GMUQHw3VObebyN5//BhMaIfPm+v9
   neb+vIpRKNB/A331nKNPGqYcVOPkV+Kfn+UwEWJhgV3iVH6q57PPRfxmT
   9Nw3Yl1yR+KGhY8zROcg4HjKN+YeO2YEt/r0+6Gx6cXkMSnj16YUWoJe7
   a9z0XGVo2Se16yeyDeRG3qw60mg72BUmZ68aJo9t8wPNuCSxEUxFjX2XE
   +yc6o5cmgDXjST2wtNJu2xDMa7i0IMgU+Rsr88W3yJMzJZn5HnXRny7V0
   fgJiqkE8Z3Xqx4fcevEx0KxUUQsLFQG4gikEC2GyjBsedgwG2doFohjJB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271492326"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271492326"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:21:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700706711"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.11.158]) ([10.212.11.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:21:00 -0700
Message-ID: <a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com>
Date:   Wed, 18 May 2022 10:20:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: linux-next: manual merge of the dmaengine tree with Linus' tree
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220517153435.645a9313@canb.auug.org.au>
 <YoTcmqygoMm/gmsZ@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YoTcmqygoMm/gmsZ@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2022 4:46 AM, Vinod Koul wrote:
> On 17-05-22, 15:34, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the dmaengine tree got a conflict in:
>>
>>    drivers/dma/idxd/device.c
>>
>> between commit:
>>
>>    1cd8e751d96c ("dmaengine: idxd: skip clearing device context when device is read-only")
>>
>> from Linus' tree and commit:
>>
>>    cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")
> Thank you Stephen, the merge looks right to me. Dave pls verify and test
> -next
>
>> from the dmaengine tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc drivers/dma/idxd/device.c
>> index f652da6ab47d,1143886f4a80..000000000000
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@@ -699,21 -716,23 +716,26 @@@ static void idxd_device_wqs_clear_state
>>    		struct idxd_wq *wq = idxd->wqs[i];
>>    
>>    		if (wq->state == IDXD_WQ_ENABLED) {
>> + 			mutex_lock(&wq->wq_lock);
>>    			idxd_wq_disable_cleanup(wq);
>>   -			idxd_wq_device_reset_cleanup(wq);
>>    			wq->state = IDXD_WQ_DISABLED;
>> + 			mutex_unlock(&wq->wq_lock);
>>    		}
>>   +		idxd_wq_device_reset_cleanup(wq);


The lock needs to go around both functions, we can move it outside the 
if().

  + 		mutex_lock(&wq->wq_lock);
   		if (wq->state == IDXD_WQ_ENABLED) {
   			idxd_wq_disable_cleanup(wq);
  -			idxd_wq_device_reset_cleanup(wq);
   			wq->state = IDXD_WQ_DISABLED;
   		}
  +		idxd_wq_device_reset_cleanup(wq);
  + 		mutex_unlock(&wq->wq_lock);


>>    	}
>>    }
>>    
>>    void idxd_device_clear_state(struct idxd_device *idxd)
>>    {
>>   +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
>>   +		return;
>>   +
>> + 	idxd_device_wqs_clear_state(idxd);
>> + 	spin_lock(&idxd->dev_lock);
>>    	idxd_groups_clear_state(idxd);
>>    	idxd_engines_clear_state(idxd);
>> - 	idxd_device_wqs_clear_state(idxd);
>> + 	idxd->state = IDXD_DEV_DISABLED;
>> + 	spin_unlock(&idxd->dev_lock);
>>    }
>>    
>>    static void idxd_group_config_write(struct idxd_group *group)
>
>
