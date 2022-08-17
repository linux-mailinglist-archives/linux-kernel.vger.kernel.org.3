Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40F59668B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiHQBMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiHQBMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:12:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5E90810
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:12:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d71so10726715pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IQqOeOHFCBfDNqFiPFtHTz2iG/+I6d7AdQ+Jlb2zqWc=;
        b=eRLga/ew2mwW/xZzX/BChS+LiLoI5DOBLdj+vF/UBkyaxgfq75XnYSRio4eiI6iCzL
         w/jgqFQ1wsj7Nxp4zkMUCZSpuzn2MvKRlFN+SK2MZ3RI7oENrIaNba8cAYnNWHtSeyH4
         iV/qpBmzUzuswAd88P2sY4vob45SviTYAQV+LfPxmcf15yiCJzgXbEEoIECMe40/twa8
         Gq95wv7raIT7cgQYeSRr0/k4TJur+qc37dDktEYxKQZqn2sxID6kyc3PDIfrIoYQomr5
         1k1R1Fl0xSl8HSwPbPQYXqHHvma4PpJqeKRgnV8Qq6rK1bA1WQsu13Ors2flpnHeRzwE
         k5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IQqOeOHFCBfDNqFiPFtHTz2iG/+I6d7AdQ+Jlb2zqWc=;
        b=TDD690upcGRRhLXeL9MwdRB/YbGOfocAK+Kdv+AP3/shucj+75NIfPQvCWk/Mj0w8m
         BtR19/aG4QQuJyAujmK46/QHhB+cpT47ILCKNYntRDyRjmSzZhmL4mjmoqcpTvRDTrzM
         Adqsw7zlaXXMddZf5sjpogi3yDXoN+pobi3U9GovuEicC9FrESWjYGOy70zeyM5sqF4o
         QlY9jh73Txvvvxooz5a3lY9cKjLNwHk6KFoQ+WwXhxrXbJJ1g9flLWhB/aP6yDiLgXCu
         OEFP0ehX0+RN/JOI5XMZQdvVLI7ecFSVrW82nKGHH2ffVeKPEE8eDIrlOwZ637s4yWej
         cALA==
X-Gm-Message-State: ACgBeo18sN8h1OLP0D165lXGOUuEhObVHJh5/kXRXIEfjNoX/2CK+7BF
        yQ8oH9v+wKDGWAmWaTaSATpsBA==
X-Google-Smtp-Source: AA6agR5kDiAkPbnRjr+14CDqrypjIhm5qym7KSIqHqudrFG886p9g3GBKwUogbIFus+aEKXvwAxqzA==
X-Received: by 2002:a05:6a00:a82:b0:530:2f3c:ec99 with SMTP id b2-20020a056a000a8200b005302f3cec99mr23481411pfl.53.1660698756595;
        Tue, 16 Aug 2022 18:12:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:df29:644b:8119:e30a])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b0016cd74e5f87sm6296plb.240.2022.08.16.18.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:12:36 -0700 (PDT)
Date:   Tue, 16 Aug 2022 18:12:30 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <YvxAfiSOrzy7/c1J@google.com>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817010559.GA1880847@roeck-us.net>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:05:59PM -0700, Guenter Roeck wrote:
> On Tue, Aug 16, 2022 at 10:13:28AM -0700, Isaac Manjarres wrote:
> > On Tue, Aug 16, 2022 at 04:13:11AM -0700, Guenter Roeck wrote:
> > > On Mon, Aug 15, 2022 at 10:17:23PM -0700, Isaac Manjarres wrote:
> > > > On Mon, Aug 15, 2022 at 09:25:07PM -0700, Guenter Roeck wrote:
> > > > > > v1 -> v2:
> > > > > > - Fixed the logic in __driver_attach() to allow a driver to continue
> > > > > >   attempting to match and bind with devices in case of any error, not
> > > > > >   just probe deferral.
> > > > > > 
> > > > > > Guenter,
> > > > > > 
> > > > > > Can you please give test this patch to make sure it still works for you?
> > > > > > 
> > > > > 
> > > > > Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
> > > > > emulations now stall during boot when trying to boot from usb.
> > > > > 
> > > > > Guenter
> > > > Thanks for trying the patch out. This patch isn't meant to fix the clk
> > > > crash that you mentioned on another thread. I had made the following patch for
> > > > that: https://lore.kernel.org/lkml/YvqTvuqSll30Rv2k@google.com/. Have
> > > > you been able to give that a shot yet? If not can you please test with the
> > > > patch in this e-mail and that patch?
> > > > 
> > > 
> > > No, sorry, I missed that one. It does not apply, though - it is whitespace
> > > corrupted. I tried to fix it up, but that failed.
> > 
> > When applying the patch, can you please try with
> > git apply --ignore-whitespace ? That worked for me.
> 
> Ok, that worked. With the above patch, the problems with sx1 and versatileab
> are gone.

Good to hear! Thanks for testing that patch out.
> However, imx25-pdk fails to shut down when booting from usb
> drive. I cross checked that this does not happen without the above patch.
> 
> Guenter

Can you please share the following for your imx25-pdk environment?
qemu commandline, defconfig, dtb, and baseline kernel commit you're
using for testing.

Thanks,
Isaac
