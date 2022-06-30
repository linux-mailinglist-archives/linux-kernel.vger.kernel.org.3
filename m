Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEEF561B16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiF3NMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiF3NMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:12:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02B2AE1E;
        Thu, 30 Jun 2022 06:12:00 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0A76122236;
        Thu, 30 Jun 2022 15:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656594719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GhwSrnQypOT7kztVVGLUbtw9wfZViKsA+oML1t/nB9Y=;
        b=vSWlBo3T2ton9o/3C9Vp46GYNKHx1HIFyXpLzIG6xPTlLno8t8pnbzoqi03smycjlRL5Hn
        MInw88G3yw+szTFDjVQttU/Fcy7YPB4lm6/cbSwMWeCng4SeYY/VvBSfzj16jBaNzGoOqf
        QJVYiZiAsU/NlLgFJvzkB8/NlUCTIUY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jun 2022 15:11:58 +0200
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Regression for duplicate (?) console parameters on next-20220630
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8460ecf2a963c85793cf325e16725044@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure it these are the correct recipients, feel free to CC 
others.

Since next-20220630 (or maybe also since next-20220629) I'm getting the

[    3.707900] WARNING: CPU: 0 PID: 38 at fs/kernfs/dir.c:531 
kernfs_put.part.0+0x1a0/0x1d4
[    3.716313] kernfs_put: console/active: released with incorrect 
active_ref 0

on both arm and arm64 boards. See for example:
https://linux.kernelci.org/test/case/id/62bd840b330c4851eaa39c16/

I have the console set in the device tree as well as on the commandline.
Up until recently that wasn't a problem and I guess that should be a 
valid
configuration. That being said, the warn() will go away if I remove the
console= parameter on the commandline.

I haven't had time to do a bisect yet. That will probably my next step;
or maybe kernelci will already do that for me, Guillaume? Unless someone
has some more insights/ideas.

-michael
