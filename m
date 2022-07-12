Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DFA572865
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiGLVRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiGLVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:16:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC33D03B1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:16:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu1so11711686wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdOEioFO23wO9jT+v84Uq6yR/rM6WjphFOowXqeZg+8=;
        b=FGMgDJ/UWUUwxtjgAbMXHbpKlAFja3YZGN8NTh9r5gki2J1eTGIrihjn5kYu8Zp5m4
         6VTF06qBe97J1CxPU3T14bt6XIuwgM9FBXtDhrpqJEJRIUmhzBQG7IK+T7h8yE7VdA5a
         I70IGaN4H1bfFHKVCsYsxL34OJK1NRAnfx/0yh1pnxcRJXal4rH+p6RYOdQrahufvonY
         fWO0KQmvYb+As0YFoNmK/y+Vj75uZM2InxTtWMWRkuQ6q1O5gPBztxVzh4L3IWpslSUJ
         Y2NpYIgYdzc37H3yOAl5XR3vg+AuNRrMZP+8+WIw7tZouCd93viYtW4+bYH/RYk0XbUP
         D/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdOEioFO23wO9jT+v84Uq6yR/rM6WjphFOowXqeZg+8=;
        b=x9ijIv5gKwBhxiX2HoCnymOs3W3OVpeIAaI+fkecip8gZp8FkBQEPJaeIJlZBv5w51
         6otctN1O0D2nINB7YMbDeDkdBnrawWgnEPPf9bWGJt2c3Pwj3BdwjvUapYv5IXCANVTK
         uG4BUbBpK4SonfQKKCTFWl+yLx+8Q0cuPmavfrR7YZxafGf3o17GCFgvgtYqQTlaB/ok
         Qg+Uhm1rZnRfVLXpJeQxWPuxJoFBd79Qi/XdVfEMQm1Ry7WcuC6U/bMRCkYjkyJUnZsP
         63BFj8xxTlUcKI9VE1ww7z7AS/aWIBo0WmJ23Q1/L3q9g6TbDWx5NYnTi+8PijJD9xy6
         p0pQ==
X-Gm-Message-State: AJIora9vMoNuacWXmmKywmVFdEa7jLVLNP5CIH/QWN4S4VZWA+UWOPFW
        +qp5A4MT0KEdxuI9xAi6YqaaYSkxk4/glatWJcIG
X-Google-Smtp-Source: AGRyM1t6+kJwHmyatPByBWwaapf9v8hUQbiKnGv5L2vOBVFV2hCN6Zjs9bYVu18D1T6dN31FclApp8UbXipJerOfjYM=
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id
 m3-20020a5d64a3000000b0021dadaace4cmr7514967wrp.161.1657660616240; Tue, 12
 Jul 2022 14:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com> <Ys2DobolHlrXP4/M@xz-m1.local>
In-Reply-To: <Ys2DobolHlrXP4/M@xz-m1.local>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jul 2022 17:16:45 -0400
Message-ID: <CAHC9VhRv2VPvUAbpDo0D0oK9gEHL=vcOh84M9Fg+AN1c1SR0pA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Peter Xu <peterx@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:22 AM Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jul 08, 2022 at 11:34:51AM +0200, Ondrej Mosnacek wrote:
> > Since userfaultfd doesn't implement a write operation, it is more
> > appropriate to open it read-only.
> >
> > When userfaultfds are opened read-write like it is now, and such fd is
> > passed from one process to another, SELinux will check both read and
> > write permissions for the target process, even though it can't actually
> > do any write operation on the fd later.
> >
> > Inspired by the following bug report, which has hit the SELinux scenario
> > described above:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> >
> > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks Peter.

-- 
paul-moore.com
