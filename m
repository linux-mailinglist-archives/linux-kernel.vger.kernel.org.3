Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D071C58CC2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiHHQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbiHHQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:32:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D4E09F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:32:09 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220808163206epoutp01a4ae56b3c0f6dfb59fa359f22b92b610~Ja6ybxOcX1754217542epoutp01p
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:32:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220808163206epoutp01a4ae56b3c0f6dfb59fa359f22b92b610~Ja6ybxOcX1754217542epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659976326;
        bh=OeznQ3GkC9JRq+f3xZfmLQAFgDq/aEQ32HyLK7ycDo4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uVU/w34lszm2Vo0ALOPdwnTJ0rsyA6R6gTF7vZgW1cv6giaIco196jkMYFOWiP+9A
         Bg8Xp82/CvAyOhI1oNWTqtN8O2tu5FtjcYGsTWw4hWRmhKVcLLqZFil+pIbrb9O2/b
         0B8EbjK1+sO35U9vG/l8byPJIyNRhU4/4EaqPN7Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220808163206epcas5p127e3863c746b0fd3dd4ccf20d8268f06~Ja6x3FpUj0145101451epcas5p1R;
        Mon,  8 Aug 2022 16:32:06 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4M1hYc40hwz4x9Pt; Mon,  8 Aug
        2022 16:32:04 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.52.42669.48A31F26; Tue,  9 Aug 2022 01:32:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220808141724epcas5p28c9d48f9e0e5b9a5e5aeb93eba2404bf~JZFLjm15G0522905229epcas5p2-;
        Mon,  8 Aug 2022 14:17:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220808141724epsmtrp2ebdc7d5929baa9d730d15cbe2f08b702~JZFLi27ix1426814268epsmtrp23;
        Mon,  8 Aug 2022 14:17:24 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff7000001a6ad-b5-62f13a84a38c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.2A.08905.4FA11F26; Mon,  8 Aug 2022 23:17:24 +0900 (KST)
Received: from mshams02 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220808141723epsmtip17c954427ce84ff2780d2df1bf1998fd8~JZFKnLxPN2405624056epsmtip1V;
        Mon,  8 Aug 2022 14:17:23 +0000 (GMT)
From:   "m.shams" <m.shams@samsung.com>
To:     =?iso-8859-1?Q?'Uwe_Kleine-K=F6nig'?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
Subject: RE: [PATCH] pwm: removes period check from pwm_apply_state()
Date:   Mon, 8 Aug 2022 19:47:03 +0530
Message-ID: <019701d8ab31$94c86d60$be594820$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQE14N23Ecc1n6hvU/1TooO9Vl2YEgEF3maVAoBW2yquzm0akA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmpm6L1cckg4svZC0ezNvGZnH/61FG
        i8u75rBZ3L27itHi5655LBa3J05mdGDz2DnrLrvHnWt72Dz6/xp49G1ZxejxeZNcAGtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMabcO
        sxYclaj4+mciewPjLeEuRk4OCQETic3f17J3MXJxCAnsZpToOrmdEcL5xCgxt/sEG0iVkMA3
        RokPjXAdW5d/ZYEo2ssoMfHZclYI5xmjxLVvq5m7GDk42ARUJXbcFAFpEBHwkph7eTfYCmaB
        SYwSP/qPsYIkOAVsJaYteMkCUi8s4Crx8RcjSJhFQEXix997zCA2r4ClxJHHvawQtqDEyZlP
        WEBsZgE9iRtTp7BB2PIS29/OYYY4TkHi59NlrBBxcYmjP3uYIW5wkrhy7jXYnRICvRwSr9o+
        MUI0uEgc/nQZyhaWeHV8CzuELSXx+d1eNgg7XWLuw14mCLtAYtmu71A19hIHrsxhgbBlJaae
        WscEsZhPovf3E6h6Xokd82BsRYn/u/uhesUl3q2YwjqBUWkWkt9mIfltFpLfZiH5ZwEjyypG
        ydSC4tz01GLTAqO81HJ4jCfn525iBCdQLa8djA8ffNA7xMjEwXiIUYKDWUmE98ja90lCvCmJ
        lVWpRfnxRaU5qcWHGE2BIT6RWUo0OR+YwvNK4g1NLA1MzMzMTCyNzQyVxHm9rm5KEhJITyxJ
        zU5NLUgtgulj4uCUamAqfTbZ4dIr90vpi7tOO7277CXDYLtu0pyf+pePGDevD0l3vWVQolzn
        rnjyznEdHZPzf2Vt3gfZLO7zZahTiTgVeLF3iVrpXvZW3uZHN9S7bdZf+dcmkezqraQadEOo
        aolo3QXvA2cf2Bj6pWwKv2m5N02tJvV5R87ZGuu9G/Wy89721DWfW/39Hcu10mcyEz3/SJ6S
        WXhv8fz0KOt7ypNFgx1Tvs5iPXb56EnhGJbvDtKmB28tDoi58qlu/m2DwpZNDds2TM4z5XA6
        aJR6VeRp9M7is4dk1A3ePqjv+VXIueLnnHB7bsnP58OuhVmqdHffnBo7171cYVeUYUTwuVwP
        2dc5ZbtMe2PYTrN981RiKc5INNRiLipOBADh4YqoKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO4XqY9JBh/v61o8mLeNzeL+16OM
        Fpd3zWGzuHt3FaPFz13zWCxuT5zM6MDmsXPWXXaPO9f2sHn0/zXw6NuyitHj8ya5ANYoLpuU
        1JzMstQifbsEroxptw6zFhyVqPj6ZyJ7A+Mt4S5GTg4JAROJrcu/snQxcnEICexmlFh5/hgb
        REJcYtqv/YwQtrDEyn/P2SGKnjBKzDj8BSjBwcEmoCqx46YISI2IgJfE3Mu7wWqYBaYxSky9
        fZcRburmiXuYQao4BWwlpi14yQLSLCzgKvHxF9gCFgEViR9/74GV8ApYShx53MsKYQtKnJz5
        hAXEZhYwkLh/qIMVwpaX2P52DjPEcQoSP58ug4qLSxz92cMMcZCTxJVzr1knMArPQjJqFpJR
        s5CMmoWkfQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAY0tLcwbh91Qe9Q4xM
        HIyHGCU4mJVEeI+sfZ8kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQi
        mCwTB6dUA1P5Sf/na2ZtKb4R33o7a9Ltly92Cv8/PefaWsUsCZHjH06lJj74rX56E5N98N1J
        Xx9Ma9zeeWLWwndWjnMfhk76J9VvuHvnheZquZVz2X9OmOgiUNrDJ/u1OWbpGRml9zvXxndM
        vL5u9lHrJ58aa1tPd9Vzhr63fW2aO+FG+N/5r+PPXN7iul9oqlaej2Sx8drLRctftW1c4Xlt
        /ftTdSJas3oDpcMe/ddeXiYjkLi//cSc97cdVm4UuGQs1HToStiqq/a1cx33mNxslNha0OF2
        unZyaYn21eArUhdjljCYf54U9USm7W9MIfv6JS5FDtz+zquCmxwOl5+94T7P4OBif5X3Rj8+
        /T4d9iD6Fg//TCWW4oxEQy3mouJEAEqgA+AQAwAA
