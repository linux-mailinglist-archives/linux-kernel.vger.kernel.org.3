Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD34CCDAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiCDGY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiCDGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:24:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AE66C961;
        Thu,  3 Mar 2022 22:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B75961CD2;
        Fri,  4 Mar 2022 06:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE03BC340F2;
        Fri,  4 Mar 2022 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646375044;
        bh=cmSmvJubvXnBKZu876qJHYaGoLR7nF9IOp0DGZ8oYCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s5OsmlGlF7UPZe4GDO6wFvXtQF8pQfpEKKlFlHIWmx+EaX1pHPS7Djhm08QxQevTZ
         wsX1H2r4Nnl7bDh+mzsRDeg+J9+oUE8LX74YnlYGmXfwfOtDdd+GkMwoHLMyLDsJFS
         bp8VbvDMFTn7+PFt7fCDBiT4C4CMxrHJYPOz8yE4SQQTF+9qilLRX/eA5+koKViJhU
         imZMXp4VsqeEwwU4+d7S5lqz1qySgohQpIL39wTMbwgnF8YSfH88NYe5z6XBUB0WIv
         VVwXZ7ho+TmGNNIymxKmUKnbBIG9jluHSTUkiQdVQBxFhzHJEB7KlZzXvPgk8Yp6Tp
         VHnEhwYr6mwYw==
Received: by mail-yb1-f178.google.com with SMTP id w16so14920373ybi.12;
        Thu, 03 Mar 2022 22:24:04 -0800 (PST)
X-Gm-Message-State: AOAM530D+q2JubNEbh4iq54RPvx5CJv3sxqBTr/ZHVlo5+D7NbKTeGdJ
        US1JLAHstacmx1nPbLLk5AoEZ31A3zN76JxkHng=
X-Google-Smtp-Source: ABdhPJyWhShCPrnO9QtlwgdGZr5yvWxXWG+a37w5SymLcCreQX2N65S9uZikua4Xg7Unly/1FvNqv23OKxQPtN5z22k=
X-Received: by 2002:a25:bcc:0:b0:628:c317:a1a4 with SMTP id
 195-20020a250bcc000000b00628c317a1a4mr5687713ybl.9.1646375043765; Thu, 03 Mar
 2022 22:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20220303231933.1313075-1-eric.dumazet@gmail.com>
In-Reply-To: <20220303231933.1313075-1-eric.dumazet@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Mar 2022 22:23:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW74Xkhpk=gHBxeSydCZ2R=UvW3mVmg8qE8Di0_7RqUnrg@mail.gmail.com>
Message-ID: <CAPhsuW74Xkhpk=gHBxeSydCZ2R=UvW3mVmg8qE8Di0_7RqUnrg@mail.gmail.com>
Subject: Re: [PATCH] md: use msleep() in md_notify_reboot()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 3:19 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> Calling mdelay(1000) from process context, even while a reboot
> is in progress, does not make sense.
>
> Using msleep() allows other threads to make progress.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: linux-raid@vger.kernel.org

Applied to md-next. Thanks!

Song
