Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B560587B34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiHBLBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiHBLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:01:40 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35EDD;
        Tue,  2 Aug 2022 04:01:39 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-32194238c77so136608137b3.4;
        Tue, 02 Aug 2022 04:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u56ky1itKQ0F3dnJn7huu8Yqx+Y2BBrDNofqx/cbRmA=;
        b=MH4rUtsLZfVKhnTSLZ6lYDlccfp/pdLgN/1mzpPM0Nt6QOI88FjQu4h1PMtuytdl8c
         2F6Oklqxquhkm9yddGYf7vhsUIIZXQKyJkTSJqWIwDKQWzUNUup2OoUxZpdyD28wSVBA
         fnk3P6q/oG3Ih6Ldo19DP/fDz0vbbxBuAgapY0KSM2JRB7EX7JC5Qw7FrxYHETj4aZAk
         uTsBj21erVFqdrkeUCX8Uj/Tq1qlW7hTz9A3Xv+UVIeLTn6n+22/9dCt+9lRWee8ezJr
         s41ms6H/gyWbi7lPwgLl+/22PRzHZga+9cPOWSYiVcEz7T+28h665JecCL83zS/bhs43
         h81g==
X-Gm-Message-State: ACgBeo242JNK/x3s5CySbkw+6VkIQkBIRh9aOc0EpDooINooE4E2ZwsC
        irv3V5fMMYZd1JHnDkwMlsWtu/9eqYMfKbK+2C4=
X-Google-Smtp-Source: AA6agR6LRdZwcQ/mfpZQHXi4IGHjWhl8Eep37NVydJddjCpOUmp7T9QJT7o+QGIaiJcyN8b18DI2pybo80omvLzJzKc=
X-Received: by 2002:a81:8847:0:b0:325:314d:7787 with SMTP id
 y68-20020a818847000000b00325314d7787mr3674001ywf.19.1659438098815; Tue, 02
 Aug 2022 04:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com> <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
 <12028598.O9o76ZdvQC@kreacher> <90b5f619-2dd6-817b-fe2d-f895be0b5b98@mediatek.com>
 <CAJZ5v0h8xNCV+1YwRA5wob6Vnvz8JFikv3pYMR_mUrXxzfc=tQ@mail.gmail.com>
 <f6ebfd39-a27a-8b1c-6a61-f9a63236961d@mediatek.com> <CAJZ5v0gChpusk6JuTG+Zhd_qGR1N+s97Avn4ybdp7Ggpv_uRaQ@mail.gmail.com>
 <7c3ec17e-296f-ab15-6055-fd59a7d8f036@mediatek.com> <5c9a3908-a2c6-76d7-db6d-d762503d640a@mediatek.com>
In-Reply-To: <5c9a3908-a2c6-76d7-db6d-d762503d640a@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Aug 2022 13:01:21 +0200
Message-ID: <CAJZ5v0gSY7sJ2zsUsBeNFpT8XnL5yHd0inxh1+pXa9s1b9M50A@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
To:     Peter Wang <peter.wang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 5:19 AM Peter Wang <peter.wang@mediatek.com> wrote:
>
>
> > Hi Rafael,
> >
> > Yes, it is very clear!
> > I miss this important key point that usage_count is always >
> > rpm_active 1.
> > I think this patch could work.
> >
> > Thanks.
> > Peter
> >
> >
> >
> >
> Hi Rafael,
>
> After test with commit ("887371066039011144b4a94af97d9328df6869a2 PM:
> runtime: Fix supplier device management during consumer probe") past weeks,
> The supplier still suspend when consumer is active "after"
> pm_runtime_put_suppliers.
> Do you have any idea about that?

Well, this means that the consumer probe doesn't bump up the
supplier's PM-runtime usage counter as appropriate.

You need to tell me more about what happens during the consumer probe.
Which driver is this?
