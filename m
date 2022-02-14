Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2C4B45A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiBNJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiBNJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:27:43 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE260A8C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:27:36 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JxzQZ21l3z1r5Sf;
        Mon, 14 Feb 2022 10:27:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JxzQZ1HbSz1qqkD;
        Mon, 14 Feb 2022 10:27:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aNRyA1YptquK; Mon, 14 Feb 2022 10:27:33 +0100 (CET)
X-Auth-Info: R0XjbQXb2+5gGB2bT5bpBZHuDOLFj/16nNUnBauej6c6LUkDgKfgDP03UTXie8CI
Received: from igel.home (ppp-46-244-178-131.dynamic.mnet-online.de [46.244.178.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 14 Feb 2022 10:27:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id D80442C39FF; Mon, 14 Feb 2022 10:27:32 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Helge Deller' <deller@gmx.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
References: <YgmB01p+p45Cihhg@p100>
        <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
X-Yow:  YOU PICKED KARL MALDEN'S NOSE!!
Date:   Mon, 14 Feb 2022 10:27:32 +0100
In-Reply-To: <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com> (David
        Laight's message of "Mon, 14 Feb 2022 09:12:01 +0000")
Message-ID: <8735klx0fv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14 2022, David Laight wrote:

> The 'bug' is caused by put_user() trying to do:
> 	__typeof__(ptr) __ptr = ptr;
> where __typeof__ is returning char[n] not char *.
>
> I've tried a few things but can't get __typeof__ to
> generate a suitable type for both a simple type and array.

Does it work to use __typeof__(&*(ptr))?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
