Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42545741FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGNDlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGNDlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCC325EB3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEAF261E1E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45413C34115;
        Thu, 14 Jul 2022 03:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657770091;
        bh=AZSjVzGi4sFow1O7HTakF+F0oYqMEHY3kI20gzzwNjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0X0lIxzIH8h1HGTGqJboS1UMqhEsMWSwXeiWt7qCzz8tyoyiCOP8XQxASsPCsWfU
         1LarWVOMbOyg+3MfTQwynu0EZmtBJ+2wlMNn6bn3/CT6DFbOVF3OJz1wMY8ijb0h25
         hRGLOtth9BP9t02J/fNNp17nmR83d9SiyRbVNeT3wo6lSpN+ctIBkRAHpEhmSmOT91
         gvVFPTmamh9jhA+nUscmJmtElYKcE+FVe8oanqj6Gu0CPIwdij4m/kT4a3wbloUKIl
         wFisLKmbxU4hvjLxlAH2bAv7Lepc98guH8nyfR9WQwEpFWlJzoMepF/cFJyPdvVBit
         xpETjenunfTmg==
Date:   Thu, 14 Jul 2022 03:41:27 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 07/11] platform/chrome: cros_ec_proto: return
 -EAGAIN when retries timed out
Message-ID: <Ys+QZyOdIT8d1rvW@google.com>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
 <20220628024913.1755292-8-tzungbi@kernel.org>
 <CABXOdTft0Nu_hJQuXwepBXE3tWZf7jaidGE5mamq_=1Zi4hevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTft0Nu_hJQuXwepBXE3tWZf7jaidGE5mamq_=1Zi4hevg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:18:32AM -0700, Guenter Roeck wrote:
> On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
> > EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
> > cros_ec_wait_until_complete() doesn't return an error code.
> >
> > Return -EAGAIN in the case instead.
> 
> Does this make sense, or should it be -ETIMEDOUT ? What does the EC do
> if it is still busy (stuck ?) with executing a command and it gets
> another one ?

AFAIK, most existing ECs use single task for host command[1][2].  As a
result, EC won't reply if it was busying on executing a host command.
Not sure if it would change after leveraging Zephyr (if enabling multi-core
support).

EC_CMD_GET_COMMS_STATUS is the only exception.  EC executes the command in
interrupt context[3].  That's why AP can use EC_CMD_GET_COMMS_STATUS to query
the status while EC was busying on another host command.

I have no strong preference for the return code but tried to align to another
timeout case (when cros_ec_xfer_command() returned -EAGAIN for
EC_COMMAND_RETRIES times).  Do we want to separate the cases: one for -EAGAIN
and another one for -ETIMEDOUT?

[1]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/common/host_command.c#428
[2]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/board/volteer/ec.tasklist#20
[3]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/common/host_command.c#176
