Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FB5135A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbiD1Nvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbiD1Nvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:51:42 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3ECB3C47
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:48:27 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C3E1BCD1C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:45:13 +0000 (UTC)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 539D120000E;
        Thu, 28 Apr 2022 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651153508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N1Tulo/oSEe9H5n9GB4cImHi2WR56NZD7DcX6uZWIXk=;
        b=myJyZ8GGk5A2p0B9uBpfnuL2ZsC88dbhxXN9V1IW/gYeN20Yi9+foPepcWeqn7tTZtHtU6
        oTlhFG+BNBdMXBnKx8WSLj65E8tZqaxdjntrsFz0Qk74wzLDmOpfTAKGdxwX3/lPPgSAAe
        aSRMBNr86AHB30Vzets23IKTQAQfO6lmYlub17OaW4CY/8v8ajjiXSGzJTwnzqDiokUSUo
        GBvbXM8ZGvVtP0fhB4KQM0ikT/xjHa7tYhdKV0wKcY9v9lhgLa55vIEJHiI8m2SSncLVlD
        hq5piOHpdOZKTD71sxcXEfdmajdjiJVYQM/i5B4Pqf5kJ8opSz2TxsEOk4JftQ==
Message-ID: <574d4aad-b786-71bc-18a0-f768a585658a@bootlin.com>
Date:   Thu, 28 Apr 2022 15:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     michael.opdenacker@bootlin.com
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
From:   Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: How to mount the root filesystem with "strictatime"?
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Sorry, this is almost a userspace question ;-)

I need to mount my root filesystem in "strictatime" mode, instead of the
"relatime"  default.

Of course, if I pass "rootflags=strictatime" through the kernel command
line, it doesn't work because the kernel only knows about the
"MS_STRICTATIME" define, and not about the "strictatime"  string, which
is a userspace thing:

    2.351189] EXT4-fs (mmcblk0p2): Unrecognized mount option
"strictatime" or missing value

Would there be a way to do this from the kernel command line anyway?
Otherwise, I'll run "mount -o remount,strictatime /" from my startup
scripts.

Thanks
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

