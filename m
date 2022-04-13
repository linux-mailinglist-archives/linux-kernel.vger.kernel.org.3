Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D24FF90F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiDMOi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiDMOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:38:23 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F060CC7;
        Wed, 13 Apr 2022 07:36:01 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso7717467b3.9;
        Wed, 13 Apr 2022 07:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkFKvLI0J6quLQdPqpOX0Tj5KDs3UD15ORpTF0qg2e4=;
        b=6hQpGirc2ucrJ9JNE7jYo5jl4SHtx/ANBT6uAt77bprdZYH5y2kuYkbDNSdKxI19CO
         Vks0rWB1uTjTdodn/qlTfbCQVmWC+auMgUXSsCm1uDowqWiAfkjNk1wx3pPf/Jf13Rdp
         vJdxE1OakSQ8tZTf8K9n8bjDgFxY8HGcvchTBCCDOU025JxLoeIyH2JskpbFwcviPeq3
         b5AKzC0IikRHezcfNsEWBkYWPZdNXtpb+37gHglnBKY/I7b2JwLbL4LwZzWowJ4+vRd6
         LWo2Ii3M9hEJJ0c60NZUXgFSjHU79QljZ2vb5uyH4PwKWXatABeSm5n5boSyfGRy5e5H
         hiKA==
X-Gm-Message-State: AOAM530ou+RJYTXA4bif6i9JDwSLIrPYtnvMNtPeAXQZQDUR7aQxGKvt
        bU2k5tWOgbxLLNE1lp7sMUojoJj5GVt0Y0jaT9KWsRXp
X-Google-Smtp-Source: ABdhPJznRcpigdB/Ir4yWmRFfF/hE4YWrrX33xtGTbB1mSjJwf3cB1Z/dbSo3oLnkmCEfqHiC41UZjsnNi4mMw7TUVA=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr33491323ywb.326.1649860560856; Wed, 13
 Apr 2022 07:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220324080653.454333-1-dacohen@pm.me>
In-Reply-To: <20220324080653.454333-1-dacohen@pm.me>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 16:35:50 +0200
Message-ID: <CAJZ5v0jDEau14RF4-pEc0HiWG+Cg7f93oMmhBXZULCXpOJFVaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] PM: refactor pm_pr_dbg() to support dynamic debug
To:     David Cohen <dacohen@pm.me>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 9:07 AM David Cohen <dacohen@pm.me> wrote:
>
> Hi,
>
> I am currently debugging an issue with s2idle on my laptop where in a
> rare occasion instead of sleeping, it gets stuck in an infinite loop.
> The pm_pr_dbg() is placed on very useful functions and it helps me to
> debug it, but the current all or nothing enabling mechanism with
> pm_debug_messages_on flag is causing the suspending mechanism to be
> disturbed with so many debug messages to the point it becomes extremely
> difficult to reproduce the issue I'm debugging. More granularity when
> enabling pm_pr_dbg() in this case is very welcome.
>
> These patches I'm sending introduce dynamic debug support to pm_pr_dbg()
> while still maintaining the pm_debug_messages_on flag behavior if
> dynamic debug is not used.
>
> Regards, David
>
> ---
> David Cohen (2):
>   PM: narrow down -DDEBUG on kernel/power/ files
>   PM: enable dynamic debug support within pm_pr_dbg()

Both patches applied as 5.19 material, thanks!
