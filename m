Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6F58DD78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbiHIRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHIRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:49:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43D237D2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:49:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BAC62106D;
        Tue,  9 Aug 2022 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660067376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFEcIZhh+NenTSRU7B/sMYILulgZi/8rIFBk+LzpRmQ=;
        b=hCKZz65GvVqfSrk6l/fpsc+ohWE0XY45aNVjv4o6e6l8IUTF5PYoEpSLr+h0aSYj/fmX/+
        HnDnJfjImCZOVXmk9qGmskkywQakiOxthgG0hcENAdwg+F1G137nshnL/y4cTppeXF9Y87
        mVRPpiUpxUYf3NCq8DJhhzQ2Lro0av0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F33613AA1;
        Tue,  9 Aug 2022 17:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2/9wCjCe8mLUJgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 09 Aug 2022 17:49:36 +0000
Date:   Tue, 9 Aug 2022 19:49:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] enable memcg accounting for kernfs objects
Message-ID: <20220809174934.GC10478@blackbody.suse.cz>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
 <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:31:31AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm not quite sure whether following the usual "charge it to the allocating
> task's cgroup" is the best way to go about it. I wonder whether it'd be
> better to attach it to the new cgroup's nearest ancestor with memcg enabled.

See also 
https://lore.kernel.org/r/YnBLge4ZQNbbxufc@blackbook/
and
https://lore.kernel.org/r/20220511163439.GD24172@blackbody.suse.cz/

Michal
