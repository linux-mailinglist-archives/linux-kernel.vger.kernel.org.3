Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109A44950DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbiATPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiATPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:03:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB53C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:03:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDAC961811
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA00C340E9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:03:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iMVOSBZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642691033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DcwDRP0dP9OA/GQEOpitTE09xlkAhrUZn3ox+C9GSoY=;
        b=iMVOSBZK4KEG+CUCuW4emWG+Lw0L+sQuqOaW+WDcYwfsOd9woRtnWIa8CMGP20pasCCP+S
        44MXtdn2vaWdoQYcQ0uskL0VqtcqJurm+aocqwQdnWUij3uyNCyskV3Xcg41LiPGjGZTwp
        SDvg+r51Yh8eAv5nGTBcVDZzTDFTj/A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e93442dd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jan 2022 15:03:53 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id r65so15040033ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:03:52 -0800 (PST)
X-Gm-Message-State: AOAM533vShdV8iEesTPUJup7Isc1NHnOX43aZA7Q/H2dlNbt0wvh8KSM
        y/2aCuWqapBh91eK8E4UwhacOIS2IW8Hib/RnWw=
X-Google-Smtp-Source: ABdhPJw5Xvkn5uUd5puek8Vt5EmQz4Lhu2/XNE2k3MqZxXhUqx69rHU8pXpqtNy4zWWaLCkRuY6tr6nzLKbH5rleLjk=
X-Received: by 2002:a25:244b:: with SMTP id k72mr9048574ybk.638.1642691032219;
 Thu, 20 Jan 2022 07:03:52 -0800 (PST)
MIME-Version: 1.0
References: <Yc56ey6QKwaYg0yi@mit.edu> <20211231114903.60882-1-Jason@zx2c4.com>
 <Yc86TIah3w4waDEc@mit.edu> <CACXcFmm2nKLHdqN27Ced2nLg=h2mSX_fKWFf-OkgArVRDi3xTw@mail.gmail.com>
 <YdPhZQqM52viEttQ@mit.edu>
In-Reply-To: <YdPhZQqM52viEttQ@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Jan 2022 16:03:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
Message-ID: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
Subject: Re: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG extraction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 6:55 AM Theodore Ts'o <tytso@mit.edu> wrote:
> If we want to worry about what happens if we could actually manage to
> call _extract_crng() more than 2**64 times before the reseed interval
> is up --- which *is* one of the benefits of:
>
>    if (arch_get_random_long(^v))
>         crng->state[14] ^= v;
>
> I could see doing perhaps this instead:
>
>     if (crng->state[12] == 0) {
>         crng->state[13]++;
>         if (crng->state[13] == 0) {
>             crng->state[14]++;
>             if (crng->state[14] == 0) {
>                 crng->state[15]++;
>             }
>         }
>    }

While probably overkill, I've got a patch that does this while also
labeling these constants. I'll send that as a reply to this message.

Jason
