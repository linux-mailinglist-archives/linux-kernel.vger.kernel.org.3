Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF94C7140
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiB1QGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiB1QGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:06:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC541982
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5118761162
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8DFC340E7;
        Mon, 28 Feb 2022 16:06:00 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:05:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Willy Tarreau <w@1wt.eu>,
        David Laight <David.Laight@aculab.com>
Subject: Re: Strange output on the console
Message-ID: <20220228110559.2a8e0b32@gandalf.local.home>
In-Reply-To: <CAAq0SUkUAMyCoLt=n9X7+QH93zZ00ZpXNjG-gv7xUzL3YGtaPQ@mail.gmail.com>
References: <20220224230035.36547137@gandalf.local.home>
        <Yhhh730RX1HpdXp2@google.com>
        <Yhhj9MLZTrhjSWUE@google.com>
        <20220225083209.24bafe2c@gandalf.local.home>
        <20220225084256.071dcf82@gandalf.local.home>
        <YhmOifZcbbxVHPr9@google.com>
        <CAAq0SUkUAMyCoLt=n9X7+QH93zZ00ZpXNjG-gv7xUzL3YGtaPQ@mail.gmail.com>
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

On Sat, 26 Feb 2022 08:49:45 -0300
Wander Costa <wcosta@redhat.com> wrote:

> Hi Steve and Sergey,
> 
> Could you please tell the serial controllers in your hardware?

Not sure how to find that information, but I tried ;-)

On one machine, lspci gives:
 00:16.3 Serial controller: Intel Corporation 7 Series/C210 Series Chipset Family KT Controller (rev 04)

and dmidecode gives:


  Handle 0x0023, DMI type 8, 9 bytes
  Port Connector Information
          Internal Reference Designator: VGA/COMA
          Internal Connector Type: None
          External Reference Designator: COMA
          External Connector Type: DB-9 male
          Port Type: Serial Port 16550A Compatible

  Handle 0x0024, DMI type 8, 9 bytes
  Port Connector Information
          Internal Reference Designator: COMB
          Internal Connector Type: Proprietary
          External Reference Designator: COMB
          External Connector Type: DB-9 male
          Port Type: Serial Port 16550A Compatible


On another machine, there's nothing in lspci, and dmidecode gives:

  Handle 0x0007, DMI type 8, 9 bytes
  Port Connector Information
          Internal Reference Designator: J2A2A
          Internal Connector Type: None
          External Reference Designator: COM A
          External Connector Type: DB-9 male
          Port Type: Serial Port 16550A Compatible

and dmesg has:

  Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
  serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

Anything else I could do to find out more?


-- Steve
