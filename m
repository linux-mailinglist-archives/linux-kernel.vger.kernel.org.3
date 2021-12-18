Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB1479953
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhLRHS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:18:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57024 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLRHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:18:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E36860959;
        Sat, 18 Dec 2021 07:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153A6C36AE1;
        Sat, 18 Dec 2021 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639811937;
        bh=LVZc0lIzCRfFTdqMZFHee6leUkMKs2b/GFmLfzHDido=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=kFx0UuXTFXQfuSF+EO8PBvVOyRAqf3FPhoVk3c/MmfwtdD8xZHSVKlBBdT1N/K7qu
         sQ6dSklqj8VVjeFTdyIYSFi04/98rXe4D2neIOkzBXp2er0QnQOTefzZgluVK9sJHC
         BBuhGf+ihP9aST6ffpzrDbo2RokkAwrHFDNvmGxhzuJ9bsZljrvMHIR9rd+j5WfZo0
         V1UJi/IRQKz5tX2zeZdq37E+sVknR4mvP3oIs7S4rs8VbSUOzCOxk2bp4iEEpGlBSS
         zshwtpGoMb8z6o867X4j+JPlJWpDWqUl2akZlexc2Fm3z8PLq3qbMheSlpO3qXH/ql
         HOHsAsFsYYY/Q==
References: <20211217125757.1193256-1-balbi@kernel.org>
 <da9a88a5-46bf-3eab-7318-6db4dfeef994@somainline.org>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustave Monce <gustave.monce@outlook.com>
Subject: Re: [RFC/patch 0/2] arm64: boot: dts: qcom: sm8150: enable
 framebuffer for Surface Duo
Date:   Sat, 18 Dec 2021 09:17:48 +0200
In-reply-to: <da9a88a5-46bf-3eab-7318-6db4dfeef994@somainline.org>
Message-ID: <87czlu4bz7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Konrad,

Konrad Dybcio <konrad.dybcio@somainline.org> writes:

> On 17.12.2021 13:57, Felipe Balbi wrote:
>> From: Felipe Balbi <felipe.balbi@microsoft.com>
>>
>> Hi folks,
>>
>> I'm trying to enable the framebuffer on Microsoft Surface Duo. Looking
>> through some internal docs, it came to my attention that the bootloader
>> will fill up the framebuffer address and size to a memory node names
>> splash_region. Adding the node, I can see the address of the
>> framebuffer. Creating the relevant framebuffer device using
>> simple-framebuffer, I can't see it working. Tried dd if=/dev/urandom
>> of=/dev/fb0 and fb-test. None of which manage to get rid of what's
>> already on the screen, put there by the bootloader (platform Logo).
>>
>> Wondering if any of you have seen a behavior such as this and how did
>> you manage to get framebuffer working on SM8150 (I see at least Sony
>> Xperia has the node).
>>
>> Felipe Balbi (2):
>>   arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
>>   arm64: boot: dts: qcom: surface duo: add minimal framebuffer
>>
>>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> Hi,
>
>
> this issue is totally unique to the Duo and your bootloader configuration.
>
>
> Gus (CCd, co-author of Lumia 950/XL patches) and I were dissecting
> this precise issue (albeit for a different usecase) and in our testing
> it turned out that XBL likely kills the display stack upon exiting
> Boot Services and jumping to LinuxLoader. This may be a bug that comes
> from the legacy of this device, as exiting Boot Services would be
> rather undesirable in that scenario..

This is very nice background information which I didn't have. Thanks :-)

> One fix would be to ask the bootloader team to look into it and fix it
> from there, otherwise you'd have to bring up the display using the
> DPU1 driver, or perhaps in a third-stage-bootloader (pls don't do it

I'll give DPU1 a shot, thanks for the pointer

> for the sanity of us all :D)

no 3rd stages :-)

-- 
balbi
