Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6638A4F485B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381152AbiDEVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389357AbiDENdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:33:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED2EAC84;
        Tue,  5 Apr 2022 05:39:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5CAFD1F390;
        Tue,  5 Apr 2022 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649162360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44WdJDAM4MlPxpp8F4IUlomW8eAElCp3inRrCglwpEA=;
        b=te4oG7MY72SKmF273U2pX2k2+jHnDSNTgOk+ONkm2R8nMhGILo+e9GXOlwan922cj8u3A6
        HDBS34ElcfPt2jQeGz1Pxw430DT12bAMEUTqpLDXsvOR786TYOTK5C8R/Y9oYKnKbLY1x8
        gZpIANGTaDb2BeYLSEETOntX9yVpBLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649162360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=44WdJDAM4MlPxpp8F4IUlomW8eAElCp3inRrCglwpEA=;
        b=EqNQeYztjzGzSZ3CRA8Me4uKWtVwr+ytPqgCM1QxvVUmMXESpdPlw9i/GK0uTQ+OhoijHy
        aSHlpK/Esr43FBCw==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56E33A3B88;
        Tue,  5 Apr 2022 12:39:20 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id 4DD9E64E6; Tue,  5 Apr 2022 12:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id 4CA16628B;
        Tue,  5 Apr 2022 12:39:20 +0000 (UTC)
Date:   Tue, 5 Apr 2022 12:39:20 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Borislav Petkov <bp@alien8.de>, linux-toolchains@vger.kernel.org,
        Richard Biener <rguenther@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
In-Reply-To: <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.20.2204051232101.963@wotan.suse.de>
References: <YkwQ6+tIH8GQpuct@zn.tnic> <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1609957120-1876949182-1649162360=:963"
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

---1609957120-1876949182-1649162360=:963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hey,

On Tue, 5 Apr 2022, Peter Zijlstra wrote:

> > sound/usb/midi.c: In function ‘snd_usbmidi_out_endpoint_create’:
> > sound/usb/midi.c:1389:2: error: case label does not reduce to an integer constant
> >   case (((0xfc08) << 16) | (0x0101)):
> >   ^~~~
> 
> IIRC GCC-8 fixed a bunch of -wrapv issues. Could be this is one of them 
> I suppose.

Or better said, later GCCs returned back to the old behaviour of rejecting 
this only with -pedantic even in the presence of -fsanitize.  But 
pedantically speaking (ahem!) it really isn't conforming c99 (which the 
compilation flags claim) , and in this case it seems easy enough to make 
the construct actually be conforming in the kernel sources, so that should 
perhaps be done?


Ciao,
Michael.
---1609957120-1876949182-1649162360=:963--
