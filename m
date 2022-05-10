Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D316E5224B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiEJTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiEJTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:25:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9806268E8F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:25:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so21147918edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q02MjLOgg2Tpze+rP7gT3Qz466ICkAZt0Ry0Ipd95Jk=;
        b=EYGCJd6nKoa7AlCbXFoVs2wwPeK/MEzlyyIuT7RYv0vzGpEIeuOFdQINX/UX8oUQ+O
         zqeKwl0MK/RxV77Ect8iMtjzOqYv3i79dlLCP9x+TIdxK9JM5qr9BXQ0gfDvAS0riPkj
         ij+Nag5o81v4h3q5apmB7S/7VJGRJvNpxN7/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q02MjLOgg2Tpze+rP7gT3Qz466ICkAZt0Ry0Ipd95Jk=;
        b=aend1Rf7dghLxE97hCvA/WRBXLlI9TTg1EHny5WZGFnOxl8xlMP0yrfBN1lsK6Epnu
         ngkftIQOWoRroTrMRAoHj1iAywO1dNW5plvXjdj6+aYHP8yFmplYdfnovFrYHn5IG5fs
         /r15W0m24aA8UA3JVKnieOeYNkti0a3j1JoY02xxpKJF+CitFesBhFZ22IzfwG/eQ0Qy
         FsAo/ggOZSoaXERYi55h33Qdb5MTgtjXmPiAe2lZTYGOlMMLq0CEBWO0IrMD/JXMGs7k
         k0Eou6y9Wl0EC02I8EXBc23Z4MrvkgVHyllHmV4Mn04N8elgobOp8AONnWznRLkslLFE
         /gvw==
X-Gm-Message-State: AOAM533n8/y+XC2OX0WqBkuBifM07pQMkreVz6yXSL1/PONfcaFLzbxe
        tD+x7iaZh3S3qd6J03eESuy6rS+A5wM0QtvGsrk=
X-Google-Smtp-Source: ABdhPJwt2Xt8jemseEIF44yoFgfv8IWIv2MyU7Cci7/k/Zt06yRPXP42BJdIuiiQHnAVrIAVLVxi6w==
X-Received: by 2002:a05:6402:2920:b0:425:d7c7:41f with SMTP id ee32-20020a056402292000b00425d7c7041fmr25222329edb.370.1652210734385;
        Tue, 10 May 2022 12:25:34 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r23-20020a17090638d700b006fb6d9d25bfsm100496ejd.22.2022.05.10.12.25.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:25:34 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id q23so33359wra.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:25:34 -0700 (PDT)
X-Received: by 2002:a5d:6d0b:0:b0:20c:4ec7:8e84 with SMTP id
 e11-20020a5d6d0b000000b0020c4ec78e84mr19776596wrq.281.1652210733697; Tue, 10
 May 2022 12:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220420013526.GB14333@xsang-OptiPlex-9020> <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1> <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1> <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com> <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com> <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <56474c28-e62a-36b1-257b-9e5ffb11b0e2@redhat.com> <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
In-Reply-To: <CAHk-=wiEtdHOeBti66NpSZDQw0KxcU45UNHaO-+Zwbiq3JEu+g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 May 2022 12:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpkeoyKVf9GVPcddFUDM1+fzFHmoseNZAcqAtjd3D85A@mail.gmail.com>
Message-ID: <CAHk-=wjpkeoyKVf9GVPcddFUDM1+fzFHmoseNZAcqAtjd3D85A@mail.gmail.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0% regression
To:     Waiman Long <longman@redhat.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Aaron Lu <aaron.lu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think the PV case already basically does that - replacing the the
> "store release" with a much more complex sequence. No?

Looking around, the PV case is absolutely horrid, and does a
cmpxchg_release() on the unlock path. Yeah, that would make the unlock
*much* more expensive.

And I guess that's fairly fundamental. Even if you were to avoid an
explicitly atomic access - do the unlock a non-atomic write followed
by a non-atomic "read pending and see if we need to something
expensive", just that check would have to involve at a minimum a
memory barrier, so it ends up being expensive even for the
non-contended case.

              Linus
