Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D08530149
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiEVGjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbiEVGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:38:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85C41986
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:38:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b5so3497402plx.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2Pe0MYHq/Yx78fCTpUgbwdSX/KtiLZzQfFUiCB9rR4=;
        b=2yX+PxR79RziW6XLaAynJWecE1Q0bheyhr3naloLu2PlOc+IfkrnlU/rZn33HmEjpv
         EdTY9j89e2UdiePS9za4CH5f9jEsK5SAldon3f6WO9nGwbMyVLhbBU/iZWDFkAtg+lSI
         WHUsv68nRcZvXAKJ5YbSlk8+0B5k9z3ARTy6Bs1SWP5L9xVAD4EbVnDMCwQLAL0cOXNm
         Z13qKhUnxfchrKP3qprM2GOZZnFc6kJ7UycB/bId4/bo8iOrIa9sorUPGtza2P+b+j/h
         mNalOAMptkd5Ci5/dhDH++4UW7brno4SVp2T2RWIdgCG2sEMp9mndu4EVvIMtffRkEvZ
         KdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2Pe0MYHq/Yx78fCTpUgbwdSX/KtiLZzQfFUiCB9rR4=;
        b=o8sZZd26Gp7qdviCztVQGEX2xNqH05fq2HV6WshPm4NIhPogsAeHeaAIK3XkRex2V5
         XouN+k5NlZ7XuCWtVJuPCXU2+Hw4cf1XPnwfSeu88fMEpTH1YtogTtl1TgSXqm6OB3Cd
         fMVWqRZkHDACLatFE5tuycYkNIKa3FmmNb6LCpZ+AKZ+Gk+2OzBxpjE8KWeGkMb2VPrN
         wz0HhrM5AZlBMQVpcYPk8qtnbGKJIUC9O7S30IFKovSNquXOrkaqJHGMVor6tKhidGFr
         snn1vm3TZJzJwL64R9kSCD9wkxhg1fzwnebUd0PDBt71HqhhlLAfhrGE6r3d83qGx0O8
         hNNQ==
X-Gm-Message-State: AOAM533LOsdOhH0yy+opxbHdo2tcmHUh4ZMK8qwEJlf7lzcIvBJLzJKE
        YG/W146EQCZWLqMEjYomRymFOA==
X-Google-Smtp-Source: ABdhPJywflv0j9NZ/ircUsYHj7JAaBn2Uy5Z2shosb9G2vUS2CksYAtESm7vYVdrN/w6La8I/F6Zzg==
X-Received: by 2002:a17:902:8214:b0:162:188b:e326 with SMTP id x20-20020a170902821400b00162188be326mr2290099pln.129.1653201537317;
        Sat, 21 May 2022 23:38:57 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i23-20020aa78b57000000b005187ed76a78sm2581240pfd.174.2022.05.21.23.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:38:56 -0700 (PDT)
Date:   Sun, 22 May 2022 14:38:54 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 4/9] memcg: enable accounting for struct
 simple_xattr
Message-ID: <YonafoqQkw22i41B@FVFYT0MHHV2J.usts.net>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <b69d2389-3a1f-d0bb-6a14-83473fe2d815@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b69d2389-3a1f-d0bb-6a14-83473fe2d815@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 07:38:11PM +0300, Vasily Averin wrote:
> kernfs nodes are quite small kernel objects, however there are few
> scenarios where it consumes significant piece of all allocated memory:
> 
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.
> 
> Usually new kernfs node creates few other objects:
> 
> Allocs  Alloc   Allocation
> number  size
> --------------------------------------------
> 1   +  128      (__kernfs_new_node+0x4d)        kernfs node
> 1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
> 1   +   96      (simple_xattr_alloc+0x28)       simple_xattr
> 1       32      (simple_xattr_set+0x59)
> 1       8       (__kernfs_new_node+0x30)
> 
> '+' -- to be accounted
> 
> This patch enables accounting for struct simple_xattr. Size of this
> structure depends on userspace and can grow over 4Kb.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
