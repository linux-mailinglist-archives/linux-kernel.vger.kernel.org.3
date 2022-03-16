Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE34DA7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbiCPC0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiCPC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:26:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4A4B408
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647397534; x=1678933534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2VA94Eh1qS411dAUoSCxbhcrRfvG6zQ7XscUmqUXoRY=;
  b=SPLTKn6kf+pUR36OW/W+mo8d+EBvpt+E3FNwyQh0JbGP91v1Fwsg9bdS
   rviTEM5R5aJ75edDWfGpi17/EArvhHgRauKjEG4UNNJBWGL1cIhAPdjhE
   WalV9jxr6Qr8IOXyHDuFUrluS3TI4lRuqhAfQIv8wlkimLVi5XYIkIU4O
   gPDLzCNJ19aAKnXI/KL/Jm4JI528WP15YtIx7AEWb0LejA434pHCbcQH1
   57fO4WEuJmD8Zc2BihCWL20rY0Bp/RA8ctjfFKvJWu7Zxn+/5aBKlh+zo
   K6myq+HuDnnmR+/UvVbULwP90iwl4Gw0H9x0hN1uAfludx/W4YfxMIicZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319690484"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="319690484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:25:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="557221241"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.31.20]) ([10.255.31.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:25:31 -0700
Message-ID: <eb3b0964-662e-2c5f-02c6-6141c4c5bf92@intel.com>
Date:   Wed, 16 Mar 2022 10:25:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, Tom Rix <trix@redhat.com>
Cc:     jasowang@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        sgarzare@redhat.com, xieyongji@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220315124130.1710030-1-trix@redhat.com>
 <20220315092656-mutt-send-email-mst@kernel.org>
 <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
 <20220315111456-mutt-send-email-mst@kernel.org>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20220315111456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2022 11:15 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 15, 2022 at 08:03:26AM -0700, Tom Rix wrote:
>> On 3/15/22 6:28 AM, Michael S. Tsirkin wrote:
>>> On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> Clang static analysis reports this issue
>>>> ifcvf_main.c:49:4: warning: Called function
>>>>     pointer is null (null dereference)
>>>>     vf->vring->cb.callback(vring->cb.private);
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> The check
>>>>     vring = &vf->vring[i];
>>>>     if (vring->cb.callback)
>>>>
>>>> Does not match the use.  Change dereference so they match.
>>>>
>>>> Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
>>> Thanks a lot! I squashed this into the offending patch - no point in
>>> breaking bisect. Pushed to linux. However I'm now
>>> having second thoughts about applying that patchset - I'd like
>>> soma analysis explaining how this got through testing.
>> static analysis is something i do treewide.
>>
>> There are currently ~2500 issues in linux-next, do not panic! many are false
>> positives.
>>
>> It is pretty easy to setup and once you have a baseline you can filter only
>> your files.
>>
>> Tom
> Thanks for that info! I was actually directing this question to the
> contributor since the code does not look like it could have ever
> worked. I don't have the hardware in question myself.
Oh, that's my bad introducing this bug by typo, thanks Tom for fixing that!
In my previous testing, I tolerated the lower performance(only one queue 
working as you pointed out)
due to the shared irq, and did not check mq status, sorry for that.

After fixing this issue, test again:

(1)set nvectors = 2 after allocate MSI vectors, force the queues share 
one vector. from /proc/interrupts, we can see:
[lszhu@localhost linux]$ cat /proc/interrupts | grep ifcvf
  241:          0          0          0          0 0          0          
0          0          0          0 0          0          0          
0          0          0 0          0          0          0          
0          0 0          0          0          0          0          0 
0          0    2724424          0          0          0 0          
0          0          0          0          0 IR-PCI-MSI 
534528-edge      ifcvf[0000:01:00.5]-vqs-reused-irq
  242:          0          0          0          0 0          0          
0          0          0          0 0          0          0          
0          0          0 0          0          0          0          
0          0 0          0          0          0          0          0 
0          0          0          0          0          0 0          
0          0          0          0          0 IR-PCI-MSI 
534529-edge      ifcvf[0000:01:00.5]-config
  251:          0          0          0          0 0          0          
0          0          0          0 0    2693318          0          
0          0          0 0          0          0          0          
0          0 0          0          0          0          0          0 
0          0          0          0          0          0 0          
0          0          0          0          0 IR-PCI-MSI 
536576-edge      ifcvf[0000:01:00.6]-vqs-reused-irq
  252:          0          0          0          0 0          0          
0          0          0          0 0          0          0          
0          0          0 0          0          0          0          
0          0 0          0          0          0          0          0 
0          0          0          0          0          0 0          
0          0          0          0          0 IR-PCI-MSI 
536577-edge      ifcvf[0000:01:00.6]-config

(2) after several rounds of scp from a VF to another, at the source 
side, ethtool -S shows(cut off, only tx):
localhost:/home/lszhu # ethtool -S eth1
NIC statistics:
      tx_queue_0_packets: 437256
      tx_queue_0_bytes: 629246017
      tx_queue_0_xdp_tx: 0
      tx_queue_0_xdp_tx_drops: 0
      tx_queue_0_kicks: 34089
      tx_queue_1_packets: 73
      tx_queue_1_bytes: 96721
      tx_queue_1_xdp_tx: 0
      tx_queue_1_xdp_tx_drops: 0
      tx_queue_1_kicks: 12
      tx_queue_2_packets: 294647
      tx_queue_2_bytes: 433949815
      tx_queue_2_xdp_tx: 0
      tx_queue_2_xdp_tx_drops: 0
      tx_queue_2_kicks: 14948
      tx_queue_3_packets: 20226451
      tx_queue_3_bytes: 29735633548
      tx_queue_3_xdp_tx: 0
      tx_queue_3_xdp_tx_drops: 0
      tx_queue_3_kicks: 1123675

so every queue carries traffic now, all enabled

Thanks,
Zhu Lingshan


>
>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>    drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> index 3b48e717e89f7..4366320fb68d3 100644
>>>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>>> @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
>>>>    	for (i = 0; i < vf->nr_vring; i++) {
>>>>    		vring = &vf->vring[i];
>>>>    		if (vring->cb.callback)
>>>> -			vf->vring->cb.callback(vring->cb.private);
>>>> +			vring->cb.callback(vring->cb.private);
>>>>    	}
>>>>    	return IRQ_HANDLED;
>>>> -- 
>>>> 2.26.3

