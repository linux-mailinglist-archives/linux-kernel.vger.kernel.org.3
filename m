Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ABD54DDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359624AbiFPJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFPJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:02:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2D92DD4A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:02:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s12so1554460ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc5Amsn8TgDKhR/5plxMGf5bc0SbsnTaDD4PIb/Yu5w=;
        b=UXL5I2ysh9P8L6Oo8E2wnIxMZ60LLgOVT2jV9ZytcZfsqDdOP5nX9tjZkutipW1NyM
         Qttk6WOE1hInbn4Lm+SpGlypygKTWfQYsjM4t7T15ZzIPDaUD+/ZvG7C9UE9cAkyljXS
         cEEY44p6T1VkjiNRqDpJG67fqs7FXJEqJSyuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc5Amsn8TgDKhR/5plxMGf5bc0SbsnTaDD4PIb/Yu5w=;
        b=gQvSGqU5m5bqL7Ha9AKLum9kOBF6HV31F2H10HGdZckzuKY0RDha6hy16EJsBzShDp
         Yu2WZ9KyfBZhbhLr8PHRJr9Q//YB3mNyC4JuWml2uEjcVkjWLIp7ivGBQhNYV95l6Hi1
         v0DWw2p3mtc0kJDzk5DzzzxeIhJ5d8yCBHSA/mRmHb/svY7CFVyWz6pzrOGV4mWz2OYh
         iCr3c44yoVgGkcl8iiWWwgmE8xN8gH2GIxJ/7DPnA9U58yNaDw+yafBUUzdV6XJMwJFE
         iSMny3iwhCme8CStu+wwDcd2vBbtvdn5K/dd/Khy7BewYamc8Q5REHWvky4m8FXtUo92
         m32Q==
X-Gm-Message-State: AJIora/IFANrrVrQvKrjsR/ixoLv4iA6K8ERi8FBaaexvQ1OaAg4z8Me
        MLMnVGHtdywX0qT+tS/pssgjtrjd8R+MJ3w9/EVMHqrBHPQswA==
X-Google-Smtp-Source: AGRyM1u4KXzIo3qgzwa+diwcwq4iTbdaCf5r9GEZ/ERy8CWzUrD1uf6bG/vHa4WfMNeiKpRfcpdG+J6Dgg41ne51m/M=
X-Received: by 2002:a17:907:3f92:b0:706:db40:a0ef with SMTP id
 hr18-20020a1709073f9200b00706db40a0efmr3487509ejc.524.1655370130911; Thu, 16
 Jun 2022 02:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220605072201.9237-1-dharamhans87@gmail.com> <20220605072201.9237-2-dharamhans87@gmail.com>
 <Yp/CYjONZHoekSVA@redhat.com> <34dd96b3-e253-de4e-d5d3-a49bc1990e6f@ddn.com>
 <Yp/KnF0oSIsk0SYd@redhat.com> <3d189ccc-437e-d9c0-e9f1-b4e0d2012e3c@ddn.com> <YqH7PO7KtoiXkmVH@redhat.com>
In-Reply-To: <YqH7PO7KtoiXkmVH@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 16 Jun 2022 11:01:59 +0200
Message-ID: <CAJfpegsbNPuy3YmGZ1prUyir_h_5noGZLN8R__o0=iz8n4Y9og@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Allow non-extending parallel direct writes on the
 same file.
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 15:53, Vivek Goyal <vgoyal@redhat.com> wrote:

> Right. If user space is relying on kernel lock for thread synchronization,
> it can not enable parallel writes.
>
> But if it is not relying on this, it should be able to enable parallel
> writes. Just keep in mind that ->i_size check is not sufficient to
> guarantee that you will not get "two extnding parallel writes". If
> another client on a different machine truncated the file, it is
> possible this client has old cached ->i_size and it will can
> get multiple file extending parallel writes.

There are two cases:

1. the filesystem can be changed only through a single fuse instance

2. the filesystem can be changed externally.

In case 1 the fuse client must ensure that data is updated
consistently (as defined by e.g. POSIX).  This is what I'm mostly
worried about.

Case 2 is much more difficult in the general case, and network
filesystems often have a relaxed consistency model.


> So if fuse daemon enables parallel extending writes, it should be
> prepared to deal with multiple extending parallel writes.
>
> And if this is correct assumption, I am wondering why to even try
> to do ->i_size check and try to avoid parallel extending writes
> in fuse kernel. May be there is something I am not aware of. And
> that's why I am just raising questions.

We can probably do that, but it needs careful review of where i_size
is changed and where i_size is used so we can never get into an
inconsistent state.

Thanks,
Miklos
