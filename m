Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B33516BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359354AbiEBIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359278AbiEBIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:25:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33440A2C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DF8ECE17C8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3817AC385A4;
        Mon,  2 May 2022 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651479702;
        bh=DO14eca36/8x8DjDJdsA4uwFGc1SVhaWvo9PYVUd8XY=;
        h=Date:From:To:Cc:Subject:From;
        b=A1qsWe1ZePTa1hFfNqFpyfe+uDovYVrObUOPp0E9EnPjbNt7toS/j1Mm1Zc5D/K1X
         iisfsULu30schurBChEpNXnfYwvjJcyBndBTKH8PUpcHESVguc+L0EbAqRTIYsRFq4
         49xdPbJtdD4vKasyUlWCaWxYh7FucXtR7l2aqt2Z9Cu5iDL4zzae1UUcBDUqDj7QmR
         1SGtRinvzDUWhXs4N4JVdl9wGOrS8v49MyeEuss6PqaVo2RNviJMVuTzbqnjHIjj/x
         hmoISSgtEE8mJH1+nFjcwnO3XbjOY6WMempkByZH6j89q7TsGfobBJTMkTeKxvrAqZ
         gD3wlcoyrENOw==
Date:   Mon, 2 May 2022 10:21:37 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        pali@kernel.org
Subject: irqdomain API: how to set affinity of parent irq of chained irqs?
Message-ID: <20220502102137.764606ee@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Marc, Thomas,

we have encountered the following problem that can hopefully be put
some light onto: What is the intended way to set affinity (and possibly
other irq attributes) of parent IRQ of chained IRQs, when using the
irqdomain API?

We are working on a driver that
- registers an irqchip and adds an irqdomain
- calls irq_set_chained_handler_and_data(parent_irq, handler)
  where handler triggers handling of child IRQs
- but since parent_irq isn't requested for with request_thread_irq(),
  it does not show up in proc/sysfs, only in debugfs
- the HW does not support setting affinity for the chained IRQs, only 
  the parent (which comes from a GIC chip)

The problem is that he parent IRQ, as mentioned in the third point, does
not show up in proc/sysfs.

Is there some precedent for this?

Thank you.

Marek
