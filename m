Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFAB59745B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiHQQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiHQQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:41:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7771B80486
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:41:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l64so12443455pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=E/WUK+EZH+G0Nw5v/ljN7mHurJREvywoLwk9357cYts=;
        b=QV0UY/uZ3/+BP4P7a0dFEFwVmciILKHs4TU5cmEfG1tE90r34b3s9+fEParsMlHGc2
         8XfQWKtT9heb9WvMsFl7z+zrNUuDq6Cd/CAQbXOfhJRcB9rWyZ6RhvXozwqW4ZAWgwaT
         SwYi3P9KRVzToEJ5zVbudzLztm/58IkXdTYrLcIC3hJklClAG51tUioGYIeDVvrkKnEr
         s8vXgZrPTt/86Jwhbpqe1A7box4ggkTbxxaw7cL9NadbvNR5jjnAfpNaFIMtWi5eyZiV
         793GmFXjiZzsXMx3j+025J01vDbsIYJKYvAU7hbuRn11anqbCAmp4racBmgO52bd3j6v
         My2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=E/WUK+EZH+G0Nw5v/ljN7mHurJREvywoLwk9357cYts=;
        b=ADsuK0PGit/zBSUiMnkwbDiJ1be+PDtLIr68MaZtSH6cQfeSY0RV9bhw7IrTwJmWLJ
         qHH5e7xCjGoXDm5nABkO2k9IdZruJtv6hEQo//khzSi4hIyI7OOLA7qNyzKlF78CDt1L
         MfWRu6EOU5/TaPPKtbRKddh9zbn9W/uN4XNql7k+h2pot6GN/dklU1LFwgAfjiqrkDFB
         2XCh55BJ7HBgMs34kQWeJ48imzVHdql6P/OnNSZH+5nHkopc62vod+CPqa0TBhAGylWQ
         IMaRYc6VpeqwB6rmQpbHTNRTwQVmrgoR2r0xgsa3umu0wlD5/Gd9RCuUQwW+ThuMfRpm
         sntA==
X-Gm-Message-State: ACgBeo2pqPtfNANkJ4nJ3M18bKY0AlAYdB8ajj8VUL8YICJ6GJEEZCzH
        SR9PafDlc8cms37kAjO6v20=
X-Google-Smtp-Source: AA6agR5k841QvYSAxdV0srqkofV2AdZNo8z+Mjy79oVSvGKsGJg7/WnvCwzgIujBR2NKr1k6nZ6q7Q==
X-Received: by 2002:a05:6a00:2991:b0:52e:b387:b3c6 with SMTP id cj17-20020a056a00299100b0052eb387b3c6mr26542622pfb.11.1660754484741;
        Wed, 17 Aug 2022 09:41:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b0017297a6b39dsm110042plk.265.2022.08.17.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:41:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Aug 2022 06:41:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
Message-ID: <Yv0aMqMIafD7cOQX@slm.duckdns.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
 <20220817091728.GA23229@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817091728.GA23229@blackbody.suse.cz>
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

Hello,

On Wed, Aug 17, 2022 at 11:17:28AM +0200, Michal Koutný wrote:
> On Wed, Aug 17, 2022 at 10:42:40AM +0300, Vasily Averin <vvs@openvz.org> wrote:
> > However, now we want to enable accounting for some other cgroup-related
> > resources called from cgroup_mkdir. We would like to guarantee that
> > all new accounted allocation will be charged to the same memory cgroup.
> 
> Here's my point -- the change in the referenced patch applied to memory
> controller hierarchies. This extension applies to any hierarchy that can
> create groups, namely, a hierarchy without memory controller too. There
> mem_cgroup_from_cgroup falls back to the root memcg (on a different
> hierarchy).
> 
> If the purpose is to prevent unlimited creation of cgroup objects, the
> root memcg is by principle unlimited, so it's just for accounting.
> 
> But I understand the purpose is to have everything under one roof,
> unless the object lifetime is not bound to that owning memcg. Should
> memory-less hierarchies be treated specially?

At least from my POV, as long as cgroup1 is not being regressed, we want to
make decisions which make the best long term sense. We surely can
accommodate cgroup1 as long as the added complexity is minimal but the bar
is pretty high there. cgroup1 has been in maintenance mode for years now and
even the basic delegation model isn't well established in cgroup1, so if we
end up accounting everything in the root cgroup for most of cgroup1
hierarchies, that sounds fine to me.

Thanks.

-- 
tejun
