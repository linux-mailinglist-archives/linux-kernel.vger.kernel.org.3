Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0184A4DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiAaSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiAaSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:07:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40291C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:07:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u24so28193660eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ngbIhCdogOcBSU1e6pp7yjPEGqtjsYnsxL5Y/3BpBs=;
        b=MWuX920xhwonGe/Eb70HBXGdjtu5RWpImkn9WM5pAZLILk/by+T+gAKQz/5ki2lADw
         ahNGvnc4HO9cFwyKxVCsJVfkrcrG7gniiWGieXnlzfe/2y+gBJm8alG9ty1aFzqpcBxZ
         uhsIC39YV0NmuPj2wAfQThdYZ5J29CbkiQZm6ux11SRxNh2wz3GyJ9cW+ziYHgSfFZRG
         f6gf0+csG0COT81NSw2TlP0ORR6mF7X1jao/BWb4X/Q+hzIykX0brdlNiRx8Nmuz0+Dd
         DOjAOzM8e8xnWD27OTh5Wm6zdca6CDEHBb3ZJxsj1Lzxpm79u43XqAPsQNA7zEsvubwN
         zVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ngbIhCdogOcBSU1e6pp7yjPEGqtjsYnsxL5Y/3BpBs=;
        b=iQW9X2xfnoQeqtG6h3LxJ42zzqzSbv1fyz+md6/0mcldql8OsujSlS7vVag4lJMH/O
         BqIoYPqx2CQnsP0MZjvTNcJIMo+0AksWPLt7MYfo8c93O9qbSmq9MtYZCiEOhhu0sJYX
         p65f0zsZc304CZkhS2U9JEVNCg9QBoWBQkZCkHwTrU553HfRwaFhcoSjWlGQ5+Y6FnLM
         o8TqLLO/yclGyfIauHLkC41l1HFnc6JXlPi++mERek45sArWDqGA+5rs0MXhrHLyUWT4
         sicYgrasUeAvPSyS7zPWCTIrForCsW/7tO8UWSLEoxWFOF0SVkvHlUwrJeoKjrUo2mvq
         pD5Q==
X-Gm-Message-State: AOAM5338G19id1DXScG/sA8SXCABuxvAOeuZ1klzeNi+s7vuGrhV2PJR
        y9LVGcuBfa8wBY4VxJC51qN0fO7PMuKdMpt9iqwU0Q==
X-Google-Smtp-Source: ABdhPJxEX+n+D2eQlJRrREPiJ7wffLrZ03BnYNKye/ZjKAndcysFBqZMj1aZaz1ZTaqJGUM4F6BF+1mZFxobl19IeCI=
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr22007921edd.294.1643652426755;
 Mon, 31 Jan 2022 10:07:06 -0800 (PST)
MIME-Version: 1.0
References: <YfgivbCgwKjJu9ec@fedora> <Yfgjhq6LIzhKNaTU@casper.infradead.org>
In-Reply-To: <Yfgjhq6LIzhKNaTU@casper.infradead.org>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Mon, 31 Jan 2022 15:06:55 -0300
Message-ID: <CAH7FV3kL=6-aKjrYNS7LkbN3Z2MzKufCCrWP5xHSicytAGTPkQ@mail.gmail.com>
Subject: Re: [PATCH v2] seq_file: fix NULL pointer arithmetic warning
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em seg., 31 de jan. de 2022 =C3=A0s 14:59, Matthew Wilcox
<willy@infradead.org> escreveu:
>
> On Mon, Jan 31, 2022 at 02:56:13PM -0300, Ma=C3=ADra Canal wrote:
> > +EXPORT_SYMBOL(single_start);
>
> kernfs is a 'bool', which means it can't be a module, so there's
> no need to EXPORT this symbol.

Thank you for the feedback! Still learning...
