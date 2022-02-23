Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCF4C1E81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiBWWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244074AbiBWWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:32:09 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448912602
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:31:41 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id y26so241921vsq.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGFCF0ugUwB9zgsPP1PTg1zmqOYPQWevE+kDC3pOR9o=;
        b=sCbimNFQ/1lozKCH6znougv9Yg8lZBsF8pPbuEI9Pwb2Kr5P4PO1ppxR+3akn+9Q4U
         kUOmz0j1uLK2F7oGPW3WXzEd3Lw4ewbuZM4SkH3pKjmeoXz/mDDTa5CEiAV7DUpQc7sB
         k052A99jY5cF/iQbIVqPeMXlHX7FYI4E62wFdZUtNkZ9T/C6EoI/NUTtet7shKaK5XUX
         7zO74MvzeeHtBzmHbze+x+7zq3F9Pfa5qW45m4Kdqr3qPqB5F03sGrFToYB6kgYyQuRk
         9T2UnZ5OYi7VFI6xdP6TGmGOYVsOIls3g9ziMwJAoUYW07OGIlLZUxVvM1ukQ6rYoQb4
         hYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGFCF0ugUwB9zgsPP1PTg1zmqOYPQWevE+kDC3pOR9o=;
        b=hXQ7hqqRbexcYKS2PY975Yp4Z8xdyPF7VMyO9XaeosNI4vFRd3k+aN+hQux6jM9c7l
         dzcNTSHqSz9X1qy/grBXZDPK+xehrXD8lBKSZw4P07hcPax/qt4Anr/6Mqq7Az6GHtZ3
         Zy03dqY1K6rnTWK8/Vo1N5eozsAFFs6VBZXaOO6aF7OuZpnqIZBAEv8wn/xKovV1TCvc
         1IId3JHqR5ekAtW9R80OxtdILjOKosTsKhj5+EcdwkmfWcskz34IALe7C91Iae1o+iBo
         OYDv38G0JjLfknV+lGlfBcg1ycjilbeyO3M87ypDTTMreKsBtYJLIIPGrqQ9o6jTEB57
         Kfzw==
X-Gm-Message-State: AOAM531DWmkQnxy7HI/npfvlyp7YtFnKAWlBdjVtDT5pYk2eZ77FO5YZ
        mtGiy4098WfTK17ykhbeodlWm9w8iYZulp0MOVwx4P92KAE=
X-Google-Smtp-Source: ABdhPJwTTM3pPfY+/ag7YXwhhrxrmugVEwtoLyTEtxyKlVERB2XDvVekE3xUsTPTUvsj9HQ1rYE4fyZASwVT7Xrkmlw=
X-Received: by 2002:a05:6102:806:b0:31e:2206:f1c with SMTP id
 g6-20020a056102080600b0031e22060f1cmr962658vsb.59.1645655499973; Wed, 23 Feb
 2022 14:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20210913233435.24585-1-pcc@google.com>
In-Reply-To: <20210913233435.24585-1-pcc@google.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 23 Feb 2022 14:31:29 -0800
Message-ID: <CAMn1gO6zzSWJktCeH9Tg=eqpTR5innBOgqVOeDvBV0hcDi-uog@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer.pl: support running from non-top-level dir
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 4:34 PM Peter Collingbourne <pcc@google.com> wrote:
>
> My workflow usually involves running scripts from a subdirectory of the
> kernel source tree. This fails with get_maintainer.pl because it assumes
> that it runs from the top level. Fix this assumption by setting $lk_path
> appropriately based on a check of $0 similar to what is in checkpatch.pl.
>
> This also requires fixing the VCS available checks to also check $lk_path.

Ping.

Peter
