Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387DC50E08D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiDYMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiDYMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:44:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2BCE4AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:41:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p4so2609430edx.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DsLpqQPuxCK2Mrehw4P0708AXzU3xBMKVlsThqy3Zc=;
        b=YIsai6GVstoGAERSXy61aZOo146osRmFisTtgf1r43CWKdN0WObYtifthAbCAQXzY3
         tqDNkB8lZMG8O+ZA3BI7ARoIlT9sDW4DiT6LNdT+qU2+HKoMz7Klz4vA4aiecr6cuU0N
         31+H7m93zTKZRdQm5Ly7aMJZqVx4OM7TEkO7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DsLpqQPuxCK2Mrehw4P0708AXzU3xBMKVlsThqy3Zc=;
        b=H3JIonjIVdYaDwlTxrgJ5T3eSDkIFRlA6PaWgT687Ch13vlO8giekbN/aHuFgbilxc
         ZXA8I35mSMgNQg7+M7zYZQ4w2PR07wPkEhyrOReDqTpQ+xfoYJOHDQJ2Ay5ZYnBytbGw
         GwQQWMA8wv7eVLIT2nxweZdFZE47R1X/NDOYNWUpd/VL/r1FT+Pv9a6ndKnQQ/bFE/kv
         YL6qh+s/0t6MJa0HjPmiB/LJHEHIjdso29UZnu9toKPT5OKO0BYwCfwdFkPmBIOXQY1i
         LcIpU0W0bmswSki2rQAeLM+6IwsRUdngKk6sVL0Ji/U9AmIU1ttpddfypmnrwsbN32On
         FtdQ==
X-Gm-Message-State: AOAM533BQiEJAC37OH6KxBmPM/KFG5EPyz8C9M6DqE/uAhFGkwnQn6H+
        s2OWZcCt19lAMGNBSUdUE71b6i54m2siI00eEh4vuA==
X-Google-Smtp-Source: ABdhPJyXkzITV2ceShfI11A54nnWGtHFrfecC+LpX/i3C5jj2uy9aIr5gNUmnebtnuLIX3bX+4PSPJXxoydBw/Mil7M=
X-Received: by 2002:a05:6402:274b:b0:423:fe73:95a0 with SMTP id
 z11-20020a056402274b00b00423fe7395a0mr18665932edd.224.1650890487604; Mon, 25
 Apr 2022 05:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 14:41:16 +0200
Message-ID: <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: support cache revalidation in writeback_cache mode
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 at 14:23, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Hi all,
>
> This RFC patch implements attr cache and data cache revalidation for
> fuse writeback_cache mode in kernel. Looking forward to any suggestions
> or comments on this feature.

Quick question before going into the details:  could the cache
revalidation be done in the userspace filesystem instead, which would
set/clear FOPEN_KEEP_CACHE based on the result of the revalidation?

Thanks,
Miklos
