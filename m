Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B961346F255
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhLIRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbhLIRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:44:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CEC0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:41:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so22389609edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgwf0EqG1zOV5K51D86bZBb5Zvrw1Vxqre5N6HLlv/s=;
        b=BSJojAdwqlU2UjVnJob211Ie71far1uO/y3X3p/GvID7KC2+Noijrz3C3WGAIijESg
         nN2BEZxD0COSoVdFS+jdZkm3XLXJFd4062mm4OImPWczg9gP/V6+KXu5C++qLZriXu/a
         9cWeJmmQVCJtHqGb4pShPCncTPYei+UIgmwjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgwf0EqG1zOV5K51D86bZBb5Zvrw1Vxqre5N6HLlv/s=;
        b=030FcQ6JB0fg28b7vxZ7AhersP0n5T6iVkVns6J8UbhsF5AVAUNze8ulIolOMZRdgA
         BzzIwQ45BWKgeZ0uK4ujN7u/9bY2wDbhfwxpoh01L9G+NLGniyxg5NsVjiVk0BIoomyS
         mQAk5+PGqQnoA3IODBENH98naIRMc0PG1e9qXCq6aDt/Gt7hLlDTyu1ul8+/Dr+QuuCM
         KiulJCFqnKf157V5tLF2e/pdrHRWRqSDvizZAuBzMCYXDFd6xj/259BkYDJklZje2KIP
         PTfoDfdrN/z77X2+FGi1biCCY9U554Qng2pIXNQAWNHGzMpH+BXVcOfwJH74AnUbup3g
         CPCQ==
X-Gm-Message-State: AOAM532+8zGBjs8MPGGwcF34pHo6LygzbKPYI7WOtAVm1vxy2cA8f7iE
        S3UI7kVrSOooDMtA3X71mv1anMlZBMJHR+3wV30=
X-Google-Smtp-Source: ABdhPJx+yRL0RBeB47wRmfNMxcvdgr2n0/H4hF9nPwPQMfsVk5pHBifoVDwkGJwDyk3C/DaOpQ0Y4w==
X-Received: by 2002:a17:907:c0e:: with SMTP id ga14mr17189076ejc.26.1639071537471;
        Thu, 09 Dec 2021 09:38:57 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id z8sm223719edb.5.2021.12.09.09.38.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:38:57 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id i5so11030175wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:38:56 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr7990589wrq.495.1639071536663;
 Thu, 09 Dec 2021 09:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20211209165113.150581-1-sashal@kernel.org>
In-Reply-To: <20211209165113.150581-1-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:38:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfioCtywT_9HnKufGsKwgLD3fEDDR=gPTqSVZrfdmiLQ@mail.gmail.com>
Message-ID: <CAHk-=wjfioCtywT_9HnKufGsKwgLD3fEDDR=gPTqSVZrfdmiLQ@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/lockdep: drop leftover liblockdep headers
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:51 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Clean up remaining headers that are specific to liblockdep but lived in
> the shared header directory.

Thanks, applied directly, the same way I took the original liblockdep removal.

                 Linus
