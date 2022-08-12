Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D6590DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiHLIyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiHLIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D01E5A98F1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660294423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVBJ07hgCcMJvtQxqB1fn4K3n5iAnchLaBytWfkxYb4=;
        b=gVDB6nOdW6yBqw0VEi0iRRNj+fJUVXjgcSpZPFCXLXd0rBdyr9jZRy1UOwUFBDCWXFyBSw
        OxF0gB7IZ3Uf7DHryagGeTqojwdY5lrmXuerx4kj4d516fgQXW6tZyK9MZBeNJGGy+AIPZ
        Rk2KG7R9PwJkvr6LI149YDje0k9KMR8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-eZvJF6ZQNjCWXdPycBhRuA-1; Fri, 12 Aug 2022 04:53:42 -0400
X-MC-Unique: eZvJF6ZQNjCWXdPycBhRuA-1
Received: by mail-ej1-f69.google.com with SMTP id hp22-20020a1709073e1600b007309edc4089so196359ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LVBJ07hgCcMJvtQxqB1fn4K3n5iAnchLaBytWfkxYb4=;
        b=pqjxTc9LWWzh2UgrueDdowJbtmWOowzJ4k0zsesGqEYj29wGHWjlSbiLKZ21NlqkGt
         Vwwbirv30dxwvKbXjchXakAR/OfgBAPmDKuVRtCoGK0h6O3Ym+EqwOIQSOVn73fO8d+M
         RRpI9feyhYmTnZU+eIuTGuA8Zg8IX8D9wYB8HZHiSx7N807DGH1cGlDV6eGcw9q5Ps7W
         rp4/96ayWGGlkMPFsdGaBMJC40lG81egEZkTHcZkJ/b66AYd8sakfFrN7sLtV8unUTu5
         +jwV2x25vwchfNBfk6JLoebjtzui9uM94Z+Y1s/JZLR1zt8boykHpYNnco+HCKB8zFaP
         XntQ==
X-Gm-Message-State: ACgBeo0s43JN5ZKxy5hxON5WT4kS34tXXWe6c78zQAf9hNR+hpxgIMUn
        zRbv9Wa+dtg0Hurn2xJ+ra+7QKcWo1ztSVfYb65HTopi2cMue5ILX/AvMRh3cQzB16HraVY/GB6
        P2U8T+Mt3h9QzT0SHg7A20DCM
X-Received: by 2002:a50:fb10:0:b0:43d:561a:c990 with SMTP id d16-20020a50fb10000000b0043d561ac990mr2668135edq.115.1660294421454;
        Fri, 12 Aug 2022 01:53:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TEPABAEpkXidXc3AXAFU6PBoWB/RxZAWk0lIWN7zUmGK3rFQKNWfqLYaXVshcyRfAk5PMeQ==
X-Received: by 2002:a50:fb10:0:b0:43d:561a:c990 with SMTP id d16-20020a50fb10000000b0043d561ac990mr2668126edq.115.1660294421286;
        Fri, 12 Aug 2022 01:53:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640206c900b0043cc7a3ff7fsm1008538edy.33.2022.08.12.01.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:53:40 -0700 (PDT)
Message-ID: <075cd337-7dbf-2de2-fb28-9217091f9480@redhat.com>
Date:   Fri, 12 Aug 2022 10:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: FW: [PATCH] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Content-Language: en-US
To:     Marge Yang <Marge.Yang@tw.synaptics.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc:     Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
References: <1659944641-2625-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <41ca4d6b-e19c-c039-ed57-716106135e06@redhat.com>
 <PH0PR03MB584819DB46B04A4AB481C0F1A3679@PH0PR03MB5848.namprd03.prod.outlook.com>
 <PH0PR03MB584812B0831CBEFA0468D32FA3679@PH0PR03MB5848.namprd03.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <PH0PR03MB584812B0831CBEFA0468D32FA3679@PH0PR03MB5848.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/12/22 10:43, Marge Yang wrote:
