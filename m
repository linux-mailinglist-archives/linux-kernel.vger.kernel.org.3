Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1364F4A80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457655AbiDEWrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392396AbiDENuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:50:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D4111DE0;
        Tue,  5 Apr 2022 05:53:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 20B38210EA;
        Tue,  5 Apr 2022 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649163198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+8JIbtU2VTfD3OB4UfbP2nnduY9ZA25ajUu+eR70tM=;
        b=YTWrWfAcdU5QcjE6lulkWjCsTBTep/SuRYlr+tHQARg72bM+fmj48GXRX8RqPqQ0AH2Ex5
        YAVK2HABdDNMB+iIz4izzLpDczxEpm3We98tOjDMbZwhfiXXoEIvUcL6VkdRWk/5/QXhmT
        KHItmkSzhkX5DcAO1h6pPVfm3Cuy+rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649163198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+8JIbtU2VTfD3OB4UfbP2nnduY9ZA25ajUu+eR70tM=;
        b=6Wc5+MK80zA6TtAq26/8yfzUsCj8Zxzq51GCFD0OgFwuVLDgZ9mtvKIQ14eXRgnnG8FQu1
        vxC3AaEdNQe276Dw==
Received: from murzim.suse.de (murzim.suse.de [10.160.4.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17D7FA3BB0;
        Tue,  5 Apr 2022 12:53:18 +0000 (UTC)
Date:   Tue, 5 Apr 2022 14:53:18 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     Michael Matz <matz@suse.de>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        linux-toolchains@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
In-Reply-To: <alpine.LSU.2.20.2204051232101.963@wotan.suse.de>
Message-ID: <79p0n5po-1377-4q33-3599-6129o38p96p@fhfr.qr>
References: <YkwQ6+tIH8GQpuct@zn.tnic> <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net> <alpine.LSU.2.20.2204051232101.963@wotan.suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1609908220-1478233879-1649163198=:27745"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1609908220-1478233879-1649163198=:27745
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Apr 2022, Michael Matz wrote:

> Hey,
> 
> On Tue, 5 Apr 2022, Peter Zijlstra wrote:
> 
> > > sound/usb/midi.c: In function ‘snd_usbmidi_out_endpoint_create’:
> > > sound/usb/midi.c:1389:2: error: case label does not reduce to an integer constant
> > >   case (((0xfc08) << 16) | (0x0101)):
> > >   ^~~~
> > 
> > IIRC GCC-8 fixed a bunch of -wrapv issues. Could be this is one of them 
> > I suppose.
> 
> Or better said, later GCCs returned back to the old behaviour of rejecting 
> this only with -pedantic even in the presence of -fsanitize.

Only that it doesn't:

#define USB_ID(v,p) (((v)<<16)|(p))
void foo (unsigned int *i)
{
  switch (*i)
    {
      case USB_ID(0xfc08, 0x0101):;
    }
}

> gcc-11 -S t.c -std=c99 -fsanitize=shift
t.c: In function 'foo':
t.c:6:7: error: case label does not reduce to an integer constant
    6 |       case USB_ID(0xfc08, 0x0101):;
      |       ^~~~

for some reason it might fail to sanitize the case label for the
full testcase but clearly it doesn't so on purpose.

> But 
> pedantically speaking (ahem!) it really isn't conforming c99 (which the 
> compilation flags claim) , and in this case it seems easy enough to make 
> the construct actually be conforming in the kernel sources, so that should 
> perhaps be done?

Indeed.  Simply cast vendor/product to (unsigned) in the USB_ID
macro to avoid arithmetic shifts.

Richard.
---1609908220-1478233879-1649163198=:27745--
