Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59548531AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiEWRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiEWRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:06:01 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42869C12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:05:57 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 51A4A20012BA;
        Tue, 24 May 2022 02:05:57 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24NH5uoE135043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 02:05:57 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24NH5tK8397956
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 02:05:56 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24NH5rIE397954;
        Tue, 24 May 2022 02:05:53 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Colin Walters <walters@verbum.org>, linux-kernel@vger.kernel.org,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220519092343.2776414-1-javierm@redhat.com>
        <20220519092343.2776414-3-javierm@redhat.com>
        <7963aad6-203c-4da4-ba9f-cf716d350121@www.fastmail.com>
        <6a6ca822-ac6a-8484-0bc8-aaa1dce3d8ef@redhat.com>
Date:   Tue, 24 May 2022 02:05:53 +0900
In-Reply-To: <6a6ca822-ac6a-8484-0bc8-aaa1dce3d8ef@redhat.com> (Javier
        Martinez Canillas's message of "Mon, 23 May 2022 17:34:17 +0200")
Message-ID: <87a6b8tc0e.fsf@mail.parknet.co.jp>
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

>> So assuming we have this, I guess the flow could be:
>> 
>> 1. rename_exchange(old, new)
>> 2. syncfs()
>>
>
> Correct. In fact, Alex pointed me out that I should do sync in the test too
> before checking that the rename succeeded. I was mostly interested that the
> logic worked even if only the in-memory representation or page cache was
> used. But I've added a `sudo sync -f "${MNT_PATH}"` for the next iteration.
>  
>> ?  But that's assuming that the implementation of this doesn't e.g. have any "holes" where in theory we could flush an intermediate state.
>> 
>
> Ogawa said that didn't fully review it yet but gave useful feedback that I
> will also address in the next version. As said, is my first contribution to
> a filesystem driver so it would be good if people with more experience can
> let me know if there are holes in the implementation.

I'm not reading emails about ostree and stuff, so I may not understand
the issue though. If you are expecting the atomics on disk (not
in-core), rename exchange can't provide atomics on vfat without non
standard extension like adding journal or such. And even any syncfs(2)
can't prevent rename corruption, syncfs(2) can just only minimize the
race window.

If power failure happened on rename exchange, the file may lost in worst
case. (If had journal, file can recover to before or after rename
exchange while journal replay, but as you know vfat can't)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
