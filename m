Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80253D924
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiFECBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiFECBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:01:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D04C402
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 19:01:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LG0GZ74KWz4xD8;
        Sun,  5 Jun 2022 12:01:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654394487;
        bh=ZebXCvVgYyoDD7R+hexZUA6pHVkZP2KZ/lhCRG9v1Nw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SKhU/q9WEzDGPnswYIpnFpNztIfIGHL0Vw9SnjJGCGwl4292sdSAj+JPj4A5xkzQb
         B+y7yf7HOYRhAFgS4FVK1Tub7rZqA/nsXwbNOsJFgdbfvBM7sIZHD4SD7kFL0RzFkh
         4LAZuDBJ2i+GfAD0qdoBjleSWz7y3T0/nVDNPuVFtorZf3m6oBOfj9s66A2CtkfvCC
         W1+3qpbYbqxrMo+T6K2Yxddet2CdAE2SRRRfV3eF8sxv1HkTH+reURjf75ivPf0bqu
         Q0yL9l09vNrOMBoVQI5ppwupEBNnxca/NZZL6J6wgQOW+K2G2tsvoHRJ8kqMmlDtuR
         Ikh4iERgGVRCA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1] kernel/reboot: Change registration order of legacy
 power-off handler
In-Reply-To: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
References: <20220524212118.425702-1-dmitry.osipenko@collabora.com>
Date:   Sun, 05 Jun 2022 12:01:22 +1000
Message-ID: <8735gjq365.fsf@mpe.ellerman.id.au>
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
> We're unconditionally registering sys-off handler for the legacy
> pm_power_off() callback, this causes problem for platforms that don't
> use power-off handlers at all and should be halted. Now reboot syscall
> assumes that there is a power-off handler installed and tries to power
> off system instead of halting it.
>
> To fix the trouble, move the handler's registration to the reboot syscall
> and check the pm_power_off() presence.

I'm seeing a qemu virtual machine (ppce500) fail to power off using the
gpio-poweroff driver. I bisected it to this commit.

I think the problem is that the machine is going via kernel_power_off(),
not sys_reboot(), and so legacy_pm_power_off() has not been registered.

If I just put the core_initcall back then it works as before. Not sure
if that's a safe change in general though.

cheers



> Fixes: 0e2110d2e910 ("kernel/reboot: Add kernel_can_power_off()")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  kernel/reboot.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 0bdc64ecf4f6..a091145ee710 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -569,22 +569,6 @@ static int legacy_pm_power_off(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>  
> -/*
> - * Register sys-off handlers for legacy PM callbacks. This allows legacy
> - * PM callbacks co-exist with the new sys-off API.
> - *
> - * TODO: Remove legacy handlers once all legacy PM users will be switched
> - *       to the sys-off based APIs.
> - */
> -static int __init legacy_pm_init(void)
> -{
> -	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
> -				 legacy_pm_power_off, NULL);
> -
> -	return 0;
> -}
> -core_initcall(legacy_pm_init);
> -
>  static void do_kernel_power_off_prepare(void)
>  {
>  	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
> @@ -646,6 +630,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  		void __user *, arg)
>  {
>  	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +	struct sys_off_handler *sys_off = NULL;
>  	char buffer[256];
>  	int ret = 0;
>  
> @@ -670,6 +655,21 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Register sys-off handlers for legacy PM callback. This allows
> +	 * legacy PM callbacks temporary co-exist with the new sys-off API.
> +	 *
> +	 * TODO: Remove legacy handlers once all legacy PM users will be
> +	 *       switched to the sys-off based APIs.
> +	 */
> +	if (pm_power_off) {
> +		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> +						   SYS_OFF_PRIO_DEFAULT,
> +						   legacy_pm_power_off, NULL);
> +		if (IS_ERR(sys_off))
> +			return PTR_ERR(sys_off);
> +	}
> +
>  	/* Instead of trying to make the power_off code look like
>  	 * halt when pm_power_off is not set do it the easy way.
>  	 */
> @@ -727,6 +727,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
>  		break;
>  	}
>  	mutex_unlock(&system_transition_mutex);
> +	unregister_sys_off_handler(sys_off);
>  	return ret;
>  }
>  
> -- 
> 2.35.3
