Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70E4ACFB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiBHDVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBHDVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:21:16 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 19:21:14 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C5C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644290473;
        bh=W4Q+yNoZLcEadH7nKADIjZEALbNNRjNzktVW60BEcl8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HT2tFi7kYQwaf6lGGxISkHfRSMuHvqn2NAW35gZ8eO0qo/Um5MNUG+WuHIvGJHFvW
         uTt69EgYYCC/y2+T2Iz65QxSyu9+zQXylnVfFQS02HnT3ucq2S42KFI7asPYLF/Pzo
         nG0VujFqvds2+zXFiEr8LoCWCywPcKy2u6ioXZfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.251]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1nW6wm2fNG-00EswO; Tue, 08
 Feb 2022 04:16:02 +0100
Message-ID: <83f59bac8286f3348d4c7ccdd93d1ce1ad2f06c9.camel@gmx.de>
Subject: Re: regression: LTP isofs testcase failure - bisection fingers
 "loop: make autoclear operation asynchronous"
From:   Mike Galbraith <efault@gmx.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Feb 2022 04:16:01 +0100
In-Reply-To: <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
         <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pi7c7Bt/KGRzxamZhlE37B3BVuMcE0BWd1gh16bOF9tQ+pCnOWL
 SobI7n7aU+y6ssJAhT3HEszk0RXg7SsUi0RAKedM0ms5iUTnXyR9U+w/O33/326hKu4f0qA
 724yikACR+l1Dc80B981XGcyfQloE+wwtbJBNx8boNb9T/EXth3d58r9S86sr0FF12FlJkt
 REUYB2LMIoWAYmc5gvo0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gavn2NmWmyw=:DjMMYXS9CXAhUYjg4Z2IJE
 H6UfOyKPsV6T7gESqQwGHDVhyLrr/f8OQrdoA7FzYGHNQ1V43y1nvDfeYpSG+9I/BG5iWNESU
 AhTFU1GUuSy+RLFrUdG7YSJWrugUXdMPNDf7gBM0sJE/zXx/sml+d81LPQdAtONJf99NdmBFy
 r5CmNbFTJWk6/kkQkgHRe/SOUPNLDGBamndY7LPiL4S7HL4uFBP4IqW8YER6qjziasdczsWgz
 gcn03FPImAVipwroLnrJZ9IT28QNXIv/jXDoxxSk2j7S/3n/6b9LWneDjykZv2f12tSbAzabH
 yXo97Ol+ovZyU1U4kFZseB4laNw04QqYhayEmWvU4xt6VlX4h27mxdGXFW3wOv8F7AWFR6fUA
 Rrpk1Z4z08QjfNGN238YacsCUUBtPqJsUj5IhIunleLixm4INPvV9yEb46MoSI0ffYb4cFfe0
 KU24g0/0ozIf/jLA3DW30tInX1SmOzgMAO6ysAfMczhwsf3rxL0cp/sXUd5ZhLGpYEmMLhScY
 xSM2WQ1j0DPK7baMwcFVLaO9SlJj14Rn5tz9f9TkXcxTNQhiNk/jTjGAXzQReT0rkT/oTqsw7
 GUmdNHxd+MJgGL8urzxg/O+X483fXugbt4XT1+3wuS/zm4WnE00vJrWpd1EmNzFd/o3KRSVnU
 rNuktBIO7lWL8ZsBlWYZGZ4Vkz8SzSWZXS/bG2nBoNuFpxz9QH6MqQXL0N/ZCftcQH2CHWbuI
 eZbQ8GsS0Q7tTmeIZ2QGUKFaqAxStHs9v+PWXIf4WdQa/yeSODKs/3toujkHGut7utgiBm+E5
 SWq+SChmg5hLTfeo79E/X53GyCAXiHhRLeLbJR+M99kUd5szdnmStgEI+F/wdPsC3PWLfz+Hd
 aePgsI/B5pS5gQGVrMaTPTLDr9/aIa3o3U2p+C54WVncW7MdIxsgV2x5FFeoBk8M44+XDgcVu
 r9H4mtGKng7Tb+egR4q195exHs+77Q/hSFwIpfYMRGhskSmHNf65dNLki0IHQMjRAxNU+IKVV
 s2yBhvYQNvK0JcDvWsyRCzPn8GUvykD6In5FJhB42/CKCmMRHqNz6XE0funSNIQS6UX/JUL3r
 i9hFkpXyMRz34E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 06:57 +0900, Tetsuo Handa wrote:
> On 2022/01/18 0:34, Mike Galbraith wrote:
> > Greetings,
> >
> > LTP's isofs testcase began failing this cycle, and bisected as below,
> > which a revert then confirmed.=C2=A0 Full testcase output attached.
> >
>
> Thanks for reporting.
> Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f0da-=
8878-12264bd48348@I-love.SAKURA.ne.jp=C2=A0.

<legalese-disclaimer-font> ping
