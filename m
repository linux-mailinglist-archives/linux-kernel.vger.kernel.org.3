Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481014F49F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453668AbiDEWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387971AbiDENUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:20:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE59D95D5;
        Tue,  5 Apr 2022 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E3zotaW1dbgZPSLuwko0wembR1SFboZ06zEGfDaR1Q4=; b=SpJ0FYLIVRfgL1ql9NafIxHBTk
        BWwcskNqRk7OMiga0j8XKJLMZbg0euqmaPZtVo13hltNk45VVcrsUp3Xs9Ul1FModE6HDvLgKQSEP
        nV1v9/rBdaSUupc/AF/o0Kogzjif0FBSMYzweFig8FjlWYA0VECv5+iXZjPwUveBhdgA7cTgaTRGS
        v9H3aY29hKR45cjXU5ytSBbm+YCBMJxJMcTvLWiRhJooFLSWhLypLyW2dOTnuOs6gs2VjU0jvcv62
        iGcdlMy3XYnOQZDhbRIer9AOXGCiY1rRtBzyuwZ1DqfhqetQiQhgsstfd0coTmKLf6fZnMQq1ft8P
        hO3fwNMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbiDd-001qvS-Eh; Tue, 05 Apr 2022 12:23:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0F2E3001EA;
        Tue,  5 Apr 2022 14:23:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 819002019C0B6; Tue,  5 Apr 2022 14:23:31 +0200 (CEST)
Date:   Tue, 5 Apr 2022 14:23:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        Richard Biener <rguenther@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkwQ6+tIH8GQpuct@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:50:35AM +0200, Borislav Petkov wrote:
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

IIRC GCC-8 fixed a bunch of -wrapv issues. Could be this is one of them
I suppose.
