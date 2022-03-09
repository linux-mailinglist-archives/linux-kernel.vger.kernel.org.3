Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4884D314D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiCIOz6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 09:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiCIOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:55:57 -0500
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 06:54:57 PST
Received: from omta013.useast.a.cloudfilter.net (omta013.useast.a.cloudfilter.net [34.195.253.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBABE169218
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:54:57 -0800 (PST)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.147])
        by cmsmtp with ESMTP
        id RtsUnfr06pH1ARxgqnyQHa; Wed, 09 Mar 2022 14:53:24 +0000
Received: from [192.168.1.121] ([68.0.59.20])
        by cmsmtp with ESMTPSA
        id RxgpnUPygfyzPRxgpnC5cg; Wed, 09 Mar 2022 14:53:24 +0000
Authentication-Results: cox.net; auth=pass (PLAIN)
 smtp.auth=cameronghall@cox.net
X-Authority-Analysis: v=2.4 cv=QPV7+yHL c=1 sm=1 tr=0 ts=6228bf64
 a=YRu6w0iJ0PLxWKpWPKeGRw==:117 a=YRu6w0iJ0PLxWKpWPKeGRw==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=WrZyhvej8QGNWhJhATAA:9 a=QEXdDO2ut3YA:10
Date:   Wed, 09 Mar 2022 08:53:21 -0600
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: [Input] Wrong button mappings on PowerA USB gamepad
To:     linux-kernel@vger.kernel.org
CC:     linux-input@vger.kernel.org
From:   Cameron <cameronghall@cox.net>
Message-ID: <2329F4E9-1A1B-4D8A-B853-F93A62FFC654@cox.net>
X-CMAE-Envelope: MS4xfO70W8CknrGTnBX98YGYLqVtGOZ7C10yqZr/BFnDr0NymeG7LGtEYeYqs0C/REuECSVrznvFjAhYe/BRFzRh4gp4ClGbuLyHN6wfL3xqm9KGq4kWviBk
 kifoOa9qc8WoRZ+9HP6FQPwm847ewidiyRCIteRXl8Clq2xkdRKcncT6eVBYpjOtx/9vVTUSr+BwtmDtvwKG8USQmDKgMuyf/fvyKNwvx99gc8wZwl6E50+N
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I sent an email about this issue to the linux-input mailing list a week ago, but still haven't heard back, so I am sending it to the generic kernel mailing list.

I am using a PowerA USB wired Nintendo Switch controller on Void Linux. Games and applications are able to successfully detect and use the controller, however the button mapping is very wrong in every program I have tested. I tested this with evtest-qt to see what button values evdev is reporting. Since there appears to be no way to remap these from userspace, I suspect the problem lies in the kernel driver.

Pressing the two analog sticks (which should be BTN_THUMBL and BTN_THUMBR) incorrectly generate events for BTN_SELECT and BTN_START, and pressing the + and - buttons (which should be mapped to BTN_START and BTN_SELECT) instead result in BTN_TL2 and BTN_TR2 events.

The device in question (as reported by lsusb) is:
Bus 001 Device 003: ID 20d6:a711 Core (Plus) Wired Controller

and I am using kernel version 5.15.26_1 on Void Linux.

I wrote a small kernel module to correctly remap the buttons (code is here https://gist.github.com/camthesaxman/af7099505103a555518741b4083eaea8), but I would like to know more about how this kind of situation is handled in the input subsystem in order to create a proper patch.

Thanks,
Cameron
