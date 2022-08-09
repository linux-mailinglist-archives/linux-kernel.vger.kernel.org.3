Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984158DD38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiHIRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245522AbiHIRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:31:37 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2F21E00
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:31:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q19so11396997pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=DAuyBheZuRHxgbT+xkex8fMKl7Fnn2ftU3GmNZB6VYk=;
        b=j/xrHYDRbbtlR/BHgsK46YeK+IuysRf+p4J+XhIzG96by8pEaizgXJgyCR4u0a/cb4
         Zp98BW3pxJkLDaN6OmB5pQLPYGRcGpelpRDnIWHfCTVeNOMtCrltKWQ1/Jj+Vzp9vhLv
         h3HBPi/9tUaLooOMD/IfHHdOm28xQRmTkUa3z5etR5WDZfOcafMDfKyMbcx6DSqE0GcF
         7k9jeS6iR1vajRRW7ECmyleQzhvPt2Idu/FhJ6Uek1Jh1iKGl+KwE0/iEkybu2GypU+e
         yeenPGL0HiM83PHRznvLwDCDqUOJvZtQs5P9xC2wP0moyeENlJRDx2DAeezvqLRyorXu
         u60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=DAuyBheZuRHxgbT+xkex8fMKl7Fnn2ftU3GmNZB6VYk=;
        b=1PGwQH8iBW9qUeyeMQTXtog6VwGnNRUKITSdGe23kDpKaNQJTvIOZsA5upigsOmTTU
         qDumzC6dnsqVOUR8hjUld/TG+EP4ErDLBnCCgMjauR1166ONw+421derFVAP8nRciG9w
         aAoUsFpcvt6s5WsYEv2XyHv/ZXZI4NsbjHo9aA5XtDL7z8m98UCr9JRMrZwKephIea+f
         WBlE35IMpQd0NWbN3CFXiHhoqDSnUSLRnGXCoQdyCinSnjondYaNxR39X39PQfvuNGv/
         cmdPh32xYlZD7NukAalMbSIyU/jxgtZ1wLLr0nYnMKIv6SwaEDCO6Bae2lsPUO+OLxpv
         zVUQ==
X-Gm-Message-State: ACgBeo1B23MNT/ZQ8KpLBUlYPnnrTn4375vtXBfBKbMlzgRZZPnVZacF
        8+unbb4QbG+VCTiHMdyOmGU=
X-Google-Smtp-Source: AA6agR40G2NYqdKNqMXyx12fu76qrw69TSkbFo5K7EMoOdvuhI6sj1gt7diDFk9itbK3eRmKhG388Q==
X-Received: by 2002:a63:8bc7:0:b0:41c:d1e1:7fb2 with SMTP id j190-20020a638bc7000000b0041cd1e17fb2mr20122606pge.281.1660066293174;
        Tue, 09 Aug 2022 10:31:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x130-20020a628688000000b0052dd9dbe291sm164345pfd.105.2022.08.09.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:31:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Aug 2022 07:31:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] enable memcg accounting for kernfs objects
Message-ID: <YvKZ8zYJFhhFvRxO@slm.duckdns.org>
References: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0414cab3-32d6-c60a-d3c8-96fc72064ba0@openvz.org>
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

(cc'ing Johannes)

Hello,

On Sun, Jul 31, 2022 at 06:37:15PM +0300, Vasily Averin wrote:
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.

So, I don't have anything against accounting kernfs objects in general but,
for cgroups, because cgroups are what determines what gets charged where,
I'm not quite sure whether following the usual "charge it to the allocating
task's cgroup" is the best way to go about it. I wonder whether it'd be
better to attach it to the new cgroup's nearest ancestor with memcg enabled.
Johannes, Michal, what do you guys think?

Thanks.

-- 
tejun
