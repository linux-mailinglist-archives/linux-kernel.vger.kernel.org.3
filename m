Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA951C1CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380342AbiEEOE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380310AbiEEODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:03:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5AA4EA01
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:59:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k27so5323881edk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=E8qBemq4oTx4YPbWRWMJzV2qIbcvYOdveNbfeZemz+4dZQ+I0m7fLXmsY75j+/wiX5
         XaE1LThAuxmxZgvbTboIF71ZZ5XDfPUtgSQz8ZVQ2PL1AE4CxYt/PmItFNePGMLFoNgb
         A8tRUVmKiVc6KZIJU/kk/0DlACH0+77UO+Qz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=R3NzU9qSF03drxAjub/vMlVuZhN52nw62YHsAI6f6bEMmMcy2nvUXlNi/PaqXcjpJL
         bNonDZu5c1N04GRkbLhD5iD9WuMZa/Nkjv8IFNuUsfd5nRmvwKbERGDiAykDYACNht3c
         m0j3waDIDG7FGMn9FrBJdOW3HvDERbbyqh1pwXDnqkYmxQDV2vLYN86gmlO6Nxk4UysA
         r+g6iepN/vRNsVT9QKvQ7WV49quKLkQHZ1W2+lFCDKA5Dsg8ox6O+pX8iy8KvnU/l25U
         2DqyW5l2PkLdEviTFfzn6WlnQFTBhLdxsd3qQ7IEGUvD7cAKvvNTlgjtR9pzISmeUJh9
         /wJw==
X-Gm-Message-State: AOAM530+80SHXgRBli/2OI3YkN2Lp5X3Tea82tKCG8aj9xoK+NoZ1pQ0
        pRKDtjhCutW4N1ULQzdtjMxT7wasdhzP9l2+0vkaWw==
X-Google-Smtp-Source: ABdhPJzTe+CDKCcscUgOgvXLSyK5NVYs7EmJWj3tio4m59arkqFAPKBq+XxNeijdGRs92739wL1GOOxDMjNo+9z+bh8=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr30384732edx.116.1651759197275; Thu, 05
 May 2022 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
In-Reply-To: <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 May 2022 15:59:45 +0200
Message-ID: <CAJfpegv2asQoevG992+1yruSrmMus57CoQ+=Cssf7O50FhyJyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 at 14:30, Karel Zak <kzak@redhat.com> wrote:

> Is there a way how to get mountinfo-like entry by mount ID for some
> sub-tree? Something like:
>
>  getfattr -etext -n ":mnt:info:21" /

Yes:

getfattr -etext -n ":mntns:21:info" /

>
> The interface has to be consistent with some notification system (I
> see your question about fsnotify/fanotify at linux-fsdevel) and mount
> ID seems better than paths due to over-mounts, etc.

Right.

If the mount notification doesn't fit into fsnotify well, the original
patch from David could be used.  I think that part was
uncontroversial.

Thanks,
Miklos
