Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217464C3582
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiBXTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiBXTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:15:46 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C8822BEA5;
        Thu, 24 Feb 2022 11:15:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 62F7E5BF;
        Thu, 24 Feb 2022 19:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 62F7E5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645730116; bh=iuR6bTXwXLNVJwbHRO9fEL+9jzf5zsp9TeQMDm6axF0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g+eH+UKhkh6PimfB7Q+3OkA4+g9EqQL4aFQZWTuAZ7j3zv5u43euu/d4YVDM29c7x
         U19iSPG/gX3ziopWhTaqJfA6x7IfAQiBnHDFx5j8jR2c1Soul8ZSK7O0llFWC6g2LX
         iIMoTrNL2XMHrTS2wSy5+Xa2JnR+Xh3Qg3jzcbL0XYUQfsrXzrmuaAIHc5Ad0QpbRa
         1p452N0YpXzDsofx3+gE+OYPDOAJXcFbb1So5KCk77UaEu5QkMi/k/z8T+atPNvv+N
         fY6jdtV+sUc+/19G0RMFh/aF48OIlizxiYN2ST6IY3y0Ni0t/rpRDqb6MkzhUar7n4
         aAdNbbP52Ksng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: scripts/kernel-doc: Detect absence of FILE arg
In-Reply-To: <7b136049-a3ba-0eb5-8717-364d773ff914@gmail.com>
References: <7b136049-a3ba-0eb5-8717-364d773ff914@gmail.com>
Date:   Thu, 24 Feb 2022 12:15:15 -0700
Message-ID: <87ley0krek.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Currently, when there is no FILE argument following a switch such
> as -man, -rst, or -none, kernel-doc exits with a warning from perl
> (long msg folded):
>
>     Use of uninitialized value $ARGV[0] in pattern match (m//)
>     at ./scripts/kernel-doc line 438.
>
> , which is unhelpful.
>
> Improve the behavior by adding a check at the bottom of parsing
> loop.
> If the argument is absent, display help text and exit with
> the code of 1 (via usage()).

As might be expected, this applied poorly after the pod patches went in.
I went ahead and resolved the conflict, substituting an appropriate
pod2usage() call.

Thanks,

jon
