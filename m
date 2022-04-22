Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37950B6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447302AbiDVMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447139AbiDVMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:09:39 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AF8A53B76
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:06:46 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5466115F93A;
        Fri, 22 Apr 2022 21:06:44 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23MC6hP3060896
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 21:06:44 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 23MC6goo151196
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 21:06:43 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 23MC6gPe151195;
        Fri, 22 Apr 2022 21:06:42 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-kernel@vger.kernel.org, kernel@cccheng.net
Subject: Re: [PATCH v3 3/3] fat: report creation time in statx
References: <20220415094518.380543-1-cccheng@synology.com>
        <20220415094518.380543-3-cccheng@synology.com>
        <87h76utrj2.fsf@mail.parknet.co.jp>
        <CAHuHWt=xYOBhRp_KJrSF5-xDBW+x_O4gnQSsX2M5u2D8zSXwTg@mail.gmail.com>
Date:   Fri, 22 Apr 2022 21:06:42 +0900
In-Reply-To: <CAHuHWt=xYOBhRp_KJrSF5-xDBW+x_O4gnQSsX2M5u2D8zSXwTg@mail.gmail.com>
        (Chung-Chiang Cheng's message of "Fri, 22 Apr 2022 16:20:06 +0800")
Message-ID: <87o80tpbjh.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chung-Chiang Cheng <shepjeng@gmail.com> writes:

>
> I also have a question. If msdos doesn't support create-time, why does the
> original fat_truncate_time() truncate it to a 2-sec granularity?
>
> if (flags & S_CTIME) {
>         if (sbi->options.isvfat)
>                 inode->i_ctime = fat_timespec64_trunc_10ms(*now);
>         else
>                 inode->i_ctime = fat_timespec64_trunc_2secs(*now);
> }
>
> This logic was introduced in 6bb885ecd746 (fat: add functions to update
> and truncate timestamps appropriately"), and seems not for change-time.
> Should I remove it?

Hm, not sure.

However, ctime/atime is not stored into backing storage in
__fat_write_inode() and loaded if !isvfat (if I'm not missing
something).  So I think we don't need it for creation time.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
