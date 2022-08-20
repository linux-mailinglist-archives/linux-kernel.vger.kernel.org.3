Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0F59AD2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbiHTKXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiHTKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:23:49 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7A31DED
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:23:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s11so4931813qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=GH7MacsqFe4ByHX40zFjzh3TPhnjs8RQ6MXRmazRC0o=;
        b=Bum+rL0sbPfLVmi0o3ZRd4u+9nIwC96k40Sam2kAvyhGxinPEP1jMClSc8uGNRIm5D
         U+tp+tzfLfy5cqWIqH2R+eI17ksutdChNVMv3Yx3pGircyEOu5vz8RkCkwP0pj6oRd+Y
         fjgERy7+7LfbmpEBfMu/JnnNwz/h4hJYWe03P3FgUJNqmtx7Ay1+Csj5tjHu//2kqBP+
         E/Q60WxxSQMU4HQcFgnb+p+qoKJKTl7ChaDbw3R16I2hYMXVCsySBNiHs9NlM+qWBqvi
         Kn0wi/sEQpgJiAMt3j4PqJ3xN3Lmn7bNcV/nGcDtoAqlZ46Bmjdhvg18E+GYN1oyb2cX
         eC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=GH7MacsqFe4ByHX40zFjzh3TPhnjs8RQ6MXRmazRC0o=;
        b=xLBrJ/K1VBaKv77CdglxpLRQI4FnvGSkmES8WCJO8yCdMjEZ9DzK6Jqu6PoxH3AyQj
         baSdT66BsOeJdBxGYjLd8QHDTkNUDtOK2qZkxCpGqIyQJ6e8Mh91MtN5fBeTJmdxmEf5
         CoKBa8o4wBbfQF58fQxXvG9qQ0Znq8dTvyFbBu7LJtPv0kNAO8FImLpoj7vA48R016Sa
         8y3TSwuoYovAA7l78y7Pc4r1/KNkwxs6+RCOds3oYSx3y0HaNh79pKOe3rAJM6g2lobA
         xE8t7yjr+Jn1BMhAOLj9cpAIJElMyF9KQsTFMTc2oA50FAv69nHkyFejJbndQ/bVtt6o
         Mayw==
X-Gm-Message-State: ACgBeo0KIkBe0VvhbRITpBF+CBZzJEsI+4CGMRi+rUBzr5Q0PE/vI2h/
        d3pvNr7pTf2NG2ZDYj9iPHE8md0UPqXBVFHz
X-Google-Smtp-Source: AA6agR7HTIUb4rx3W4ILkzrFYACE2jN65GdaNMfcGKFaJcv1cQA8k9JuE0LwrRMSsvPDL5DAjyattA==
X-Received: by 2002:ac8:5948:0:b0:342:f500:2eb7 with SMTP id 8-20020ac85948000000b00342f5002eb7mr9302458qtz.483.1660991025577;
        Sat, 20 Aug 2022 03:23:45 -0700 (PDT)
Received: from ?IPv6:2601:153:901:9131:d0f3:7f7c:9506:88d2? ([2601:153:901:9131:d0f3:7f7c:9506:88d2])
        by smtp.gmail.com with ESMTPSA id i12-20020ac85c0c000000b0031eb393aa45sm5172492qti.40.2022.08.20.03.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 03:23:44 -0700 (PDT)
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220622003140.30365-1-pgwipeout@gmail.com>
 <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
 <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
 <ec3d2515-b2a2-8441-2e9a-a7fe664e048a@wolfvision.net>
 <CAMdYzYo1nm76ti3PCYk4DYtEnjWD731bybHaQV3ODBZi4SMvRg@mail.gmail.com>
 <88e9c256-b930-d26d-63b4-9d0f132ae962@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <3dd1a585-cf7e-033b-6c9b-f58dc43de6cb@gmail.com>
