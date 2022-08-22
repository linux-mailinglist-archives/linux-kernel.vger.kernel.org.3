Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA559B8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiHVF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHVF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE052611C
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F96CB80D83
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F4C433C1;
        Mon, 22 Aug 2022 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661147762;
        bh=UXPhdV0KvZbi0frdKGtoEE+EnbITh7+sFXDjXX0lowc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgJjG6+GaSpvVxT1gTZ2WSxmSsi9vQolmpIw/Ul7tck/K+Nt8uQLGYU/aqUtI/zJZ
         DaRTqfLGi64Ji/l3RLKjg516Mmrdq7hScEwSpitVEgEzm1PjuYKRR2INDiDD9wflos
         2f27ALuH8F3/cqSvD3ZnSpPExC8PrNKpguOSENHsxZO+OXSyQJpJ32Zq8xS9pSGW+h
         zZzIhGxzRZvzSuvqc/+Yhd3YZz5SfyCMKQ8RxjXyw2JreMIwtbOrBEDGRfoyH3XdLY
         6H/0uUgrTmColPMV/KcpDlK/XvmjCmI8L8+PgBnGsVdpid0sPC9pFHGNU7+jGjNd++
         o0pgzdTwwwb+A==
Date:   Mon, 22 Aug 2022 05:55:58 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Expose suspend_timeout_ms
 in debugfs
Message-ID: <YwMabj1HazWxJEAr@google.com>
References: <20220818082827.v2.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
 <CACeCKafyHSTiyyjA=yjSXsTub4kKECfe9gp=y10LCYYx0nGKqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafyHSTiyyjA=yjSXsTub4kKECfe9gp=y10LCYYx0nGKqg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:24:23AM -0700, Prashant Malani wrote:
> On Thu, Aug 18, 2022 at 8:29 AM Evan Green <evgreen@chromium.org> wrote:
> > diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> > index 1fe0add99a2a99..9f79c641b2d09f 100644
> > --- a/Documentation/ABI/testing/debugfs-cros-ec
> > +++ b/Documentation/ABI/testing/debugfs-cros-ec
> > @@ -54,3 +54,25 @@ Description:
> >                 this feature.
> >
> >                 Output will be in the format: "0x%08x\n".
> > +
> > +What:          /sys/kernel/debug/<cros-ec-device>/suspend_timeout_ms
> > +Date:          August 2022
> > +KernelVersion: 6.1
> > +Description:
> > +               Some ECs have a feature where they will track transitions to the
> > +               a hardware-controlled sleep line, such as Intel's SLP_S0 line,
> > +               in order to detect cases where a system failed to go into deep
> > +               sleep states. The suspend_timeout file controls the amount of
> s/suspend_timeout/suspend_timeout_ms

Please also fix it in code.
