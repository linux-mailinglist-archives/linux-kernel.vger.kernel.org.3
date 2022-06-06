Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978453E6A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiFFNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiFFNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:06:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EFA47566
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:06:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LGtzS1HY4z4xXJ;
        Mon,  6 Jun 2022 23:06:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654520788;
        bh=i9e500zxu1g22ahZBxmWTFnpIkC2mYPGVdl0FhelEpQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dWQMsN0g3Pei2Ht3cSkeFHMQ7DeuSfJQ8YJ7hCWpHh/MkiHZFHawvu1KDSUtn4LoT
         RYFaVmj4Y6yttBQOmopkcolRZIS99m4KkC2aPTSPJqvxfAzH/DZwkluVBOma6DpNWa
         6f54LQStn+KpWh0dy/ft1VsVJP9XR46hXsm2lUVxhfP8aQQV//F6ED2vSoSnoq/NK4
         YxYbJlfhCEPkqVK8QvAtvvvD9leoxHKTT+zSV1EEcIIVkf4Nx7fk4i90u76BKXXGO2
         Z3xpMzuix8i4tb9pluZoqysV45gH3ZtNLBwe+GwYF244mtu0npsq5ZLntI93eEwhVh
         AYOfn25To4wig==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] kernel/reboot: Change registration order of legacy
 power-off handler
In-Reply-To: <e597fd8e-d0d1-dd1c-b889-86cfca60f0f6@collabora.com>
References: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
 <8735gjq365.fsf@mpe.ellerman.id.au>
 <e597fd8e-d0d1-dd1c-b889-86cfca60f0f6@collabora.com>
Date:   Mon, 06 Jun 2022 23:06:23 +1000
Message-ID: <87r142ndps.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> Hi Michael,
>
> On 6/5/22 05:01, Michael Ellerman wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>> We're unconditionally registering sys-off handler for the legacy
>>> pm_power_off() callback, this causes problem for platforms that don't
>>> use power-off handlers at all and should be halted. Now reboot syscall
>>> assumes that there is a power-off handler installed and tries to power
>>> off system instead of halting it.
>>>
>>> To fix the trouble, move the handler's registration to the reboot syscall
>>> and check the pm_power_off() presence.
>>
>> I'm seeing a qemu virtual machine (ppce500) fail to power off using the
>> gpio-poweroff driver. I bisected it to this commit.
>>
>> I think the problem is that the machine is going via kernel_power_off(),
>> not sys_reboot(), and so legacy_pm_power_off() has not been registered.
>>
>> If I just put the core_initcall back then it works as before. Not sure
>> if that's a safe change in general though.
>
> Thank you very much for the testing and reporting the problem! I see now the two more cases that were missed previously:
>
> 1. There is the orderly_poweroff() used by some drivers.
> 2. PowerPC may invoke do_kernel_power_off() directly from xmon code.
>
> Could you please test this change:

That works, thanks.

I tested both sysrq-o and the xmon power off path.

I couldn't come up with an easy way to test the orderly_poweroff()
path, but it boils down to basically the same code in the end.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
