Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28BF558F30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiFXDj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiFXDjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4658D1018
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA06F6209D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E38FC341C7;
        Fri, 24 Jun 2022 03:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656041945;
        bh=hvDGrtKuAmkd+sf5FsC2kG2pzlnLQfPD66t4zrguroY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdW9aYWTna/FgxG26tzKfPxIIv0eFwJPbhVl1P7F3ufU/qTD4whyEnVjNhh0Jwoge
         WJeBFYalCNyUJtib10S95jOdCwyIeUwhEg6qrauIsDYBgiauuewCT4RPjJ0ZQGuBpm
         NowzND0ibKJpg0Y8kOAcjviWjmRtc6/CCRhlVRgz5GgwqmyhpiBx7/1J1h98Mu7PUU
         twY7tQJCLAJO2R5wtBfhO+G9mPXmHRjuATKrckxfutAPY/FWcjE/TfIy5ekx3c1fg2
         50I+7msYSYsoOGC3rODa+mtahpIlNyEE6wLs+cMkfdBGRoCs3N5XsH5Y4nZjbtv//D
         a7BeMi3sawfjg==
Date:   Fri, 24 Jun 2022 03:39:01 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] platform/chrome: cros_ec_proto: separate
 cros_ec_wait_until_complete()
Message-ID: <YrUx1UXR4OnuTgAN@google.com>
References: <20220615051248.1628156-1-tzungbi@kernel.org>
 <20220615051248.1628156-6-tzungbi@kernel.org>
 <CABXOdTeYf=KsaMeEMOcevRjitvkLDKPeTELfDSmCxyG0OWWjgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeYf=KsaMeEMOcevRjitvkLDKPeTELfDSmCxyG0OWWjgQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:50:26PM -0700, Guenter Roeck wrote:
> On Tue, Jun 14, 2022 at 10:13 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
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
> >
> > -       if (msg->result == EC_RES_IN_PROGRESS) {
> > -               int i;
> > -               struct cros_ec_command *status_msg;
> > -               struct ec_response_get_comms_status *status;
> > +       msg->command = EC_CMD_GET_COMMS_STATUS;
> > +       msg->insize = sizeof(*status);
> >
> > -               status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
> > -                                    GFP_KERNEL);
> > -               if (!status_msg)
> > -                       return -ENOMEM;
> > +       status = (struct ec_response_get_comms_status *)msg->data;
> >
> > -               status_msg->version = 0;
> > -               status_msg->command = EC_CMD_GET_COMMS_STATUS;
> > -               status_msg->insize = sizeof(*status);
> > -               status_msg->outsize = 0;
> > +       /* Query the EC's status until it's no longer busy or we encounter an error. */
> > +       for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
> > +               usleep_range(10000, 11000);
> >
> > -               /*
> > -                * Query the EC's status until it's no longer busy or
> > -                * we encounter an error.
> > -                */
> > -               for (i = 0; i < EC_COMMAND_RETRIES; i++) {
> > -                       usleep_range(10000, 11000);
> > -
> > -                       trace_cros_ec_request_start(status_msg);
> > -                       ret = (*xfer_fxn)(ec_dev, status_msg);
> > -                       trace_cros_ec_request_done(status_msg, ret);
> 
> I'll have to spend more time on this; I don't immediately see (from
> the diff) the replacement for the traces, and I don't see what
> happened with xfer_fxn.

They are replaced by calling cros_ec_xfer_command() (see below) which does the
same things.

> > -                       if (ret == -EAGAIN)
> > -                               continue;
> > -                       if (ret < 0)
> > -                               break;
> > -
> > -                       msg->result = status_msg->result;
> > -                       if (status_msg->result != EC_RES_SUCCESS)
> > -                               break;
> > -
> > -                       status = (struct ec_response_get_comms_status *)
> > -                                status_msg->data;
> > -                       if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> > -                               break;
> > -               }
> > +               ret = cros_ec_xfer_command(ec_dev, msg);
> > +               if (ret == -EAGAIN)
> > +                       continue;
> > +               if (ret < 0)
> > +                       break;
