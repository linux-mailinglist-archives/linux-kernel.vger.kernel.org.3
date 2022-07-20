Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1328C57B6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiGTMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiGTMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:47:34 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9851B7AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:47:33 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 217432FDF2F;
        Wed, 20 Jul 2022 14:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658321250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAYsArRBBzVehk6i1de1HOPaI+3iM8rWMPZa69TRJyE=;
        b=tW0Bli4pdbfLpsA1kLIiFRlnJiVJAxIC+ST2pzND+hgOg3fZzYw9BK732p7IMYByLyRCAa
        TbSYiG0TdWURfNbU5wGRdt9t3wrlv84YyYhFXXtJR3tdtcydGfwqfu5l4czVp1Y8Wmf7yD
        mGh1pVoZlwIcNatYKDvI8IXUCKTrvOawe/ZsrgMFszByiF8Kax5ZK7WIt2rZO36ZI9StEI
        1hh0xY/JRzOGDHieqWEawSg8qYLUhdZhVxDts3Vv+neJaUJdQQq4ILk252uPNLuZtaknVG
        6U2XUHuFIWKorlL9bL/FdWGYK4D0n6MwPLJvWj0hsGBheBFGlU5c84aUmM171g==
Message-ID: <38c839001bbd10f58d12c64d78b5f310ee55f9aa.camel@svanheule.net>
Subject: Re: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, elver@google.com,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, vschneid@redhat.com,
        x86@kernel.org, yury.norov@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Date:   Wed, 20 Jul 2022 14:47:28 +0200
In-Reply-To: <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
References: <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
         <346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2022-07-19 at 18:31 -0300, Ma=C3=ADra Canal wrote:
> > Add a basic suite of tests for cpumask, providing some tests for empty
> > and completely filled cpumasks.
> >=20
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> The tests test_cpumask_weight and test_cpumask_last are failing on all
> architectures, as can be seen on [1]. Also this test doesn't follow the
> standard style for KUnit tests [2].
>=20
> [1]
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220718/=
testrun/10865066/suite/kunit/tests/
> [2] https://docs.kernel.org/dev-tools/kunit/style.html

Thanks for the feedback, I wasn't aware of the style guidelines. See my rep=
ly to
David's message for the issues with the cpu_possible_mask tests.

Andrew, would you like me to resubmit the entire series, or can I just send=
 a
new version of this patch?

Best,
Sander


