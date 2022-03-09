Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9954D2BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiCIJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiCIJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:28:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A977B7F8;
        Wed,  9 Mar 2022 01:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646818067; x=1678354067;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=40lu8G3vNf9s+cmlvZJzsGvJxZvLDzsgHboDdo7NC/c=;
  b=SuBp23e5I3jqIcxV6DksKN4WVZJ7cpUcIYFBVIJfSvG+G+ycNf/mpA5O
   UHY3IsYok0AsTF7mYsMra/8PxvBDKIxLy71PW89y7yfvkAsUc3w7na/Ud
   5fypjU1VLxMIiD4HmNgdZfTxzq8jZ4PKrvmuMUG/HmnaP2yUh0gqLPSQZ
   2oPlK4eCDXJxTn6lbW5TAZ69i1zrpqB1IB9qJxFdQ0YGmTfza/YxhMeBd
   a5wmSZVHJwhw4C9357KrF0K78fqfaKzlRBaE2nWgt9JcPmdAOXhRKY6t0
   WQilPja02F2ZD4ih5jM2QWnK+WSov3vDqQ0zBMhgYdnKKpV3FixHdwPUD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="255121270"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="255121270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:27:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="578322963"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 01:27:44 -0800
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
 <YiIfZFPl9ZqPBKvj@kroah.com>
 <835b3990-43a6-a985-81b4-b86bddfe951f@linux.intel.com>
 <2d439eec0548361669bcc7b4de5b2c0e966d4d62.camel@puri.sm>
 <efd900656e15eac9169ee597ab7c19986c15277c.camel@puri.sm>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: xhci: make XHCI_STOP_EP_CMD_TIMEOUT a module
 parameter
Message-ID: <60227688-4435-516d-2525-b31fabbef273@linux.intel.com>
Date:   Wed, 9 Mar 2022 11:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <efd900656e15eac9169ee597ab7c19986c15277c.camel@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.3.2022 9.56, Martin Kepplinger wrote:
> Am Dienstag, dem 08.03.2022 um 17:17 +0100 schrieb Martin Kepplinger:
>> Am Montag, dem 07.03.2022 um 10:49 +0200 schrieb Mathias Nyman:
>>> On 4.3.2022 16.17, Greg KH wrote:
>>>> On Fri, Mar 04, 2022 at 12:30:57PM +0100, Martin Kepplinger
>>>> wrote:
>>>>> On the Librem 5 imx8mq system we've seen the stop endpoint
>>>>> command
>>>>> time out regularly which results in the hub dying.
>>>>>
>>>>> While on the one hand we see "Port resume timed out, port 1-1:
>>>>> 0xfe3"
>>>>> before this and on the other hand driver-comments suggest that
>>>>> the driver
>>>>> might be able to recover instead of dying here, Sarah seemed to
>>>>> have a
>>>>> workaround for this particulator problem in mind already:
>>>>>
>>>>> Make it a module parameter. So while it might not be the root
>>>>> cause for
>>>>> the problem, do this to give users a workaround.
>>>>
>>>> This is not the 1990's, sorry, please do not add new module
>>>> parameters.
>>>> They modify code, when you want to modify an individual device.
>>>>
>>>
>>> Agree, I think we really need to find the rootcause here.
>>>
>>> There's a known problem with this stop endpoint timeout timer.
>>>
>>> For all other commands we start the timer when the controller
>>> starts
>>> processing the
>>> command, but the stop endpoint timer is started immediately when
>>> command is queued.
>>> So it might timeout if some other commend before it failed.
>>>
>>> I have a patchseries for this. It's still work in progress but
>>> should
>>> be testable.
>>> Pushed to a branch named stop_endpoint_fixes
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
>>> stop_endpoint_fixes
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=stop_endpoint_fixes
>>>
>>> Can you try it out and see if it helps?
>>>
>>
>> thanks a lot Mathias, I'm running these now. The timeout has not been
>> easy to reproduce (or I'm just lazy) but in a few days I should be
>> able
>> to tell whether that helps.
>>
>> So this thread has been about
>>
>> [14145.960512] xhci-hcd xhci-hcd.4.auto: Port resume timed out, port
>> 1-
>> 1: 0xfe3
>> [14156.308511] xhci-hcd xhci-hcd.4.auto: xHCI host not responding to
>> stop endpoint command.
>>
>> that I previously tried to work around by increasing
>> XHCI_MAX_REXIT_TIMEOUT_MS and XHCI_STOP_EP_CMD_TIMEOUT.
>>
>>
>> These patches can't help with the following, right?
>> readl_poll_timeout_atomic() with a fixed timeout is called in this
>> case:
>>
>> xhci-hcd xhci-hcd.4.auto: Abort failed to stop command ring: -110
>>
>> I see that too from time to time. It results in the HC dying as well.
>>
>> thanks,
>>                               martin
>>
> 
> hi Mathias,
> 
> I already saw "Port resume timed out" and the HC dying running your
> patches. I append the logs.
> 
> So for now I saw more success with increasing
> XHCI_MAX_REXIT_TIMEOUT_MS.
> 

XHCI_MAX_REXIT_TIMEOUT_MS is only 20ms, that we can probably change.

Is 40ms enough?

"Port resume timed out, port 1-1: 0xfe3" means port link state is still in
resume even if we asked link to go to U0 20ms ago.

Maybe this hw combination just resumes slowly.

Thanks
Mathias
