Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6155089F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354209AbiDTOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379276AbiDTODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:03:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC523A191
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:01:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so980992qtp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1Sscqvoo7rz90w552fG1qluFSOgbb1+p44eFkfXZXw=;
        b=BkM9SmDrgxYj+HcWafYKsLOSaaQkvO8MYXKQsOg921qCb4v0nRrMUOznRS4a5VLFUx
         BmxCxhwGnDs978fatHUFHPnnRmuVlZEG4QPYYZhOhUdxamvwrFCjwlrEjVZzHgguwQ7q
         Is50mVeULvFhzQ6RDedeNeXWimUX2TQE6G9BXWCWhSuaU9okmm7z401UarFu3BI2MPIa
         67HKueLQiSlF/pvRGANYugd3ckQ3FFq/8kVzXdQZMRkqsBtP8AX0yFz4QRa+bokecm7J
         ycWK6Z8HBEH93VeWncKSsfEAJz975O1T/3Y619q5R69A0ccap8aZPTzxRaC8df8PQ5JT
         bzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1Sscqvoo7rz90w552fG1qluFSOgbb1+p44eFkfXZXw=;
        b=yDYMUZj49Mi04JGfU+Qj7C7N8o1Qqq0MSf/4+5XLofhevo6PdE0SuOwLH0+I7NJ419
         CTFNmnsKn83y2V8JEwldCG4JXjvySmFZPX8qnB4vJ8mM+l/qxx3aA/cpdGleJptABM0t
         BzaMsWZdzwdYlXfgxs+47HsxGBwfXF/yAIV0118a/Uot4pzYCK0912x9kD6Oby29YKV7
         2qynT4Ql5ZWyGIDVRJZen/c8sQMVauF9wuXraiAUY5N9IgQSX553AgbH+za4TQ7akxiH
         xxVGREUL3Wh5dZJnqgN6xZ+OBR8xQmlnE9mjn8eUul06hOUpy+okvJIle3DfOVPczsZ5
         wHwg==
X-Gm-Message-State: AOAM531y2rpge7heBOFeAQxbmYI70CNf8nouYLR7Trg70q14UZUqal96
        cPZUNtFBOu3ijQ5NFqmBn+xn7g==
X-Google-Smtp-Source: ABdhPJwozpmC0SgweInYjDsRTNf8wKGRtqJ3jxjVI8LofpTyn+G1S8X1pHxVhVdLfumr1ntlcJDH1A==
X-Received: by 2002:ac8:7d55:0:b0:2f3:458f:236f with SMTP id h21-20020ac87d55000000b002f3458f236fmr544454qtb.251.1650463265504;
        Wed, 20 Apr 2022 07:01:05 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a27d200b0069ecf023d1asm1535936qkp.129.2022.04.20.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:01:05 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:01:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Message-ID: <YmASIHjTVndHHoL4@cmpxchg.org>
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
 <Yl8Dk+a1YDwupLMv@cmpxchg.org>
 <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e495901c-f2f3-cc85-10a6-0d2944255b19@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:54:52PM -0400, Nico Pache wrote:
> 
> 
> On 4/19/22 14:46, Johannes Weiner wrote:
> > Hi Nico,
> > 
> > On Tue, Apr 19, 2022 at 02:11:53PM -0400, Nico Pache wrote:
> >> I think its is important to note the issue we are seeing has greatly improved
> >> since the initial posting. However we have noticed that the issue is still
> >> present (and significantly worse) when cgroupV1 is set.
> >>
> >> We were initially testing with CgroupV1 and later found that the issue was not
> >> as bad in CgroupV2 (but was still an noticeable issue). This is also resulting
> >> in the splitting of THPs in the host kernel.
> > 
> > When swappiness is 0, cgroup limit reclaim has a fixed SCAN_FILE
> > branch, so it shouldn't ever look at anon. I'm assuming you're getting
> > global reclaim mixed in. Indeed, I think we can try harder not to swap
> > for global reclaim if the user asks for that.
> > 
> > Can you try the below patch?
> Sadly this did not fix the V1 case.
> 
> I will have to go back through my notes and over the code again to find what
> difference between the two may be causing this issue. Im just starting to focus
> on this issue again so my memory needs some refreshing of where I was last at.
> 
> The good news is that with the current state of upstream the issue of swap
> storms tearing down THPs seems to be minimized to sane amount with V2.
> 
> My swappiness=0 solution was a minimal approach to regaining the 'avoid swapping
> ANON' behavior that was previously there, but as Shakeel pointed out, there may
> be something larger at play.

So with my patch and swappiness=0 you get excessive swapping on v1 but
not on v2? And the patch to avoid DEACTIVATE_ANON fixes it?

If you haven't done so, it could be useful to litter shrink_node() and
get_scan_count() with trace_printk() to try to make sense of all the
decisions that result in it swapping.
