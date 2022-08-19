Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B759A47D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbiHSRyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350181AbiHSRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:53:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E935ADAA2D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:29:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e19so4054231pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=TmCUsQL8JXn7Bb8iL7gl6/228zr3U/z7/7g4TUu4EMk=;
        b=ntg7e5Uk9fDIy48sD1U7+KAmbXz1c5AGnUUSfJD2bWTIeixH5VBwArAz4RG4fvTSEh
         QyRQVtAD7qoCMJtP7WsAbfGNnvnxkXt1ZFryOarpM5HCyyn+VjfFRcoMCbUtShcxgkxl
         rTfDRgazxsasI1W8JnITN6mTovG00WrDnJN1ffLs5tWdH/BEdYUdyhqqI9JlCN14PNhf
         Lrmqn3cZXXR701ILeEH4C+6gcrrgDVsJwdpr6ox8ilWfc7Lrh+YAZXWT+Uv0GIiuUjBn
         psSP/T16fmGM5QVbSnMRGMZWeiHv67z/YdrSpv7gxHCRbwo9OD/nWYcx9UXTZfFlODD5
         dPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=TmCUsQL8JXn7Bb8iL7gl6/228zr3U/z7/7g4TUu4EMk=;
        b=uMfZrP1fjnTcx4I9aJIpox0M6uPeB0ED7G4uk1rs/7ztOYCogPJqYOQ4SBre6l57jL
         9eb8WgzICYANzWO1VQcAf/4sEzVpHQVKwgO6eaHM0giDkYMVkIuvQTsxghqIkOD8OVYO
         LKY2qPh5I96cML5IlyQIty9+Mn0tFBmd6+01Ao6YWRjULYbA+GnOVRvoT8GCLNyqQMPq
         qXzmZCIKB7qcYJWxQYIDBDxRHk//ne1JtAZxHn+CT08NnIOMoMvn2Nxo3YJ12+Q2fv1u
         X+ZOl33/cWQfQC40SNa8S60DiaEwLqfUM6EkGjkXIemzR4vsFC8riKZc234CRwlq/0DS
         mGLQ==
X-Gm-Message-State: ACgBeo2yDNUXrFZurl7iuttp2x1nVUBCsKXPbO3uUenCttrjE83gskm4
        kgSfpkss8xikr7IldSTcw9H3UntYhmk=
X-Google-Smtp-Source: AA6agR6PF+iURq3mD3Yya98Ews1MgOytFE0m7YTmxI220Cdgfd31bCWFEyMUZAD45XWvJHa8OBqo8Q==
X-Received: by 2002:a17:90b:4cc5:b0:1f5:395:6c71 with SMTP id nd5-20020a17090b4cc500b001f503956c71mr15385124pjb.132.1660930193269;
        Fri, 19 Aug 2022 10:29:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:db7d])
        by smtp.gmail.com with ESMTPSA id i23-20020a17090acf9700b001fad69cc346sm644532pju.52.2022.08.19.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:29:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 Aug 2022 07:29:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [RFC PATCH 7/8] workqueue: Remove the outer loop in
 maybe_create_worker()
Message-ID: <Yv/Ij/tE9BqMHhrL@slm.duckdns.org>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-8-jiangshanlai@gmail.com>
 <YvwVbWfoV/bkFb6e@slm.duckdns.org>
 <CAJhGHyAy2OVd_q_dtJ+cLX=BuNOa4L7hPn50oj_Y7iwBuNEfRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAy2OVd_q_dtJ+cLX=BuNOa4L7hPn50oj_Y7iwBuNEfRQ@mail.gmail.com>
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

On Thu, Aug 18, 2022 at 10:44:02PM +0800, Lai Jiangshan wrote:
> On Wed, Aug 17, 2022 at 6:08 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Thu, Aug 04, 2022 at 04:41:34PM +0800, Lai Jiangshan wrote:
> > > worker_thread() always does the recheck after getting the manager role,
> > > so the recheck in the maybe_create_worker() is unneeded and is removed.
> >
> > So, before if multiple workers need to be created, a single manager would
> > create them all. After, we'd end up daisy chaining, right? One manager
> > creates one worker and goes to process one work item. The new worker wakes
> > up and becomes the manager and creates another worker and so on. That
> > doesn't seem like a desirable behavior.
> >
> 
> The recheck is always in the same pool lock critical section, so the
> behavior isn't changed before/after this patch.

Ah, right you are.

Thanks.

-- 
tejun
