Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16E542447
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiFHFP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiFHFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52743A15E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47363B823D0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B7C34114;
        Wed,  8 Jun 2022 02:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654654622;
        bh=ZqeGTyfh/Ani8+K+9DA5ei1T7FyK6i6XD9rV4VeyryM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVw5jD9hmlhBw7cna50eKtb6BeRDtHouoqUONkWwUvYQztv3TxoS0mvnCy9XqEVN+
         gH5gWRcVQtW8NoEhTpTp+QlmDyPb3/lbCpAEUWtNqkuNDmkhvYl5DMQQa+4yew+jlq
         p1UNiKj4ki0Kfj5RfksRxlDEmjZjX4aUzqAoBczz5Q3sLTnGZl+70w8IKLgnmTH3GZ
         m2NhqtJ+O3Tvdjm9Y66iXUZ11vA46jlLN0MhG22GajiM5m91pboCr8f12QVqa4YYn+
         Y2QlDuHMd3P6d68y6srF/whAFIiHwnsSIj5XjHgQ5VsRwiaGgFkoU5aoYTueZ6dBnK
         agh5XPsIuAP1g==
Date:   Wed, 8 Jun 2022 02:16:58 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] platform/chrome: cros_ec_proto: handle empty
 payload in getting proto info
Message-ID: <YqAGmpdTfZsa7Lux@google.com>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
 <20220607145639.2362750-9-tzungbi@kernel.org>
 <CABXOdTdx7jKLbHa3X7aOz3wUMpwWWHkncfKuRyGzonkA92Rg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdx7jKLbHa3X7aOz3wUMpwWWHkncfKuRyGzonkA92Rg=w@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:47:56AM -0700, Guenter Roeck wrote:
> On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_get_proto_info() expects to receive
> > sizeof(struct ec_response_get_protocol_info) from send_command().  The
> > payload is valid only if the return value is positive.
> >
> > Add Kunit tests for returning 0 in send_command() and handle the case in
> > cros_ec_get_proto_info().
> >
> That should be two separate patches.

Ack, will separate them in next version.  I put them together because I wrote
Kunit test first to make sure the second half takes effect (somehow TDD).

Could I still put the Kunit patch first (even if it introduces Kunit test
failure)?

> 
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > No v1.  New in the series.
> >
> >  drivers/platform/chrome/cros_ec_proto.c      |   5 +
> >  drivers/platform/chrome/cros_ec_proto_test.c | 132 +++++++++++++++++++
> >  2 files changed, 137 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index 893b76703da6..6f5be9e5ede4 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -314,6 +314,11 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
> >                 goto exit;
> >         }
> >
> > +       if (ret == 0) {
> > +               ret = -EPROTO;
> > +               goto exit;
> > +       }
> > +
> 
> I think you can move that into the if() statement above (which already
> checks for ret >=0),
> making it a special case of that situation.

Nope, there is no "ret >= 0" (you could be confusing with
cros_ec_get_host_event_wake_mask()).

The result flow roughly like:

ret = send_command(...);
if (ret < 0)
  goto exit;

mapped = cros_ec_map_error(...);
if (mapped) {
  ...
  goto exit;
}

if (ret == 0) {
  ...
  goto exit;
}
