Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D328854217C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiFHFQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiFHFQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB83A2B92
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D62E60AD8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC66C34115;
        Wed,  8 Jun 2022 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654654636;
        bh=dFIQHND7/de6ERt33/EJw1YFoRsUBtTJPGMBARvM1fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYSHXrCZEtji0UMMxEA6ZIX76EWxraIEyNwA/Tk6tJAJ5ewGG2PmwN4+EXBHz1EX4
         vcfD1HCPwGljjiQ5kYe1rhOUPU4F2kEHrJKKLeCh6M9SJkwr5tP8PnL3fWeOpSV27l
         n0Jew4dSxH/FjA8pWHoiBak3gqfnJscuynFcC3i5/YseJTX0Di9CKCWEcGl/PLWZWg
         2SfkkbhF26U+YERsW+R02lHSaxt6We1a2uuWsW9Z92bFwHSGE0r1cnw0ORiVBQ8qXp
         4uZwzmTJaQaF/hbXpWgmzMwg01pCjbZjuCzL0YLUHahWxN1tZ8fpeaqn9QqUIcVw3F
         NaVKcAdQ6YU8A==
Date:   Wed, 8 Jun 2022 02:17:13 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] platform/chrome: use krealloc() for `din` and
 `dout`
Message-ID: <YqAGqZgauTnn76KD@google.com>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
 <20220607145639.2362750-13-tzungbi@kernel.org>
 <CABXOdTebXS3c823jWYx9r8mU4LwNfhLo833s7_krK4JW0fSgUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTebXS3c823jWYx9r8mU4LwNfhLo833s7_krK4JW0fSgUw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:06:23PM -0700, Guenter Roeck wrote:
> On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > Use krealloc() to re-allocate `din` and `dout`.  Don't use devm variant
> > because the two buffers could be re-allocated multiple times during
> > runtime.  Their life cycles aren't quite aligned to the device's.
> 
> While this saves a few lines of code, it is runtime-expensive:
> krealloc() copies the old data, which is a waste of time/resources.
> Maybe it would be better to just use kfree() followed by kzalloc().

Ack.  I wasn't aware of the memcpy().  Let's don't use it.

> > @@ -469,9 +469,9 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> >   */
> >  int cros_ec_query_all(struct cros_ec_device *ec_dev)
> >  {
> > -       struct device *dev = ec_dev->dev;
> >         u32 ver_mask = 0;
> >         int ret;
> > +       u8 *din, *dout;
> >
> >         /* First try sending with proto v3. */
> >         if (!cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_EC_INDEX)) {
> > @@ -492,21 +492,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
> >                 }
> >         }
> >
> > -       devm_kfree(dev, ec_dev->din);
> > -       devm_kfree(dev, ec_dev->dout);
> > -
> > -       ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
> > -       if (!ec_dev->din) {
> > -               ret = -ENOMEM;
> > -               goto exit;
> > -       }
> > +       din = krealloc(ec_dev->din, ec_dev->din_size, GFP_KERNEL);
> > +       if (!din)
> > +               return -ENOMEM;
> 
> I would suggest assigning the values directly; the new variables don't
> really add value.

checkpatch.pl generated a warning for it.  See [1].

Will remove the krealloc()s anyway.

[1]: https://github.com/torvalds/linux/commit/972fdea2e6ece7578915d386a5447bc78d3fb8b8
