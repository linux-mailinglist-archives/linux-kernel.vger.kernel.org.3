Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA65A1B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiHYVgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiHYVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:36:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16957C0E60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:36:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so14780176otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qgpUdA9yJwxNR7SYANlRBsI/f5GIxXb0hftd7P2kISk=;
        b=B0Mnj6nGBRyvDvVQiq6JX2fv5bFAIsUiaVShStHsYRLSNodnEUBCxhJFq1qkduGyq1
         PROu1fKtWURi4bQxd9mzOlKzw8pjOjQMZHElU/0a9hzy4BkVTpmRHtg9z/0bmThldUVI
         iAKIR87QD6MB/VDsrnOM6O7BvmMYR/cpwdRWyw5plppBH8Wf8lp/66BJL7umNhIWEOno
         SpEaFHEOghhdZMcFQik43jJ8pbpzVw19yXjzUtnDTJNCTPRGec8+K9XVh2xL3ObCtNRq
         v8DMx7Nqe0oWGeJV9Hy68tjb+mzUTRZCkiGe09BB3LAsJKr60wD/DfU7pL0P4AIaDXXJ
         FQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qgpUdA9yJwxNR7SYANlRBsI/f5GIxXb0hftd7P2kISk=;
        b=Z4UzcKUEXOMJamC5krcWiyRZaO5o8K8c66Lkioaua6IBlsjniRkCLdkZP6spfrMTsi
         RBdE30FtVNAwQFbpOsEfqhR0526T206WZllWMEXm2SexDhU2bhwtxUDtxzO+7z6+iIyx
         KFwosrtmqXZbS4B8LDZjIXrz3nqDK80z4l9mCF37Nx7BpaFQJSzhAG3DNUdH783kqWiK
         1JHvB9LLZJ9cOY9ic4z2EDxLvndPnzTYmAAAZ5063PM6dGsUIv360eL4rLyRs+u434cK
         qsjXbwCJionDM8wG5UrZXzfjZNY7rGnpChFgHsp/FOMxwWF0EI6lzN1oXFgukS6P4QB/
         7pbQ==
X-Gm-Message-State: ACgBeo3Q23iBpJo1L7mg/juqAwNJELNgsz7hIiZhMr8r5QdxHE7wBqDl
        pxDkgBCw1RS3IAeW2SdXKqWGe2i4Z7ku/vyhhkf+
X-Google-Smtp-Source: AA6agR53F5fX0GAZ+LrxusCimQgbNKbE7tdlEa2F1osV2i4WEdL+3Y0ULU1OC1vGq3ICyjzY9X4arRv2KOSXlLlIF6M=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr381017otv.26.1661463376439; Thu, 25 Aug
 2022 14:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661449312.git.rgb@redhat.com> <0129ccc2378a772a7c38090ce2cea0fda44c8479.1661449312.git.rgb@redhat.com>
In-Reply-To: <0129ccc2378a772a7c38090ce2cea0fda44c8479.1661449312.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 17:36:05 -0400
Message-ID: <CAHC9VhTuCLD0QAXO0Y8Jp8L=yFS6a27Gfv+HQnPW54V0Bfg3ag@mail.gmail.com>
Subject: Re: [PATCH ghak138 v2 4/4] audit: move audit_return_fixup before the filters
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, scorreia@redhat.com,
        omosnace@redhat.com, omoris@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The success and return_code are needed by the filters.  Move
> audit_return_fixup() before the filters.  This was causing syscall
> auditing events to be missed.
>
> Link: https://github.com/linux-audit/audit-kernel/issues/138
> Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks better.  Merged into audit/stable-6.0 and assuming the
automated testing goes well I'll send it to Linus shortly afterward.

-- 
paul-moore.com
