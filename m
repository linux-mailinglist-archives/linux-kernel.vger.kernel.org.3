Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D55572B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiGMC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGMC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1334B23F9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC53619E9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E3CC3411C;
        Wed, 13 Jul 2022 02:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657681086;
        bh=ppGPQRz71SyIIbpVVd2z7ECwSLRj01ZGyLWURlj+GMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eteu4NCCWfn+jiUzOIs19qru53PJJ87Bxq+f2JvAP/5JrNd9VG2tONn7NsH6d/WpZ
         G1oEWQOFSwV4KuhaKZiEgkhUerBhycdNCuwO9faN2XpUm5WIE8HkOnbpmVc/HnL16Q
         7G9Ma7xtC3pJhhCEG2l3t6u8He3TqCgu3bGciGhWV9Auia7N5XG1x0ZRddUqnfhayW
         wvBSpZMiDl0F8uymLhgiL60tFA8TwvClk4MRVuVieTUBwkynEo09jWpV37/fluQMYe
         sDa/yAMnGFJnF22ok3ZWdFAeW+4HtxcOPu4TKqkJwj8MW9kDnCzH+O6ImeUWfwwQ/u
         hVagCi1Dg+DFg==
Date:   Wed, 13 Jul 2022 02:58:03 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for
 prepare/complete
Message-ID: <Ys40uw4QIe4fQKA/@google.com>
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 08:51:39PM -0600, Tim Van Patten wrote:
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
> .prepare() and cros_ec_lpc_resume() during .complete. This allows the
> EC to log entry/exit of AP's suspend/resume more accurately.

Please be consistent.  Either way:
- .prepare and .complete.
- .prepare() and .complete().

The patch doesn't allow EC to log anything.  It makes AP emit more logs.

On the related note, the commit subject is confusing.  The patch doesn't
send "host event".  "host event" is a terminology when EC wants to notify
AP something.  Also, s/cros_ec/cros_ec_lpcs/.

> Changes in v2:
> - Include cros_ec_resume() return value in dev_info() output.
> - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

I didn't see concerns in [1] have been addressed.

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid/#24920824
