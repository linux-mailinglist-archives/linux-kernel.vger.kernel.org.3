Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7807D54E5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377765AbiFPPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377570AbiFPPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:25:18 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 08:25:16 PDT
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69C37A06
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:25:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id EA094399488
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1655392773;
        bh=2ebmjz3DZxCC+hSEljeBnmkIaKP8IuAOYICTMSOTjmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UdHf2fjty0QVDXLZttQNnTIKlRRsafhGqAhPnpQK7FLsXRCCV+ZVPjxeKbAw69ksB
         8vxSrf982AAtbsWGXRteTXLg+esyfK/UGwRYM9V7h3Db/6sKOOQyd7bvf9qNWBGgiZ
         Qoe9khTitVP865LL+fDxMtYnsp4WK1l7n/jkVQuI=
Received: from fx306 (localhost [127.0.0.1]) by fx306.security-mail.net
 (Postfix) with ESMTP id 97EC9399457; Thu, 16 Jun 2022 17:19:32 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 0E30639945D; Thu, 16 Jun
 2022 17:19:32 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id DF67E27E04E7; Thu, 16 Jun 2022
 17:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id C81D927E04EC; Thu, 16 Jun 2022 17:19:31 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 HRohE4rTlDqw; Thu, 16 Jun 2022 17:19:31 +0200 (CEST)
Received: from ws2104.lin.mbt.kalray.eu (unknown [192.168.37.162]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id B691C27E04E7; Thu, 16 Jun 2022
 17:19:31 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <1373d.62ab4a04.cf63.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C81D927E04EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1655392771;
 bh=ZnF5dOAqai9/DAKHxn+FgY+HSbzOiIIV25KahdTP0oo=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=gaU2Riaia48af4yqsScW3pl2L7Yf7P4xXQMwOKldoIJ1fKBssvAk3DgS+n3hAKo1w
 ULcf5OTQS0CtzPStFg74q9W/fr9LPpjB2KF2SY11xlrVKd+KDgjmlRVSyFnQpAdOvY
 EGzrsRdcSAwL3sJJbBs8rJwjo1efUBg9BLlmHiDo=
Date:   Thu, 16 Jun 2022 17:19:30 +0200
From:   Julian Vetter <jvetter@kalray.eu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        ysionneau@kalrayinc.com, jmaselbas@kalrayinc.com
Subject: Re: [PATCH v2 1/2] msi: The MSI framework only supports 2048
 platform MSIs
Message-ID: <20220616151930.GA22409@ws2104.lin.mbt.kalray.eu>
References: <20220614151411.32674-1-jvetter@kalrayinc.com>
 <Yqin77ydGHV9N85x@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yqin77ydGHV9N85x@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:23:27PM +0200, Greg KH wrote:
> On Tue, Jun 14, 2022 at 05:14:10PM +0200, Julian Vetter wrote:
> > Some devices need more MSIs. To support this the number must be
> > increased.

Hello Greg,
thank you for the feedback. See below my comments on it.

> What devices specifically?

You're right I didn't specify this. We have a mailbox device in our
system which supports up to 8192 MSIs. Our architecture is not yet upstreamed,
but the code can be found here https://github.com/kalray/linux_coolidge/blob/coolidge/drivers/irqchip/irq-kvx-apic-mailbox.c
It's a mailbox that can be written to, to trigger an interrupt. It has
128 x 64bit registers and each bit can trigger an interrupt.

> How many more did you just increase it by?
> 
> How much more memory are you now using?
> 
> Why is there a limit in the first place?  Why not just make it dynamic
> so that it never runs out in another month or so?
> 
> We need lots more specifics here...

I increased the number from 2048 -> 8192. But you're right. I just
increased it to the amount that it serves our device. But in my opinion could
it be increased to 2^16. Because the value is OR'ed with the device ID
((devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;) and I assume the device ID
will not exceed 65536. They are stored in a variable of type irq_hw_number_t
which is at least 32bit. So, we could just use the lower 16bit for the
MSI index and the upper 16bit for the device ID.

In terms of memory usage I'm not entirely sure. But the value in the
MAX_DEV_MSIS is only a "global" limit that ensures that we don't overflow the
variable. So, no additional memory is consumed. Because the size of the
IRQ bitmap is handled by other variable(s) (i.e. NR_IRQS).

> thanks,
> 
> greg k-h

Thanks you,
Julian