X-CMS-MailID: 20220808141724epcas5p28c9d48f9e0e5b9a5e5aeb93eba2404bf
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
        <20220805101125.47955-1-m.shams@samsung.com>
        <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Uwe,

On Fri, Aug 05, 2022 at 03:41:25PM +0530, Tamseel Shams wrote:
>> There may be situation when PWM is exported using sysfs, but at that 
>> point PWM period is not set. At this situation if we issue a system 
>> suspend, it calls pwm_class_suspend which in turn calls 
>> pwm_apply_state, where PWM period value is checked which returns an 
>> invalid argument error casuing Kernel to panic. So, check for PWM 
>> period value is removed so as to fix the kernel panic observed during 
>> suspend.

> This looks and sounds wrong. One thing I would accept is:

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c index
0e042410f6b9..075bbcdad6c1 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -557,8 +557,8 @@ int pwm_apply_state(struct pwm_device *pwm, const
struct pwm_state *state)
> 	 */
> 	might_sleep();
> 
> -	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	if (!pwm || !state || state->enabled && (!state->period ||
> +	    state->duty_cycle > state->period))
>  		return -EINVAL;
> 
> 	chip = pwm->chip;

> That is, don't refuse calling pwm_apply_state() for state->period = 0 and
even state->duty_cycle > state->period if the > > PWM is not enabled.

By this do you mean doing it following way?

if (!pwm || !state || (pwm && !state->period) ||
	    (pwm && state->duty_cycle > state->period))
		return -EINVAL;

> But anyhow, even without that the kernel should not panic. So I ask you to
research and provide some more info about > > the problem. (Which hardware
does it affect? Where does it panic? ...)

Observing Kernel panic in exynos SoC when we issue system suspend. Following
is the snippet of error:

# echo mem > /sys/power/state
[   29.224784] 010: Kernel panic - not syncing: pwm pwmchip0:
dpm_run_callback failure
[   29.240134] 010: Call trace:
[   29.242993] 010:  dump_backtrace+0x0/0x1b8
[   29.247067] 010:  show_stack+0x24/0x30
[   29.250793] 010:  dump_stack+0xb8/0x114
[   29.254606] 010:  panic+0x180/0x398
[   29.258073] 010:  dpm_run_callback+0x270/0x278
[   29.262493] 010:  __device_suspend+0x15c/0x628
[   29.266913] 010:  dpm_suspend+0x124/0x3b0
[   29.270899] 010:  dpm_suspend_start+0xa0/0xa8
[   29.275233] 010:  suspend_devices_and_enter+0x110/0x968
[   29.280433] 010:  pm_suspend+0x308/0x3d8
[   29.284333] 010:  state_store+0x8c/0x110
[   29.288233] 010:  kobj_attr_store+0x14/0x28
[   29.292393] 010:  sysfs_kf_write+0x5c/0x78
[   29.296466] 010:  kernfs_fop_write+0x10c/0x220
[   29.300886] 010:  __vfs_write+0x48/0x90
[   29.304699] 010:  vfs_write+0xb8/0x1c0
[   29.308426] 010:  ksys_write+0x74/0x100
[   29.312240] 010:  __arm64_sys_write+0x24/0x30
[   29.316573] 010:  el0_svc_handler+0x110/0x1b8
[   29.320906] 010:  el0_svc+0x8/0x1bc
[   29.324374] 010: SMP: stopping secondary CPUs
[   29.328711] 010: Kernel Offset: disabled
[   29.332607] 010: CPU features: 0x0002,00006008
[   29.337026] 010: Memory Limit: none
[   29.343949] 010: Rebooting in 1 seconds..
[   30.344539] 010: Disabling non-boot CPUs ...


Thanks & Regards,
Tamseel

