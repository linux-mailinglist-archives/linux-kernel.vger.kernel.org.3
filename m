Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5052FFD2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiEUX24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUX2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:28:53 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C562547540;
        Sat, 21 May 2022 16:28:50 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb40.dynamic.kabel-deutschland.de [95.90.235.64])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 13DD861EA1928;
        Sun, 22 May 2022 01:28:48 +0200 (CEST)
Message-ID: <fd14c5e5-9635-7ef5-0bf4-438dfaea5361@molgen.mpg.de>
Date:   Sun, 22 May 2022 01:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 15/20] ACPICA: executer/exsystem: Warn about sleeps
 greater than 10 ms
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bob Moore <robert.moore@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5578328.DvuYhMxLoT@kreacher> <4200238.ejJDZkT8p0@kreacher>
 <CAJZ5v0gWYZ_BSonhLGT7L4wPQvXLVyobPptE1Nx6PoNSGn4yXg@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJZ5v0gWYZ_BSonhLGT7L4wPQvXLVyobPptE1Nx6PoNSGn4yXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,


Am 21.05.22 um 18:11 schrieb Rafael J. Wysocki:
> On Mon, Apr 11, 2022 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> ACPICA commit 2a0d1d475e7ea1c815bee1e0692d81db9a7c909c
>>
>> Quick boottime is important, so warn about sleeps greater than 10 ms.
>>
>> Distribution Linux kernels reach initrd in 350 ms, so excessive delays
>> should be called out. 10 ms is chosen randomly, but three of such delays
>> would already make up ten percent of the boottime.
>>
>> Link: https://github.com/acpica/acpica/commit/2a0d1d47
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I have decided to revert this, because it spams logs with unuseful
> warnings on many production systems.

Thank you for the information. Can you please give an example?

> Power management AML uses sleeps above 10 ms for PCI spec compliance
> and polling is not useful in those cases.

Can you please tell me what delays are used? Maybe we can increase the 
threshold to the one required by the PCI spec?


Kind regards,

Paul


> I will submit an analogous revert for upstream ACPICA.
> 
>> ---
>>   exsystem.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff -Nurp linux.before_name/drivers/acpi/acpica/exsystem.c linux.after_name/drivers/acpi/acpica/exsystem.c
>> --- linux.before_name/drivers/acpi/acpica/exsystem.c    2022-04-01 18:26:54.958046947 +0200
>> +++ linux.after_name/drivers/acpi/acpica/exsystem.c     2022-04-01 18:26:51.760086923 +0200
>> @@ -170,6 +170,16 @@ acpi_status acpi_ex_system_do_sleep(u64
>>          acpi_ex_exit_interpreter();
>>
>>          /*
>> +        * Warn users about excessive sleep times, so ASL code can be improved to
>> +        * use polling or similar techniques.
>> +        */
>> +       if (how_long_ms > 10) {
>> +               ACPI_WARNING((AE_INFO,
>> +                             "Firmware issue: Excessive sleep time (%llu ms > 10 ms) in ACPI Control Method",
>> +                             how_long_us));
>> +       }
>> +
>> +       /*
>>           * For compatibility with other ACPI implementations and to prevent
>>           * accidental deep sleeps, limit the sleep time to something reasonable.
>>           */
>>
>>
>>
