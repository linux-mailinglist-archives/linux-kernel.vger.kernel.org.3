Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671E5837C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiG1D4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiG1D4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:56:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C76481FF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:56:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z22so671862edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=89cQYoQQ7JVoZPEZvY+m6QaTS5rutXILVa1TKYLXWdA=;
        b=ni5FbjN1qo1IcwXc0V6jy4L1VolTDNx9NxXUNOxtd+C5QHAkL/v2mFJcLSuZ91Avus
         6BownTzDkI2RA95Rvu3CJqUDx+0GrXOOiU6vemDC9npkFirDi2n0YFuoJD3fMmmz4VFL
         ACizRnHI/KQAxhhoQHyOKqVNuyXAYbalzQQXGIJCiovZdzLd7zXSD81Q/FAvJJTddZ7T
         RdTqY4IdQS8VamfwfO9ePWI5WEVxh0xMyyuZ/OFbW7HkURa7XUiAvrlafBC+d5TjiNP1
         MwAG5hUjRxUrLxmYvWfRcJEAOqArv96RA9sh3wFPBtqZvBZ9sKgbFwjsf6EkJR8E5WaN
         1Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=89cQYoQQ7JVoZPEZvY+m6QaTS5rutXILVa1TKYLXWdA=;
        b=ny9ELyxcYVVZj6lPM5BNTPhDs3GFErgr1fiOi4TCW0NXzbNicruSmuJK6+pZEBK9bg
         FhlLIidSg2FBzt8eIJUoosFmdFsHe+p59qF1+bs3S1p57oIAdcjPP7IZ79K2cUq37PQ9
         OgoUSkQ5CdWCmY3bO9dH5tjGN/QyC3MSGE4QyE7mKrcsBnJwXYTLSRtBVIG5QVYr4BU1
         sYPJRn2mMBdHcPiXqQQOym1LZqSnd+E9AhhVADvj4UNdzHFm3BnL56ibMryeU5ik274D
         AcVk4RZpoLVcCa6B5xBBM2IUKY+dGza6Kitz8BKJHv9FpDjVLAV9NN6r4qaHJFyaPPLM
         bXtA==
X-Gm-Message-State: AJIora/+Eh2ygrX39F6SRl9x+LHXkq3e9Fhf+hvUBjZ1vfUhF/ja7qBc
        PGkaFS9qHQwTThb1IVO4LxzpkqcbuKgH5q4F1Xg=
X-Google-Smtp-Source: AGRyM1u7dJsyxJCRo/V6Dl4LAU1JVfq9c+j1rRuqYJvCJODT7OQYqZytRXwXmzqpKR1zZXpv5dFnUlpQBRwYXrl2J+c=
X-Received: by 2002:a05:6402:249b:b0:43c:8ce6:8890 with SMTP id
 q27-20020a056402249b00b0043c8ce68890mr8391507eda.74.1658980601132; Wed, 27
 Jul 2022 20:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220701185303.284082-1-dakr@redhat.com> <1c0cbab1-f920-3565-f326-189cbac56da0@redhat.com>
In-Reply-To: <1c0cbab1-f920-3565-f326-189cbac56da0@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 28 Jul 2022 13:56:30 +1000
Message-ID: <CAPM=9tyJNMgupHLyNZDLmXW+UC9+pc-C2Mt+qjuLUAkVfRrvuA@mail.gmail.com>
Subject: Re: [PATCH 00/10] drm: use idr_init_base() over idr_init() if applicable
To:     Danilo Krummrich <dakr@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        Eric Anholt <emma@anholt.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 00:24, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Hi Laurent,
>
> On 7/1/22 20:52, dakr@redhat.com wrote:
> > From: Danilo Krummrich <dakr@redhat.com>
> >
> > This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
> > idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
> > this avoids unnecessary tree walks.
> >
> Guess this would go through drm-misc too?

Could someone from the misc team pick this up, Danilo doesn't have
commit rights yet.

Dave.
