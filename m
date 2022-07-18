Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE25779CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiGRDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E8DFD9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 20:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9844361196
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12827C341C0;
        Mon, 18 Jul 2022 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658116223;
        bh=W1l3MKFfc668mGrdCGEIa+NpnVFSilikyS52LQqnzqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZwzSCq08R4rpdqTK3LFcHQ2o/1tgJhyW6XJUnoxyRnGY3ylxtyuz5jRq/TukLcBw
         qv8CB0V/I8szCaSW7Brc/mNeupOS+zsbcdiFzjLThC5qMZV9MgXxQXX0vMQKOkNYx2
         KbVDIxoiVHV63T7t9S4hJ9FjU7rASKgy50nS04bQYbIZCuSg/vPkJtIWvhJK0FhRCd
         pcn4XROh8HvcpA3XD876//T7kw/JwTFzyO3tRCE8S38qP8hA9ZRYTQfN+Ngk3tpeN/
         hpgbN+3udW6eZ8qIjI+1VS/OCz+aMqGAJyk7SPseicpVWyXMeRpUYfHMXW+XyjRNW4
         0i6XXnxGpMvKQ==
Date:   Mon, 18 Jul 2022 03:50:19 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate
 cros_ec_wait_until_complete()
Message-ID: <YtTYexaeIWZgSwfH@google.com>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
 <20220628024913.1755292-6-tzungbi@kernel.org>
 <CABXOdTeC+q-UiPiThqL5MGg-+cGACGW4qLaLKZbmX4M26TvbDg@mail.gmail.com>
 <Ys+OlrVCy4MkyRnr@google.com>
 <CABXOdTfJ6x5ePkmj+w21jTX7EOTXZrCd8PwikAJQTfeQmUBxaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTfJ6x5ePkmj+w21jTX7EOTXZrCd8PwikAJQTfeQmUBxaQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:29:45AM -0700, Guenter Roeck wrote:
> On Wed, Jul 13, 2022 at 8:33 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > On Wed, Jul 13, 2022 at 11:15:47AM -0700, Guenter Roeck wrote:
> > > On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > > +               ret = cros_ec_xfer_command(ec_dev, msg);
> > > > +               if (ret == -EAGAIN)
> > > > +                       continue;
> > > > +               if (ret < 0)
> > > > +                       break;
> > >
> > > With the command allocated on the stack, this can return immediately.
> >
> > Nack, the function has no goto labels.  `return ret` follows the loop
> > immediately.  The `break` here doesn't make it to become too complicated.
> > I would prefer to keep it.
> 
> Sorry, you lost me here. The code after the loop does
> 
>            kfree(msg);
>            return ret;
> 
> If kfree() is no longer necessary, only the return statement is left. So break;
> is identical to return ret;. Am I missing something ?

You are correct.

I meant personally I would prefer to use `break`:
  * The loop is short so that it won't become too complicated.
  * Keep the function has a single exit point.

But, anyway, let's use `return ret` to make it explicit.
