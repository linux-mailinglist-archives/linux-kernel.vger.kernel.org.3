Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CAB5179C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiEBWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387794AbiEBWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:11:33 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7DC1121
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:08:00 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so571748pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 15:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+WzlqIMp293K3H3f2sHDB997qf0xEgsGTkNiSko9TGw=;
        b=iJWcWAk2swrrWfIviGf86iD3M9J1puJ2JvBtRZ9SL1K30RPUCsY/R4pR9OBaK1OEqP
         +rMj9KG9WrrIS+AJBIz7SjPgBarLCkiIsRRwuihCQtlvo3fjs34dmX2N63ga6pe7IluG
         yP6HXcVJJUrvE9wgtHifOFGa9OLJ7igi/yLIe0fFMTMcx93S7BfJ2HOCQg7FIgF5W9dW
         MgxiVLyXzm3EM/DCAwjboDw1OSO259boJnU+yKkISIpV7BNwebAW05T2yh57p2OSwlp1
         WZlTDKqUds2dnSGiF/uppbVVGmmuUlSRY1/7MelFiNpxF9XtGWGMFkzNX/3lEAazKr5R
         5TrQ==
X-Gm-Message-State: AOAM532rZahUXwyaalwjACS8aDYTmRTyBExMKLoaY7dlwxU5NfYCTSLy
        ZIF8dZYV72D8Ba21V+X9I22QGQ==
X-Google-Smtp-Source: ABdhPJy77EMHFvDo/1IyhZFgTnu75Y3CzXZKSBDCXc2aNKF4uB76iHf85o37EM0Bt3dSQlistTdcqA==
X-Received: by 2002:a17:903:2043:b0:15b:f6ff:79ed with SMTP id q3-20020a170903204300b0015bf6ff79edmr13581711pla.15.1651529279501;
        Mon, 02 May 2022 15:07:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b0015e8d4eb2a1sm5105174plp.235.2022.05.02.15.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:07:58 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <CAGXv+5HtMVCUdV=kNfOTCp3-1gEzTWtZ1xapgw=L-C2nTC0yag@mail.gmail.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
 <7hczhbe3wn.fsf@baylibre.com>
 <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
 <7hsfq6ql4v.fsf@baylibre.com>
 <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
 <ca127f7f-0620-1c03-4f39-206945b0e612@gmail.com>
 <CAGXv+5HtMVCUdV=kNfOTCp3-1gEzTWtZ1xapgw=L-C2nTC0yag@mail.gmail.com>
Date:   Mon, 02 May 2022 15:07:58 -0700
Message-ID: <7h8rrjr3k1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen-Yu Tsai <wenst@chromium.org> writes:

> On Fri, Apr 22, 2022 at 11:38 PM Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 22/04/2022 04:24, Roger Lu wrote:
>> > Hi Kevin,
>> >
>> > On Thu, 2022-04-21 at 12:41 -0700, Kevin Hilman wrote:
>> >> Hi Roger,
>> >>
>> >> Roger Lu <roger.lu@mediatek.com> writes:
>> >>
>> >>> On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
>> >>
>> >> [...]
>> >>
>> >>>> That being said, it would be really nice to see an integration tree
>> >>>> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
>> >>>>
>> >>>> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
>> >>>> board, it fails to probe[1] because there is no CCI node in the upstream
>> >>>> mt8183.dtsi.
>> >>>>
>> >>>> I'm assuming this series is also not very useful without the CPUfreq
>> >>>> series from Rex, so being able to test this, CCI and CPUfreq together on
>> >>>> MT8183 on a mainline kernel would be very helpful.
>> >>>>
>> >>>> Kevin
>> >>>>
>> >>>> [1]
>> >>>> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
>> >>>> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe
>> >>>> fail
>> >>>
>> >>> Just share. I've tested this series on below two platforms and it works as
>> >>> expected.
>> >>> - mt8183-Krane (kernel-v5.10)
>> >>> - mt8192-Hayato (kernel-v5.4)
>> >>
>> >> Unfortunately testing on v5.4 and v5.10 with lots of other additional
>> >> out-of-tree patches does not give much confidence that this series works
>> >> with upstream, especially when I've given a few reasons why it will not
>> >> work uptream.
>> >>
>> >> The examples I gave above for CCI and CPUs/cluster disable are good
>> >> examples, but another one I forgot to mention is the dependency on Mali.
>> >> The SVS driver will never probe because it also depens on a "mali" node,
>> >> which doesn't exist upstream either (but panfrost does, and acutually
>> >> loads/probes fine on v5.17/v5.18) so this should be fixed to work with
>> >> upstream panfrost.
>> >>
>> >> IMO, in order for this to be merged upstream, it should at least have
>> >> some basic validation with upstream, and so far I have not even been
>> >> able to make it successfuly probe.  To do that, you will need to either
>> >> provide a list of the dependencies for testing this with mainline
>> >> (e.g. CCI series, CPUfreq series, any DT changes), or even better, an
>> >> integration tree based on recent mainline (e.g. v5.17 stable, or
>> >> v5.18-rc) which shows all the patches (in addition to this series) used
>> >> to validate this on mainline.
>> >
>> > No problem. We'll find a machine that can be run correctly with recent mainline
>> > (e.g. v5.17 stable, or v5.18-rc) and add patches (CCI series + CPUfreq series +
>> > any DT changes) to test this SVS series. Thanks very much.
>> >
>>
>> Thanks Roger. I'll wait until this got tested with upstream Linux, before I will
>> apply all the patches.
>
> Hi everyone,
>
> I've put together an integration test branch:
>
> https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test
>
> This branch is based on next-20220422 and includes the following series:
>
> - ANX7625 DPI support v2
>   https://lore.kernel.org/all/20220422084720.959271-1-xji@analogixsemi.com/
> - MTK SVS v24
>   https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
> - MTK cpufreq v4
>   https://lore.kernel.org/all/20220422075239.16437-1-rex-bc.chen@mediatek.com/
> - PM / devfreq core patches from
>   http://git.kernel.org/chanwoo/h/devfreq-testing
>   PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>   PM / devfreq: Add cpu based scaling support to passive governor
>   PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>   PM / devfreq: passive: Update frequency when start governor
> - CCI devfreq v2
>   https://lore.kernel.org/all/20220408052150.22536-1-johnson.wang@mediatek.com/
>
> And some patches of my own to fix some errors. See the last handful of
> patches including and after the fixup! one.

