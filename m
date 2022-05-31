Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBF5390F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbiEaMlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiEaMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:41:49 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CED31056F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:41:48 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id ABA8B20012B9;
        Tue, 31 May 2022 21:41:47 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24VCfkaR042459
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 21:41:47 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24VCfk49221105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 21:41:46 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24VCfj6Q221104;
        Tue, 31 May 2022 21:41:45 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [PATCH v3 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220526134119.242182-1-javierm@redhat.com>
        <20220526134119.242182-3-javierm@redhat.com>
        <87ilpmows4.fsf@mail.parknet.co.jp>
        <0ca7d264-2522-c820-d26e-19b6685d5016@redhat.com>
Date:   Tue, 31 May 2022 21:41:45 +0900
In-Reply-To: <0ca7d264-2522-c820-d26e-19b6685d5016@redhat.com> (Javier
        Martinez Canillas's message of "Tue, 31 May 2022 14:15:02 +0200")
Message-ID: <87czftq3g6.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

>> Main purpose of me is to consolidate helpers with vfat_rename(), and
>> tweak coding style to use existent fat codes.
>>
>
> Indeed. What do you think of the following plan for v4 ?
>
> 1) Keep patch "fat: add a vfat_rename2() and make existing .rename callback a helper"
>    as the first patch of the series.
> 2) Add a patch #2 with your authorship that adds the helper and use them in the
>    vfat_rename() function.
> 3) Make this patch "fat: add renameat2 RENAME_EXCHANGE flag support" to be patch #3
>    and use the helpers introduced in patch #2.
> 4) Make patch #4 to not only add a test for RENAME_EXCHANGE but also for renameat()
>    and renameat2(..., RENAME_NOREPLACE). That way it will also cover your changes in
>    patch #2.

I don't care much about it because whole is not big (in short, I'm ok
with even one patch), so the point is the patches should be able to
bisect easily if separated.

>>> +	/* update inode version and timestamps */
>>> +	inode_inc_iversion(old_inode);
>>> +	inode_inc_iversion(new_inode);
>> 
>> Why do we need to update iversion of those inodes? I couldn't get intent
>> of this.
>>
>
> To be honest, I wasn't sure about this either but I saw that the implementation
> of RENAME_EXCHANGE in other filesystems did. For example btrfs_rename_exchange().

Ok. If I'm not overlooking, it looks like only btrfs. Please remove
those inode_inc_iversion() for {new,old}_inode.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
