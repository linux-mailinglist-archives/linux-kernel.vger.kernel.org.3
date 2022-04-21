Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9150A8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391734AbiDUTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiDUTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:06:33 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357C749924
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:03:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id hu11so4369963qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1ek3wN02GincmUV+xyNQc8ilOsdNX/XVZ4b8GezTFQ=;
        b=m3XYYnXY5ktaWr46Q6VYKCB8BTvzzCrI4OoyX2PylTtwUQczHSRIbZm6KojMOoY9xU
         9TRcD1NaLEykrxy9E53iM9hB3bPmDw/YNKSLTRNJALF8/ucT8HgKooeBHw/1MuPUnmce
         FuAs32+E1GkdKMsOi5reZAFEerQt6aErq5xwjECyijjWgaRzr+pC5GSbi2lll8g+CGDS
         5JaboSZuGQi3QiWnTRD6cCnwzhtIlCR+6FvhSk58uqpj1RK2g8xoqx3WEMMcSEGNydpH
         LwK76tlUvFJP0tLJaziX5s3p3Xz3vn624EL4zd/Ee5rodf8KPOU2ASN63nZAXU90HPhf
         Shig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1ek3wN02GincmUV+xyNQc8ilOsdNX/XVZ4b8GezTFQ=;
        b=q7F/A6KOsQXYo5pzI2YjYQqot0PsjUZ0izuvc5PQUbrpPNrzcGb851M059dwODEyte
         Mqb6pfQWT0KpO98mXHcqfe/iFtZBoQ0q5QOrCIWhC92R82vEb9f+UYliakStWfcjyJKj
         z4TZr2CzKipepkLEk9Xvt9YVKqgXWMh0snomiKapTY+Prq/eWh6d04EKtbYylhDxM5bR
         FnSiUPe+W6dkQJNaO18+pB+Lv4mkr9jgvjCnQeuuXSj+BKHu+Z+WihiuNUB/XXHHmd77
         DDwQxQZAmf/RkDbRo+i+J6cWeZWDbsVb2rx3PHrSu94KScAv/0SwAqC4lY9+Zy5Olf1N
         2LbQ==
X-Gm-Message-State: AOAM5317BpqLEEE0FSV/CpepiLt1dOYHDSllGPYSGmNq4F0ZBriihX3A
        i+4qjuJqWN01rOPg3YlAgA==
X-Google-Smtp-Source: ABdhPJzK54XRT0TIUAumPMcTgiIse6zxFliYcFyYzq6Uf8v80O3pog0Ak8EOG4nQZUhhFNy0Ogxt9A==
X-Received: by 2002:ad4:5aa1:0:b0:446:6444:aa03 with SMTP id u1-20020ad45aa1000000b004466444aa03mr1019835qvg.23.1650567822339;
        Thu, 21 Apr 2022 12:03:42 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a0d5400b0069c71a71ed3sm3221549qkl.33.2022.04.21.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:03:41 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:03:39 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hillf Danton <hdanton@sina.com>, MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <20220421190339.z2fxoywedhyibsgn@moria.home.lan>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <YktCKVbChtC+YjOk@carbon.dhcp.thefacebook.com>
 <20220405051710.GW1609613@dread.disaster.area>
 <Ykxv1j9dxlz1BS5N@carbon.dhcp.thefacebook.com>
 <CAHbLzko=bjLhhJXjcs0Uh-g3x9vV1gQZjEU2JqxVehqSb1UGkQ@mail.gmail.com>
 <Ykyy8RfJgWDOGylv@casper.infradead.org>
 <20220406000130.GZ1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406000130.GZ1609613@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:01:30AM +1000, Dave Chinner wrote:
> On Tue, Apr 05, 2022 at 10:21:53PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 05, 2022 at 01:58:59PM -0700, Yang Shi wrote:
> > > Yeah, I agree it actually doesn't make too much sense to return the
> > > number of reclaimed objects. Other part of vmscan returns the number
> > > of base pages, the sizes of slab objects are varied, it may be much
> > > smaller than a page, for example, dentry may be 192 bytes.
> > 
> > From the point of view of vmscan, it only cares about the number of pages
> > freed because it's trying to free pages.  But from the point of view of
> > trying to keep the number of non-useful objects in check, the number of
> > objects freed is more important, and it doesn't matter whether we ended
> > up freeing any pages because we made memory available for this slab cache.
> 
> Yes and no. If the memory pressure is being placed on this cache,
> then freeing any number of objects is a win-win situation - reclaim
> makes progress and new allocations don't need to wait for reclaim.
> 
> However, if there is no pressure on this slab cache, then freeing
> objects but no actual memory pages is largely wasted reclaim effort.
> Freeing those objects does nothing to alleviate the memory shortage,
> and the memory freed is not going to be consumed any time soon so
> all we've done is fragment the slab cache and require the subsystem
> to spend more resources re-populating it. That's a lose-lose.
> 
> We want to select the shrinkers that will result in the former
> occurring, not the latter.

Do we have any existing shrinkers that preferentially free from mostly empty
slab pages though? And do we want them to?

You're talking about memory fragmentation, and I'm not sure that should be the
shrinker's concern (on the other hand, I'm not sure it shouldn't - just freeing
the objects on mostly empty slab pages is pretty reasonable for cached objects).

We could also plumb compaction down to the slab level, and just request the
subsystem move those objects. Might be easier than making that an additional
responsibility of the shrinkers, which really should be more concerned with
implementing cache replacement policy and whatnot - e.g. shrinkers were doing
something more LFU-ish that would also help with the one-off object problem.
