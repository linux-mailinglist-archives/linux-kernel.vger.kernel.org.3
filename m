Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6493A48A692
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbiAKDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiAKDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:43:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D5C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:43:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i5so8218404edf.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdvrBmP0mPwKb4JWkekj6mSFKKSyk8//kkI9lvd2Cu8=;
        b=NszoFqoF81m1sZRZHjugOzR1aCLA5CWi62KmxDm340AjUvZ1aFYiTySVSXVJLy6Z4i
         suBPg6ue2xbHsThfyWZ5DsSGU9Fq1IaUsIV+5zYIULmhvPq6JJX0qXMQU8EIGhMKIldI
         ZybpvkgNZDMgrEtmNL0QNYIHHXs+pS7x8Gp+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdvrBmP0mPwKb4JWkekj6mSFKKSyk8//kkI9lvd2Cu8=;
        b=B7qf7LENfWsFASRzeofDrelHT4MFGuCtJYRBBz0PLT9uyp1DxkDjtju3+L+WyuiJHK
         fA590V+2JUa7zeXLb1MFz0wSf7BhkS5aS7GNdPmxtjp4X/WIELG9XnL9eSf3BUaSo3m1
         YXHP8fvl3pDWj6qR2+KphoaA2L+s5m9YwwuIbP4Ucm44F0LK/ruEJczyVJp+8/QUDvxA
         YByCYAD+Q2CggE7AYmLtPegjFAPk59m3zAuRbvhmIThNY+40v/vtR07+RoNWlKk/xqra
         5hmXvomX9EQe/TZYw2sOJ9dx8VTZLAIw7X8gPs+rTjkG6u5QVijVcXLae6w7e3pFfmDu
         /xnA==
X-Gm-Message-State: AOAM532N3/lYJkmg6/j/Al/neh+hdmJp7oHAifoBaMhpycNfqnXLmnzA
        ZozEYaXAcyHAlhCmDilju/YC6GS6iE+eVwwC460=
X-Google-Smtp-Source: ABdhPJw33zdDDoGmKKHEZu961LoOkkFnOayRVnPPRuqtABSnbXtvm1rZIVPn4Sn7nRVBDrEVFAngEA==
X-Received: by 2002:a17:907:10d5:: with SMTP id rv21mr2097604ejb.52.1641872585276;
        Mon, 10 Jan 2022 19:43:05 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id g4sm4413894edp.25.2022.01.10.19.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 19:43:04 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id k30so12898517wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:43:04 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr2004530wrp.442.1641872584012;
 Mon, 10 Jan 2022 19:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20220110025203.2545903-1-kuba@kernel.org> <CAHk-=wg-pW=bRuRUvhGmm0DgqZ45A0KaH85V5KkVoxGKX170Xg@mail.gmail.com>
In-Reply-To: <CAHk-=wg-pW=bRuRUvhGmm0DgqZ45A0KaH85V5KkVoxGKX170Xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 19:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTN_hOyQ1_3DPgYJ_oBhwN+e29jrsj8qjqKsodRZ6r1Q@mail.gmail.com>
Message-ID: <CAHk-=wiTN_hOyQ1_3DPgYJ_oBhwN+e29jrsj8qjqKsodRZ6r1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.17
To:     Jakub Kicinski <kuba@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 7:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Merged. But I now note that this actually triggers an error when
> building with clang:
>
>   net/netfilter/nf_tables_api.c:8278:4: error: variable 'data_size' is
> uninitialized when used here [-Werror,-Wuninitialized]
>                           data_size += sizeof(*prule) + rule->dlen;
>                           ^~~~~~~~~
>
> and I think clang is entirely right.

I pushed out my trivial one-liner fix for this as commit 63045bfd3c8d
("netfilter: nf_tables: don't use 'data_size' uninitialized"). The
build error kept my clang builds from working, so waiting for any
alternate fix wasn't going to happen.

              Linus
