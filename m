Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13CD542055
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385871AbiFHAWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359353AbiFGWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:31:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF627B9AF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:25:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so16359991pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=szR7r+mhCiyllPHOYpWCvCcgEkcODKa3DHmlzg25Uuc=;
        b=YxOVYFIXNDL2R9Bp5NP7sFBCXOpoBOSoM2+6V+lnOBnYxPPzfDjs2/v/oTsXj4uhLS
         078BRiHzhGwm+ESUcmIhulF8W4QCV6GSulm+/klLNoOsu0JbpU1VZvx/TBp4Fen3EBH7
         /jj0leaQxRcNbCpvW6hZMD8BLq397vAcPTfDhJe3C26YNJoQkrv87gKE/wcOPh7xxi5o
         QCRIdWFaPOS4K/eIwD87pekU6QM+YI/CHK5K6Gic1G7v7fGKPzWBpaF3tvNwt42+LPJk
         KsE7eVpzhBKnfe7hGrCKvIZU5E3bMVAAdH8DHASpfdSkoz6ia8Lr61B9+lKpxySWVQM/
         emBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=szR7r+mhCiyllPHOYpWCvCcgEkcODKa3DHmlzg25Uuc=;
        b=PStEOTEH5NEZobwrIDyqwvMj32WsEc9d8nSkXhWBsx/r2yR6007R6jiqiVZgtYPmnh
         pWxHs46DSH5zrjRiMa8Zc1r0u6eBKa70Fg2YOq9VdvkOhg9HySAFZ2M4xIcwkGMPPb4b
         FnhsU2c/NN11CtwmOf7BwpOqL5AhMcB+VYlr/wEWjYUXVViP1pNCRrQouB9b5wJ3P394
         lGws4gMnbss5Ok8RDBP+TdLPViXUz9f5nXKcpUb1B7hhIfU/RSmVIE+v3sa39QcX2Sk1
         ZD0mBNNLr5iRlQ1DOt0hNF/g6c2Mhqs4R+j76qVbV/Sl4oE6aVgIGJVUnmHc6UF0ObjA
         qCSQ==
X-Gm-Message-State: AOAM532GHuUBjFW/w9iTDZG0jf+iXFt2EWGWuK5VFp7xwZsu8VrUGdsO
        d94U5WN4Rlqd+/CWZKycxC3Xlw39Mgc=
X-Google-Smtp-Source: ABdhPJxjqDVgqTFmIHkJXehL20yGslGE4u+0x03+g4O9N4M8WM3QfKusenD1lbiI3tyXzFjnFuTgcg==
X-Received: by 2002:a05:6a00:88f:b0:510:7a49:b72f with SMTP id q15-20020a056a00088f00b005107a49b72fmr30639671pfj.21.1654629915579;
        Tue, 07 Jun 2022 12:25:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0015ef27092aasm12865936plk.190.2022.06.07.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:25:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Jun 2022 09:25:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <Christian.Koenig@amd.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <Yp+mGaY+Ga/wX2h2@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com>
 <Yp+HXowR9nTig331@slm.duckdns.org>
 <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:39:01PM -0400, Alex Deucher wrote:
> On Tue, Jun 7, 2022 at 1:14 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> > > From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> > > From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > Date: Thu, 19 May 2022 09:47:28 -0400
> > > Subject: Revert "workqueue: remove unused cancel_work()"
> > >
> > > This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> > >
> > > amdpgu need this function in order to prematurly stop pending
> > > reset works when another reset work already in progress.
> > >
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >
> > Applied to wq/for-5.19-fixes.
> 
> Could we take it through the drm tree so we can include it with
> Andrey's patches that depend on it?

Oh sure, please go ahead. Imma revert from my tree.

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
