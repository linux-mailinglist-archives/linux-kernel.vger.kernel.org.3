Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385DE517B34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiECAUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiECATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:19:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438D38DA0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 17:16:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r1-20020a1c2b01000000b00394398c5d51so432435wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEBPkXZGZET4EOg9cNqgzGfoaXYf5cttjHHg7Lavyrc=;
        b=u0NnuCLWvA+j4fCTpPXTlOameD/fsMdeVXQnlE6sn/YvxBdcoQOutZx7GGA9/BVUP9
         qa1zezBlh9PyWkhRje1o2dkuSrJesxNSGB3pI7HZ7xyu3jBpwv89b7rIAgaqBG9uXy2B
         eUiD+hMF6vGP1FACV2CyxjMQsdAGuwzIZQW8PuMMu6MgRFhaZz1GPb97QijP2WQdBydU
         eZPQ7k66fs99I4BGeJdcyBcfL/KcZArFCBHbU3pvOAHrTQV/xX+AMLkogLHv5479Lh1L
         MnPkl7ZQwF42gnaqvM7GbjxVEHKoBWaroH0OF4KvZFFDr74jqiVibcAPParhHHN6rUdu
         ATXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEBPkXZGZET4EOg9cNqgzGfoaXYf5cttjHHg7Lavyrc=;
        b=RNCCh8rI9mNZuFuM5g/TzvSlV3w9aECCJ51JZyRgccVJUBQsUaD2pcnkKEGy5p0Icm
         GfhfAAVg4IQjDGsF4u26veztFupFt/US1kzmrx789OiwjLovySaoHpOUa9q5saBS6RWD
         k/i7KnrIdXUIVL3Qntpg2dtG4Nt3ZUypTC5juDPO74iALBTKZSz3aPJmeA3AWNq3wt6w
         w5szne8A6tlYR8QrY0EupEyUUG8WaS/We23w0i2szilE1EVM414FBjFRgNbfGWeB+KVT
         bjvKwNmxiO4A6CXMCmSMootofZb3R0bbrLg2BpLyzHUMdf/yCRpib6bhPfGs4BbmO3Yv
         0U8Q==
X-Gm-Message-State: AOAM531YKKCMA/rhEar9klm+YPxMvbzuPbc9j6RAgwPfjhKFlzpjiIWu
        sVF2XUx9LqQskMi/zSYN69kU8/cQUvBn7p82kD57
X-Google-Smtp-Source: ABdhPJyZ4midsbD61Si1Qw0RhxNxL5d5wRIVNY/d5Kxnxugjn6yw9JwqCUzXCTQrt39kvTqxQ7ozsBrGJ7xQHItqm6s=
X-Received: by 2002:a7b:cf02:0:b0:393:fbb0:7189 with SMTP id
 l2-20020a7bcf02000000b00393fbb07189mr1065567wmg.197.1651536978767; Mon, 02
 May 2022 17:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com>
In-Reply-To: <aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:07 -0400
Message-ID: <CAHC9VhSFOx1d_7-XnbobjZXjps_mXq3S33T_5E=PmNAeyqAsdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fanotify: Ensure consistent variable type for response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The user space API for the response variable is __u32. This patch makes
> sure that the whole path through the kernel uses __u32 so that there is
> no sign extension or truncation of the user space response.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/12617626.uLZWGnKmhe@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com
> ---
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

It seems like audit_fanotify()/__audit_fanotify() should also be
changed, yes?  Granted, in this case it's an unsigned int to u32
conversion so not really all that critical, but if you are going to
update the fanotify code you might as well update the audit code as
well for the sake of completeness.

--
paul-moore.com
