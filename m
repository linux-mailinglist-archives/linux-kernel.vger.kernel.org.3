Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E184F4ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582575AbiDEXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357407AbiDELQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E0F28E09;
        Tue,  5 Apr 2022 03:45:14 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CE931EC02B9;
        Tue,  5 Apr 2022 12:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649155509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/5LBcy5siohW4oFuFeRpf6DCnAk2CessNOW+twB7uY=;
        b=LGiTheZnyXcmHnN6XZzLCW/0mEVkEf7wOP1WEXJasS41X6E41rojW0fFU3DUbi95ouWOvL
        +qP8ubIgpxNuiDJ8B7mOShS68hHBrzc1vZijoUZorxOdnSsPWpR5IuIr9pdd9saOH/pVq9
        4QE0lYfd7DhP+R9IBCJqJS8WuA9tED4=
Date:   Tue, 5 Apr 2022 12:45:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Biener <rguenther@suse.de>
Cc:     linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <YkwdtxNCpiERLFGW@zn.tnic>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr>
 <onrq8p1-582o-6rs9-r682-rs9sqoq7sq6p@fhfr.qr>
 <YkwbygWj/C3XooMV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkwbygWj/C3XooMV@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:36:58PM +0200, Borislav Petkov wrote:
> On Tue, Apr 05, 2022 at 12:06:45PM +0200, Richard Biener wrote:
> > Wird auch mit gcc 11 rejected.  Kanns sein dass mit gcc 7 andere
> > compiler flags genommen werden?
> 
> Found it:
> 
> $ gcc -fsanitize=shift -c switch.c
> switch.c: In function ‘foo’:
> switch.c:10:7: error: case label does not reduce to an integer constant
>        case (((0xfc08) << 16) | (0x0101)):;
> 
> $ gcc --version
> gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> Copyright (C) 2017 Free Software Foundation, Inc.
> 
> Something not fully backported?

Ok, not really:

gcc-10 -fsanitize=shift -c switch.c
switch.c: In function ‘foo’:
switch.c:10:7: error: case label does not reduce to an integer constant
   10 |       case (((0xfc08) << 16) | (0x0101)):;
      |       ^~~~

BUT!

when more switches are set with gcc-10 (full gcc cmdline from a kernel
build), then that passes.

But it doesn't pass with gcc-7.

Weird...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
