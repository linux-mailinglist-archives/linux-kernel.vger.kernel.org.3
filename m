Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8B59D58B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiHWIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346182AbiHWIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:36:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF891760FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:17:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l19so9645874ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dsUb3JwxKrpGEtwaM0xXt8nmsJshMrpryqMcaqMUxgw=;
        b=HVGb4rTve0Fn0XJnLuQnerqws3m5Uhfk3U25WThW/5EA2sh13xN47kcg6Kb0M0oDOd
         9uV1jUMBYfese4AM4viw6rZp9A7dtiq+5cYAc8rkGxkcuECk2C04awFUvG7TcWNfpl5H
         vYBBxcx8pcmw7RkgdzctvGuCdMGJeyTT23ZCaJ9m/iA4/MLiL8J4ohtX7iQByuNsULCg
         GlTdQYgiScAhgclk132QhLpCCJJnI+2bWqFQSjPTVBQgIS9UxJ+6JEMIQdLw/yrlUMt5
         LfRW+2FL9L/3LbTujvlPjCxbQ7t6VvdDZ5YDayNVICak4OiAHEewMAL7QAkAlcINZiw2
         /h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dsUb3JwxKrpGEtwaM0xXt8nmsJshMrpryqMcaqMUxgw=;
        b=uIahdYlrnIB/Fp2Vb61nWf9qihr3jpisKCGEalFZFFziS90oSsdb10Zpv2bTqlae+b
         L75kYsZLc5pS3cPFttXNGoGhi0IZITHl0nLyyrJ5jdoUPrjs/WQUKIBmZQBzQbHCtURr
         zDopL+5H9XQvKz8HdWtW6f1g3HNCrqR+AuVNhI+Mg3gmIsoj0zotBUVbDOWH4Ei/5Kg4
         HLqNrPERRtmAtOYy7Z+ML8h9Uy8TUH8wiUAYcTXQSjteiCi9YgInQNqQHQ+DYyFkSkN/
         uYlyjg+776tEs3KY7/1rj/oweWPsGvx/8ogNM5VcOXx74BDx08dkX4qz0bQbVDmDGVkx
         uSzg==
X-Gm-Message-State: ACgBeo0uuOvlaDGHt4yLwdk+++E9/4gtNDgHFqlKgcBZXS4yGwaMuQlJ
        RyzUP/8oOjlSDbCq6vp3FRO+0g==
X-Google-Smtp-Source: AA6agR79ZeQOdFEdVULVnemohBGH9LmWT7OumoXb1UHf8vB7YnOku6VNElwDzXeWV5YXEmxTiLfvhw==
X-Received: by 2002:a2e:a7d6:0:b0:261:caab:a952 with SMTP id x22-20020a2ea7d6000000b00261caaba952mr2985133ljp.425.1661242622922;
        Tue, 23 Aug 2022 01:17:02 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512314a00b00492e36cb723sm1057328lfi.179.2022.08.23.01.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:17:02 -0700 (PDT)
Message-ID: <fba5dccb-2549-30fe-5d65-8668aebd3811@openvz.org>
Date:   Tue, 23 Aug 2022 11:17:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] memcg: adjust memcg used to charge for new
 simple_xattrs objects
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, tj@kernel.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <f58bd7c8-0053-316c-db06-ced13ffcf867@openvz.org>
 <20220818122743.GB19175@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220818122743.GB19175@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 15:27, Michal Koutný wrote:
> On Thu, Aug 18, 2022 at 12:10:45PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>> sys_set[f]xattr uses simple_xattr infrastructure to create a new
>> extended attribute for in-memory file systems like sysfs and tmpfs.
>> Number and size of allocated objects are controlled by user space,
>> they are always living in memory and its lifetime is indefinitely long.
>> Therefore this memory should be properly accounted.
>>
>> By default new memory is accounted to memcg of creator process.
> 
> despite objects aren't bound to this process lifetime.
> 
> (I think this was the main argument for this approach and should be in
> the commit message then.)

Thank you for the remark, I'll update patch description in the next version

>> As a result, neighboring xattrs of the same inode can be charged to
>> different memcgs. This looks unexpected and makes hard the
>> investigation of the memcg accounting issues.
>>
>> This patch adjust memcg used for such allocations. For kernfs
>> it gives memcg from kernfs node, for shmem -- from shmem_info.
>> This allows to cahrge all inode-sepcific objects to the same
>> memory cgroup.
> 
> IIUC you intend to inherit association from shmem_inode_info (i.e.
> whoever created the inode). shmem_inode_cachep has SLAB_ACCOUNT, so it's valid.

Yes, you are right, I'll clarify this in next patch version.

Thank you,
	Vasily Averin
