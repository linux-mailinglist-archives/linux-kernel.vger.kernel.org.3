Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB546FEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhLJKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:34:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:4315 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237928AbhLJKen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:34:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225190385"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="225190385"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:31:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="659515095"
Received: from ccrisan-mobl2.ger.corp.intel.com (HELO [10.251.210.20]) ([10.251.210.20])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:31:06 -0800
Subject: Re: [RFCv3 3/7] HID: core: Add support for USI style events
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
 <20211201164301.44653-4-tero.kristo@linux.intel.com>
 <CAO-hwJ+hzHNZVUrL9vC02t4GMBnaLym_vz7JT6+_cKEK8wEAMA@mail.gmail.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
Message-ID: <c217aab3-a1b4-c94f-13c0-71c848d90d09@linux.intel.com>
Date:   Fri, 10 Dec 2021 12:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+hzHNZVUrL9vC02t4GMBnaLym_vz7JT6+_cKEK8wEAMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 08/12/2021 17:18, Benjamin Tissoires wrote:
> On Wed, Dec 1, 2021 at 5:43 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>> Add support for Universal Stylus Interface (USI) style events to the HID
>> core and input layers.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   drivers/hid/hid-input.c                | 18 ++++++++++++++++++
>>   include/linux/mod_devicetable.h        |  2 +-
>>   include/uapi/linux/hid.h               | 10 ++++++++++
>>   include/uapi/linux/input-event-codes.h | 22 ++++++++++++++--------
>>   4 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 73c2edda742e..b428ee9b4d9b 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -829,6 +829,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>                          }
>>                          break;
>>
>> +               case 0x38: /* Transducer Index */
>> +                       map_msc(MSC_PEN_ID);
> This is the new slot version for pens, I am not sure we really want to
> blindly introduce that without testing.
>
> Do you have a panel that supports multiple values (at once) for this
> usage (2 pens???). If not, I would simply skip that usage until we get
> an actual hardware that makes use of it.
Afaik, current controllers (panels) only support single pen at a time. 
You can use multiple pens with them and they effectively re-use the same 
pen-id, but you can't use them at the same time.
>
>> +                       break;
>> +
>>                  case 0x3b: /* Battery Strength */
>>                          hidinput_setup_battery(device, HID_INPUT_REPORT, field, false);
>>                          usage->type = EV_PWR;
>> @@ -876,6 +880,20 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>                          map_msc(MSC_SERIAL);
>>                          break;
>>
>> +               case 0x5c: map_msc(MSC_PEN_COLOR);              break;
>> +               case 0x5e: map_msc(MSC_PEN_LINE_WIDTH);         break;
> We already have ABS_TOOL_WIDTH which seems to relate to that very closely.
Ok, I can switch to use this one.
>
>> +
>> +               case 0x70:
>> +               case 0x71:
>> +               case 0x72:
>> +               case 0x73:
>> +               case 0x74:
>> +               case 0x75:
>> +               case 0x76:
>> +               case 0x77:
>> +                       map_msc(MSC_PEN_LINE_STYLE);
> Nope, this is wrong. It took me a long time to understand the report
> descriptor (see my last reply to your v2).
> Basically, we need one input event for each value between 0x72 and
> 0x77. HID core should translate the array of 1 element into a set of
> {depressed usage, pressed usage} and from the user-space, we will get
> "MSC_PEN_STYLE_CHISEL_MARKER 1" for instance.
>
> And *maybe* we could even use KEY events there, so we could remap them
> (but that's a very distant maybe).
>
>> +                       break;
>> +
>>                  default:  goto unknown;
>>                  }
>>                  break;
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index ae2e75d15b21..4ff40be7676b 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -322,7 +322,7 @@ struct pcmcia_device_id {
>>   #define INPUT_DEVICE_ID_KEY_MAX                0x2ff
>>   #define INPUT_DEVICE_ID_REL_MAX                0x0f
>>   #define INPUT_DEVICE_ID_ABS_MAX                0x3f
>> -#define INPUT_DEVICE_ID_MSC_MAX                0x07
>> +#define INPUT_DEVICE_ID_MSC_MAX                0x09
>>   #define INPUT_DEVICE_ID_LED_MAX                0x0f
>>   #define INPUT_DEVICE_ID_SND_MAX                0x07
>>   #define INPUT_DEVICE_ID_FF_MAX         0x7f
>> diff --git a/include/uapi/linux/hid.h b/include/uapi/linux/hid.h
>> index 861bfbbfc565..60ef9b615a1a 100644
>> --- a/include/uapi/linux/hid.h
>> +++ b/include/uapi/linux/hid.h
>> @@ -255,6 +255,7 @@
>>   #define HID_DG_TOUCH                           0x000d0033
>>   #define HID_DG_UNTOUCH                         0x000d0034
>>   #define HID_DG_TAP                             0x000d0035
>> +#define HID_DG_TRANSDUCER_INDEX                        0x000d0038
>>   #define HID_DG_TABLETFUNCTIONKEY               0x000d0039
>>   #define HID_DG_PROGRAMCHANGEKEY                        0x000d003a
>>   #define HID_DG_BATTERYSTRENGTH                 0x000d003b
>> @@ -267,6 +268,15 @@
>>   #define HID_DG_BARRELSWITCH                    0x000d0044
>>   #define HID_DG_ERASER                          0x000d0045
>>   #define HID_DG_TABLETPICK                      0x000d0046
>> +#define HID_DG_PEN_COLOR                       0x000d005c
>> +#define HID_DG_PEN_LINE_WIDTH                  0x000d005e
>> +#define HID_DG_PEN_LINE_STYLE                  0x000d0070
>> +#define HID_DG_PEN_LINE_STYLE_INK              0x000d0072
>> +#define HID_DG_PEN_LINE_STYLE_PENCIL           0x000d0073
>> +#define HID_DG_PEN_LINE_STYLE_HIGHLIGHTER      0x000d0074
>> +#define HID_DG_PEN_LINE_STYLE_CHISEL_MARKER    0x000d0075
>> +#define HID_DG_PEN_LINE_STYLE_BRUSH            0x000d0076
>> +#define HID_DG_PEN_LINE_STYLE_NO_PREFERENCE    0x000d0077
> Could you integrate that patch before my patch "HID: export the
> various HID defines from the spec in the uapi"? And also have it as a
> separate patch from the mapping?
> This way I can schedule that part earlier before we settle on the
> actual user space usages.
>
>>   #define HID_CP_CONSUMERCONTROL                 0x000c0001
>>   #define HID_CP_NUMERICKEYPAD                   0x000c0002
>> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
>> index 225ec87d4f22..98295f71941a 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -901,14 +901,20 @@
>>    * Misc events
>>    */
>>
>> -#define MSC_SERIAL             0x00
>> -#define MSC_PULSELED           0x01
>> -#define MSC_GESTURE            0x02
>> -#define MSC_RAW                        0x03
>> -#define MSC_SCAN               0x04
>> -#define MSC_TIMESTAMP          0x05
>> -#define MSC_MAX                        0x07
>> -#define MSC_CNT                        (MSC_MAX+1)
>> +#define MSC_SERIAL                     0x00
>> +#define MSC_PULSELED                   0x01
>> +#define MSC_GESTURE                    0x02
>> +#define MSC_RAW                                0x03
>> +#define MSC_SCAN                       0x04
>> +#define MSC_TIMESTAMP                  0x05
>> +/* USI Pen events */
>> +#define MSC_PEN_ID                     0x06
>> +#define MSC_PEN_COLOR                  0x07
>> +#define MSC_PEN_LINE_WIDTH             0x08
> PEN_LINE_WIDTH should be dropped.
>
>> +#define MSC_PEN_LINE_STYLE             0x09
> Again, PEN_LINE_STYLE is HID only and we should only map the values,
> not the title of the array.

Ok will update this, thanks.

-Tero

>
> Cheers,
> Benjamin
>
>> +/* TODO: Add USI diagnostic & battery events too */
>> +#define MSC_MAX                                0x09
>> +#define MSC_CNT                                (MSC_MAX + 1)
>>
>>   /*
>>    * LEDs
>> --
>> 2.25.1
>>