> Hi Hans,
> 	Thanks for your suggestion.
> I have replied the following questions.
> Some questions will be fixed on V2 patch.
> 
> Thanks
> Marge Yang
> 
> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Thursday, August 11, 2022 10:23 PM
> To: margeyang <marge.yang@synaptics.corp-partner.google.com>; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; benjamin.tissoires@redhat.com
> Cc: Marge Yang <Marge.Yang@tw.synaptics.com>; derek.cheng@tw.synaptcs.com; Vincent Huang <Vincent.huang@tw.synaptics.com>
> Subject: Re: [PATCH] Input: synaptics-rmi4 - filter incomplete relative packet.
> 
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi,
> 
> On 8/8/22 09:44, margeyang wrote:
>> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
>>
>> RMI4 F03 supports the Stick function,
>> it's designed to support relative packet.
>> This patch supports the following case.
>> When relative packet can't be reported completely, it may miss one 
>> byte or two byte.
>> New Synaptics firmware will report PARITY error.
>> When timeout error or parity error happens,
>> RMI4 driver will sends 0xFE command and ask FW to Re-send stick packet 
>> again.
>>
>> Signed-off-by: Marge
>> Yang<marge.yang@synaptics.corp-partner.google.com>
>> ---
>>  drivers/input/rmi4/rmi_f03.c | 82
>> ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 78 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f03.c 
>> b/drivers/input/rmi4/rmi_f03.c index c194b1664b10..57f03dfcb4ff 100644
>> --- a/drivers/input/rmi4/rmi_f03.c
>> +++ b/drivers/input/rmi4/rmi_f03.c
>> @@ -23,8 +23,12 @@
>>  #define RMI_F03_BYTES_PER_DEVICE_SHIFT       4
>>  #define RMI_F03_QUEUE_LENGTH         0x0F
>>
>> +#define RMI_F03_RESET_STYK 0xFE
> 
> Please use tabs in front of the 0xFE to align it with the other values.
> 
> [Marge 08/12] Correct it on V2 patch.
> 
>> +
>>  #define PSMOUSE_OOB_EXTRA_BTNS               0x01
>>
>> +#define RELATIVE_PACKET_SIZE         0x03
> 
> Just "3" please since this is a size (not a register value).
> 
> 
> [Marge 08/12] Correct it on V2 patch.
> 
>> +
>>  struct f03_data {
>>       struct rmi_function *fn;
>>
>> @@ -36,7 +40,8 @@ struct f03_data {
>>       u8 device_count;
>>       u8 rx_queue_length;
>>  };
>> -
>> +int iwritecommandcounter;
>> +unsigned int ipacketindex;
> 
> Please do not use global variables like this, instead store these e.g. inside struct f03_data.
> 
> [Marge 08/12] Correct it on V2 patch.
> 
>>  int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
>>                            int value)
>>  {
>> @@ -87,7 +92,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
>>                       __func__, error);
>>               return error;
>>       }
>> -
>> +     iwritecommandcounter++;
>>       return 0;
>>  }
>>
>> @@ -197,10 +202,12 @@ static int rmi_f03_register_pt(struct f03_data
>> *f03)
>>
>>  static int rmi_f03_probe(struct rmi_function *fn)  {
>> +
>>       struct device *dev = &fn->dev;
>>       struct f03_data *f03;
>>       int error;
>> -
>> +     iwritecommandcounter = 0;
>> +     ipacketindex = 0;
>>       f03 = devm_kzalloc(dev, sizeof(struct f03_data), GFP_KERNEL);
>>       if (!f03)
>>               return -ENOMEM;
> 
> If you put the 2 variables into the f03_data then there will be no need to zero them.
> 
> [Marge 08/12] It is initialized. I will move them to rmi_f03_initialize function.
> 
>> @@ -251,9 +258,12 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>>       const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
>>       u8 obs[RMI_F03_QUEUE_LENGTH * RMI_F03_OB_SIZE];
>>       u8 ob_status;
>> +     static u8 ob_dataArry[RELATIVE_PACKET_SIZE];
>>       u8 ob_data;
>>       unsigned int serio_flags;
>> +     static unsigned int serio_flagsArry[RELATIVE_PACKET_SIZE];
> 
> Please drop these 2 static arrays here and instead store the info in the f03_data struct.
> [Marge 08/12] Correct it on V2 patch.
> 
>>       int i;
>> +
> 
> Unrelated whitespace change, please drop.
> [Marge 08/12] Correct it on V2 patch.
> 
>>       int error;
>>
>>       if (drvdata->attn_data.data) {
>> @@ -284,6 +294,22 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>>               ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
>>               serio_flags = 0;
>>
>> +             if (ob_status & (RMI_F03_OB_FLAG_TIMEOUT | RMI_F03_OB_FLAG_PARITY)) {
>> +                     //  Send resend command to stick when timeout or parity error.
>> +                     //  Driver can receive the last stick packet.
>> +
>> +                     error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr,
>> +                      RMI_F03_RESET_STYK);
>> +                     if (error) {
>> +                             dev_err(&f03->fn->dev,
>> +                                     "%s: Failed to rmi_write to F03 TX register (%d).\n",
>> +                                     __func__, error);
>> +                             return error;
>> +                     }
>> +                     ipacketindex = 0;
>> +                     break;
>> +             }
>> +
>>               if (!(ob_status & RMI_F03_RX_DATA_OFB))
>>                       continue;
>>
>> @@ -298,9 +324,57 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
>>                       serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
>>                       serio_flags & SERIO_PARITY ? 'Y' : 'N');
>>
>> -             serio_interrupt(f03->serio, ob_data, serio_flags);
>> +             if (iwritecommandcounter > 0) {
>> +                     // Read Acknowledge Byte after writing the PS2 command.
>> +                     // It is not trackpoint data.
>> +                     serio_interrupt(f03->serio, ob_data, 
>> + serio_flags);
>> +
>> +             } else {
>> +                     //   The relative-mode PS/2 packet format is as follows:
>> +                     //
>> +                     //              bit position            position (as array of bytes)
>> +                     //     7   6   5   4   3   2   1   0
>> +                     //   =================================+
>> +                     //    Yov Xov DY8 DX8  1   M   R   L  | DATA[0]
>> +                     //                DX[7:0]             | DATA[1]
>> +                     //                DY[7:0]             | DATA[2]
>> +                     //   =================================+
>> +                     //              Yov: Y overflow
>> +                     //    Xov: X overflow
>> +                     if ((ipacketindex == 0) && (ob_data & ((BIT(7)|BIT(6))))) {
>> +                             dev_err(&f03->fn->dev,
>> +                             "%s: X or Y is overflow. (%x)\n",
>> +                             __func__, ob_data);
>> +                             break;
>> +                     } else if ((ipacketindex == 0) && !(ob_data & BIT(3))) {
>> +                             dev_err(&f03->fn->dev,
>> +                             "%s: New BIT 3 is not 1 for the first byte\n",
>> +                             __func__);
> 
> Why no break; here like above ?
> 
> [Marge 08/12] Correct it on V2 patch.
> 
>> +                     } else {
>> +                             if (ipacketindex >= RELATIVE_PACKET_SIZE) {
>> +                                     ipacketindex = 0;
> 
> This means that you are skipping every 4th byte, since you only store the ob_data + serio_flags the next cycle through the loop!
> 
> [Marge 08/12] Correct it on V2 patch.
> 
>> +                             } else {
>> +                                     ob_dataArry[ipacketindex] = ob_data;
>> +                                     serio_flagsArry[ipacketindex] = serio_flags;
>> +                                     ipacketindex++;
>> +                             }
>> +                             if (ipacketindex == RELATIVE_PACKET_SIZE)       {
>> +                                     serio_interrupt(f03->serio, ob_dataArry[0],
>> +                                      serio_flagsArry[0]);
>> +                                     serio_interrupt(f03->serio, ob_dataArry[1],
>> +                                      serio_flagsArry[1]);
>> +                                     serio_interrupt(f03->serio, ob_dataArry[2],
>> +                                      serio_flagsArry[2]);
>> +                                     ipacketindex = 0;
>> +                             }
>> +                     }
>> +             }
>>       }
>>
>> +     if (iwritecommandcounter > 0) {
>> +             ipacketindex = 0;
>> +             iwritecommandcounter = iwritecommandcounter - 1;
>> +     }
> 
> You check iwritecommandcounter inside the:
> 
>         for (i = 0; i < ob_len; i += RMI_F03_OB_SIZE) {
> 
> loop, I understand that you want to forward the entire PS/2 response data and only decrement iwritecommandcounter once, but what if the rmi_f03_attention() did not contain any OOB data at all ?
> 
> I believe that in that case iwritecommandcounter should not be decremented ?
> 
> [Marge 08/12] For Synaptics FW design, FW must have responses after TP driver writes to F03 TX register.
> When Touchpad FW gets this information, Touchpad FW needs to sync it with stick device( or TrackPoint device).
> After Stick device(or TrackPoint device) gets this information, it will report 0xFA data (Ack) or other information to Touchpad device.
> We can get FW's response from F03 RX register(in rmi_f03_attention).
> If Synaptics FW has no response, it may be a Synaptics firmware issue.
> For RMI_F03_RESET_STYK command, it is a special command.
> After TP driver writes RMI_F03_RESET_STYK to F03 TX register, FW will clear fun03 buffer and re-send relative packet again.

Right but what if the following happens:

1. PS/2 command is forward to stick through RMI
2. Regular RMI touchpad data is received, no PS/2 response yet, so no
   OOB data
3. Despite here not being OOB data rmi_f03_attention() still decrements
   iwritecommandcounter
4. PS/2 command reply comes in, but iwritecommandcounter is 0 now
   because of 3, so the code will hit the else part of:

+             if (iwritecommandcounter > 0) {
+                     // Read Acknowledge Byte after writing the PS2 command.
+                     // It is not trackpoint data.
+                     serio_interrupt(f03->serio, ob_data, 
+ serio_flags);
+
+             } else {
+                     //   The relative-mode PS/2 packet format is as follows:
+                     //
+                     //              bit position            position (as array of bytes)
+                     //     7   6   5   4   3   2   1   0
+                     //   =================================+
+                     //    Yov Xov DY8 DX8  1   M   R   L  | DATA[0]
+                     //                DX[7:0]             | DATA[1]
+                     //                DY[7:0]             | DATA[2]
+                     //   =================================+
+                     //              Yov: Y overflow
+                     //    Xov: X overflow
                      ...

Treating the command reply as a relative mode PS/2 packet, instead
of just forwarding it to the PS/2 layer.

I believe that to fix this possible race you *must* only decrement
iwritecommandcounter() at the end of rmi_f03_attention() if
the read data actually contains OOB data.

But thinking about this more, I guess this can never happen
because each function has its own attention handler and if
there is only touchpad data then the attention handler for
the f03 function will never run ?

Regards,

Hans

