Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D2566F08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiGENOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiGENNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:13:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2608833EA6;
        Tue,  5 Jul 2022 05:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91C5CB817D2;
        Tue,  5 Jul 2022 12:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7028C341C7;
        Tue,  5 Jul 2022 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657024697;
        bh=ZLcEeZ+XHMclDymmtx7KObEo+kt/3lNRCCJxnaCxASI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kRqYfTwXVHfu28r1rmhtBcZX8TBGiOJzfOV2QMT2vxK4dz6Rny3AEBvLLB6nH9IUk
         qHUgTgz6XoePXlYPxx0ViYH+LGRqPhICeQKIykQdCogi7beb11NSvbkuuwZ9jI6hXN
         674dighzjnjx3YtUC9lARtoB2KQbYRu6KgI/2aFRV9/UlP+5CJcNGd5ypHwOrPwf7B
         gSygC7tK01W6tmJyM3m8yalpx4kPE8/5G5KBCO99cYdBpTRrvqvibDOqfZTvs2cpAp
         a65PfNIqRn0NkR8WQm3VXM6KrwxOH5YlRLnkgayKvP5whabwSNgT4WwmZ5RK4VHs47
         hTemFVqfRbiPQ==
Date:   Tue, 5 Jul 2022 14:38:12 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705143812.35ac5f2d@thinkpad>
In-Reply-To: <20220705123206.6umrjbj5g4o5n2mk@pali>
References: <20220705000448.14337-1-pali@kernel.org>
        <20220705000448.14337-2-pali@kernel.org>
        <20220705123705.0a9caead@thinkpad>
        <20220705105609.cpabhrwozyeejwqe@pali>
        <20220705135227.6380d6d5@thinkpad>
        <20220705122238.ul3cctrxkkttge3m@pali>
        <20220705143001.7371a256@thinkpad>
        <20220705123206.6umrjbj5g4o5n2mk@pali>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 14:32:06 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Tuesday 05 July 2022 14:30:01 Marek Beh=C3=BAn wrote:
> > On Tue, 5 Jul 2022 14:22:38 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote: =20
> > > So what about exporting another sysfs file which controls current lev=
el (0-7)? =20
> >=20
> > OK, that would be satisfactory. Something like
> > "selected_brightness_index". =20
>=20
> Too long? What about just "brightness_level" and make it R/W?
> We already call it level (not index).

ok
