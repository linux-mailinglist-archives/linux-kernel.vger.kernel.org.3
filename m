Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0847929D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhLQRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbhLQRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:16:12 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D100C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:16:12 -0800 (PST)
Received: from [192.168.1.101] (83.6.165.42.neoplus.adsl.tpnet.pl [83.6.165.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9C7A93F5DC;
        Fri, 17 Dec 2021 18:16:06 +0100 (CET)
Message-ID: <da9a88a5-46bf-3eab-7318-6db4dfeef994@somainline.org>
Date:   Fri, 17 Dec 2021 18:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable
 framebuffer for Surface Duo
Content-Language: en-US
To:     Felipe Balbi <balbi@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>,
        Gustave Monce <gustave.monce@outlook.com>
References: <20211217125757.1193256-1-balbi@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211217125757.1193256-1-balbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.12.2021 13:57, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@microsoft.com>
>
> Hi folks,
>
> I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
> through some internal docs, it came to my attention that the bootloader
> will fill up the framebuffer address and size to a memory node names
> splash_region. Adding the node, I can see the address of the
> framebuffer. Creating the relevant framebuffer device using
> simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
> of=/dev/fb0 and fb-test. None of which manage to get rid of what's
> already on the screen, put there by the bootloader (platform Logo).
>
> Wondering if any of you have seen a behavior such as this and how did
> you manage to get framebuffer working on SM8150 (I see at least Sony
> Xperia has the node).
>
> Felipe Balbi (2):
>   arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
>   arm64: boot: dts: qcom: surface duo: add minimal framebuffer
>
>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)

Hi,


this issue is totally unique to the Duo and your bootloader configuration.


Gus (CCd, co-author of Lumia 950/XL patches) and I were dissecting this precise

issue (albeit for a different usecase) and in our testing it turned out that XBL likely

kills the display stack upon exiting Boot Services and jumping to LinuxLoader. This may

be a bug that comes from the legacy of this device, as exiting Boot Services would

be rather undesirable in that scenario..


One fix would be to ask the bootloader team to look into it and fix it from there,

otherwise you'd have to bring up the display using the DPU1 driver, or perhaps in a

third-stage-bootloader (pls don't do it for the sanity of us all :D)


You can see the thing happening during the boot animation when the Microsoft

logo goes black for a split second and then it reappears with the "Powered by Android"

splash a short while after.


P.S I don't have this device and I'm only speaking on behalf of what we discovered

on Gus's one.


Konrad



