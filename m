Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292352E696
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbiETHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiETHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:52:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35033EBA98
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:52:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 10so3307177plj.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5vIeqJ2l7ohbADo6n14qY+TAL6tqjFMC+/vvZ+WHJvA=;
        b=QbMBFcQM9qRP+Zt3g3VsB3vTZOpvKm6co4eXrI0mMajeM60kX9QU+FH98IFoV4NfxD
         oRl0QjfFPBhMbU2V8gl/4x95UfmTyCaYSwq6U9PgyvQxVsCf4tzMbl9WOdYQJHo1qPcw
         6lH+gvtR04sra0+Q4UwHEm6eSKsJKD0RHgLwSU1VIh8K98sH+Sm7Mg/PNk0OO11VygyX
         I/a5DQemxJjUDN9jnRlMyQ8E7Aow7y1AnyqI8UyDT5KbsOWrir/uPpHFcx9LoIWiF5Db
         SOd6VQmpcmW7+w065G+ZrR4LNhyHz0SY/j1URG/gcgJOLrnFH8do/XBfJ2zzmXfgnAW9
         6vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=5vIeqJ2l7ohbADo6n14qY+TAL6tqjFMC+/vvZ+WHJvA=;
        b=2jUhXC4eKTOEI6Pf+4qJvmtvTlvM6vaF2L0kGOrS0JfK8MrjyJfNQsh2b8snF4Diya
         770jN+5pcVySh8DHgN1Qs7wfScgarg4c2Fcsl9+Vsul+SEezL6A/MxxGSGywLE/f4t3N
         yaVMznWuLsMRxOBXGGRTXb17nomES+hGLrQ9nG3cJGNZXkDvSoG5eu3NSJJ4ZeODunrP
         /VhH5gxj4kAlXk/bhwB6BE+y3Xg4071nVSu+VRwCpeVmCwZMzvHYKv/gu8I6JWAm3hCk
         779qmGJ2Jdub4lXrw3rEUS3yi8L3Qe0uw6M7c1Auv9WmeHwIE31FVRsTMaN8eVRjgQ57
         LtUg==
X-Gm-Message-State: AOAM530qW2gb5Mc8GUyDrIKAY9NkYin9M3iua+7esziyipPiy5tHvKBz
        pbZY2h7Pkj486G3c4VgGwLA=
X-Google-Smtp-Source: ABdhPJz2uw+P0c+QcAEevcQomiSCOXCL0p/z1jWLOWE65LWBQt5+YLv0FiSxkyiQpvuR3U6l2l8jRw==
X-Received: by 2002:a17:90b:1e4f:b0:1dc:847d:38b5 with SMTP id pi15-20020a17090b1e4f00b001dc847d38b5mr10177098pjb.3.1653033132554;
        Fri, 20 May 2022 00:52:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902c1d100b0015e8d4eb243sm4943881plc.141.2022.05.20.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:52:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 May 2022 21:52:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <YodIquufXzK581gw@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
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

On Fri, May 20, 2022 at 08:22:39AM +0200, Christian König wrote:
> Am 20.05.22 um 02:47 schrieb Lai Jiangshan:
> > On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> > > See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
> > > 'drm/amdgpu: Switch to delayed work from work_struct.
> > > 
> > > I will just reiterate here -
> > > 
> > > We need to be able to do non blocking cancel pending reset works
> > > from within GPU reset. Currently kernel API allows this only
> > > for delayed_work and not for work_struct.
> > > 
> > I'm OK with the change.
> > 
> > With an updated changelog:
> > 
> > Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>
> 
> Good morning guys,
> 
> for the patch itself Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> And just for the record: We plan to push this upstream through the drm
> branches, if anybody has any objections to that please speak up.

Andrey, care to resend with updated description?

Thanks.

-- 
tejun
