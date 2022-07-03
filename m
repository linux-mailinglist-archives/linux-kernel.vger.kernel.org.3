Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1145649BC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGCUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGCUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96D81150
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 13:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B046111F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A12AC341C6;
        Sun,  3 Jul 2022 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656880762;
        bh=Ot5RZGbRnE1N8ktpzcURyEz71uTVVDBhfE5in7dP34M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cJs6nEH/fo2oh19/S5CB0GYiScyZAH/HRZSNZdx/NMQjDp6MM9H316avAFv80L2s5
         SKla+tU3ZnhIf8mC6Z0qh+qL/Y2cE8maW2GgXPwLYe4mWKqsJb4eE6a/MQcLH125pZ
         ZYT3bki82hrio+IF4xseN5Bh/XF0MBVW441SKMNo=
Date:   Sun, 3 Jul 2022 13:39:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
Message-Id: <20220703133921.6800bf1e7df3b00cb586a3c1@linux-foundation.org>
In-Reply-To: <6a4ea3d21bfb4c692d257d3f38ba28c83f242dfc.camel@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
        <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
        <6a4ea3d21bfb4c692d257d3f38ba28c83f242dfc.camel@svanheule.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jul 2022 09:50:51 +0200 Sander Vanheule <sander@svanheule.net> w=
rote:

> On Sat, 2022-07-02 at 13:38 -0700, Andrew Morton wrote:
> > On Sat,=A0 2 Jul 2022 18:08:23 +0200 Sander Vanheule <sander@svanheule.=
net> wrote:
> >=20
> > > On uniprocessor builds, it is currently assumed that any cpumask will
> > > contain the single CPU: cpu0. This assumption is used to provide
> > > optimised implementations.
> > >=20
> > > The current assumption also appears to be wrong, by ignoring the fact
> > > that users can provide empty cpumask-s. This can result in bugs as
> > > explained in [1].
> >=20
> > It's a little unkind to send people off to some link to explain the
> > very core issue which this patchset addresses!=A0 So I enhanced this
> > paragraph:
> >=20
> > : The current assumption also appears to be wrong, by ignoring the fact=
 that
> > : users can provide empty cpumasks.=A0 This can result in bugs as expla=
ined in
> > : [1] - for_each_cpu() will run one iteration of the loop even when pas=
sed
> > : an empty cpumask.
>=20
> Makes sense to add this, sorry for the inconvenience.
>=20
> Just to make sure, since I'm not familiar with the process for patches go=
ing through the mm tree,

Patches enter -mm in quilt form and are published in the (rebasing)
mm-unstable branch
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.  Once they have
stopped changing and have been stabilized, I move them into the
non-rebasing mm-stable branch.

> can I still send a v5 to move the last patch forward in the series, and t=
o include Yury's tags?

I already added Yury's ack.  Please tell me the specific patch ordering
and I'll take care of that.

