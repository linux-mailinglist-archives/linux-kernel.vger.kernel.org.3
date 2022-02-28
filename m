Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989134C65B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiB1Jch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:32:36 -0500
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net (p3plsmtpa09-08.prod.phx3.secureserver.net [173.201.193.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9C4504A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:31:57 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id OcNmnbFBfQCatOcNonvxS1; Mon, 28 Feb 2022 02:31:56 -0700
X-CMAE-Analysis: v=2.4 cv=e/XD9Yl/ c=1 sm=1 tr=0 ts=621c968c
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=S43n_5l8ym9LK2i3y9QA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Mon, 28 Feb 2022 09:31:54 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Petr Mladek <pmladek@suse.com>, "cl@linux.com" <cl@linux.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Message-ID: <20220228093154.5gzs3ega23l7fwks@ava.usersys.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley>
 <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
 <YhisWkgZCK8dz5fl@alley>
 <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
 <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
 <aad10c3f-ecaf-c8fb-f1c6-81ba6f1c4f8d@csgroup.eu>
 <YhqNRoEgIaoplF9b@bombadil.infradead.org>
 <5caa95d8-ba59-30f3-198d-b67389817762@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5caa95d8-ba59-30f3-198d-b67389817762@csgroup.eu>
X-CMAE-Envelope: MS4xfESUff6nWYa7Ksm6NruKAT9vm0WUgWzufQx8hs/XKSb9YwlNTl2UkwkSVCMIPBXwnxqnq86f+RsK1yEoSw4M/o4McfBmKmPrrbeRpheSaSGGzmxXjvB5
 0SpiYz266irMuxGRHc2AqYTdJI8o27WHO6zAYZimTiEX5hVN8Ak241GbDAiiQxC7Mg210k+Y620DAbbm2sazGt/vuqSPWNPfLRIbH6Fb9MU8SCrJ7qEQFvyN
 4KqOatO/8gJDwE7gB1w7T6Oov5JeyfIhmxfbL2Tkb+5Ox9nl5gp9KXtb9Cxtoj8Cnfgg4N7JTqjke83FnwVjwvrbuGRfXQL4cW0Rifap97PyqnD3oG9Ylakp
 M9gvUfRYXztQq0zfcJXZpfIRP96cyLFTSBtkNge1SxOwtbxqXbGFUMYBSxbaCIq1KsOrqrFmBXANednl71kNa+3Vb84lUO69Vj9EUzJyranXGoN9K0IS2MYJ
 3v3Pd0Eq1q/T8E51eHG2p8qNrZ0N0iE27POxV0Rmiif4O6UqnIVqccV9rjibioyMriIccjf5WAnxJCSNfB70m0D84kJfxyaU4ugoI0dna6Jdqh0FCmN9kz0N
 nc7sYSWbQQC5R/BdEUg29tj1eL0n4y4cbTk0s2qSQDWDcA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-28 09:02 +0000, Christophe Leroy wrote:
> Aaron, do you plan to send v9 anytime soon ?

Hi Christophe,

Yes, today.

As discussed previously, I will resolve the Sparse warnings, in the context
of Kconfig CONFIG_KALLSYMS, with an appropriate statement in the commit
message, as a preliminary patch to the series. That being said, I believe
it makes sense to include the aforementioned patch within the series.
Any objections?


Kind regards,

-- 
Aaron Tomlin
