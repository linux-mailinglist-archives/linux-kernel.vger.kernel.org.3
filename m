Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F435741EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiGNDe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiGNDeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:34:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB52656F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A39CB8222B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE418C3411E;
        Thu, 14 Jul 2022 03:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657769625;
        bh=81ghQuT4MUDXtO15JndBoby2uZqZSln18bQdbLogn3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3ex3EScQj21gSpEDCavtxo6dUAh+L31Tmt5h1qo7zKuZh+DTts3YdR+IAH+L/LKz
         aVMD19kXy1Xr0Fi11yFY9djP+SQpw8t2CloMR9wCGlaHBMi/Wyyn8uYyo8X2sCVkwW
         sJtNRqFfGyd8Ms3pkS44qZlRDS5vHkdj5du+jguNO/PoYwGqXSqiHJWrdguQin4Sjf
         QArXZfeGSyEuPBFIguk04fVCuLndnRXy2/2se1nF/Mpxdt1Dg596JQ175ZyVro2uaH
         4A/iMcG/yiwBu6zmjIOC+mVFh5T+zzXUCEiur5KOEH/5WayeKABnV/WiNy6BXhPbhc
         1PgYGnQVqq4MA==
Date:   Thu, 14 Jul 2022 03:33:42 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate
 cros_ec_wait_until_complete()
Message-ID: <Ys+OlrVCy4MkyRnr@google.com>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
 <20220628024913.1755292-6-tzungbi@kernel.org>
 <CABXOdTeC+q-UiPiThqL5MGg-+cGACGW4qLaLKZbmX4M26TvbDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeC+q-UiPiThqL5MGg-+cGACGW4qLaLKZbmX4M26TvbDg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:15:47AM -0700, Guenter Roeck wrote:
> On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> > +static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
> >  {
> > -       int ret = cros_ec_xfer_command(ec_dev, msg);
> > +       struct cros_ec_command *msg;
> > +       struct ec_response_get_comms_status *status;
> > +       int ret = 0, i;
> > +
> > +       msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
> > +       if (!msg)
> > +               return -ENOMEM;
> 
> AFAICS this is always 24 bytes. I would suggest to allocate it on the
> stack to reduce overhead.

Ack.

> > +               ret = cros_ec_xfer_command(ec_dev, msg);
> > +               if (ret == -EAGAIN)
> > +                       continue;
> > +               if (ret < 0)
> > +                       break;
> 
> With the command allocated on the stack, this can return immediately.

Nack, the function has no goto labels.  `return ret` follows the loop
immediately.  The `break` here doesn't make it to become too complicated.
I would prefer to keep it.

> > +
> > +               *result = msg->result;
> > +               if (msg->result != EC_RES_SUCCESS)
> > +                       break;
> 
> Again, this can return immediately if the command buffer is on the stack.

Nack.  See above.

> > -               kfree(status_msg);
> > +               if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> > +                       break;
> 
> Can return immediately.

Nack.  See above.

> > +       kfree(msg);
> > +       return ret;
> 
> What should this return on timeout ?

It returns either:
* -EAGAIN, if cros_ec_xfer_command() returned -EAGAIN
* 0, if EC_COMMS_STATUS_PROCESSING flag was on
for EC_COMMAND_RETRIES times so far.

This is a "move" refactor.  I would prefer to keep it as is and change the
behavior in later patch.
