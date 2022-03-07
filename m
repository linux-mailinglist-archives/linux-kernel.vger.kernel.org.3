Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBC4CF3ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiCGIsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiCGIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:48:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BEE0A;
        Mon,  7 Mar 2022 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646642869; x=1678178869;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xt/3R0lQEI5gTKOyK1+eaIjn7pr4giAio4UXAW6KfRk=;
  b=Iot3qmYni8Y0TZbUMQSi7hJoNUxGueUGdgF8FO94rpK1oDDEDAvzcYkJ
   5T2DiZGm/hEvBvnofcRyjKz0FYPc6gpT/DVPO00GHkJYNBoLMDJNzd+xH
   0eDVZyazqH5/xsxu19BgEUxiPXEDrBAPx3xHs5iWWxJSsMJs69DU9nebU
   YghUzAv1QzxSo3Y7/x93CnNxCLGWrCYi9f02Dh0hJZWI1lGTbRL2eo1n8
   rZQyJ33hXByaWNMh7N1S3bLQjMXje1yGUINIo5lcdIe5PUw9ICyQlEezL
   YCAuuGq8xX263zFJ8qZVbniz+/zDio6taQWQnJ+8BStB2KlYcrt3uBJwM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="317571629"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="317571629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 00:47:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="577527667"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 07 Mar 2022 00:47:41 -0800
To:     Greg KH <gregkh@linuxfoundation.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mathias.nyman@intel.com, kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304113057.1477958-1-martin.kepplinger@puri.sm>
 <YiIfZFPl9ZqPBKvj@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: xhci: make XHCI_STOP_EP_CMD_TIMEOUT a module
 parameter
Message-ID: <835b3990-43a6-a985-81b4-b86bddfe951f@linux.intel.com>
Date:   Mon, 7 Mar 2022 10:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YiIfZFPl9ZqPBKvj@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.3.2022 16.17, Greg KH wrote:
> On Fri, Mar 04, 2022 at 12:30:57PM +0100, Martin Kepplinger wrote:
>> On the Librem 5 imx8mq system we've seen the stop endpoint command
>> time out regularly which results in the hub dying.
>>
>> While on the one hand we see "Port resume timed out, port 1-1: 0xfe3"
>> before this and on the other hand driver-comments suggest that the driver
>> might be able to recover instead of dying here, Sarah seemed to have a
>> workaround for this particulator problem in mind already:
>>
>> Make it a module parameter. So while it might not be the root cause for
>> the problem, do this to give users a workaround.
> 
> This is not the 1990's, sorry, please do not add new module parameters.
> They modify code, when you want to modify an individual device.
> 

Agree, I think we really need to find the rootcause here.

There's a known problem with this stop endpoint timeout timer.

For all other commands we start the timer when the controller starts processing the
command, but the stop endpoint timer is started immediately when command is queued.
So it might timeout if some other commend before it failed.

I have a patchseries for this. It's still work in progress but should be testable.
Pushed to a branch named stop_endpoint_fixes

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git stop_endpoint_fixes
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=stop_endpoint_fixes

Can you try it out and see if it helps?

Thanks
-Mathias
