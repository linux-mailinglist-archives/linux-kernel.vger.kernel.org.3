Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D306525164
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356018AbiELPhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbiELPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:37:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13D25C28B;
        Thu, 12 May 2022 08:37:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D9FA846;
        Thu, 12 May 2022 15:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D9FA846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652369856; bh=i+7cj4/G5qFWaDsvpxUy3aGMfQgj+VzEITIE6+j6oWY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kS8v5mVvFQHYeJDxgphwKw1jGH8dPoJg69tycBYgJ/pZMEY2FCbh/DTevk0G3wB2l
         Wtx4eeXhtqc1Oc840JxIDI5fguU70OU2MIOWbHxfCnGgTX/pUQ+aHlOB9jKbk5Rpsc
         xvhYURaUFoPYnRGN28DayN7ZpDWev6jVWEbAOR0EWSwg9Sgi7Q8SQpK2Y9HV00zkDs
         xGgrrw8/604vRlwh5ftEfL02pO/H1At0RQ8MJ3P+p2YD4hmryjvEL2539GovNDKpDP
         Z/O1fTcUC4/IhwGwVTHkmiv1TYUNZfvj0RGVm5+RI/Ixbr22WDwd/cWp6giXxAcDJ7
         1LrV6yqV4nwsg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v1 1/2] docs: move Linux logo into a new `images` folder
In-Reply-To: <20220510172530.29704-1-ojeda@kernel.org>
References: <20220510172530.29704-1-ojeda@kernel.org>
Date:   Thu, 12 May 2022 09:37:35 -0600
Message-ID: <87r14y4v9c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:

> Having assets in the top-level `Documentation` directory can make
> it harder to find the documents one needs, especially if we want
> to add more of them later on.
>
> Instead, create a new `images` folder inside it that is used
> to hold assets such as logos.
>
> Link: https://lore.kernel.org/lkml/8735hicoy7.fsf@meer.lwn.net/
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/{ => images}/COPYING-logo |   0
>  Documentation/{ => images}/logo.gif     | Bin
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/{ => images}/COPYING-logo (100%)
>  rename Documentation/{ => images}/logo.gif (100%)
>
> diff --git a/Documentation/COPYING-logo b/Documentation/images/COPYING-logo
> similarity index 100%
> rename from Documentation/COPYING-logo
> rename to Documentation/images/COPYING-logo
> diff --git a/Documentation/logo.gif b/Documentation/images/logo.gif
> similarity index 100%
> rename from Documentation/logo.gif
> rename to Documentation/images/logo.gif

This will break scripts/spdxcheck-test.sh - which somebody might
actually try to run one of these years.  So this patch really needs to
update that script to follow the move.

As far as I can tell, that's the only reference to logo.gif in the
entire tree.  It makes me wonder if we need it at all.  Digging through
the history suggests it was added in 2.1.15, but never really used for
anything.  It's only role would appear to be to serve as testing
material for the SPDX checker..:)

Thanks,

jon
