Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC859BD3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiHVJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbiHVJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:58:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6248AE5B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661161915;
        bh=AHjD0DvM8QxmU1Hawx6cTQsq43ntBX/baB6RCwWB3Ik=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ecI57KNqSePWYhwtVrWhM7CrHxqqvkFIa7eT2Ouoe3o1BcVXdk/hmXmtH36e7VAQe
         DQPjynBly6pN/zv/khvGwuVlVidi2/YdhzrkWZ7N1PtgkGY3N9MBO2smwgFQQEcepZ
         iL5o5c1DdTS4VXTK2l74sJ8e5j+S6tgRRSkbHa74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.199]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1os5cv2kW2-00T9UZ; Mon, 22
 Aug 2022 11:51:55 +0200
Message-ID: <dbde377fbefdf77323e00c6aeeac251273a8a36c.camel@gmx.de>
Subject: Re: regression bisect --> 88f1669019bd " scsi: sd: Rework
 asynchronous resume support"
From:   Mike Galbraith <efault@gmx.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Date:   Mon, 22 Aug 2022 11:51:54 +0200
In-Reply-To: <b64ae172-505a-fbbe-688c-d2d7a713f9a4@leemhuis.info>
References: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
         <b64ae172-505a-fbbe-688c-d2d7a713f9a4@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NxS+ZUUynD02baWKpjTE6IrxUBCC33iDY4jZzY/AWtkH0b9i3Eu
 XK0CbcuKzLH5lAIwRl01V8sHAahGbA3W/VAMm10hki+39yOWT35awi3kQs60W1qcsaQ6QqT
 kTQy/KdPehh7g4wfiISi/ruSrYOLu0sqLNMNMLOCdAFQJJIu+01gfK9e+kV2Iog2FH/Fx6o
 Y5tYwHnjpVKFO7dRDiNcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrufr0dxUEw=:yFKQ9DXfL/H2EjWFH9ZQFb
 9Op9jKcDTzGdKpQGKEkrbY5KY3COXUcOTK+ONSRtM44WyeFvPoZkPlPkUzW00Lo35RoEMU5EX
 0V9xhfWMLwFEDifm+o9yV0bfzsQQfLOr5/wCzj7YnmvNXH1GukubiqobmkLFqOnPDaflZRNZM
 r7tFb0Yl5dC3NaS1fnFVlNfiqI1NSQ0/5c+59YvxJdwd56clikBOJuf1BPX1Ub8HrJ2cNwIa2
 gz8fURCys3TzgfYi+IJqNPirTFp0rF/GRQpKvX5YdM+8QJwT2rtqgWvtl7ipQgzfusXejvPnk
 oj0+I9ZqYwmlyHEhvHQvSRdlO611ms/lUNSB5VsepV8zO1GFfzj0VE2cNnhwuKgpHEZmXpGfc
 Ekkcjbi3/wfPRdK61B4VG1XuAIh5Hm1XdhPP65ryLN3geJJ+qx9j9ZaoHvXEmBKZDqs84RVST
 f8P53y2iPJWklB+Cgs1p07V17r/+rq5lh0Hy9FxzIGFkkcZta1zIpxwdbTbV3Hv86LtAxSfOF
 JQlfXfJv5MZTtyHExLNLjXpsh1VWGfjNm/tgZYiyKeYx0GffEjNWePPZNFajrEcV+JgsMwGbP
 U0apGaGR38FTBRgK+j7ZGeZMRYPaxS078iQidyGbkMk7EtWtUX8FTk8tcNq7IPCbBcM7GMHd+
 srvWVrh5rQZfqPvyTHgwusSVwSQFw0FVKCTiFDJUp09/f/08MaanDfLQKfpZ/EoqLKhYBWcxj
 UAPqY//ARsXLjuPjC41aSNgQyV0q7WeXOG7aBYSR89HJG5AgLEhwz4JmNTKR7k8POyi5DjV7W
 NMjkuFkc1822kZPbiCEWgXY8zc4DSttue7WMsfuajJS9CalKatYT1C6hi55zI2oroGvi7eXoi
 TZirWhbUPB+ywdah0Ee0rl2XrIT/PrjVAXHLTnwr+PxjeoDjL7HWtXnQXQf7/PKckSlA25qRM
 10zEINYUEkw+6So+owNztcgkf12MhAZeufDe5Jao2JMTqIBr3CzcLp/0xI5hWPdALD7BcR3yK
 3ayBtXe2KjuRVH4TfT1YEFtNEqm80smAx7PrZpu5rUmKcatcmf4IZMvCmFqAAwmUTk23hKtxt
 WA43YCJBoSKLEfayXjdIzzgLntF33vd56GKMRT3lYQhzJRovDtVgR7hAg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-22 at 11:11 +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
>
> On 21.08.22 09:34, Mike Galbraith wrote:
> > Greetings,
> >
> > My box claims this patch is a dud for it, symptom being hang during
> > suspend _after_ a successful suspend/resume cycle. Revert at bisect
> > starting point and now HEAD (15b3f48a4339) confirms box's assertion.
> > [...]
> > # first bad commit: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi: s=
d: Rework asynchronous resume support
>
> FYI, in case you missed it: there are multiple reports that this patch
> is causing problems. A revert and a partial reverts are discussed:
>
> https://lore.kernel.org/all/20220816172638.538734-1-bvanassche@acm.org/
> https://lore.kernel.org/regressions/dd6844e7-f338-a4e9-2dad-0960e25b2ca1=
@redhat.com/
> https://lore.kernel.org/all/98592410-dd31-9081-86be-fda67d3b06d2@suse.cz=
/
>
> See also:
> https://lore.kernel.org/all/ecf878dc-905b-f714-4c44-6c90e81f8391@acm.org=
/

Yup, missed all that. Hohum, tosses bisection on the 'dead bugs' pile.

	-Mike
