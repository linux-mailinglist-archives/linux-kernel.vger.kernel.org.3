Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF34983E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiAXPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiAXPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:55:26 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7CC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:55:26 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h7so2096121iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAk46n1MPi9gPpAjJNci/8kPlMhpslWLN7yEsIjhWq4=;
        b=GewqqABG6/7V/ms2Yxh7ww0Nktw+O/cM64/81V2i9uPU+eqLQGhPIxs51HP/nA4dY3
         NBwP5hsYz/pkFblWVNpzZWr2f1OLQNhVUcqIZaiWJK0qbBeZ/mhUzr5oUmVvgxDGxLdS
         Yc2pEbNFbzn8HwdF0zHkzo0nTuUQqmtK9e0zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAk46n1MPi9gPpAjJNci/8kPlMhpslWLN7yEsIjhWq4=;
        b=YHVoYASzWg56QBzy8eorpTAiJjdhtetfAOpgofEtRTMeFaRnp7OqIbcpKETHMFDhpN
         AHriKCwvCoz/jqflM8zxt3potyfrjmFzz/maRYJ8hGCLZ2r1EabLfaqFj8K/wEuleVxA
         TTISyXSttLwjJpwmsCavBURUfIFFzDRN1916L0yty3ANlYZPEDnHTfJJidvnKP96q6ZH
         qpG4nxixVrYq7z5NLwW1xeUlv7mRHXSiQG6zQQ0tjI8McV23PqP07vCn0Bl+qEfUYGWe
         yeat5igN3xdYf+BfWIFBi0MArTRU8d0CmzZEuUIn1qChyDfdu7XfoxO2KIRjRW3zpzb/
         SDOw==
X-Gm-Message-State: AOAM530sUBpkQrQz9l17At02hwg1IUTmbDdi5a3WS9/JcmJjvGZG2SHl
        TI98gzBldNygNYZ7fUieBZP4bVn6NlL63DzDz/FL6g==
X-Google-Smtp-Source: ABdhPJyxBqzCdPqA56UWB4jv/1dn8GxVWqJQuoJalf6pMaCqUpsM+VCbcLeIjIQvF+SRKk4FjmW02qOpqmaS1PtY8Pg=
X-Received: by 2002:a02:6d04:: with SMTP id m4mr6392976jac.80.1643039725076;
 Mon, 24 Jan 2022 07:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20220123001258.2460594-1-sashal@kernel.org> <20220123001258.2460594-3-sashal@kernel.org>
 <20220124075041.13c015a6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20220124075041.13c015a6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 24 Jan 2022 15:55:14 +0000
Message-ID: <CALrw=nFwuo=OWzDimGK0MyqLs4LBu9_WkKxXLpw+e2oTJAD8Lw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 3/9] sit: allow encapsulated IPv6 traffic to
 be delivered locally
To:     Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, netdev <netdev@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Amir Razmjou <arazmjou@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 3:50 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 22 Jan 2022 19:12:52 -0500 Sasha Levin wrote:
> > From: Ignat Korchagin <ignat@cloudflare.com>
> >
> > [ Upstream commit ed6ae5ca437d9d238117d90e95f7f2cc27da1b31 ]
> >
> > While experimenting with FOU encapsulation Amir noticed that encapsulated IPv6
> > traffic fails to be delivered, if the peer IP address is configured locally.
>
> Unless Ignat and Amir need it I'd vote for not backporting this to LTS.
> This patch is firmly in the "this configuration was never supported"
> category. 5.15 and 5.16 are probably fine.

We planned to use it on 5.15 and onwards. Not backporting to 5.10 is
fine for us.
