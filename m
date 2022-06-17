Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662E54F6F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381989AbiFQLtE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380989AbiFQLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:49:03 -0400
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 04:49:01 PDT
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97D6CF56
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:49:01 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1o2ATD-000767-I8; Fri, 17 Jun 2022 13:48:59 +0200
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [127.0.0.1] (dynamic-046-114-037-216.46.114.pool.telefonica.de [46.114.37.216])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 25HBmv1V003806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 17 Jun 2022 13:48:58 +0200
Date:   Fri, 17 Jun 2022 13:48:56 +0200
From:   MR <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: rk3399-roc-pc does not boot
User-Agent: K-9 Mail for Android
In-Reply-To: <Yqxm+IR9wApJCFMN@Red>
References: <YqxEL/pgv3zuH6aS@Red> <c12cc4bd-f7b8-5e52-14a2-41a0da83bb0c@arm.com> <Yqxm+IR9wApJCFMN@Red>
Message-ID: <D6E0B1F3-D6C3-49D6-A6F8-3F07F48D1C0B@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1655466541;bb534dd1;
X-HE-SMSGID: 1o2ATD-000767-I8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_NAME_MR_MRS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17. Juni 2022 13:35:20 MESZ schrieb Corentin Labbe <clabbe.montjoie@gmail.com>:
>Le Fri, Jun 17, 2022 at 10:58:03AM +0100, Robin Murphy a écrit :
>> On 2022-06-17 10:06, Corentin Labbe wrote:
>> > Hello
>> > 
>> > I try to add rk3399-roc-pc to kernelCI but this board fail to ends its boot with any kernel I try.
>> > It boot normally up to starting init but it stucks shorty after.
>> > It fail on 5.10, 5.15, 5.17, 5.18 and linux-next.
>> > When disabling CONFIG_USB, the board boots successfully.
>> > 
>> > In dmesg I see OF: graph: no port node found in /i2c@ff160000/usb-typec@22
>> > According to Documentation/devicetree/bindings/usb/fcs,fusb302.txt, the port is mandatory.
>> > Can it be possible that the problem was that the power port being disabled ?
>> 
>> Indeed, I believe the OF graph error is just a meaningless annoyance, 
>> but the general problem sounds like it's probably the same thing that's 
>> come up before:
>> 
>> https://lore.kernel.org/all/0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de/
>> 
>> Disabling CONFIG_TYPEC_FUSB302 or blacklisting the fusb302 module should 
>> help confirm that. I have no idea if it's still an open problem, or if 
>> it's been fixed and you might just need to define the proper power role 
>> in the DT; this just triggered a memory of that older thread :)
>> 
>
>If I comment fusb0 node in arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi, the board boot well.
>
>With the following patch, the boards boot well also:
>diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>index 0e45cc2d195b..60c400ca4034 100644
>--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>@@ -552,6 +552,22 @@ fusb0: usb-typec@22 {
>                pinctrl-0 = <&fusb0_int>;
>                vbus-supply = <&vcc_vbus_typec0>;
>                status = "okay";
>+
>+               connector {
>+                       compatible = "usb-c-connector";
>+                       data-role = "host";
>+                       label = "USB-C";
>+                       power-role = "dual";
>+
>+                       ports {
>+                               #address-cells = <1>;
>+                               #size-cells = <0>;
>+
>+                               port@0 {
>+                                       reg = <0>;
>+                               };
>+                       };
>+               };
>        };
> 
>        mp8859: regulator@66 {
>
>I think this patch is the proper way to fix, I will send it soon.
>
Thanks, happy to see that this works now.

>Linux-rockchip mailing list
>Linux-rockchip@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
