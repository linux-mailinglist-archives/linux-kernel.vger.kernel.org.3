Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283D5570F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377361AbiFWCPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiFWCPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:15:50 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98133A22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:15:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3137316bb69so180462937b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C+XiHaOAuGr9ITlyPSDvgchDu5ILHwN6mWwq8+shYQ=;
        b=RMUg4hFqzCPu+TwayaHdoFw1lEbENOR5xl7OVHaaEiPmKSiuW3Kv90JlK7sqZ6l10G
         l+HgfjYGmez3OLT2bYaEshICznR44QsKw3PKKnmd8QUZJYNxScpifo0BsC5K6dOw9iwA
         BkpzezUlxh2ElDJoRYqiE4r9vZhA/WX22xWN223+4yKu7xAMTnQtD0d8v4qMtoTPnEze
         8ZhCJxsH6zs2HBu2lZ7BLoTq7y/QdEVDrOs6WLZ496MQeB2kHV9ALEEu3SVZfsObKgYW
         3o84Af8L9ggU9AQ7/Amd/kLnSEULTzT5zFqxvz1HM+aAuIV/aTvcSAz9pvB9xBrcmuzZ
         az1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C+XiHaOAuGr9ITlyPSDvgchDu5ILHwN6mWwq8+shYQ=;
        b=dWBx0FS5pYJgEoOb5uJqPYNQdHdSUL2kYWKCRth/G4ExxwWvH+2HfIbFBDWhHydfh8
         +0O/EVUesd7DuAHkIRpMSWDCLv7gN8+xkWTftR2hgk1bCsFsHZsV8lSL10uiFOa25n6c
         RSTp9Aw73wxZhMiMKTax7AbAnBg+nZ9ftpbhGWuBeNsfN2tda/gPSl4NZX0WVbOgDx94
         zfynHKkLb4hgUEHJBMbjTBhMGQ6tL15s840VgIqGMC8QtSuRwoxudcnEqdr4QHSlBieQ
         5R5EYFmeyJs4KnSueHBd5tUTgsMcgYlGqYhleITEuOa1oB+ykuUTRyeQTtsU5JVm2qsr
         2cIQ==
X-Gm-Message-State: AJIora/x+X/JEKgsC+ZvIss5fnxYNC7HPlsayBcwduBzsde3g7xoZ2GV
        Ip0NZsUfxw5PcJyQjDi8wxzQYW7A6PFGgHQLQfWynQ==
X-Google-Smtp-Source: AGRyM1tLIkOQVRgWFenL32+zjV3O6TY+8dBQMEHu+tQIvlvZxfX6Z8ZhPGrxlxJ98TDk6yZ4UWzV9dtLUCpv4I232TE=
X-Received: by 2002:a81:2fd8:0:b0:314:eaa:bbc1 with SMTP id
 v207-20020a812fd8000000b003140eaabbc1mr8055504ywv.141.1655950546326; Wed, 22
 Jun 2022 19:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220622153815.6f2e671a@canb.auug.org.au> <CAMZfGtVQr=7pUevVbbNK9teskfGsjcoif2sfHQ-YrDx5qHNiXg@mail.gmail.com>
 <20220622115917.5268aeea70b22a566c90be8c@linux-foundation.org>
In-Reply-To: <20220622115917.5268aeea70b22a566c90be8c@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 23 Jun 2022 10:15:09 +0800
Message-ID: <CAMZfGtUQonnzoUOgZBnt5AoTbG6PGo00C-86TBQYM7DqPdLHVQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 2:59 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 22 Jun 2022 15:22:35 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > > Today's linux-next merge of the mm tree got a conflict in:
> > >
> > >   mm/vmscan.c
> > >
> > > between commit:
> > >
> > >   15077be8badc ("vmscan: Add check_move_unevictable_folios()")
> >
> > Sorry for the conflicts, I didn't see this change in the mm-unstable branch
> > yesterday. Based on this commit, I have reworked the following commit
> > (see attachment, mainly changes are about check_move_unevictable_folios()).
> > Andrew can pick it up if he wants to replace the original patch with
> > the new one.
>
> Your comments in
> https://lkml.kernel.org/r/YrM2XCwzu65cb81r@FVFYT0MHHV2J.googleapis.com
> make me wonder whether simply dropping cca700a8e695 ("mm: lru: use
> lruvec lock to serialize memcg changes") would be best?
>

Hi Andrew,

Well, I think we can drop this now. After memcg reparenting work stabilizes,
I will resend this patch again.

Thanks.
