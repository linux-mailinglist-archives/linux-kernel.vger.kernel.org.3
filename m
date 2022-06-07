Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97D153F31A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiFGAyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiFGAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A119165A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C5860B5A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68125C385A9;
        Tue,  7 Jun 2022 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563286;
        bh=gmk4fKRSp3bwlEUvDrKNNUCOS51VOk9isFdfb+Hkvo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKosIKHyxThYRiWu0vnxKEf7INJoR2jurTks+bSWE1PJWWArPfP0Vyx5Sj6m1xeXi
         ncXyZs7yEGnXFXeuyBZW+8QszMBqc1DadQx5rsP2IJd9LHKc5B5s3lBgPH8AqDjJnS
         XrMc0v0CytceX+f4KUvuC9WL1lAn9SvXRDbaZabyFEYVCX3NlACKRIqBxNS2jrsJll
         EQpgs/M1kl1+fGsyrDOJd85R0M6KX+YduoNM1fS6Dy/q13Jl4DhhFcGtv4ahQPXCgS
         MhWG3T8SpoUkNQCQ89oC04LZnsJwpFDRfV+Gfypo7KBA9/09KPuIbIBOXu32dfA7aM
         zU+u67OoLyg9A==
Date:   Tue, 7 Jun 2022 00:54:43 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] platform/chrome: cros_ec_proto: add Kunit tests
 for cros_ec_query_all()
Message-ID: <Yp6h08cYtUgat1cQ@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-3-tzungbi@kernel.org>
 <CABXOdTdT0EtVoO6JmD0RdsmGvAXF3ERRwJATO01dU8+CtO7ofg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdT0EtVoO6JmD0RdsmGvAXF3ERRwJATO01dU8+CtO7ofg@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 08:18:41AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > +static void cros_ec_proto_test_query_all_pretest(struct kunit *test)
> > +{
> > +       struct cros_ec_proto_test_priv *priv = test->priv;
> > +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> > +
> > +       /*
> > +        * cros_ec_query_all() will free din and dout and allocate them again to fit the usage by
> > +        * calling devm_kfree() and devm_kzalloc().  Set them to NULL as they aren't managed by
> > +        * ec_dev->dev.
> > +        */
> > +       ec_dev->din = NULL;
> > +       ec_dev->dout = NULL;
> > +}
> > +
> > +static void cros_ec_proto_test_query_all_normal(struct kunit *test)
> > +{
[...]
> > +       cros_ec_proto_test_query_all_pretest(test);
> > +       ret = cros_ec_query_all(ec_dev);
> 
> Wouldn't it be better to implement a post_test function and have it
> call devm_kfree() if it is really necessary to release ->din and
> ->dout here ?
> 
> Either case, I am not convinced that clearing / releasing din and dout
> is really needed. The device pointer should not change, after all, and
> either the next call to cros_ec_query_all() will release the pointers,
> or unloading the driver will do it.

The `din` and `dout` are not managed by `ec_dev->dev` but statically
initializing in cros_ec_proto_test_init()(see below).

cros_ec_proto_test_query_all_pretest() sets them to NULL to get rid of the
following warning (as devres_destroy() in devm_kfree() returns -ENOENT):
WARNING: CPU: 0 PID: 27 at drivers/base/devres.c:1058 devm_kfree

Oops, I just realized qemu still generated yet another warning:
Device '(null)' does not have a release() function, it is broken and ...
Will fix it in next version.

[...]
> >  static int cros_ec_proto_test_init(struct kunit *test)
> >  {
> >         struct cros_ec_proto_test_priv *priv;
> > @@ -188,24 +902,48 @@ static int cros_ec_proto_test_init(struct kunit *test)
> >         ec_dev->din = (u8 *)priv->din;
> >         ec_dev->din_size = ARRAY_SIZE(priv->din);
> >         ec_dev->proto_version = EC_HOST_REQUEST_VERSION;
> > +       ec_dev->dev = kunit_kzalloc(test, sizeof(*ec_dev->dev), GFP_KERNEL);
> > +       if (!ec_dev->dev)
> > +               return -ENOMEM;
> > +       device_initialize(ec_dev->dev);
> > +       ec_dev->cmd_xfer = cros_kunit_ec_xfer_mock;
> > +       ec_dev->pkt_xfer = cros_kunit_ec_xfer_mock;
> >
> >         priv->msg = (struct cros_ec_command *)priv->_msg;
> >
> > +       cros_kunit_mock_reset();
> > +
> >         return 0;
> >  }
