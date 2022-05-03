Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F9518CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiECS4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiECS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:56:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C63EBB2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:52:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so35149042ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+53Nu1sdzbhj5f+bVeszWe3uOnWBSR1lb0KWgzfBqos=;
        b=CA7MqryCloS3FBvwU8S/wXU0n7Gs5ssJT66d6+3L+MaMSAq1o7K03VtxVZR20goLQ1
         k16T3/68mpBatPHWuEcGDm3l31LJJ5beiSFCjrTvbiFLIxN6Bc0OHvYG82C9AU90qg+L
         svrtv3fCPbyGI6WWLZl/NmMkkd4E16clswe3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+53Nu1sdzbhj5f+bVeszWe3uOnWBSR1lb0KWgzfBqos=;
        b=w/jjdeHO10iZJL4rJNTWTNAr77d8Bx772OV19cSqbIOkBrEClxQ4JKJvfvbAIlL8bf
         o7XfvE6eJ8MKvDl3YRCs8rGqpMCPCDTiepaZcHJHokSSBMaXbquDlBEHnUXQBpEj0jZ7
         pgL6XXGFg1F1i9VLn8RwaS8CRnQLlHl19QtxW5a6QPI68368rQL6WSPgbacBKGQbfeJy
         iluiuGcZ2YEcIDkO9qga3n7Rk1gqg4T7J83RBvLtR/VDLh/tUc6HJRXm5nSOZuBG+Ua5
         SYUQv+r2mnP7VndMtkMMqh2+9Tfe4wNFcR06gGuCjE3Fb8Ro4kCDLTnhMNBvP80Oc3Pf
         LSdA==
X-Gm-Message-State: AOAM531xAnN727DZrLcSsmysZZfjRr35TlQn7JpTcfE53jFnq9AG3PkP
        xvsWsl34xb/RqMoeHEQkCyAHGWX84gst064FmFFIdQ==
X-Google-Smtp-Source: ABdhPJysAIdTHp9PSQJkZUq/jimZI5MPOJIj4u+BZoM6Q5whd76vnfVhBKCoOEbFM+b4oGJXiERGdeWvtp6KS96MN34=
X-Received: by 2002:a17:906:58d1:b0:6f4:6e61:dae with SMTP id
 e17-20020a17090658d100b006f46e610daemr7130379ejs.468.1651603955075; Tue, 03
 May 2022 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
In-Reply-To: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 May 2022 20:52:23 +0200
Message-ID: <CAJfpegskJzpXXhWCdw6K9r2hKORiBdXfSrgpUhKqn9VVyuVuqw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] making O_TMPFILE more atomic
To:     Steve French <smfrench@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 at 06:33, Steve French <smfrench@gmail.com> wrote:
>
> Currently creating tmpfiles on Linux can be problematic because the
> tmpfile is not created and opened at the same time  (vfs_tmpfile calls
> into the fs, then later vfs_open is called to open the tmpfile).   For
> some filesystems it would be more natural to create and open the
> tmpfile as one operation (because the action of creating the file on
> some filesystems returns an open handle, so closing it then reopening
> it would cause the tmpfile to be deleted).
>
> I would like to discuss whether the function do_tmpfile (which creates
> and then opens the tmpfile) could have an option for a filesystem to
> do this as one operation which would allow it to be more atomic and
> allow it to work on a wider variety of filesystems.

A related thread:

https://lore.kernel.org/all/20201109100343.3958378-3-chirantan@chromium.org/#r

There was no conclusion in the end. Not sure how hacky it would be to
store the open file in the inode...

Thanks,
Miklos
