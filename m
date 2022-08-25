Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA95A0B79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiHYI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiHYI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:28:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F951422;
        Thu, 25 Aug 2022 01:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31CD7B82751;
        Thu, 25 Aug 2022 08:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11AEC433C1;
        Thu, 25 Aug 2022 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661416129;
        bh=hsT1N0GZBS8zN6pPF/LIhtsONDIzHgnCZgWOFTupmWw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=muJUzUi725vGuHKBcJ2G3DNWkTRz7BXsPFk4VyXuG5XqP/q1W2Bs62ss8QJY6KsRa
         uYoMp+u+tjx/IEt2sUm399XkWVfJwSZrrQPz18Tl3bb6SFcJJi5pZ5tUUOgilCSXmd
         41gj4ox85hZKdtaPRFHVMANivRWJvDECE8/enx3ZXB9K++oirYXWlKZGYaXSt3hrKT
         JtX5DCHbXcLCQ8PYmQvOyFHbsa10QkMOh5Z4gA/Z9QQ11mCtfEkG8thjOvK9I6V0++
         WTKhqKjUqXUunOfXIeGytAd9C9w32zkBTg+G9tJ+L4jICEe03/R4U2gfCsOQX2Z/bg
         ngF1GHX4qpRVg==
Date:   Thu, 25 Aug 2022 10:28:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 0/8] XP-PEN Deco Pro S support
In-Reply-To: <20220815142956.19180-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2208251026400.19850@cbobk.fhfr.pm>
References: <20220815142956.19180-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022, José Expósito wrote:

> Hello everyone,
> 
> This is v4 of [1]. Check the description in the link for more
> information, please.
> 
> v1 -> v2:
> 
>  - First patch acked-by Daniel Latypov
> 
> v2 -> v3:
> 
>  - Fix bug in "HID: uclogic: Add support for UGEE v2 mouse frames".
>    Reported-by: kernel test robot <lkp@intel.com>
> 
>    I copy-pasted the wrong template size.
>    Thanks to Nathan Chancellor for looking into it. As he mentioned [2],
>    CONFIG_FORTIFY_SOURCE doesn't catch this error without LTO enabled.
> 
> v3 -> v4:
> 
>  - Rebase on hid/master after the merge window.
> 
>  - Add and extra patch to add support for Parblo A610 PRO. The tablet
>    is similar to the XP-PEN Deco Pro S and adding its ID is enough to
>    support it.
> 
>  - Minimal cleanup in the return branch of uclogic_params_ugee_v2_init_frame_mouse
>    and uclogic_params_ugee_v2_init_frame_buttons.
> 
> [1] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/
> [2] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/#m796ac6c8f7484b0bafc1f1>
> 
> José Expósito (8):
>   HID: uclogic: KUnit best practices and naming conventions
>   HID: uclogic: Refactor UGEE v2 string descriptor parsing
>   HID: uclogic: Refactor UGEE v2 frame initialization
>   HID: uclogic: Parse the UGEE v2 frame type
>   HID: uclogic: Add support for UGEE v2 dial frames
>   HID: uclogic: Add support for UGEE v2 mouse frames
>   HID: uclogic: Add support for XP-PEN Deco Pro S
>   HID: uclogic: Add support for Parblo A610 PRO

Now in hid.git#for-6.1/uclogic. Thanks,

-- 
Jiri Kosina
SUSE Labs

