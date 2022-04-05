Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F004F4339
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380825AbiDEU2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384326AbiDEM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0B65A7;
        Tue,  5 Apr 2022 04:41:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 46F141F745;
        Tue,  5 Apr 2022 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649158869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRRxg6udnXTabhP4kMhtiuHHu5+YdylTuzhfgNh5DT0=;
        b=0wtAiHZ2XsShXe7cIptTg3k8X+4oHApryJqVK5hd+8cqRZjLseNjHnoZcQcoQxyD1OWXot
        1ZeREICduo8y7r8BsKPU1y+qehLHwuE7pWYzuzwgfIeWIUC4Eykm5wBfzxrxDHVkTCnZCN
        OIrZG9eU4ycjps7xaIJr/M1NryFB5rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649158869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRRxg6udnXTabhP4kMhtiuHHu5+YdylTuzhfgNh5DT0=;
        b=9+UNg7nWIBJgpgt0CtdlOpv95TMNTWHUt1bUOVG/Ue0N2y64KaP0ZmC0jpV692HZP1gqMa
        YEUb3/5QV6AuxfCw==
Received: from murzim.suse.de (murzim.suse.de [10.160.4.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3FB16A3B94;
        Tue,  5 Apr 2022 11:41:09 +0000 (UTC)
Date:   Tue, 5 Apr 2022 13:41:09 +0200 (CEST)
From:   Richard Biener <rguenther@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
In-Reply-To: <YkwdtxNCpiERLFGW@zn.tnic>
Message-ID: <rppnr36-25n9-nors-3p6-3oos06219s8@fhfr.qr>
References: <YkwQ6+tIH8GQpuct@zn.tnic> <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr> <onrq8p1-582o-6rs9-r682-rs9sqoq7sq6p@fhfr.qr> <YkwbygWj/C3XooMV@zn.tnic> <YkwdtxNCpiERLFGW@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1609908220-1777648094-1649158869=:27745"
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

---1609908220-1777648094-1649158869=:27745
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Apr 2022, Borislav Petkov wrote:

> On Tue, Apr 05, 2022 at 12:36:58PM +0200, Borislav Petkov wrote:
> > On Tue, Apr 05, 2022 at 12:06:45PM +0200, Richard Biener wrote:
> > > Wird auch mit gcc 11 rejected.  Kanns sein dass mit gcc 7 andere
> > > compiler flags genommen werden?
> > 
> > Found it:
> > 
> > $ gcc -fsanitize=shift -c switch.c
> > switch.c: In function ‘foo’:
> > switch.c:10:7: error: case label does not reduce to an integer constant
> >        case (((0xfc08) << 16) | (0x0101)):;
> > 
> > $ gcc --version
> > gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> > Copyright (C) 2017 Free Software Foundation, Inc.
> > 
> > Something not fully backported?
> 
> Ok, not really:
> 
> gcc-10 -fsanitize=shift -c switch.c
> switch.c: In function ‘foo’:
> switch.c:10:7: error: case label does not reduce to an integer constant
>    10 |       case (((0xfc08) << 16) | (0x0101)):;
>       |       ^~~~
> 
> BUT!
> 
> when more switches are set with gcc-10 (full gcc cmdline from a kernel
> build), then that passes.
> 
> But it doesn't pass with gcc-7.
> 
> Weird...

As was noted in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66880
this is invalid C99+ but compilers are not required to diagnose that
(you get it diagnosed with -pedantic).  -fsanitize=shift exposes
it though since the non-integral-constant gets instrumented.

Richard.
---1609908220-1777648094-1649158869=:27745--
