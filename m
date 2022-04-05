Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9ED4F4DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiDEXxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354203AbiDEKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:12:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06A53E2C;
        Tue,  5 Apr 2022 02:58:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE1411F745;
        Tue,  5 Apr 2022 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649152713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9a/4aWMnWgkY65Ue+vqroxBzn1D+3uaU5AzDsaTyLNk=;
        b=2Wea9AbDcGVfSFq0QG3rlJWkGO+m7CJ4DLAeyJSfPiKAbSa9IUttz9RwKzFsHbtpu7P086
        PIwrqr+4xrLKni7Ee2uD8j4mfQqFgRuyq+fNoR0SCVO6Lz4tgH2+YvXgEDXeFs+7H8HbY4
        oC4d/GeD4tyVud9VBdkNCNEYYIy7Tq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649152713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9a/4aWMnWgkY65Ue+vqroxBzn1D+3uaU5AzDsaTyLNk=;
        b=KFhmiYSggNmD9D1VA7PMDbsQDcs7P8Xutg+p8/i9NhcXPmq3NfN4ykB1Ymc2mxyE0638a1
        XEVmsUz7jSSQscDg==
Received: from murzim.suse.de (murzim.suse.de [10.160.4.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B7283A3B83;
        Tue,  5 Apr 2022 09:58:33 +0000 (UTC)
Date:   Tue, 5 Apr 2022 11:58:33 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
In-Reply-To: <YkwQ6+tIH8GQpuct@zn.tnic>
Message-ID: <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1609908220-30019681-1649152713=:27745"
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

---1609908220-30019681-1649152713=:27745
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Apr 2022, Borislav Petkov wrote:

> Hi folks,
> 
> I'm starting to see failures like this on allmodconfig builds:
> 
> sound/usb/midi.c: In function ‘snd_usbmidi_out_endpoint_create’:
> sound/usb/midi.c:1389:2: error: case label does not reduce to an integer constant
>   case (((0xfc08) << 16) | (0x0101)):
>   ^~~~
> 
> (The case statement is a macro but it evaluates to what I have there)
> 
> and that thing fails with
> 
> $ gcc --version
> gcc (SUSE Linux) 7.5.0
> 
> although it doesn't have any problems building with newer compilers.
> 
> I'm presuming older gccs consider those case statements signed ints and
> the following fixes it:
> 
>   case ((((unsigned int)0xfc08) << 16) | (0x0101)):
> 
> and I guess we can whack the couple of occurrences but what I'm
> wondering is why does this work with newer gccs?

I tried

void foo (int i)
{
  switch (i)
    {
      case (((0xfc08) << 16) | (0x0101)):;
    }
}

also with 'unsigned int i' but that's accepted with GCC 7.  So
what do you switch on?

> Thx.
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH, Maxfeldstrasse 5, 90409 Nuernberg,
Germany; GF: Ivo Totev; HRB 36809 (AG Nuernberg)
---1609908220-30019681-1649152713=:27745--
