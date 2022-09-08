Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BD5B1517
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiIHGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIHGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:49:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C4D476E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:49:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t70so9998386pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=iK+jXg5NmojrjrXTvcBk5UVdDJeNZinaYGMOcpZC3/8=;
        b=oHAp0tnWXJ81IHC5ZFwfbAdD8DIhC2yqLrgizCbBZ8c0lemiyoBBb+dBqgDIZWdQ1J
         Hsrmo7+GFUfedzBzOj0mHNIYce/b5hC7D+sm5tMFOdLhsl/0epi4YGsBTKxrMIwAWNsf
         wZhAQCBbqslAZMyjOvDAT+X/XUchHIriMYhKeAMcpgUvjuQn8soULx9pja/b5BK3bIf/
         3zzlMYNq6SVI4uJfAGsb0DJBCDPUNT6AjCvCMFjk5iF3pwGyGRXALo5yTUVd6a41TJSN
         6tQqnvxSzQM5IvADL1o4NlowFpS9TWyIVONwic8eV9FSm8tiqs5WBkVCGz1rzyvCUmAM
         TYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=iK+jXg5NmojrjrXTvcBk5UVdDJeNZinaYGMOcpZC3/8=;
        b=i05SpougXRpXtng5gGef5c+008L+xv+hk6dwuxg2M+JKWsa/ED4jm9XYKlcy/jpCy+
         SS6duD6aGf4Dzuo5rRie1BYAxKTuDUVMy2nMByJ3fVVJN5cCbxbiJu/35oNXK2imLmSp
         udbSASW2x+IovmiDlh9ABH3TfF5NZcZYy1cyT3lMzRKHvvCykk3uLkUbgG1WK7QhosWl
         /BJeXypzCz4jRDdVmVEQinz6vXtbsVbxnKa5akedRzXY32EHG1k/NBNMeFS6o/Dap5tT
         iRnrObEX2HHwpiPo1Iwc/PFmT4VeNL2nnUl0FfR/lxVw89dz70ihQuG/Ic4Z7JrF3uZg
         wZnQ==
X-Gm-Message-State: ACgBeo21gb10Aq0szU7r2ZhNDVF/14O9xsNyoVbigLlBXgicgUEXiBMH
        1gar15AdesFKTzU7dHGodhF9OQ==
X-Google-Smtp-Source: AA6agR5g0ssNDJNYCDYXHAlKO7pnWMd0buFZ5w8+Wi+bRA0ye/AK1s9OcGtBXH3K7j4TLTJvluQxtA==
X-Received: by 2002:a05:6a00:1590:b0:53a:d2fd:9b0f with SMTP id u16-20020a056a00159000b0053ad2fd9b0fmr7867955pfk.80.1662619755862;
        Wed, 07 Sep 2022 23:49:15 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:427:1cff:3226:873b:1ccd? ([2404:9dc0:cd01::21])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b0016f1ef2cd44sm12146072plq.154.2022.09.07.23.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 23:49:15 -0700 (PDT)
Message-ID: <79eccbcc-b18e-80c4-5c8f-89213f047db8@bytedance.com>
Date:   Thu, 8 Sep 2022 14:49:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 0/5] Introduce erofs shared domain
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[E2E Container Demo for Quick Test]
===================================
[Issue]
     https://github.com/containerd/nydus-snapshotter/issues/161

[Pull Request]
     https://github.com/containerd/nydus-snapshotter/pull/162

在 2022/9/2 18:53, Jia Zhu 写道:
> Changes since V1:
> 0. Only initialize one pseudo fs to manage anonymous inodes(cookies).
> 1. Remove ctx's 'ref' field and replace it with inode's i_count.
> 2. Add lock in erofs_fscache_unregister_cookie() to avoid race condition
>     between cookie's get/put/search.
> 3. Remove useless blank lines.
> 
> [Kernel Patchset]
> ===============
> Git tree:
> 	https://github.com/userzj/linux.git zhujia/shared-domain-v2
> Git web:
> 	https://github.com/userzj/linux/tree/zhujia/shared-domain-v2
> 
> [Background]
> ============
> In ondemand read mode, we use individual volume to present an erofs
> mountpoint, cookies to present bootstrap and data blobs.
> 
> In which case, since cookies can't be shared between fscache volumes,
> even if the data blobs between different mountpoints are exactly same,
> they can't be shared.
> 
> [Introduction]
> ==============
> Here we introduce erofs shared domain to resolve above mentioned case.
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.
> 
> [Usage]
> Users could specify 'domain_id' mount option to create or join into a
> domain which reuses the same cookies(blobs).
> 
> [Design]
> ========
> 1. Use pseudo mnt to manage domain's lifecycle.
> 2. Use a linked list to maintain & traverse domains.
> 3. Use pseudo sb to create anonymous inode for recording cookie's info
>     and manage cookies lifecycle.
> 
> [Flow Path]
> ===========
> 1. User specify a new 'domain_id' in mount option.
>     1.1 Traverse domain list, compare domain_id with existing domain.[Miss]
>     1.2 Create a new domain(volume), add it to domain list.
>     1.3 Traverse pseudo sb's inode list, compare cookie name with
>         existing cookies.[Miss]
>     1.4 Alloc new anonymous inodes and cookies.
> 
> 2. User specify an existing 'domain_id' in mount option and the data
>     blob is existed in domain.
>     2.1 Traverse domain list, compare domain_id with existing domain.[Hit]
>     2.2 Reuse the domain and increase its refcnt.
>     2.3 Traverse pseudo sb's inode list, compare cookie name with
>     	   existing cookies.[Hit]
>     2.4 Reuse the cookie and increase its refcnt.
> [Test]
> ======
> Git web:
> 	https://github.com/userzj/demand-read-cachefilesd/tree/shared-domain
> More test cases will be added to:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests-fscache
> 
> RFC: https://lore.kernel.org/all/YxAlO%2FDHDrIAafR2@B-P7TQMD6M-0146.local/
> V1: https://lore.kernel.org/all/20220902034748.60868-1-zhujia.zj@bytedance.com/
> 
> 
> Jia Zhu (5):
>    erofs: add 'domain_id' mount option for on-demand read sementics
>    erofs: introduce fscache-based domain
>    erofs: add 'domain_id' prefix when register sysfs
>    erofs: remove duplicated unregister_cookie
>    erofs: support fscache based shared domain
> 
>   fs/erofs/fscache.c  | 168 +++++++++++++++++++++++++++++++++++++++++++-
>   fs/erofs/internal.h |  31 +++++++-
>   fs/erofs/super.c    |  94 +++++++++++++++++++------
>   fs/erofs/sysfs.c    |  11 ++-
>   4 files changed, 278 insertions(+), 26 deletions(-)
> 
