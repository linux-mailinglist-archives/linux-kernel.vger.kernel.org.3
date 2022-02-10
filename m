Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8924B0C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiBJL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiBJL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:26:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF25C15;
        Thu, 10 Feb 2022 03:26:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F1A4CE243B;
        Thu, 10 Feb 2022 11:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FBCC004E1;
        Thu, 10 Feb 2022 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644492387;
        bh=uGn5sWCwfvSpb9avSSWCJHzaK458xm1a3dY7suR6Wq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmP8EM8H7RyB9Ym3qK7Ab0iB7yxWmeZuQHOTX1sfiP/hya1Anr35ncQb2AAxMyiCR
         AwxffvC9428xp4W3x1H65MJVHavyI2k+lZGZkdiW//uY+5lBWEVlbTKXHjVBGtld66
         BGjb1rR3IP5tpyINKARQjp9TSExlzCX7Ne2si5nMpt1UkacdN4O4e+ChsOKxMCUaca
         mPbSXUTWrGUxqNLwo/kMVaWEUn4A/hdvDBHuWmq3DSW/1hlIybZjJliSnWaG6qacxV
         WtAIy2jd3v0CZJF8Pjg+h3cWTXmRe0fYVl1KhtP4Pq61JIoV6AGYdTdGkD/QXcREG8
         8nF94wXPl+K5w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nI7aR-0005EK-SH; Thu, 10 Feb 2022 12:26:08 +0100
Date:   Thu, 10 Feb 2022 12:26:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     davidcomponentone@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Yang Guang <yang.guang5@zte.com.cn>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] serial: 8259_aspeed_vuart: replace snprintf with
 sysfs_emit
Message-ID: <YgT2TyST3OA3a4WC@hovoldconsulting.com>
References: <a0f3e5d6d438710413d1909365f99ae4d2a4bacc.1644399683.git.yang.guang5@zte.com.cn>
 <CAHp75Vd-Zszg1j6aVrX_oEJdiq4m=69JqE4RvyPMqEu30RFaTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd-Zszg1j6aVrX_oEJdiq4m=69JqE4RvyPMqEu30RFaTA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 01:13:28PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 10, 2022 at 12:54 PM <davidcomponentone@gmail.com> wrote:
> >
> > From: Yang Guang <yang.guang5@zte.com.cn>
> >
> > coccinelle report:
> > ./drivers/tty/serial/8250/8250_aspeed_vuart.c:85:8-16:
> > WARNING: use scnprintf or sprintf
> > ./drivers/tty/serial/8250/8250_aspeed_vuart.c:174:8-16:
> > WARNING: use scnprintf or sprintf
> > ./drivers/tty/serial/8250/8250_aspeed_vuart.c:127:8-16:
> > WARNING: use scnprintf or sprintf
> >
> > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> sysfs_emit()
> scnprintf()
> sprintf()
> 
> ...
> 
> > CC: David Yang <davidcomponentone@gmail.com>
> 
> > - Use the CC for patch sender
> 
> This is incorrect. The submitter must have (the last) SoB tag.
> Question was about authorship just to be clear.

Please fix up the subject prefix too ("8059").

Johan
