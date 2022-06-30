Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F1562502
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiF3VSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiF3VSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:18:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5E45781;
        Thu, 30 Jun 2022 14:18:40 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D049C22236;
        Thu, 30 Jun 2022 23:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656623918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9v9b2QyCY7aa76Uj7OzhyotVoaj9yPQj5f2StXzCJ0=;
        b=gValFbeRhfoKv08ktpW0wJolm7fhnt3dc5tvtCnf9g1xCl/WeuHpSUjWmHrKIukHWox3an
        eLLJ/EtO6zk+o16H8Os3k5t7y3IZn1IgtfWfr+ZKOboSV5NtfQSU6xVN9rCIW5xBab0NOy
        RugwpMNRpJCJCkY5dNjen1lyKAzjwkc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jun 2022 23:18:37 +0200
From:   Michael Walle <michael@walle.cc>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: Regression for duplicate (?) console parameters on next-20220630
In-Reply-To: <Yr37D4P2Dmnbkb+M@dev-arch.thelio-3990X>
References: <8460ecf2a963c85793cf325e16725044@walle.cc>
 <Yr37D4P2Dmnbkb+M@dev-arch.thelio-3990X>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <93f5abe324cba9de1bff4aee565f8d5a@walle.cc>
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

Am 2022-06-30 21:35, schrieb Nathan Chancellor:
> On Thu, Jun 30, 2022 at 03:11:58PM +0200, Michael Walle wrote:
>> Hi,
>> 
>> I'm not sure it these are the correct recipients, feel free to CC 
>> others.
>> 
>> Since next-20220630 (or maybe also since next-20220629) I'm getting 
>> the
>> 
>> [    3.707900] WARNING: CPU: 0 PID: 38 at fs/kernfs/dir.c:531
>> kernfs_put.part.0+0x1a0/0x1d4
>> [    3.716313] kernfs_put: console/active: released with incorrect
>> active_ref 0
>> 
>> on both arm and arm64 boards. See for example:
>> https://linux.kernelci.org/test/case/id/62bd840b330c4851eaa39c16/
>> 
>> I have the console set in the device tree as well as on the 
>> commandline.
>> Up until recently that wasn't a problem and I guess that should be a 
>> valid
>> configuration. That being said, the warn() will go away if I remove 
>> the
>> console= parameter on the commandline.
>> 
>> I haven't had time to do a bisect yet. That will probably my next 
>> step;
>> or maybe kernelci will already do that for me, Guillaume? Unless 
>> someone
>> has some more insights/ideas.
> 
> I noticed this as well when booting ARCH=um defconfig.
> 
> I ended up doing a bisect against next-20220630 and I landed on the
> driver-core merge (5732b42edfd18ee888e127fa13d425ed3ed1bef3). I did two
> more bisects to figure out that there is some sort of contextual
> contlict between commit 5831788afb17 ("Revert "printk: add kthread
> console printers"") and commit b8f35fa1188b ("kernfs: Change
> kernfs_notify_list to llist."), as it is only when those two changes 
> are
> present that this issue occurs. I am happy to provide more information
> if necessary.

Thanks for the info.

I can confirm that reverting b8f35fa1188b will fix the error. I couldn't
revert 5831788afb17 though, didn't apply cleanly.

-michael
