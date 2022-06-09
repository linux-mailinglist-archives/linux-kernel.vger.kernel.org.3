Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B995442EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiFIFJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbiFIFJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6D186DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D10361D15
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014C6C34114;
        Thu,  9 Jun 2022 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654751346;
        bh=VmI5ZpIXTp9MnI4+dGgRn5ZVS3Q0GQ1DEje/j6+uJX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwNlJJ5WUsHih6dgYXLhQXO23e4U3qFvVp2rbyul3rs+YOUxXaPBqo6VnACVfy6eA
         jybfoLpJPFZnDSkVR972d8G53Gzh4CzQytrv2Ye8dESTCM9XLLVOZRc+c1u9Jp4PlS
         QNZj0N3FhI2zd0yqqXLaffNCRlXvnBBBOt4oKgvB+GeYFt0+zQk6wIji7w+KgnZ/EA
         ob+Tb/5GWg47EQBfvN5OkV4ipsdHpgkTQsTYd50mq0cYPpLnymkZGEJfd8YhxzS94a
         thL/EH7M4arphzsfOM+Wj1RUotLgwcG+2tmXz1i9v/EUe+byEr9h+cg/iZQKhlO/cZ
         BrEWecLF+/1iw==
Date:   Thu, 9 Jun 2022 05:09:03 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/23] platform/chrome: cros_ec: don't allocate `din`
 and `dout` in cros_ec_register()
Message-ID: <YqGAb9ApjYEFHoEX@google.com>
References: <20220608110734.2928245-1-tzungbi@kernel.org>
 <20220608110734.2928245-14-tzungbi@kernel.org>
 <CABXOdTegzx8Xpp3QPn8XyjLt1Rdr7ztkLcY53+vHmEEVKYSr4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTegzx8Xpp3QPn8XyjLt1Rdr7ztkLcY53+vHmEEVKYSr4Q@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:15:56AM -0700, Guenter Roeck wrote:
> On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > Don't allocate `din` and `dout` in cros_ec_register() as they will be
> > allocated soon in cros_ec_query_all().

Pardon me, I should test them earlier.

I misunderstood.  The patch will cause kernel crash (NULL dereference)
because cros_ec_query_all() relies on `din` and `dout` for getting protocol
info and then it reallocates the buffers according to the info later.

I think we should just leave them as they are.  Will drop this patch and next
patch ([v3,14/23] platform/chrome: don't use devm variants for `din` and
`dout`).
