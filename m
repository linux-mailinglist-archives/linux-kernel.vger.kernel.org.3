Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5125A59CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiHWCt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiHWCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79729474F6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F809611A7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B54C433D6;
        Tue, 23 Aug 2022 02:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661222962;
        bh=SxDOFgx9HkJ+LkUsLoDu+m9YfREIA9QbhGWo7/Vo378=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrgmIZ1DvHFjxPaLm/Vypu4az7JWHp6tFzWx5owQTuaJocH8aoS78phNmconZ8Gu1
         g7Jwm4jw936QBT7zuvz3sgdBvvZ/WKmOyRIFh/2NSrHOkU8w8qor39+2E8aIcgoLrq
         0UZG88P0Auwav/X/90jkwtZ1+ymXK/vMwfHlIxl39vtYhgE5O7lYq7zNfH711OgiF3
         8tonqlvIGtWMq/ho7weCaQOLNt/+LGP1S+HG3+FPk2PO2AJfGJEsOs+ep7MGYOwi5B
         aGw2pmzaSu/760ioa+0jJFjbiFi6HlpA6uD4tWVxWzBjUwU8LWhdh8E9qVtlpzdTLJ
         yFFMWm7DWp1+g==
Date:   Tue, 23 Aug 2022 02:49:19 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@google.com>
Cc:     rrangel@chromium.org, robbarnes@google.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Send host event for
 prepare/complete
Message-ID: <YwRAL79BN2d/A0V0@google.com>
References: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
 <Yv27K4+rLfskcQdm@google.com>
 <CANkg5ewGUcWagRNOLfbRx8hLqgX+FfdYGB5Qt7tO5=zicGBVDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkg5ewGUcWagRNOLfbRx8hLqgX+FfdYGB5Qt7tO5=zicGBVDg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:21:47AM -0600, Tim Van Patten wrote:
> On Wed, Aug 17, 2022 at 10:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Tue, Aug 02, 2022 at 11:40:08AM -0600, Tim Van Patten wrote:
> > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > .prepare() and cros_ec_lpc_complete() during .complete(). This allows the
> > > EC to log entry/exit of AP's suspend/resume more accurately.
> >
> > As what I commented on [1], the term "host event" in the commit title is
> > confusing.  Also, as this is a cros_ec_lpc specific patch, please change
> > the prefix.
> 
> I've updated the prefix to "cros_ec_lpc" and the title/description to
> indicate that this CL moves when the host event is sent to
> .prepare()/.complete().
> 
> > [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid/#24934911

I'm not sure if any unclear.  "host event" is a terminology for CrOS EC.
The usage here is confusing.

> >
> > > -static int cros_ec_lpc_resume(struct device *dev)
> > > +static void cros_ec_lpc_complete(struct device *dev)
> > >  {
> > >       struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > > +     int ret;
> > > +
> > > +     ret = cros_ec_resume(ec_dev);
> > >
> > > -     return cros_ec_resume(ec_dev);
> > > +     dev_info(dev, "EC resume completed: ret = %d\n", ret);
> >
> > cros_ec_resume() always returns 0.
> 
> Yes, it always returns 0 today, but that may not be the case forever.
>  While "ret" is not returned by cros_ec_resume() today, it's possible
> for it to be non-zero and someone may update cros_ec_resume() to
> return that status.

Does it really need to print if `ret` is always 0?
