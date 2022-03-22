Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B169E4E39EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiCVHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCVHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:53:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0A37031
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:52:17 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o64so18688751oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W67Ifbn9+3/f4cFhaY1VbqyNikmEaFjJI/hM/08NGxI=;
        b=b2JgwWSHS8NJc5vqlHuEBiizr+FWZJmttbTGDpim0+Ur+Z0FdpBT3VitHb2q77U660
         N0TRv+YBF0nuh9gdco+9bvXF9DJDFdV0sGZ5kbIHMXcz0ZHkDvvZZIbkTuckRjUKxLSU
         WEcnsoYRRyJZrYvecGlMfifRDQCeEOG0NVfYzXKcZ0O5K8nc0JePVLphhGAlDi11FBAb
         6KWhUzXScGDM3p6HTqm9sYYluC4UxAtZdoQFtPNrpp/RLNRIq+OVXfrryk5s9Ey0oaQU
         YVjKUEHT5We4ZeyhuCDOfsEks9VfWpzOBOoXOm9hl+LaQvcGTTCIZ1dj+F2Hl83B/aeQ
         dIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W67Ifbn9+3/f4cFhaY1VbqyNikmEaFjJI/hM/08NGxI=;
        b=WEV/Hkv4Xj7nSEVk8ZnCrhfyit+BUAw+tySU9yym3q3O8EfifoJ//TFwznlSkBmKzE
         +yH4JIXOsfMGc6j5lLwnAxtP8offlGnfMbHAID//kJk+H8bM4YGb3XtgL5DT9tlXiKvd
         YggCVucxmJ3rBP7NW0UAzL1JWu8pdSoC+nB3clQTHSv/A4a/4aywyladFae1g6XoD9by
         6wuSi69nrc5ufDqVTIigCo3TJDgRj7vOoUFLt1K20GPECPIkDpqY2rWwzhXUIEgMPNSQ
         7vUDeunVXT1UMtf8UCb0QvRF7zZNuUTiXWsqY/AkKFz1M3KjXj+fR6yZZLvPuRl74sy+
         KqEw==
X-Gm-Message-State: AOAM532nvmY9iSc1BvQl3BTUfbUYWF029C37+qSer+a1OBvELWY7O5i/
        nU2DuyRJFMQLIlale7/v0K756/y+mZo6GxYfHpNqKw==
X-Google-Smtp-Source: ABdhPJwySwOVDxkCIua6YQLJMk40ETjG0z4A8ooZ+GsSclch4HZ3gRSUM0cBagJQxQZCwl1Mf3jQI5pKj2L8ycxc/KY=
X-Received: by 2002:a54:4899:0:b0:2ef:3d97:2528 with SMTP id
 r25-20020a544899000000b002ef3d972528mr1476133oic.211.1647935536041; Tue, 22
 Mar 2022 00:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000aa07b205daba6d49@google.com> <1035928.1647877207@warthog.procyon.org.uk>
In-Reply-To: <1035928.1647877207@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Mar 2022 08:52:04 +0100
Message-ID: <CACT4Y+YGp7dLiXCz1Ac5=FXG+gFAH7g-fn2vJtTsBfATc8Cxtw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

On Mon, 21 Mar 2022 at 16:40, David Howells <dhowells@redhat.com> wrote:
>
> > memcpy((void*)0x20000280, "/dev/adsp1\000", 11);
>
> Is that significant to the test?!  I presume it's some sort of sound device?

Hi David,

syzkaller tries to minimize reproducers and remove anything that's not
necessary to reproduce the crash.
However, this is done mechanically. Things may have some secondary
effects that prevent removal, or a crash may be simply flaky and then
removing just anything may lead to no crash.
