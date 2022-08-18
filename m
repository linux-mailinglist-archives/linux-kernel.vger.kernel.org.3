Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA29598438
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbiHRNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiHRNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:33:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96868222B7;
        Thu, 18 Aug 2022 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660829638; x=1692365638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IEbMSu7VVxPGcPfHFKqOetzpuicz9EnlPH9Q7sBSOIU=;
  b=nvkUUI5uPjtWGqRk7KK4Ftb94oI1XAbMa2yRKKVsuvdc+8Tktn8VRsS6
   juhW5n5b0alDBcNvGKgsdRWOMO2gULXJMZ+SZ30mB9KNXn2a1wl2zNL+4
   ObxjQHy6mRul5s9q1Q4LhJr7RgLR1/aVgDYHznomINdCiOYwU1eWchk5Q
   zG34XZ3jJj6X4mTPIIkhmi4Px52ooA5wJdgTzelyIk0C6VtwBSytVKLdj
   pAtzBHcwwENhRLpGzX/uZuygHHkGPH3f5Pm6uu5YSznu0oRAn4E/ReJE9
   QCOYRRntIz/vfaszRzFtXOhQQACBjpSFigB9v3qtruLK4x4E3mk6mNocL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275804242"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="275804242"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 06:33:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584207981"
Received: from mgrzywa-mobl2.ger.corp.intel.com (HELO [10.252.49.179]) ([10.252.49.179])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 06:33:56 -0700
Message-ID: <8b71b3a0-28ed-6894-5566-139d7fc03223@linux.intel.com>
Date:   Thu, 18 Aug 2022 16:33:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] HID: i2c-hid: fix the report-id passed in via
 set_or_send_report
Content-Language: en-US
To:     Angela Czubak <acz@semihalf.com>
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
References: <20220726080504.4185715-1-tero.kristo@linux.intel.com>
 <CAB4aORWWL7w1rVCrFw-Q2aof6WeQZR5iYRFg2UrvQQwHZzy7hA@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <CAB4aORWWL7w1rVCrFw-Q2aof6WeQZR5iYRFg2UrvQQwHZzy7hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yes, I think this is a problem. Maybe we need to introduce some sort of 
quirk for the devices that are broken and expect the 0xf device id to be 
passed to them?

-Tero

On 18/08/2022 13:27, Angela Czubak wrote:
> Hi Tero,
>
> I believe this is not the right solution. To my mind the spec does not
> mention anything that the ID in the payload of SET_REPORT command
> should be altered; you have a full byte to us, so why not?
> Other than that this will result into problems with sending reports
> via output register: for any report with report ID >=0xF we will get
> the same report ID in the payload, so how could the device know which
> one we have in mind?
> Dmitry's rework was intended to actually solve problems with large
> report IDs being incorrectly overwritten with 0xF.
>
> Regards,
> Angela
>
> On Tue, Jul 26, 2022 at 10:05 AM Tero Kristo
> <tero.kristo@linux.intel.com> wrote:
>> The formatting of the data passed to the i2c HID data register was
>> changed with the re-work of the i2c-hid-core. Previously the report ID
>> passed in was encoded as 0xF if the report-id was greater than 0xF
>> (similar to what is done with the command portion.) Now with the rework,
>> a full report-id is passed in always, and this causes the messages to be
>> rejected by the i2c controller. Fix this by encoding the report-id
>> field in the same manner as previously was done.
>>
>> Fixes: dbe0dd5fd2e0 ("HID: i2c-hid: explicitly code setting and sending
>> reports")
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   drivers/hid/i2c-hid/i2c-hid-core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index c078f09a2318..156b12f840c4 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -296,6 +296,9 @@ static size_t i2c_hid_format_report(u8 *buf, int report_id,
>>   {
>>          size_t length = sizeof(__le16); /* reserve space to store size */
>>
>> +       if (report_id > 0xF)
>> +               report_id = 0xF;
>> +
>>          if (report_id)
>>                  buf[length++] = report_id;
>>
>> --
>> 2.25.1
>>
