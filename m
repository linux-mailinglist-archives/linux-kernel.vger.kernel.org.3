Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A059188C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 06:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiHMEQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 00:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMEQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 00:16:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFBBE02A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 21:16:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a9so3640640lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 21:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mw5sHT8zBEaCmnT874wuWslLzi6P/iOgebdtI/CFJ4M=;
        b=vNu4j0puet/jgla5Fq1R08f3/tQ33yq0lLRHa2vIyrJaBPoUlVDYOdhKuH0ofEljGF
         MqxvszWfIw7JpRNreDA5644oJs/bTcnp/V8lckyjxpxtLJY2To4LxAT+GTFcEHB+L4ok
         iKSPSYLEPozDummX1/k5RTcDoEbsmpKEpxNeFZ7BpWU30N2yAzRT1wuXQ+moH1Ag1boE
         3+3MGWzqs/Z6SB1pKp3SHRE4zwKPL/0I0nvRL4+RKCqxlhQECEiXyaND74kqLCNSIAr2
         y5QoGJlHQtHtw7IVGBBSi0yNaqN6tqDDV53QLxLU3jKidWe3wPGtBOZ8AufwiQ/klPLs
         Lbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mw5sHT8zBEaCmnT874wuWslLzi6P/iOgebdtI/CFJ4M=;
        b=IhiS5YPom9YOfecZ3P9abuwFpYHTwCzJ1CS/y3EITDBu+y/tr8byR+YBNpr5nmuz8G
         ek/mPWelwfa1+8dDCA5/UhBR6P74eVp06KsYkAd7BW2D7TEdDcRprZ+GyMeY3ffTTkvU
         ZAxFpTJSwbG6TkgeWrXor9HoLFeuOu1AzRdtCFUZovhdPZtiLSP78VfHgJo3KS/Sq8Mt
         Tr6Mo8n/GZfvPL/Y6FVRcPg1//YUmMovHra3g9DQjCeZC72NTdeeG4VlSUqOe69Fcf8v
         M6mffVKrUnI7ZVMu9sFuzwc2xVpo93oCdWK0TKeLxcpkFTNOGKShsrSnpz5rIv1yndrg
         qJxg==
X-Gm-Message-State: ACgBeo16PFCXLllud4svRGXS1H2Sd4EZYOGsbSLjoLBAoT399Uz3xxWy
        lvairAz6BNb+E5p9qaeEeqWCAA==
X-Google-Smtp-Source: AA6agR67cD5SvwB5TNJI0X/mXex2BNpC+OA27bHaflThgdz6K2EbG6PwckTQjR57Mt0gJ3+9XFL+ig==
X-Received: by 2002:a05:6512:e91:b0:48a:e71a:5193 with SMTP id bi17-20020a0565120e9100b0048ae71a5193mr2455033lfb.511.1660364208022;
        Fri, 12 Aug 2022 21:16:48 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id k22-20020a2e8896000000b0025e5cd1620fsm602476lji.57.2022.08.12.21.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 21:16:47 -0700 (PDT)
Message-ID: <47112ee6-9686-a272-183e-ec2e6cdeff2e@openvz.org>
Date:   Sat, 13 Aug 2022 07:16:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] kernfs: enable per-inode limits for all xattr types
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org
References: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
 <8ace5255-ce23-0a05-2d50-1455dd68acb6@openvz.org>
 <20220812102052.adiqtlsxx273t7wk@wittgenstein>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220812102052.adiqtlsxx273t7wk@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 13:20, Christian Brauner wrote:
> So iiuc, for tmpfs this is effectively a per-inode limit of 128 xattrs
> and 128 user xattrs; nr_inodes * 256. I honestly have no idea if there
> are legimitate use-cases to want more. But there's at least a remote
> chance that this might break someone.
> 
> Apart from
> 
>> Currently it's possible to create a huge number of xattr per inode,
> 
> what exactly is this limit protecting against? In other words, the
> commit message misses the motivation for the patch.

This should prevent softlockup and hung_task_panic caused by slow search
in xattrs->list in simple_xattr_set() and _get()

Adding new xattr checks all present entries in the list,
so execution time linearly depends on the number of such entries.

To avoid this problem I decided to limit somehow the number of entries in the list.
As an alternative Tejun advises to switch this list to something like rb-tree,
now I think he is right.

> I'd also prefer to see a summary of what filesystems are affected by
> this change. Afaict, the patchset doesn't change anything for kernfs
> users such as cgroup{1,2} so it should only be tmpfs and potential
> future users of the simple_xattr_* api.

This affect all file systems used  simple_xattr_* API: sysfs and tmpfs.

Now I'll try to follow Tejun's advice and switch the xatrrs list to rb-tree.
Unfortunately, I doubt that I will have enough time to finish before the merge
window closes.

Thank you,
	Vasily Averin
