Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15675432BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiFHOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbiFHOhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:37:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9316950B3E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:37:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v25so27391427eda.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIgzWiqZ9B5DH/Ah6uNm4nobex6Dnfmxiak8xN0J0Rg=;
        b=dWpsiqdRek7kuhblNqCkOUDbqDqFCbD401L+uVtIYl+aV6TVlPNqrWftvFHLbeyON5
         /U5PIaeZPpZd+M8qlIkzZozaULrWD2keeY4M9a31K0N6odL1/my2Qw2YQV8HB8htGDcR
         +jccJDDPU3uc2BCvmGrl8TA11HMeBCOYGZzZKiEgxnzBlXor0O+x6oND7ZjIBYBTsj6h
         lt8BNSfH347kyyDE5Ty6IFg6JqKSevWLqGN2FLDmV0r/kE768ujIgSNxcbs4fdtSqcsQ
         yqjh88Ud3fhocxI54S2Ky5W9BnutWGyl9W9+Xk46rAIi781BoIyGzdJwaob1bhjPzgu8
         PFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIgzWiqZ9B5DH/Ah6uNm4nobex6Dnfmxiak8xN0J0Rg=;
        b=BjR6PYzc8ih5uwrtfJeqhWNkba8PtcfQTWFbWCClEZ5r4OlE6vtIw5gWMJ3fZxqE+S
         ik/gDigvga31T9/NJ0toW1JCgPB/c61He9W+R5sqbwMQGqO6u3GK9M/aTIRkU5Vt0gW9
         p5B4zuN/zbPdcteGWEWH//cM9KQpx+Tnf8NnviWdcu8m67zk/5thh+GCkFi0Z04uuzWh
         Te7O/rbsPv2V+ptJkLizCcf5Q5yWndEePYgCrCd4J/LF/Y6Yg5M7c2cYNrMc/6rtI177
         oQ1WgVb6Ezgx3TWJ1/0OpmTJveyqbeA3j9hPvF9T2KPJRq2YXTayeFeP//D6wN4OBTIr
         MQYA==
X-Gm-Message-State: AOAM533jS3NW5bPEE3ONjTYnCSFuYNO2QrH4UUEzjXDjtrx1xy2cXq9T
        dBata3hRoY6SKkPXJA8hdw1SCiTMZeUc4IGZDHI8rB9nk3Sdiw==
X-Google-Smtp-Source: ABdhPJyzhAftpT5VLkXR18MJk31HDfd3kIidetYc8tMvuBlBYjURb2buh+BzqLpOLixltJAbgrclTo+rVNXIt604j8k=
X-Received: by 2002:a05:6402:3688:b0:42d:d3ba:4725 with SMTP id
 ej8-20020a056402368800b0042dd3ba4725mr40113923edb.212.1654699042272; Wed, 08
 Jun 2022 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220607145639.2362750-1-tzungbi@kernel.org> <20220607145639.2362750-9-tzungbi@kernel.org>
 <CABXOdTdx7jKLbHa3X7aOz3wUMpwWWHkncfKuRyGzonkA92Rg=w@mail.gmail.com> <YqAGmpdTfZsa7Lux@google.com>
In-Reply-To: <YqAGmpdTfZsa7Lux@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 07:37:10 -0700
Message-ID: <CABXOdTexvEoaRvOdoTeoHoGpHqHPPHvJAL8sYSBS4fn7eLkCgA@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] platform/chrome: cros_ec_proto: handle empty
 payload in getting proto info
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 7:17 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Tue, Jun 07, 2022 at 11:47:56AM -0700, Guenter Roeck wrote:
> > On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > cros_ec_get_proto_info() expects to receive
> > > sizeof(struct ec_response_get_protocol_info) from send_command().  The
> > > payload is valid only if the return value is positive.
> > >
> > > Add Kunit tests for returning 0 in send_command() and handle the case in
> > > cros_ec_get_proto_info().
> > >
> > That should be two separate patches.
>
> Ack, will separate them in next version.  I put them together because I wrote
> Kunit test first to make sure the second half takes effect (somehow TDD).
>
> Could I still put the Kunit patch first (even if it introduces Kunit test
> failure)?
>

Sorry, I am running behind with e-mails.

If you want to, but why not let the fix come first ? If the unit test
patch is first, mayle add a note after --- indicating that it is
expected to fail and will be fixed with the next patch.

Thanks,
Guenter

> >
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > > No v1.  New in the series.
> > >
> > >  drivers/platform/chrome/cros_ec_proto.c      |   5 +
> > >  drivers/platform/chrome/cros_ec_proto_test.c | 132 +++++++++++++++++++
> > >  2 files changed, 137 insertions(+)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > index 893b76703da6..6f5be9e5ede4 100644
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -314,6 +314,11 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
> > >                 goto exit;
> > >         }
> > >
> > > +       if (ret == 0) {
> > > +               ret = -EPROTO;
> > > +               goto exit;
> > > +       }
> > > +
> >
> > I think you can move that into the if() statement above (which already
> > checks for ret >=0),
> > making it a special case of that situation.
>
> Nope, there is no "ret >= 0" (you could be confusing with
> cros_ec_get_host_event_wake_mask()).
>
> The result flow roughly like:
>
> ret = send_command(...);
> if (ret < 0)
>   goto exit;
>
> mapped = cros_ec_map_error(...);
> if (mapped) {
>   ...
>   goto exit;
> }
>
> if (ret == 0) {
>   ...
>   goto exit;
> }
