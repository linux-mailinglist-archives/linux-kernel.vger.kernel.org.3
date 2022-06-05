Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906BA53DB60
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiFEM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:26:14 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 05:26:13 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B544A0E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:26:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-138-163.dynamic.spd-mgts.ru [109.252.138.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42BC666021F4;
        Sun,  5 Jun 2022 13:19:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654431554;
        bh=twKaKpBVHMt3pJbT7iWckMFsSCOrXNFwcbzhziI8jIg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=keesDG7st6wjge+glyw1VIFV9gnuuHlFAge/By87O5r8bp4vQoda1j8U5unMuOYA1
         1n03sE6jCBiyxmFFEz2tnFjWWg9DC/jtveaXjq1n1HaZbIL11Cpfj3tQQrsyQt6No1
         ZjPXjNRUEpT0HJ3DlhDobi9WcUAk9mUXexuT4GIC7CYpRAE4LQLduXI/+oV3lgE00G
         tcBc6Wm5KriQ9BcXrZ3rKry+H3d5o5jCRdmRb793L0oJ5EGGZm1pJJb9Zj6Z1Kk3QO
         8PBl3pDUSokjJEyiRbIXLFydl77Vl2eHIGV+h778T6SneznAeKzGsyw6GHN833dHvO
         JLVY78femTB4A==
Message-ID: <e597fd8e-d0d1-dd1c-b889-86cfca60f0f6@collabora.com>
Date:   Sun, 5 Jun 2022 15:19:11 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <8735gjq365.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Michael,

On 6/5/22 05:01, Michael Ellerman wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>> We're unconditionally registering sys-off handler for the legacy
>> pm_power_off() callback, this causes problem for platforms that don't
>> use power-off handlers at all and should be halted. Now reboot syscall
>> assumes that there is a power-off handler installed and tries to power
>> off system instead of halting it.
>>
>> To fix the trouble, move the handler's registration to the reboot syscall
>> and check the pm_power_off() presence.
> 
> I'm seeing a qemu virtual machine (ppce500) fail to power off using the
> gpio-poweroff driver. I bisected it to this commit.
> 
> I think the problem is that the machine is going via kernel_power_off(),
> not sys_reboot(), and so legacy_pm_power_off() has not been registered.
> 
> If I just put the core_initcall back then it works as before. Not sure
> if that's a safe change in general though.

Thank you very much for the testing and reporting the problem! I see now the two more cases that were missed previously:

1. There is the orderly_poweroff() used by some drivers.
2. PowerPC may invoke do_kernel_power_off() directly from xmon code.

Could you please test this change:

--- >8 ---

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3b19b123efec..0e4a3defcd94 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -320,6 +320,7 @@ static struct sys_off_handler platform_sys_off_handler;
 static struct sys_off_handler *alloc_sys_off_handler(int priority)
 {
 	struct sys_off_handler *handler;
+	gfp_t flags;
 
 	/*
 	 * Platforms like m68k can't allocate sys_off handler dynamically
@@ -330,7 +331,12 @@ static struct sys_off_handler *alloc_sys_off_handler(int priority)
 		if (handler->cb_data)
 			return ERR_PTR(-EBUSY);
 	} else {
-		handler = kzalloc(sizeof(*handler), GFP_KERNEL);
+		if (system_state > SYSTEM_RUNNING)
+			flags = GFP_ATOMIC;
+		else
+			flags = GFP_KERNEL;
+
+		handler = kzalloc(sizeof(*handler), flags);
 		if (!handler)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -615,7 +621,26 @@ static void do_kernel_power_off_prepare(void)
  */
 void do_kernel_power_off(void)
 {
+	struct sys_off_handler *sys_off = NULL;
+
+	/*
+	 * Register sys-off handlers for legacy PM callback. This allows
+	 * legacy PM callbacks temporary co-exist with the new sys-off API.
+	 *
+	 * TODO: Remove legacy handlers once all legacy PM users will be
+	 *       switched to the sys-off based APIs.
+	 */
+	if (pm_power_off) {
+		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						   SYS_OFF_PRIO_DEFAULT,
+						   legacy_pm_power_off, NULL);
+		if (IS_ERR(sys_off))
+			return;
+	}
+
 	atomic_notifier_call_chain(&power_off_handler_list, 0, NULL);
+
+	unregister_sys_off_handler(sys_off);
 }
 
 /**
@@ -626,7 +651,8 @@ void do_kernel_power_off(void)
  */
 bool kernel_can_power_off(void)
 {
-	return !atomic_notifier_call_chain_is_empty(&power_off_handler_list);
+	return !atomic_notifier_call_chain_is_empty(&power_off_handler_list) ||
+		pm_power_off;
 }
 EXPORT_SYMBOL_GPL(kernel_can_power_off);
 
@@ -661,7 +687,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	struct sys_off_handler *sys_off = NULL;
 	char buffer[256];
 	int ret = 0;
 
@@ -686,21 +711,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	if (ret)
 		return ret;
 
-	/*
-	 * Register sys-off handlers for legacy PM callback. This allows
-	 * legacy PM callbacks temporary co-exist with the new sys-off API.
-	 *
-	 * TODO: Remove legacy handlers once all legacy PM users will be
-	 *       switched to the sys-off based APIs.
-	 */
-	if (pm_power_off) {
-		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
-						   SYS_OFF_PRIO_DEFAULT,
-						   legacy_pm_power_off, NULL);
-		if (IS_ERR(sys_off))
-			return PTR_ERR(sys_off);
-	}
-
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
@@ -758,7 +768,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 	}
 	mutex_unlock(&system_transition_mutex);
-	unregister_sys_off_handler(sys_off);
 	return ret;
 }
 
