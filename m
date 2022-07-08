Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138F56B5C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiGHJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiGHJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:39:59 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3ED6B245;
        Fri,  8 Jul 2022 02:39:58 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.246) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 8 Jul 2022
 12:39:49 +0300
Subject: Re: [PATCH v3 2/9] usb: typec: Add retimer handle to port
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Prashant Malani <pmalani@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <chrome-platform@lists.linux.dev>, <bleung@chromium.org>,
        <heikki.krogerus@linux.intel.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
 <20220707222045.1415417-3-pmalani@chromium.org>
 <509bf6fe-4406-c577-aa70-6eb70801e375@omp.ru> <Ysf3F3VvmoqCFj4P@kroah.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fb07d914-b756-1f9d-b670-4d18e84352bb@omp.ru>
Date:   Fri, 8 Jul 2022 12:39:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Ysf3F3VvmoqCFj4P@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.81.246]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/08/2022 09:19:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171638 [Jul 08 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 493 493 c80a237886b75a8eec705b487193915475443854
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.246 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.246 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.81.246:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.246
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/08/2022 09:21:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2022 6:55:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 12:21 PM, Greg Kroah-Hartman wrote:
[...]
>>> Similar to mux and orientation switch, add a handle for registered
>>> retimer to the port, so that it has handles to the various switches
>>> connected to it.
>>>
>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>>> ---
>>>
>>> Changes since v2:
>>> - No changes.
>>>
>>> Changes since v1:
>>> - Relinquish retimer reference during typec_release.
>>>
>>>  drivers/usb/typec/class.c | 9 +++++++++
>>>  drivers/usb/typec/class.h | 1 +
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
>>> index 9062836bb638..f08e32d552b4 100644
>>> --- a/drivers/usb/typec/class.c
>>> +++ b/drivers/usb/typec/class.c
>> [...]
>>> @@ -2249,6 +2251,13 @@ struct typec_port *typec_register_port(struct device *parent,
>>>  		return ERR_PTR(ret);
>>>  	}
>>>  
>>> +	port->retimer = typec_retimer_get(&port->dev);
>>> +	if (IS_ERR(port->retimer)) {
>>> +		ret = PTR_ERR(port->retimer);
>>> +		put_device(&port->dev);
>>> +		return ERR_PTR(ret);
>>
>>    Why convert it to and fro, and not just return port->retimer?
> 
> That would be a use-after-free as port might now be gone.

   Ah, indeed!
   It would also ensue an explicit pointer cast...

> thanks,
> 
> greg k-h

MBR, Sergey
