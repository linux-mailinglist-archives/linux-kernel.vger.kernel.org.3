Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6451653C0C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiFBWZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiFBWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:25:24 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF722518
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:25:22 -0700 (PDT)
Date:   Thu, 2 Jun 2022 15:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654208721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iXbffRTpMmUtQ/ZhrbG1S7JhzFZozsv7ZKcRHIDCN1U=;
        b=qfIcXOjuztQwEvPSWbPAXRki0ZBCjbBpbDCUNM/xNUbkZ3Whob4ZqZyoLxUd6nbl+MNIel
        WBUvYdT2Ap/d+ZoEMvx6aIn3SEETYL2HgJop07TpJTblFpxX3upoLQzbgUHKpBpr/WuMR8
        aGZGecnRtnnZv5ri3c4UXMuII4emIW4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v5 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <Ypk4yuvJQ1ObIEJH@carbon>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
 <20220601032227.4076670-7-roman.gushchin@linux.dev>
 <20220601142351.5e04fea5586ca51898d8785f@linux-foundation.org>
 <YpgKttTowT22mKPQ@carbon>
 <20220602114132.f6e5675b2d2a4085b9b1e8c4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602114132.f6e5675b2d2a4085b9b1e8c4@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:41:32AM -0700, Andrew Morton wrote:
> On Wed, 1 Jun 2022 17:56:22 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > > 
> > > > +	ssize_t ret;
> > > > +
> > > > +	if (copy_from_user(kbuf, buf, read_len))
> > > > +		return -EFAULT;
> > > > +	kbuf[read_len] = '\0';
> > > > +
> > > > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) < 2)
> > > 
> > > Was it intentional to permit more than three args?
> > 
> > Good catch! No, of course it wasn't intentional.
> > 
> > Below is an updated version of this patch.
> > 
> > ...
> >
> > +	if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 2)
> > +		return -EINVAL;
> 
> s/2/3/methinks?
> 
> 

My bad, of course. Thanks!

--

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 12026472daae..e5b40c43221d 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -124,7 +124,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
                return -EFAULT;
        kbuf[read_len] = '\0';
 
-       if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 2)
+       if (sscanf(kbuf, "%lu %d %lu", &ino, &nid, &nr_to_scan) != 3)
                return -EINVAL;
 
        if (nid < 0 || nid >= nr_node_ids)
