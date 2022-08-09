Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86E58DD88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiHIR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245699AbiHIR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:56:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8569818384
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:56:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d16so12002190pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=zCnPcB2cpu3/GqNUc9bJk7MfZepcOxE6mZ2WJIEyIjM=;
        b=gg8paTCMt+q6jyhnsYUhBlckZmrl8YnEgxZyG6Gm9dfbrV4sWx+QagkrGUnJIOfXdR
         HCzFnNFypJqbb7Zg6fy3QZUIh/uqv/0TA+hZxYn/4/Dm0H3M/hjQy1jdmDP9nWJiS/7D
         vDxzXjjEY8/cWpdLHTpoRFKzSQHWyLvIvZkzGYv9cH9fHeNOb8+gsJ5qGScgp2P0GNjf
         VBdx0KxxvWwVIE3hNQdJSKHQoE1jH28h+TwzRuP5oLeAB+RSMFLTb0WymXHYZWujPlgB
         polocVOXmv74dBFHgq/Bpzs1cyUopdo+Xyl+Ndovj9mB9icrkGlNzBudqgEvjnzGz7HH
         +Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=zCnPcB2cpu3/GqNUc9bJk7MfZepcOxE6mZ2WJIEyIjM=;
        b=x6h9ZTju1+d97q9GLr6m4i71C0kyF1e4c1EfdKlPbS1neImoT+RCaC9cpJtDyzOvPH
         8vSCYvGH7jacDO2/Ajx3+3XPvkxSobdveylXPQTo+rnetnM5ernKskNZqQdkQumHGBtO
         9R9r/GpjyVSfIKoBDY16Drwj16QpCqkyEYkhJ1ed3NwSxdrKcXac+dYFGMiUWRg94ZtK
         mUZgF1rv047mJrOTaEQ7kzzBcZ2HeFjaYAteBbl0/fGJIwXgdtLfBlpI3FPDqr2i6uEu
         k2zrUM4S7odFK5+rxBGwqp3/L7pAKa7JYV3FkiZ4Ik7YgdspMobD8NhoPeSOTUxH9hIp
         Bt/g==
X-Gm-Message-State: ACgBeo039uFsiAemzbAslF1nL3TZmSp3oYOqV+Rah1VwT8lEokd3kiDY
        DxaIEbH7od1yo5SBnnGw2Go=
X-Google-Smtp-Source: AA6agR7n4TtUo2yz0zotuygajOoq8vM1Qm3lrFiSzCIxsqzyL3R10gmFRWrp4YDrVXD9WqBqzi3U0g==
X-Received: by 2002:a17:90b:2791:b0:1f3:c48:19d5 with SMTP id pw17-20020a17090b279100b001f30c4819d5mr26574553pjb.219.1660067781942;
        Tue, 09 Aug 2022 10:56:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001637529493esm11246279plg.66.2022.08.09.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:56:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Aug 2022 07:56:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
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
Message-ID: <YvKfxGvg5/J0+QoD@slm.duckdns.org>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
 <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
 <20220809174934.GC10478@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809174934.GC10478@blackbody.suse.cz>
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

On Tue, Aug 09, 2022 at 07:49:34PM +0200, Michal Koutný wrote:
> On Tue, Aug 09, 2022 at 07:31:31AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > I'm not quite sure whether following the usual "charge it to the allocating
> > task's cgroup" is the best way to go about it. I wonder whether it'd be
> > better to attach it to the new cgroup's nearest ancestor with memcg enabled.
> 
> See also 
> https://lore.kernel.org/r/YnBLge4ZQNbbxufc@blackbook/
> and
> https://lore.kernel.org/r/20220511163439.GD24172@blackbody.suse.cz/

Ah, thanks. Vasily, can you please include some summary of the discussions
and the rationales for the path taken in the commit message?

Thanks.

-- 
tejun
