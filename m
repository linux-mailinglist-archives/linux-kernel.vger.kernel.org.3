Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9125A30E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiHZVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHZVSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:18:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191307A531
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:18:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a133so3497883oif.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jqevxu4nJYrCA5b/jGqZsRGIEdJzHcXCyvdNgZHsnbM=;
        b=QfOoHLhXnaCXUNqj40fmWtqEJK9iLp4VqIPPjoRxwTGg6pIcDFWmDFTOOIY3ZbNCvY
         d/6MfMCg8w1r8AhBCsSyV0gCHZcue2j4r84siacgAem5S6xH/P+6zFNU74yZ22v3Fa4C
         ESPeAPI23/jwA26O8hqQzYSy3F3p4856PaEvZ55kR/lKia2cmQ3f1MTeyK7voO5QQ/+x
         zJN6/aN9aXiLO1/PbgJURvzl273zG9c9gjc+dbu9TmaRjGiolYAD8hIBxKnUgz3Gd/xC
         yqK2sCCjStNi1r/+zEefgPNxTrnXA2hXmC9ix4fuUmB0FqEd9Q0p0rPiXxpz9Ij5z9W5
         JxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jqevxu4nJYrCA5b/jGqZsRGIEdJzHcXCyvdNgZHsnbM=;
        b=3SIdsWRjACxOhBmZ52Gl+Os97C1btKIe0mxmpiNcp2LTGeKgPYLC+FJI8SfQ/WsTp9
         bh/rq+wVtSEmdGFzUHfMa7576sCAb/ff+mSvbFz4bPzZWKiOpM8Y2ES3DhLAM7Hhra3J
         0tgaXBt5K2YtgmCtdwHN8z5w2CbH1JhTyJ0CuAUaIdZ5tocP07jxgAkRCo7KIu1+ZoJ/
         zdDqhCEBSrSCp5Zy2JkaYaUBQIZlogR1CGzJABIgNMTOJQdF4GENdFaGJumM97IAq11v
         85TkoI0lsX9QbwN7peUXm/AIJsmqepybehNCEXrLsedXgr/1Y6VYdonzvkNg+DXk0pFh
         XYmQ==
X-Gm-Message-State: ACgBeo0bxuutrGDbEa2WtpdyqgfCX3ftXTEwR3KfuHDUCU8d6nNq3ann
        am8+13QFqgMlaIudT5N2M5fZlwUjek1FpRXynWaU
X-Google-Smtp-Source: AA6agR5l9c3L7Ec5r6wGQrv+AOhwxaa6G2u9mbsXmXlKW51sowK/zgnXpm8km7tyjIHItq4ciMgqkuldfis0MVJpgaE=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr2522236oif.136.1661548710417; Fri, 26
 Aug 2022 14:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661449312.git.rgb@redhat.com> <8728d12e4d765aa388602d9bc894bde75d9f476f.1661449312.git.rgb@redhat.com>
In-Reply-To: <8728d12e4d765aa388602d9bc894bde75d9f476f.1661449312.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 17:18:19 -0400
Message-ID: <CAHC9VhSCGyeZALunjMdB_tOgJ-WY1xbTo6=85iM_C=Q9JeSc+Q@mail.gmail.com>
Subject: Re: [PATCH ghak138 v2 2/4] audit: explicitly check
 audit_context->context enum value
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Be explicit in checking the struct audit_context "context" member enum
> value rather than assuming the order of context enum values.
>
> Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

-- 
paul-moore.com