Thanks for setting up this branch.

> This was tested on Juniper (Acer Chromebook Spin 311) that has MT8183.

Is there an upstream DT for this platform?

I tried this series on mt8183-pumpkin, and since the upstream DT doesn't
define a CCI regulator, the CCI driver fails to probe.  Without CCI, the
SVS driver also fails to probe.  So the platform boots, but has neither
CCI nor SVS.

If I add a regulator for CCI[1], it goes farther, but then fails more
noisly[2]


> Looking at the mcu_*_sel clocks from /sys/kernel/debug/clk/clk_summary ,
> it does seem like things are happening, though I'm not sure how to
> thoroughly test this, especially SVS.

I think you're probably seeing CPU DVFS (CPUfreq) working, but I suspect
neither CCI or SVS have successfully loaded.

Kevin



[1]
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index b288b508fa4c..e064c06dc0d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -384,6 +384,10 @@ &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
 
+&cci {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
 &cpu0 {
 	proc-supply = <&mt6358_vproc12_reg>;
 };


[2]
[    0.560083] mtk-ccifreq cci: devfreq_add_device: Unable to start governor for the device
[    0.576083] ------------[ cut here ]------------
[    0.576670] WARNING: CPU: 3 PID: 1 at drivers/devfreq/governor_passive.c:382 devfreq_passive_event_handler+0x80/0x3a0
[    0.578021] Modules linked in:
[    0.578413] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc3-next-20220422-05886-g9cd0610279c1-dirty #58
[    0.579653] Hardware name: Pumpkin MT8183 (DT)
[    0.580217] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.581097] pc : devfreq_passive_event_handler+0x80/0x3a0
[    0.581780] lr : devfreq_passive_event_handler+0x7c/0x3a0
[    0.582463] sp : ffff80000808ba40
[    0.582883] x29: ffff80000808ba40 x28: 0000000000000000 x27: fffffffffffffdfb
[    0.583788] x26: ffff0000037ba810 x25: ffff80000808bb40 x24: ffff80000a406640
[    0.584691] x23: ffff8000099153c8 x22: ffff0000037ba800 x21: 0000000000000000
[    0.585595] x20: ffff0000035c40a0 x19: ffff0000035c4080 x18: 0000000000000000
[    0.586267] mmc0: new ultra high speed SDR104 SDIO card at address 0001
[    0.586498] x17: 6f6620726f6e7265 x16: 766f672074726174 x15: 000006837f6218f7
[    0.588233] x14: 0000000000000320 x13: 0000000000000001 x12: 0000000000000000
[    0.589137] x11: 0000000000000001 x10: 0000000000000a50 x9 : ffff80000808b7a0
[    0.590041] x8 : ffff0000028b0ab0 x7 : ffff00007fb19d00 x6 : 00000000076832c3
[    0.590945] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : ffff80000a3f70e8
[    0.591849] x2 : 0000000000000000 x1 : ffff0000028b0000 x0 : 00000000fffffffe
[    0.592753] Call trace:
[    0.593065]  devfreq_passive_event_handler+0x80/0x3a0
[    0.593706]  devfreq_remove_device+0x38/0xd0
[    0.594247]  devfreq_add_device+0x328/0x5f0
[    0.594778]  devm_devfreq_add_device+0x64/0xb0
[    0.595341]  mtk_ccifreq_probe+0x340/0x4e0
[    0.595860]  platform_probe+0x68/0xe0
[    0.596330]  really_probe.part.0+0x9c/0x29c
[    0.596862]  __driver_probe_device+0x98/0x144
[    0.597416]  driver_probe_device+0xac/0x140
[    0.597948]  __driver_attach+0xf8/0x190
[    0.598436]  bus_for_each_dev+0x70/0xd0
[    0.598925]  driver_attach+0x24/0x30
[    0.599380]  bus_add_driver+0x14c/0x1f0
[    0.599868]  driver_register+0x78/0x130
[    0.600356]  __platform_driver_register+0x28/0x34
[    0.600954]  mtk_ccifreq_platdrv_init+0x1c/0x28
[    0.601531]  do_one_initcall+0x50/0x1c0
[    0.602021]  kernel_init_freeable+0x20c/0x290
[    0.602576]  kernel_init+0x28/0x13c
[    0.603024]  ret_from_fork+0x10/0x20
[    0.603480] ---[ end trace 0000000000000000 ]---

