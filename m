Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEE4EECD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbiDAMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiDAMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:06:43 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 05:04:53 PDT
Received: from zeus.flokli.de (mail.zeus.flokli.de [88.198.15.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE4119850;
        Fri,  1 Apr 2022 05:04:53 -0700 (PDT)
Received: from localhost (179.red-79-151-102.dynamicip.rima-tde.net [79.151.102.179])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 1366B12DE808;
        Fri,  1 Apr 2022 11:57:27 +0000 (UTC)
Date:   Fri, 1 Apr 2022 13:57:26 +0200
From:   Florian Klink <flokli@flokli.de>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: [PATCH v4 1/3] HID: lenovo: Add support for ThinkPad TrackPoint
 Keyboard II
Message-ID: <20220401115726.6pp2avtl5ezqkbr2@tp>
References: <20220213214924.32407-1-flokli@flokli.de>
 <20220213214924.32407-2-flokli@flokli.de>
 <CAO-hwJ+AXxf+0TtQ1Zkk9MQNZuBWsa3_eb4aAg_u+-gEuKbLPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+AXxf+0TtQ1Zkk9MQNZuBWsa3_eb4aAg_u+-gEuKbLPQ@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 22-04-01 12:30:47, Benjamin Tissoires wrote:
>>Thanks for the work Florian, and sorry for the delay.
>>
>>One comment below:
>>> @@ -977,11 +1114,14 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
>>>
>>>         /*
>>>          * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
>>> -        * regular keys
>>> +        * regular keys (Compact only)
>>>          */
>>> -       ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
>>> -       if (ret)
>>> -               hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
>>> +       if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
>>> +           hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {
>>
>>Is there a chance that other PIDs included in the files are needing that call?
>>I'm just worried about regressions here.
>>
>>Beside that question, the series is:
>>Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

`lenovo_probe_cptkbd` was introduced in

f3d4ff0e04cc4450bdc7a4140020913b1280d205
HID: lenovo: Add support for Compact (BT|USB) keyboard)

Back then, it was only called for these two "Compact (BT|USB) keyboard)"
devices (see switch case in `lenovo_probe`).

The new code now calls `lenovo_probe_cptkbd` also for
`USB_DEVICE_ID_LENOVO_TPII{BT,USB}KBD`:

> 	case USB_DEVICE_ID_LENOVO_CUSBKBD:
> 	case USB_DEVICE_ID_LENOVO_CBTKBD:
> 	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> 	case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
> 		ret = lenovo_probe_cptkbd(hdev);

… and the F7/9/11 thing is only done for the compact variants.

Other keyboards still use other `lenovo_probe_tpkbd` and
`lenovo_probe_tp10ubkbd` functions.

I agree the `lenovo_probe_*` names became a bit less self-explaining
over time, but the switch case in `lenovo_probe` itself should be pretty
authoritative about which hardware causes which function to be called.

Regards,
Florian
