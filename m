Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA64CA5E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbiCBNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiCBNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:25:15 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 05:24:31 PST
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDE2DE7;
        Wed,  2 Mar 2022 05:24:31 -0800 (PST)
Received: from brak.codesynthesis.com (197-255-152-207.static.adept.co.za [197.255.152.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id F29BD60649;
        Wed,  2 Mar 2022 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1646227019;
        bh=UOjLTGh9VnGwEHppHHwqZk2iztOOX8qewpK+K/jJ+xM=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=r3GSkmhSztpDSU+zg1vAnDlAiXumarbdIXVOiP5/7/V4F2sjxgkjGG395Ntm3HrRw
         SYajSAE9iaDS+jTT7SgbYzZP4vStXBwRByGS2DkvG+qQUxUUBB/onq46HMk21EHZG7
         ZYFRo489zgedcYlEqJ1ZhCd8Xh/NJydSoendAwtZQaco4O7enTsWLb7SxNaMR0TUoz
         Dd8MX0LKes/JGq8mHOkco22llqMqqyeTdxerW25DUvzRqAH3TjD8h3IscylLLSKCak
         dY+ieKahwepavwb38OVXz6yI8lee++xsTWtOVvpQ8MvHXH8n9YzL+g6lF6A/hlEDEH
         sqg0r9AWB5dYw==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 68ECF1A802AE; Wed,  2 Mar 2022 15:16:53 +0200 (SAST)
Date:   Wed, 2 Mar 2022 15:16:53 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
Message-ID: <boris.20220302145825@codesynthesis.com>
References: <20220226123755.85213-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226123755.85213-1-masahiroy@kernel.org>
Organization: Code Synthesis
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> With this commit, Kconfig will output disable options in a more natural
> form, "CONFIG_FOO=n".

While I agree with the overall direction, I was wondering how this
relates to string and int/hex options. It appears that they either
have a value or are not written to the .config at all, for example,
if the option is disabled via the `depends on` attribute. At first
I thought this would be inconsistent (i.e., =n for bool and omitted
for string), but it appears a disabled bool option is also omitted.
Hopefully the fact that sometimes a false bool option is =n and
sometimes it's omitted won't surprise anyone.

Reviewed-by: Boris Kolpackov <boris@codesynthesis.com>
