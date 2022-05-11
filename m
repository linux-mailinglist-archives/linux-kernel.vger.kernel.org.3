Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04E522D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiEKHs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEKHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:48:52 -0400
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362DBA99A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:48:49 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Wed, 11 May 2022 09:48:47 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Wed, 11 May 2022 09:48:46 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 09:48:47 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Wed, 11 May 2022 09:48:47 +0200
Date:   Wed, 11 May 2022 09:48:47 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Jiri Slaby <jirislaby@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: Remove pointless synchronize_irq() in
 uart_port_shutdown()
In-Reply-To: <91c006d0-c6ff-71fa-f0c3-22cf1896fc02@kernel.org>
Message-ID: <d157042-39ed-7b56-a40-e0c6c1e3f3db@pcs.com>
References: <4fe2d4a1-fc6a-c7fa-d884-5ebd01bebd3@pcs.com> <91c006d0-c6ff-71fa-f0c3-22cf1896fc02@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11.05.2022 06:00:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 May 2022, Jiri Slaby wrote:

> On 10. 05. 22, 15:54, Thomas Pfaff wrote:
> > From: Thomas Pfaff <tpfaff@pcs.com>
> > 
> > Calling synchronize_irq() after free_irq() is pointless, the context to
> > the irq is already lost.
> > It was noticed while creating the bugfix "genirq: Synchronize interrupt
> > thread startup".
> 
> That's correct for most drivers. But some drivers don't call free_irq() in
> ->shutdown(). So you likely have to move the synchronization to them. By a
> quick grep, I found icom, jsm, sccnxp, sifive, sunhv, and sunzilog.
> 

Sorry, I did not check all the drivers.
Then I would keep it in serial_core, as it does not hurt anymore.

Thanks,
    Thomas


