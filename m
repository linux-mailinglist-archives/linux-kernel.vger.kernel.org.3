Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316814EBC41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiC3IEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbiC3IE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4552BB33
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E7B617EF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B294C340EC;
        Wed, 30 Mar 2022 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648627363;
        bh=th87IHJy7/yDQo0A5r34hisJJu3XzxL2LpvctqkCO5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Em1zLiEDNn6z/j4HJswbyHsspjJZqMIHyuMbRAmq5BU4QDsuzo/imOKhbloiFCNv0
         zZM1zcfDAV2XbSaegpHVQHP56O3YmV08wu1bI8z0JOpWsR9dCiK6RPA0w7HZUCjlXl
         FWHa8+A+xPFdOKqoP/RGk4H/BZxR3wrL77aVmdaw=
Date:   Wed, 30 Mar 2022 10:02:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: mainline: qemu_arm64 boot failed - Failed to start Hostname
 Service - Stopped Serial Getty on ttyAMA0
Message-ID: <YkQOoQRUKemBEn02@kroah.com>
References: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:46:40PM +0530, Naresh Kamboju wrote:
> Linux mainline kernel booting qemu_arm64 and Raspberry Pi 4 boot
> failed [1] and [2].
> 
> Boot log:
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
> [    0.000000] Linux version 5.17.0 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
> for Debian) 2.38) #1 SMP PREEMPT @1648607824
> [    0.000000] Machine model: linux,dummy-virt
> 
> <trim>
> 
>          Starting Hostname Service...
> [FAILED] Failed to start Hostname Service.
> See 'systemctl status systemd-hostnamed.service' for details.
> [    2.453172] random: crng init done
> [    2.453522] random: 7 urandom warning(s) missed due to ratelimiting
> [    2.483013] audit: type=1334 audit(1648621045.348:8): prog-id=0 op=UNLOAD
> [    2.483953] audit: type=1334 audit(1648621045.348:9): prog-id=0 op=UNLOAD
> [    2.609230] audit: type=1334 audit(1648621045.476:10): prog-id=10 op=LOAD
> [  OK  ] Started Resize root filesystem to fit available disk space.
> [     ] A start job is running for Network Manager (6s / 1min 30s)
> ] A start job is running for Network Manager (7s / 1min 30s)[   ] A
> start job is running for Network Manager (7s / 1min 30s)[   ] A start
> job is running for Network Manager (8s / 1min 30s)[   ] A start job is
> running for Network Manager (9s / 1min 30s)[   ] A start job is
> running for Network Manager (9s / 1min 30s)[    [ A start job is
> running for Network Manager (10s / 1min 30s)[     ] A start job is
> running for Network Manager (10s / 1min 30s)[    [ A start job is
> running for Network Manager (11s / 1min 30s)[   ] A start job is
> running for Network Manager (12s / 1min 30s)[   ] A start job is
> running for Network Manager (12s / 1min 30s)[   ] A start job is
> running for Network Manager (13s / 1min 30s)[   ] A start job is
> running for Network Manager (13s / 1min 30s)    ] A start job is
> running for Network Manager (14s / 1min 30s)[     ] A start job is
> running for Network Manager (14s / 1min 30s)    ] A start job is
> running for Network Manager (15s / 1min 30s)[   ] A start job is
> running for Network Manager (16s / 1min 30s)[   ] A start job is
> running for Network Manager (16s / 1min 30s)[   ] A start job is
> running for Network Manager (17s / 1min 30s)[   ] A start job is
> running for Network Manager (17s / 1min 30s)[    [ A start job is
> running for Network Manager (18s / 1min 30s)[     ] A start job is
> running for Network Manager (19s / 1min 30s)[    [ A start job is
> running for Network Manager (19s / 1min 30s)[   ] A start job is
> running for Network Manager (19s / 1min 30s)[   ] A start job is
> running for Network Manager (20s / 1min 30s)[   ] A start job is
> running for Network Manager (20s / 1min 30s)[   ] A start job is
> running for Network Manager (21s / 1min 30s)    ] A start job is
> running for Network Manager (21s / 1min 30s)[     ] A start job is
> running for Network Manager (22s / 1min 30s)    ] A start job is
> running for Network Manager (22s / 1min 30s)[   ] A start job is
> running for Network Manager (23s / 1min 30s)[   ] A start job is
> running for Network Manager (23s / 1min 30s)[   ] A start job is
> running for Network Manager (24s / 1min 30s)[   ] A start job is
> running for Network Manager (24s / 1min 30s)[    [ A start job is
> running for Network Manager (25s / 1min 30s)[     ] A start job is
> running for Network Manager (25s / 1min 30s)[  OK  ] Started Network
> Manager.
> [  OK  ] Listening on Load/Save RF Kill Switch Status /dev/rfkill Watch.
>          Starting Network Manager Script Dispatcher Service...
> [   27.359980] kauditd_printk_skb: 11 callbacks suppressed
> [   27.359988] audit: type=1701 audit(1648621070.228:22):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=313 comm=\"(spatcher)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [  OK  ] Reached target Network.
>          Starting DNS forwarder and DHCP server...
> [   27.367248] audit: type=1701 audit(1648621070.232:23):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=315 comm=\"(dnsmasq)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
>          Starting Permit User Sessions...
> [   27.371110] audit: type=1701 audit(1648621070.240:24):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=317 comm=\"(sessions)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [FAILED] Failed to start Network Manager Script Dispatcher Service.
> See 'systemctl status NetworkManager-dispatcher.service' for details.
> [FAILED] Failed to start DNS forwarder and DHCP server.
> See 'systemctl status dnsmasq.service' for details.
> [FAILED] Failed to start Permit User Sessions.
> See 'systemctl status systemd-user-sessions.service' for details.
> [  OK  ] Started Getty on tty1.
> [  OK  ] Started Serial Getty on ttyAMA0.
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Reached target Multi-User System.
>          Starting Update UTMP about System Runlevel Changes...
> [   27.402975] audit: type=1701 audit(1648621070.268:25):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=322 comm=\"(ate-utmp)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [FAILED] Failed to start Update UTMP about System Runlevel Changes.
> See 'systemctl status systemd-update-utmp-runlevel.service' for details.
> [   32.398140] audit: type=1701 audit(1648621075.264:26):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=320 comm=\"(agetty)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [   32.399187] audit: type=1701 audit(1648621075.264:27):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=321 comm=\"(agetty)\"
> exe=\"/lib/systemd/systemd\" sig=6 res=1
> [  OK  ] Stopped Serial Getty on ttyAMA0.
> [  OK  ] Started Serial Getty on ttyAMA0.
> [  OK  ] Stopped Getty on tty1.
> [  OK  ] Started Getty on tty1.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://lkft.validation.linaro.org/scheduler/job/4809453#L252
> [2] https://lkft.validation.linaro.org/scheduler/job/4809125#L386
> 

That's a lot of userspace logs, any kernel logs showing that anything
failed?

thanks,

greg k-h
