Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD64E6962
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352985AbiCXTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352964AbiCXTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:36:08 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2EA8BF49
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:34:33 -0700 (PDT)
Received: from [84.39.73.245] (helo=optiplex980.fritz.box)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <vogelchr@vogel.cx>)
        id 1nXTCY-0003fr-F3; Thu, 24 Mar 2022 20:32:54 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, vogelchr@vogel.cx
Subject: w1/ds2490: fix excessive logging
Date:   Thu, 24 Mar 2022 20:32:45 +0100
Message-Id: <20220324193246.16814-1-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YjSD8us/T3eHDwB2@kroah.com>
References: <YjSD8us/T3eHDwB2@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Greg, I've sorted the many pr_info calls in ds2490
that were used for rather eclectic logging into dev_info/dev_debug
instead of my first attempt of introducing a module parameter. Now
debugging should cease for the normal configurations without DEBUG.

Only the first two lines will show up, and the status will not be
extensively decoded/commented.

kern  :info  : [293529.095345] usb 2-1.3.1: Clearing ep0x83.
kern  :info  : [293529.097271] usb 2-1.3.1: ep_status=0x81,
        count=16, status=01:00:20:40:05:04:04:00:20:53:00:00:00:00:00:00
kern  :debug : [293529.097282] usb 2-1.3.1: enable flag: 0x01
kern  :debug : [293529.097286] usb 2-1.3.1: 1-wire speed: 0x00
kern  :debug : [293529.097290] usb 2-1.3.1: strong pullup duration: 0x20
kern  :debug : [293529.097293] usb 2-1.3.1: programming pulse duration: 0x40
kern  :debug : [293529.097297] usb 2-1.3.1: pulldown slew rate control: 0x05
kern  :debug : [293529.097300] usb 2-1.3.1: write-1 low time: 0x04
kern  :debug : [293529.097304] usb 2-1.3.1: data sample offset/write-0 recovery time: 0x04
kern  :debug : [293529.097308] usb 2-1.3.1: reserved (test register): 0x00
kern  :debug : [293529.097311] usb 2-1.3.1: device status flags: 0x20
kern  :debug : [293529.097315] usb 2-1.3.1: communication command byte 1: 0x53
kern  :debug : [293529.097318] usb 2-1.3.1: communication command byte 2: 0x00
kern  :debug : [293529.097322] usb 2-1.3.1: communication command buffer status: 0x00
kern  :debug : [293529.097325] usb 2-1.3.1: 1-wire data output buffer status: 0x00
kern  :debug : [293529.097329] usb 2-1.3.1: 1-wire data input buffer status: 0x00



