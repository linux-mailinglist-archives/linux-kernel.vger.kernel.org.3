Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBD5928E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiHOFAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiHOFAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3697DF21
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D47A61068
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6FC433D6;
        Mon, 15 Aug 2022 05:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660539632;
        bh=MFilwZkgdY4Ni0rhfTadPQ7ULG2cq2VZ+nqfSUFQs8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goJWIc19psVpTnF4AryYtUMWOTDobtb1UgoyG9Tt5JGs6dYYSAuOApKJti7wpnqrE
         rObOG70Jn4tfDK8+tSjrmFCAP9ZN3PRJ/TBD95vglrbrw0qVkkPmr8Jnzn0p1obxm8
         q5SS2kNksFyx3XMaHjKoaJWyjsjmLsfWdKHbdpTniKGbFcJDFqZ4lv3QgIKekz4fN6
         JDJ6MaEGQBEWaky8/dAm+6inrDzYvScse4IUB2Ik8ZWKonrELit/btDQONWPh7dGC1
         ehrvZVz2JEjhQAxm5BV1tTTheFHJ4i53w3DPd758erkhG+0wvqQznp5B/uAvyJxFw1
         jtQfJqagp9Tjg==
Date:   Mon, 15 Aug 2022 05:00:28 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] platform/chrome: fix double-free in
 chromeos_laptop_prepare()
Message-ID: <YvnS7IKr/9VhffHX@google.com>
References: <20220813220843.2373004-1-subkhankulov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813220843.2373004-1-subkhankulov@ispras.ru>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 01:08:43AM +0300, Rustam Subkhankulov wrote:
> If chromeos_laptop_prepare_i2c_peripherals() fails after allocating memory
> for 'cros_laptop->i2c_peripherals', this memory is freed at 'err_out' label
> and nonzero value is returned. Then chromeos_laptop_destroy() is called,
> resulting in double-free error.

Alternatively, I would prefer to fix the double-free by setting
`i2c_peripherals` to NULL after [1].

[1]: https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L787

> Found by Linux Verification Center (linuxtesting.org) with SVACE.

After a quick glance, I found an invalid memory access at [2] if
`i2c_peripherals` is NULL (see [3]).  Do you have a real machine to perform
some module load/unload tests?  Or was the double-free issue discovered by
some static analysis?

[2]: https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L860
[3]: https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L756