Date:   Sat, 20 Aug 2022 06:23:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <88e9c256-b930-d26d-63b4-9d0f132ae962@wolfvision.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2022 4:25 AM, Michael Riesch wrote:
> Hi Peter,
> 
> On 8/16/22 17:27, Peter Geis wrote:
>> On Tue, Aug 16, 2022 at 11:20 AM Michael Riesch
>> <michael.riesch@wolfvision.net> wrote:
>>>
>>> Hi all,
>>>
>>> On 8/4/22 11:49, Peter Geis wrote:
>>>> On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl <m.reichl@fivetechno.de> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> with linux-next-20220728 rk3399-roc-pc does not boot.
>>>>> Bisecting pointed to this commit.
>>>>> By reverting this commit the board boots again.
>>>>
>>>> Thank you for reporting this, someone was kind enough to reproduce the
>>>> problem on the rockpro64 and confirmed this is an issue. As I won't
>>>> have access to my hardware until next month, we should probably revert
>>>> this until the root cause can be identified.
>>>
>>> Just experienced this issue on my ROCK3 Model A board (RK3568) and
>>> reverting this commit solved it.
>>>
>>> Having the revert in v6.0-rc2 would be great -- if there is anything I
>>> can help to accelerate this please let me know.
>>
>> If this is now happening on rk356x where I know it works, it now
>> cements my theory that it's a symptom and not the actual problem.
>> Possibly a race condition with the grf and regmap code where it isn't
>> quite ready when called. This code path is called exactly the same way
>> later on when the irq fires.
>>
>> What config are you based on? I'm running a stripped down version of
>> the arm64_defconfig, but if you deviate from that it will be helpful
>> in reproducing the issue.
> 
> I posted my Kconfig here: https://pastebin.com/P1As0W4k
> 
> FWIW the ROCK3 board has a switch to set the OTG port to device or host,
> respectively. The NPE does not occur when the switch is set to host.
> 
> Best regards,
> Michael

Good Afternoon Michael,

Please try the following fix.

Very Respectfully,
Peter Geis

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 0b1e9337ee8e..5fc7c374a6b4 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1169,6 +1169,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
  			/* do initial sync of usb state */
  			ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
  			extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
+			ret = 0;
  		}
  	}
  


> 
>> We should revert it until it's isolated, as well as the patch setting
>> the rk356x to otg since it will again be broken. If someone could
>> weigh in here as well (I currently don't have access to my hardware)
>> it would be helpful.
>>
>>>
>>> Thanks and best regards,
>>> Michael
>>>
>>>>
>>>> Very Respectfully,
>>>> Peter Geis
>>>>
>>>>>
>>>>> [    2.398700] Unable to handle kernel NULL pointer dereference at virtual address
>>>>> 0000000000000008
>>>>> [    2.399517] Mem abort info:
>>>>> [    2.399772]   ESR = 0x0000000096000004
>>>>> [    2.400114]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>>> [    2.400594]   SET = 0, FnV = 0
>>>>> [    2.400873]   EA = 0, S1PTW = 0
>>>>> [    2.401161]   FSC = 0x04: level 0 translation fault
>>>>> [    2.401602] Data abort info:
>>>>> [    2.401864]   ISV = 0, ISS = 0x00000004
>>>>> [    2.402212]   CM = 0, WnR = 0
>>>>> [    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000001376000
>>>>> [    2.403071] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>>>>> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
>>>>> [    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd xhci_hcd
>>>>> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_display_helper
>>>>> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_hcd
>>>>> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimgblt
>>>>> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_quirks
>>>>> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
>>>>> 5.19.0-rc8-next-20220728 #437
>>>>> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
>>>>> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
>>>>> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>>> [    2.414332] lr : process_one_work+0x1d8/0x380
>>>>> [    2.416948] sp : ffff800009373d60
>>>>> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 0000000000000000
>>>>> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000000000000c
>>>>> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80000888ec10
>>>>> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 0000000000000001
>>>>> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 0000000000000000
>>>>> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 0000000034d4d91d
>>>>> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff000001aa7a74
>>>>> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff000001aa7a74
>>>>> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00000356c808
>>>>> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80000888eb34
>>>>> [    2.447190] Call trace:
>>>>> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
>>>>> [    2.452169]  process_one_work+0x1d8/0x380
>>>>> [    2.454684]  worker_thread+0x170/0x4e0
>>>>> [    2.457056]  kthread+0xd8/0xdc
>>>>> [    2.459354]  ret_from_fork+0x10/0x20
>>>>> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
>>>>> [    2.464338] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Am 22.06.22 um 02:31 schrieb Peter Geis:
>>>>>> The initial otg state for the phy defaults to device mode. The actual
>>>>>> state isn't detected until an ID IRQ fires. Fix this by syncing the ID
>>>>>> state during initialization.
>>>>>>
>>>>>> Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
>>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>>>> ---
>>>>>>    drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
>>>>>>    1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>> index 6711659f727c..6e44069617df 100644
>>>>>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>>>>>> @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>>>>>>                                        EXTCON_USB_HOST, &rport->event_nb);
>>>>>>                if (ret)
>>>>>>                        dev_err(rphy->dev, "register USB HOST notifier failed\n");
>>>>>> +
>>>>>> +             if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>>>>>> +                     /* do initial sync of usb state */
>>>>>> +                     ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
>>>>>> +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
>>>>>> +             }
>>>>>>        }
>>>>>>
>>>>>>    out:
>>>>>
>>>>> Gruß,
>>>>> --
>>>>> Markus Reichl
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
