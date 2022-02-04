Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017F74A994A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358815AbiBDM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbiBDM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:28:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC57C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 04:28:55 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a28so12259434lfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5EE+DkLgmN23BbMUE4nz7OGjEySA8/7jVCGdyEuQd4=;
        b=l8iWC5a2b+sRIY7ZfxlfUPFTxvMH0CELbAuWVa9q815d/EK454CqeyWsNWJjCI9bl9
         s1Odh8R1pOW0uN0YRnccOsWreV3t8GUcThTUiLUSMv5BWfNBNvyPL25+S9bn8oI6QB+B
         yKlJXvcCk25Nm8qAuLZlHdfEUF7wf2zsPx8MrHkRWVB76FwvRbW73QzTRzSyqCI90xMw
         J5MRctd43fhRsfT+boL4RV5ziKMcPD0EJLbVVkhTfNmAA9ZUguhSqPHU7MCV0Fi7W8kd
         qaMf0mGSnD1XnRvY799LQaKjbNowpbQX39rCPeTtcVtPEST+9aYi9qu2fsqIHV4KeSyT
         g6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5EE+DkLgmN23BbMUE4nz7OGjEySA8/7jVCGdyEuQd4=;
        b=3eHsl/XS0qfHNnF6hiVcunD53Yl9CQEuf2eKIUHsycP/EH8AfPQnvnjBGWLJfuP6fy
         fnU4FoPDYdgcRoEGgWgNlOv1lY0Gf6eaRzbVJP07V2pRjw8bfSJ2260d9v5/qPosx2NY
         C68kmI9cgfmbVupNspzMuReRsU2aSqwcSCJn04ujugOygjf22P8TJf6m7PdrtIuJ+cqi
         z6IWzf7cPv+416a1mJRcyuQvDbK3uhquFNJHA91ug3yMZuy8n5IlRvF6YnIEGRZm0NEu
         /ZsLUH0IsY6xIdCuN/rGwO00VzdULyhkymbU561Cpze4SIti11RzSfOx8ftb2HdQVo4f
         Wgcg==
X-Gm-Message-State: AOAM531eA5eTKAPGHb+oKUpL8p+V36d9bxAmLmeKKgJhcncxnwwN6v0v
        tPENwi5x6sd50IBGC+RErR+fkHKaOUSFrTrNV5+/xw==
X-Google-Smtp-Source: ABdhPJxKiaraf1BxhQHs4VHBoTVENKbIOIstx8X8gx/Nh6NbS6taEj28l1A3fXhHQ2OUPqPHo2XxD9KaxtDCYCEMCWY=
X-Received: by 2002:a05:6512:ba7:: with SMTP id b39mr2169011lfv.373.1643977733643;
 Fri, 04 Feb 2022 04:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com> <20220125055010.1866563-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220125055010.1866563-1-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Feb 2022 13:28:17 +0100
Message-ID: <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 06:50, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
> use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
> keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
> weird tricks to keep it from runtime suspending.
>
> So use those helpers at right places to properly manage runtime PM.
>
> Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> Cc: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The runtime PM reference counting for the mmc host device is managed
by the mmc core. Have a look at __mmc_claim_host() and
mmc_release_host().

In other words, the runtime PM reference counting should not be needed
in the mmc host driver, unless there are some specific cases, like for
example during ->probe|remove().

So perhaps it's only the changes in the ->probe|remove() functions
that you need to fix the problems? No?

[...]

Kind regards
Uffe
