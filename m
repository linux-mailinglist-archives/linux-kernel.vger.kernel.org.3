Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4A52F6C7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 02:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354233AbiEUA1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 20:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354224AbiEUA1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 20:27:39 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A75C764
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:27:37 -0700 (PDT)
Date:   Fri, 20 May 2022 17:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653092855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybD2DLbTD497o3f+a8Ge6qsT4YJzfBUJVdSBO1Z5I2c=;
        b=J4JGNw8XxMYX+iMjs9avAhMHf7thryEg324HajnxGlDAo2CgNK2UEJT+kATb7Fflw0uOhj
        uhvuRK6Ex1GWDxQHyhYMcFVg9iyYqB18Js1SdQejp/PVaWEbIq8ey5V9kmna4Wy7M7I3Nf
        o1yfHDUUz0/k/n7gaNMNX4NojUokcDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <Yogx8K98SQ+kyOlG@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
 <20220520164512.dqqbb5gkmfm6f4g6@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520164512.dqqbb5gkmfm6f4g6@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:45:12PM -0400, Kent Overstreet wrote:
> On Mon, May 09, 2022 at 11:38:16AM -0700, Roman Gushchin wrote:
> > This commit introduces the /sys/kernel/debug/shrinker debugfs
> > interface which provides an ability to observe the state of
> > individual kernel memory shrinkers.
> > 
> > Because the feature adds some memory overhead (which shouldn't be
> > large unless there is a huge amount of registered shrinkers), it's
> > guarded by a config option (enabled by default).
> > 
> > This commit introduces the "count" interface for each shrinker
> > registered in the system.
> > 
> > The output is in the following format:
> > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> > ...
> > 
> > To reduce the size of output on machines with many thousands cgroups,
> > if the total number of objects on all nodes is 0, the line is omitted.
> > 
> > If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> > printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> > printed for all nodes except the first one.
> > 
> > This commit gives debugfs entries simple numeric names, which are not
> > very convenient. The following commit in the series will provide
> > shrinkers with more meaningful names.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> I think this looks reasonable
> 
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Thank you!
