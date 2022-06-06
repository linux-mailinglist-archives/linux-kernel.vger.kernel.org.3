Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940C53E62F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiFFNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiFFNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:07:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1449A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:07:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-163.dynamic.spd-mgts.ru [109.252.138.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0FE76601E95;
        Mon,  6 Jun 2022 14:07:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654520855;
        bh=LSsMVAQZyPb3UHQGiFXE07RX1x68iQrPgzsQm/Y6N8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J7lZtYY4Cuoa9mBoGgmh7HzBulDfQSltbib9XF0llbPdiEZUwfyVZy75VhebvcF6x
         LfmN/6WvLMFFEd57Xiq7Uzj+VOp0wfPESDbkDSRDN6xRfXFaLAm4pYCXfTKCIrWFm6
         I+X9pOVA9y74JXswamQvAzNzliEeOrb5vaFb2pmkT5f1/ClW23KrVJzH+FPh9bWfFi
         rm98yIYgZ2/sQ022F4i2iXIM+DIY0sElaY+mEkqwrv2OmPUZuJ+eQtTxFBedW+5+NQ
         2F6zphwJ+8t02wTzUfaL3YwkCUl/mWTeXfB6lLJvQR/OJVYwnCxTbFcT9A2j0v4cD/
         ZVYJRqnvVnp8g==
Message-ID: <5dbf4f96-7218-f238-5426-1ad0b4045aeb@collabora.com>
Date:   Mon, 6 Jun 2022 16:07:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] kernel/reboot: Change registration order of legacy
 power-off handler
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
 <8735gjq365.fsf@mpe.ellerman.id.au>
 <e597fd8e-d0d1-dd1c-b889-86cfca60f0f6@collabora.com>
 <87r142ndps.fsf@mpe.ellerman.id.au>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87r142ndps.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 16:06, Michael Ellerman wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>> Hi Michael,
>>
>> On 6/5/22 05:01, Michael Ellerman wrote:
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>> We're unconditionally registering sys-off handler for the legacy
>>>> pm_power_off() callback, this causes problem for platforms that don't
>>>> use power-off handlers at all and should be halted. Now reboot syscall
>>>> assumes that there is a power-off handler installed and tries to power
>>>> off system instead of halting it.
>>>>
>>>> To fix the trouble, move the handler's registration to the reboot syscall
>>>> and check the pm_power_off() presence.
>>>
>>> I'm seeing a qemu virtual machine (ppce500) fail to power off using the
>>> gpio-poweroff driver. I bisected it to this commit.
>>>
>>> I think the problem is that the machine is going via kernel_power_off(),
>>> not sys_reboot(), and so legacy_pm_power_off() has not been registered.
>>>
>>> If I just put the core_initcall back then it works as before. Not sure
>>> if that's a safe change in general though.
>>
>> Thank you very much for the testing and reporting the problem! I see now the two more cases that were missed previously:
>>
>> 1. There is the orderly_poweroff() used by some drivers.
>> 2. PowerPC may invoke do_kernel_power_off() directly from xmon code.
>>
>> Could you please test this change:
> 
> That works, thanks.
> 
> I tested both sysrq-o and the xmon power off path.
> 
> I couldn't come up with an easy way to test the orderly_poweroff()
> path, but it boils down to basically the same code in the end.
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> cheers

Awesome, thank you!

-- 
Best regards,
Dmitry
