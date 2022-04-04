Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0D4F1082
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377907AbiDDIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiDDIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:12:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DC2FFDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:10:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so13155100wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ed9ZgO0tcHyU8KJ1G38fQUbFJDJgq5Js3xMCrlb4h98=;
        b=RnsSCFrnJZ2/54eqH/h6XMCPFZbTa5Rr/UGIz/l5FYY2oT+LfGZdS8KMHFhu2ZOBnP
         PgP5f9d28aInPZwFSiuntrrCuUxLlCNl88XDf0DK6NJ9K3IobAaBJcOVo84IqkAFj8OO
         BdxWtnQevpF7F32h40s4wB5TLGMOSkgu7h73XmUHDWqsmNXTXCE69Sk/F52JdxbG6T7e
         eU9OleGkKxGvvEqZ06KsyMOKhkSitIoPEP6D8UoK4f75SSzd4ZQ/F8zbSvDOLgYqJuia
         M5pL4BbGcrotFq1v/zCrviUKpQYdAGkK7XWZpid5WXlDZmeLxXCdRfa5r+d8R3dwFUZA
         W63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ed9ZgO0tcHyU8KJ1G38fQUbFJDJgq5Js3xMCrlb4h98=;
        b=MaB6YBNIvqxEtbeL8tGGPyQKnjROsbUN17+ybwOIWj9BId0np229R9G0K3AvJXf572
         tPxj/M7PYEdTRQHWv3y7WJ95aH87kGLpGgdayc0mh4g4T4JICbtO6H5eajMzHQycGzLN
         RDuOjBcatN3ByfzrCT6z8z3DU2Wi4EG21W3+iQpamOsnKu6q/8HEYEkCrXP8pG8ACMrl
         3YPHa6DmQrsxfxIDwoXduOlcIlWqF6bWE8Eek+nuZlb1mVa71YRAq93mtaoDUbV8F6QY
         Zj7i1YGw+evNsIiYm2ArjdsPftMgNdzO4RTkOESD1H26+2/kKMV83HPUqJOrkt/Z24RZ
         gxtw==
X-Gm-Message-State: AOAM530kMVml/DbnKCuAQ1Erb8R8bE8m9Mi7pAMnXYpsL7P3ljTDzlGl
        03jDWInkH8tkv5JNMGmz9689Ww==
X-Google-Smtp-Source: ABdhPJxYLspebzgh9+lRqVZVzZMQ6Q3nzq5Iqp5wOa6grCuzqkS5BwK78nxUTjnPHaKAfvGB2Ci6Ag==
X-Received: by 2002:a05:6000:1c18:b0:206:1029:922f with SMTP id ba24-20020a0560001c1800b002061029922fmr3288428wrb.709.1649059809813;
        Mon, 04 Apr 2022 01:10:09 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:8bc1:e5e5:97b1:783])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm16195659wmb.15.2022.04.04.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:10:09 -0700 (PDT)
Date:   Mon, 4 Apr 2022 10:10:03 +0200
From:   Marco Elver <elver@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
Subject: Re: [mm/slub]  555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
Message-ID: <Ykqn2z9UVfxFwiU+@elver.google.com>
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
 <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkpgjgM/aSXd29uj@hyeyoo>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:05PM +0900, Hyeonggon Yoo wrote:
> On Sat, Apr 02, 2022 at 12:50:14AM +0900, Hyeonggon Yoo wrote:
> > On Thu, Mar 24, 2022 at 09:52:18AM +0000, Hyeonggon Yoo wrote:
> > > On Wed, Mar 23, 2022 at 05:05:20PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > > 
> > > > commit: 555b8c8cb3f335ec8fd9d1ffd25e1395790d102d ("mm/slub: use stackdepot to save stack trace in objects")
> > > > https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r1
> > > > 
> > > > in testcase: rcutorture
> > > > version: 
> > > > with following parameters:
> > > > 
> > > > 	runtime: 300s
> > > > 	test: cpuhotplug
> > > > 	torture_type: tasks
> > > > 
> > > 
> > > [+Cc Vlastimil, linux-mm, and people related to stackdepot]
> > > 
> > > I'm going to spend time on it.
> > > I have no clue why this happened yet.
> > >
> > 
> > I modified alloc/free debug processing to check if handle is valid, but
> > it couldn't detect something wrong. Everything was fine when allocating/freeing objects.
> > 
> > Handles must be modified outside SLUB code.
> > (Or maybe SLUB code related to cpu hotplugging did cause this.)
> > 
> > I reproduced this problem on x86_64 with KASAN enabled, but KASAN
> > detects nothing.
> > 
> > I suspect this would be memory corruption bug, race condition, or
> > wrong calculation of object metadata offset. But still have no clue.
> > 
> > I'm going to check if KCSAN detects something.
> > 
> 
> KCSAN also didn't help.

(Maybe CONFIG_KCSAN_STRICT=y is going to yield something? I still doubt
it thought, this bug is related to corrupted stackdepot handle
somewhere...)

> I noticed that it is not reproduced when KASAN=y and KFENCE=n (reproduced 0 of 181).
> and it was reproduced 56 of 196 when KASAN=n and KFENCE=y
> 
> maybe this issue is related to kfence?

What about KASAN=n and KFENCE=n?

Thanks,
-- Marco
