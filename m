Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC7483482
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiACQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:04:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiACQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:04:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8F2761126
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF8CC36AEE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:04:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="euNC59Gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641225850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8XHTGmIYKfD7qz9WmayRlS7affLgiwwdlzXM0fF5sx8=;
        b=euNC59Gdg1IRgTjLMVC5WO8ojrapdeVJK0jxeIYwhUh8LYkppDZmFd8QvwuKFRCICqxd8m
        yjYaLeDjhjqeRlincPFOsR/JYTnOR7Xwb/Ae/d9RronL/5Jl5SRIGds30rSPnv+tTtltYd
        0enrdAbsY8+PfDeDNdMVRN0mqHj6hEU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4152c907 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Jan 2022 16:04:10 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id i3so85803614ybh.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:04:10 -0800 (PST)
X-Gm-Message-State: AOAM530PNoR2iX9n4ycdvNOwxak9HWbZYVFCDZGaagLqlYcOnfuvmGFd
        S0SHJittdUoIXt2ZPN/7Y3aQoq7lmqOn7d1C3+Q=
X-Google-Smtp-Source: ABdhPJxpnZK/nss7YOJdP04E99smgWiQImSFQc2JyynsCr4i//o8xtbFKOyOPXMbxLPUGGGXyiUeQm7byu6r8RdExns=
X-Received: by 2002:a25:3bd3:: with SMTP id i202mr31628670yba.115.1641225849331;
 Mon, 03 Jan 2022 08:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20220103155931.411722-1-jannh@google.com>
In-Reply-To: <20220103155931.411722-1-jannh@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 17:03:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9otnT=XeMPGYW5H8TOu9aLxxKi6_gT-Fnvh5Jy+WM-HGA@mail.gmail.com>
Message-ID: <CAHmME9otnT=XeMPGYW5H8TOu9aLxxKi6_gT-Fnvh5Jy+WM-HGA@mail.gmail.com>
Subject: Re: [PATCH] random: Don't reset crng_init_cnt on urandom_read()
To:     Jann Horn <jannh@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 4:59 PM Jann Horn <jannh@google.com> wrote:
> This code was inconsistent, and it probably made things worse - just get
> rid of it.

Rather than adding crng_init_cnt=0 if crng_init<1 to extract_crng_user
and get_random_bytes, getting rid of it like this seems probably okay
and makes the model simpler. I'll apply this. Thank you.

Jason
