Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D252CBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiESGXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiESGXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:23:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0710FC;
        Wed, 18 May 2022 23:23:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so3933448plh.1;
        Wed, 18 May 2022 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=dU3DINgtfDGFvxrO8vrzH5gTpYaPOj3EtI0Lxev004k=;
        b=P9W2ao+X1j8o0e4M3FlE51sp3ZbX3kE6OaySix0Nr61fzvDANNnziV6sn4i0OFOuQb
         fnL6nP43cKR4E1RS0Ne2keCb+AkGQPT9y8ZPd6G32GtOgD+5MIeRrANHYRmlE7Ep5hGz
         Y6JPNIoB+Q0BZ/oMJmulRfJ60JVL8dmzgECHEtp9OYAhGkeunjdp17a8pupShmNPinaU
         JzCaDrAkxVMUKS9MHQjYBPMSizldkrKM7Z7fqvcp0N9w84qm/HZAzzWcHXuDY6qaAbxN
         Y/rB+0OStlQdUsmwlr5b78RECyJyCescD02nI86iYRRtnnwtGmXbAivv2KStLk79Uj8l
         nvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=dU3DINgtfDGFvxrO8vrzH5gTpYaPOj3EtI0Lxev004k=;
        b=eupZJrrhG7dqCjkSACIhd556cAlsOD3suFe/7SwcFgSsyOoKlnTJEwGA/pQITBnrgZ
         c0TbzD3RExrlcmeSsLxE61x4uI1OK753etGjP2v/xFI0ENcN90KPJXK4x3/XVYdne7yq
         N5aom8d42KEs0J9w8eTL0gEI/4p5HJx9AsWiEuf4JpLGFGxb9h2huMm3kZTEAgJexCAX
         1qg7w1K9UCMqzd4MiA8nuhlhpHr1rsQhuQDSJfMTTKGpnxg/37tRXlH9wbEnoGlybRDR
         ey6fiurs3itAah+5wToq6JjaxuU7vqNbqEmVcgg5xv22WRqE4/2gm55LQIXK8aiMZdYV
         ZkQw==
X-Gm-Message-State: AOAM531Pvn6llEasuqn+07W4XW0yADVs4XjuM+/3RyxRhvHZnSpLEtWY
        Xrq0eM7L61PiV7zHAGcfacU=
X-Google-Smtp-Source: ABdhPJyxzQAh4x9PryBtqoGQKFBgbbAygSGM6ZDhTgWcBRb9YCR0GTecP+DjRQ+BYAA7pFaWwznVqw==
X-Received: by 2002:a17:902:ba8c:b0:161:5ad4:1800 with SMTP id k12-20020a170902ba8c00b001615ad41800mr3412938pls.9.1652941413377;
        Wed, 18 May 2022 23:23:33 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0015e8d4eb204sm2815041pli.78.2022.05.18.23.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 23:23:32 -0700 (PDT)
Message-ID: <6285e264.1c69fb81.3f416.71a8@mx.google.com>
X-Google-Original-Message-ID: <20220519062330.GA1735877@cgel.zte@gmail.com>
Date:   Thu, 19 May 2022 06:23:30 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Hugh Dickins <hughd@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoOrdh85+AqJH8w1@dhcp22.suse.cz>
 <62845e2b.1c69fb81.cbf4a.1200@mx.google.com>
 <YoTiqm4sQCtq8C1C@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTiqm4sQCtq8C1C@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:12:26PM +0200, Michal Hocko wrote:
