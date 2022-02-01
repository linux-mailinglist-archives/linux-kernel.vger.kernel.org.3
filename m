Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D424A64E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiBATWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiBATWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:22:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87674C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:22:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p7so36434408edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tE/R9yvWA3Atyfb/JucqCUJU8G/DgubFOZDhk5Lo/ew=;
        b=XId/LPiTasBZmFrfoW21pxoJPIg+5+IY4ExAd2xTeXcpnBZedpcqKEDIvB/hHwHc0I
         WbSayqRMIlMgSbTwqIHUwMDXFCHiDwOZDP6ZtanGpRE63HQcOiOU53CK8pWHwGUOOk6g
         rAbF/CKE/TzqH+hhEUF0iZR61axOWuOj/9EvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tE/R9yvWA3Atyfb/JucqCUJU8G/DgubFOZDhk5Lo/ew=;
        b=d5cERSvs4M2tREDRffCsj4I/xVmsTtWXEKFn0WGC4pkxaQVxzjDlFYFk7SlyFqvPO/
         FDBv79EREEafGH1AsRmcajfaF4KommOt+aK+4t4mmyru6Kq7lqG74k07YiC+JiOKlU+N
         VHubQV+SREjJA0xNgcRLdNsh9Xuclvir4ajIl0x3uw5Z/Wx2rzfb0G0H0VMSAe1j0+fR
         jBje6Gv6iINsN7TqAg9f51B0jEWH3MJmVzKfEdYvOzagNLrNBa4+RALRZjHKt77OF2Wc
         f0dCWOwdGwdF7tTktOaBRcovv46i0rRzrnWFZPKwaGVJIRBCOFdGCPBqXlZ/wERyCbkl
         IMcg==
X-Gm-Message-State: AOAM533UiYPZf1XSjMThO1LvyInOTfCIlndpDYwF89TLaaFVJoi26QWu
        3gSNb/gapaMB+WzgNmcFIaWHpsxPhmKR/KCP
X-Google-Smtp-Source: ABdhPJyXH1kRkU+S6n6pzleHX8aWxUlQqqrBIDZz1V4lFdvjGViMIX6Ls0GyiUVNdr98ZzYGnbqXDA==
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr26219161edt.198.1643743331860;
        Tue, 01 Feb 2022 11:22:11 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id g9sm14723809ejf.33.2022.02.01.11.22.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:22:11 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id m14so33738161wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:22:11 -0800 (PST)
X-Received: by 2002:adf:d1c8:: with SMTP id b8mr472549wrd.442.1643743329676;
 Tue, 01 Feb 2022 11:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20220131144854.2771101-1-brauner@kernel.org>
In-Reply-To: <20220131144854.2771101-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Feb 2022 11:21:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpA4T2-Z8Dg2HYP=3LSbT99kLjhJ1g1nPMObihrHpnjg@mail.gmail.com>
Message-ID: <CAHk-=wjpA4T2-Z8Dg2HYP=3LSbT99kLjhJ1g1nPMObihrHpnjg@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update Christian Brauner's email address
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 6:49 AM Christian Brauner <brauner@kernel.org> wrote:
>
> I need to update my mail addresses. A pull-request doesn't seem
> warranted for this. Would you please apply this directly? It doesn't
> contain any functional changes.

Applied,

                Linus
