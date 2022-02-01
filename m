Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D717A4A6873
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiBAXUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbiBAXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:20:46 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482ACC061401;
        Tue,  1 Feb 2022 15:20:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EEA366121;
        Tue,  1 Feb 2022 23:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EEA366121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643757646; bh=NgAdi5heU5kZAdBEe4lZxyjTcHSSB4h90VkQt9pBRAk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mb7uLlGroOUqSOG4F0TOWsvNmH/Nd/UeZ3MIWvZLWL/9RGeIEdto5gPLkCoigX++e
         ULIcoQA4qI1C9v70r8l8NJcXl7b7PuBIA5lM93KU/46rlxuCfj76S07+vRirN91XAJ
         P3n0DNjlrS+FYek3Oc/N/US6F3lHMD08NF+PYTT33Q2gq6mEBDt7XB876LNDIqjHai
         E5m3flOye8V1QR+FpKRGcdiWv52NSBIpGY2zB2P25SdV2GKoUA0OyK4gToTSCYa6CL
         Na6pDcvBbalmbu2wHT12iz60OZ+5clcBP2G+4V/0y8RyoceoClnKzpVmJ9RYdDHqSQ
         3OgxXq6Ck8f5w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v4 2/3] docs: regressions*rst: rules of thumb for
 handling regressions
In-Reply-To: <e655527632dc4324cc7584cb3a73880d9c733df5.1643710947.git.linux@leemhuis.info>
References: <cover.1643710947.git.linux@leemhuis.info>
 <e655527632dc4324cc7584cb3a73880d9c733df5.1643710947.git.linux@leemhuis.info>
Date:   Tue, 01 Feb 2022 16:21:19 -0700
Message-ID: <87fsp25g28.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

One thing that caught my eye this time around...

> + * Address regressions in stable, longterm, or proper mainline releases with
> +   more urgency than regressions in mainline pre-releases. That changes after
> +   the release of the fifth pre-release, aka "-rc5": mainline then becomes as
> +   important, to ensure all the improvements and fixes are ideally tested
> +   together for at least one week before Linus releases a new mainline version.

Is that really what we want to suggest?  I ask because (1) fixes for
stable releases need to show up in mainline first anyway, and (2) Greg
has often stated that the stable releases shouldn't be something that
most maintainers need to worry about.  So if the bug is in mainline,
that has to get fixed first, and if it's something special to a stable
release, well, then the stable folks should fix it :)

> + * Fix regressions within two or three days, if they are critical for some
> +   reason -- for example, if the issue is likely to affect many users of the
> +   kernel series in question on all or certain architectures. Note, this
> +   includes mainline, as issues like compile errors otherwise might prevent many
> +   testers or continuous integration systems from testing the series.
> +
> + * Aim to merge regression fixes into mainline within one week after the culprit
> +   was identified, if the regression was introduced in a stable/longterm release
> +   or the development cycle for the latest mainline release (say v5.14). If
> +   possible, try to address the issue even quicker, if the previous stable
> +   series (v5.13.y) will be abandoned soon or already was stamped "End-of-Life"
> +   (EOL) -- this usually happens about three to four weeks after a new mainline
> +   release.

How much do we really think developers should worry about nearly-dead
stable kernels?  We're about to tell users they shouldn't be running the
kernel anyway...

Thanks,

jon
