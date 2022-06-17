Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94E54FDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiFQTu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiFQTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:50:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F63135B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0813FB82B8A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D1AC3411B;
        Fri, 17 Jun 2022 19:50:21 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:50:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220617155019.373adda7@gandalf.local.home>
In-Reply-To: <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 15:36:43 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > Did you remove any modules before displaying the trace?  
> 
> I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
> And, trace_printk was working as expected on v5.18.

Are you sure?

I just checkout v5.19-rc2 and added the below patch. Then I did the
following:

 # rmmod bridge

 # trace-cmd start -p function -l :mod:bridge

 # insmod bridge

 # trace-cmd show
# tracer: function
#
# entries-in-buffer/entries-written: 23/23   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
        modprobe-2155    [005] ...1.  4732.051406: br_init <-do_one_initcall
        modprobe-2155    [005] .....  4732.051408: br_init: here in bridge
        modprobe-2155    [005] ...1.  4732.051408: br_fdb_init <-br_init
        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051418: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051418: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051418: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051419: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051420: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: br_device_event: this is an event
        modprobe-2155    [005] ...1.  4732.051421: br_netlink_init <-br_init
        modprobe-2155    [005] ...1.  4732.051421: br_mdb_init <-br_netlink_init

 # rmmod bridge

 # trace-cmd show
# tracer: function
#
# entries-in-buffer/entries-written: 56/56   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
        modprobe-2155    [005] ...1.  4732.051406: 0xffffffffc0cc7000 <-do_one_initcall
        modprobe-2155    [005] .....  4732.051408: 0xffffffffc0cc702b: here in bridge
        modprobe-2155    [005] ...1.  4732.051408: 0xffffffffc0cc7101 <-0xffffffffc0cc7043
        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051418: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051418: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051418: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051419: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051419: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051420: 0xffffffffc0d81340 <-call_netdevice_register_net_notifiers
        modprobe-2155    [005] .....  4732.051420: 0xffffffffc0d81345: this is an event
        modprobe-2155    [005] ...1.  4732.051421: 0xffffffffc0cc7132 <-0xffffffffc0cc70a3
        modprobe-2155    [005] ...1.  4732.051421: 0xffffffffc0da1500 <-0xffffffffc0cc713e
   kworker/u16:2-2023    [004] ...1.  4737.946576: 0xffffffffc0d81340 <-raw_notifier_call_chain
   kworker/u16:2-2023    [004] .....  4737.946578: 0xffffffffc0d81345: this is an event
   kworker/u16:2-2023    [004] ...1.  4737.946634: 0xffffffffc0d8e1a0 <-if_nlmsg_size
   kworker/u16:2-2023    [004] ...1.  4737.946735: 0xffffffffc0d81340 <-raw_notifier_call_chain
   kworker/u16:2-2023    [004] .....  4737.946735: 0xffffffffc0d81345: this is an event
   kworker/u16:2-2023    [004] ...1.  4737.946833: 0xffffffffc0d81340 <-raw_notifier_call_chain
   kworker/u16:2-2023    [004] .....  4737.946833: 0xffffffffc0d81345: this is an event
   kworker/u16:2-2023    [004] ...1.  4737.946834: 0xffffffffc0d8e1a0 <-if_nlmsg_size
   kworker/u16:2-2023    [004] ...1.  4737.957648: 0xffffffffc0d81190 <-cleanup_net
           rmmod-2206    [000] ...1.  5739.459376: 0xffffffffc0d8f880 <-0xffffffffc0da3d1d
           rmmod-2206    [000] ...1.  5739.459378: 0xffffffffc0da1570 <-0xffffffffc0d8f88a
           rmmod-2206    [000] ...1.  5739.471367: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471368: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471369: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471369: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471369: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471369: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471370: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471370: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471371: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471371: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471371: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471372: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.471372: 0xffffffffc0d81340 <-call_netdevice_unregister_notifiers
           rmmod-2206    [000] .....  5739.471372: 0xffffffffc0d81345: this is an event
           rmmod-2206    [000] ...1.  5739.477366: 0xffffffffc0d81190 <-unregister_pernet_operations
           rmmod-2206    [000] ...1.  5739.477375: 0xffffffffc0d84910 <-__do_sys_delete_module.constprop.0

Before removing the module, the names were all present. Then after I
removed the module, they did not exist.

Other than that, I cannot reproduce the issue.

-- Steve


diff --git a/net/bridge/br.c b/net/bridge/br.c
index 96e91d69a9a8..4067760d3763 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -36,6 +36,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	bool changed_addr;
 	int err;
 
+	trace_printk("this is an event\n");
 	if (netif_is_bridge_master(dev)) {
 		err = br_vlan_bridge_event(dev, event, ptr);
 		if (err)
@@ -385,6 +386,7 @@ static int __init br_init(void)
 		return err;
 	}
 
+	trace_printk("here in bridge\n");
 	err = br_fdb_init();
 	if (err)
 		goto err_out;