> On Wed 18-05-22 02:47:06, CGEL wrote:
> > On Tue, May 17, 2022 at 04:04:38PM +0200, Michal Hocko wrote:
> > > [CCing Hugh and linux-api]
> > > 
> > > On Tue 17-05-22 09:27:01, cgel.zte@gmail.com wrote:
> > > > From: xu xin <xu.xin16@zte.com.cn>
> > > > 
> > > > For now, if we want to use KSM to merge pages of some apps, we have to
> > > > explicitly call madvise() in application code, which means installed
> > > > apps on OS needs to be uninstall and source code needs to be modified.
> > > > It is very inconvenient because sometimes users or app developers are not
> > > > willing to modify their app source codes for any reasons.
> > 
> > Hello, Michal.
> > > 
> > > Would it help to allow external control by process_madvise?
> > >
> > 
> > Maybe, but it will be much more complicated to achieve this by
> > process_madvise(). process_madvise works on a serires of VMAs in
> > essential, So all the eligible VMAs have to be traversed. The problem
> > about this has been discussed in [1],[2].
> > [1]https://lore.kernel.org/lkml/1835064.A2aMcgg3dW@natalenko.name/
> > [2]https://lore.kernel.org/lkml/20220513133210.9dd0a4216bd8baaa1047562c@linux-foundation.org/
> 
> I can see that this is not a trivial interface to use but I do not
> think this would be too hard to be usable. There is certainly some
> coordination required between the external and the target tasks. But
> that is to be expected IMHO. You do not really want to configure merging
> without actually understanding what the application does and whether
> that is really OK. Right?
> 
> Besides that, as far as I remember, the process_madvise interface
> doesn't really require exact vmas to be provided and a single range can
> span multiple VMAs.

Yes, but all the eligible VMAs still have to be traversed after all. It may
induce more latency than needed because the target task has to be
stopped to avoid races.


> 
> > > > So to use KSM more flexibly, we provide a new proc file "ksm_enabled" under
> > > > /proc/<pid>/. We can pass parameter into this file with one of three values
> > > > as follows:
> > > > 
> > > > 	always:
> > > > 		force all anonymous and eligible VMAs of this process to be
> > > > 		scanned by ksmd.
> > > > 	madvise:
> > > > 		the default state, unless user code call madvise, ksmd
> > > > 		doesn't scan this process.
> > > > 	never:
> > > > 		this process will never be scanned by ksmd and no merged
> > > > 		pages occurred in this process.
> > > > 
> > > > With this patch, we can control KSM with ``/proc/<pid>/ksm_enabled``
> > > > based on every process. KSM for each process can be entirely disabled
> > > > (mostly for debugging purposes) or only enabled inside MADV_MERGEABLE
> > > > regions (to avoid the risk of consuming more cpu resources to scan for
> > > > ksmd) or enabled entirely for a process.
> > > 
> > > I am not really familiar with KSM much but I am wondering whether the
> > > proc based interface is really the best fit. We have a very similar
> > > concern with THP where processes would like to override the global setup
> > > and that has been done with prctl interface. Is there any reason why
> > > this should be any different?
> > > 
> > At least for now, I can't find a simpler implementation than proc file,
> > unless we add a new syscall used for changing another process mm's flag
> > in user space.
> 
> What is the problem with the prctl extension?
>

What's the meaning of the prctl extension?
I don't quite get your point. Can prctl control external process?

> > Speaking to THP, the interactive UI of KSM is relatively simpler because
> > KSM dosen't have global knob like THP. OTOH, THP trades space for time
> > (consume memory) while KSM trades time for space (save memory), so THP
> > tends to be enabled system wide while KSM not.
> > 
> > > Another question I have is about the interaction of the per-process
> > > tunable with any explicit madvise calls. AFAICS you have made this knob
> > > per mm but the actual implementation currently relies on the per-vma
> > > flags. That means that one can explicitly disallow merging by madvise
> > > for a range. Is it wise to override that by a per-process knob? I mean
> > > there might be a very good reason why a particular memory ranges should
> > > never be merged but a per-process knob could easily ignore that hint
> > > from the application. Or am I just confuse?
> > For now, there is no any hints for letting KSM never merge some memory
> > ranges.
> 
> I am not sure I understand. Could you be more specific?

Not like THP, KSM doesn't have anything like VM_NOHUGEPAGE, so apps
cann't explicitly disallow merging by madvise. If it is really necessary for
a particular meory ranges of a process to be never merged, we have to submit
one more patch to achieve that.

> -- 
> Michal Hocko
> SUSE Labs
