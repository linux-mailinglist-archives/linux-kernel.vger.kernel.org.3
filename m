Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43A54F701
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382035AbiFQLuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382041AbiFQLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:50:31 -0400
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16B6CF66
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:50:28 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1o2AUd-0007OT-GV; Fri, 17 Jun 2022 13:50:27 +0200
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [127.0.0.1] (dynamic-046-114-037-216.46.114.pool.telefonica.de [46.114.37.216])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 25HBoPZ7003951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 17 Jun 2022 13:50:26 +0200
Date:   Fri, 17 Jun 2022 13:50:24 +0200
From:   MR <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: rk3399-roc-pc does not boot
User-Agent: K-9 Mail for Android
In-Reply-To: <YqxpuT36/sjQKm0o@Red>
References: <YqxEL/pgv3zuH6aS@Red> <c12cc4bd-f7b8-5e52-14a2-41a0da83bb0c@arm.com> <9CC86176-19B0-491F-86A4-F95E670B0A66@fivetechno.de> <YqxpuT36/sjQKm0o@Red>
Message-ID: <C9931FED-3B0A-40D8-B03C-AD270F68DB57@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1655466629;620214f1;
X-HE-SMSGID: 1o2AUd-0007OT-GV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_NAME_MR_MRS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17. Juni 2022 13:47:05 MESZ schrieb Corentin Labbe <clabbe.montjoie@gmail.com>:
>Le Fri, Jun 17, 2022 at 01:43:05PM +0200, MR a écrit :
>> 
>> 
>> Am 17. Juni 2022 11:58:03 MESZ schrieb Robin Murphy <robin.murphy@arm.com>:
>> >On 2022-06-17 10:06, Corentin Labbe wrote:
>> >> Hello
>> >> 
>> >> I try to add rk3399-roc-pc to kernelCI but this board fail to ends its boot with any kernel I try.
>> >> It boot normally up to starting init but it stucks shorty after.
>> >> It fail on 5.10, 5.15, 5.17, 5.18 and linux-next.
>> >> When disabling CONFIG_USB, the board boots successfully.
>> >> 
>> >> In dmesg I see OF: graph: no port node found in /i2c@ff160000/usb-typec@22
>> >> According to Documentation/devicetree/bindings/usb/fcs,fusb302.txt, the port is mandatory.
>> >> Can it be possible that the problem was that the power port being disabled ?
>> >
>> >Indeed, I believe the OF graph error is just a meaningless annoyance, but the general problem sounds like it's probably the same thing that's come up before:
>> >
>> >https://lore.kernel.org/all/0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de/
>> >
>> >Disabling CONFIG_TYPEC_FUSB302 or blacklisting the fusb302 module should help confirm that. I have no idea if it's still an open problem, or if it's been fixed and you might just need to define the proper power role in the DT; this just triggered a memory of that older thread :)
>> >
>> >Robin.
>> 
>> Yes, the issue above is still there. I therefore use dumb 5 V, 4 A USB power supplies  that do not react on the USB-C communication.
>> 
>> Markus
>
>@Markus
>Could you try the diff I just send ?

Right on holiday, but will test it next week.
>
>Thanks
>
>_______________________________________________
>Linux-rockchip mailing list
>Linux-rockchip@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
