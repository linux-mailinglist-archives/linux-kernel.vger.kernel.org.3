Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE384C0E33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiBWI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiBWI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:26:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348666F9D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:26:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A6F51F3A8;
        Wed, 23 Feb 2022 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645604766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndVfaSSbyuEACVconC2Gsr4OBWhW1wlnM1YJw3WL/m4=;
        b=rTpqRzq9RYE6GPLlyLdc5ql1ucNt+B9SVfCJ4snbrnfDusW0DKz474W46VNr7Kx89kk8ug
        pg0Y0gcC05huy6tSCFwNdQLaoWpO6mLotd1RpUHdFzr/P6ZBa329Ik8WmutJ1LrGsVhGKe
        3AnZBQldHejfMZu4fZWVZ4JXHrVurP8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02F8DA3B8A;
        Wed, 23 Feb 2022 08:26:03 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:26:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: prevent vm_area_struct::anon_name refcount
 saturation
Message-ID: <YhXvmhIjwScN9SNj@dhcp22.suse.cz>
References: <20220222054025.3412898-1-surenb@google.com>
 <20220222054025.3412898-2-surenb@google.com>
 <YhSqDvSTN7nbz4C9@dhcp22.suse.cz>
 <CAJuCfpHr78By6p5sMhJZ3UohKXXSeA7Dxm_q-OA4y6KYL0L_pQ@mail.gmail.com>
 <CAJuCfpFkwZAw-qcD6E5SchHNXf8MmzyWtuWaHOpFhid3m5bg8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFkwZAw-qcD6E5SchHNXf8MmzyWtuWaHOpFhid3m5bg8A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-02-22 19:02:08, Suren Baghdasaryan wrote:
> On Tue, Feb 22, 2022 at 7:56 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Feb 22, 2022 at 1:17 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 21-02-22 21:40:24, Suren Baghdasaryan wrote:
> > > > A deep process chain with many vmas could grow really high.
> > >
> > > This would really benefit from some numbers. With default
> > > sysctl_max_map_count (64k) and default pid_max (32k) the INT_MAX could
> > > be theoretically reached but I find it impractical because not all vmas
> > > can be anonymous same as all available pids can be consumed for a
> > > theoretical attack (if my counting is proper).
> > > On the other hand any non-default configuration with any of the values
> > > increased could hit this theoretically.
> >
> > re: This would really benefit from some numbers
> > Should I just add the details you provided above into the description?
> > Would that suffice?
> 
> Hmm. According to the defaults you posted, with max number of
> processes being 32k and max number of vmas per process 64k, the max
> number of vmas in the system is 2147450880. That's 32767 less than
> REFCOUNT_MAX=INT_MAX (2147483647) and 1073774592 less than
> REFCOUNT_SATURATED (3221225472). So with those defaults we should
> never hit these limits. Are we adding this protection for systems that
> set non-default higher limits or am I miscalculating something?

Yeah, I guess this should be the message the changelog should be
sending.
-- 
Michal Hocko
SUSE Labs
