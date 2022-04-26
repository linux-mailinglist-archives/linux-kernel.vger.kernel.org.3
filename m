Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF273510A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355063AbiDZUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353740AbiDZUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:25:35 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C056506C3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:22:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 794575C00F8;
        Tue, 26 Apr 2022 16:22:26 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 26 Apr 2022 16:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004546; x=
        1651090946; bh=U9DAiEYbrUd9tFuzbQeFQ00nB7pzlike5TcMqRrzras=; b=y
        C+vjIVy2d9e7Sp46ooWs2Kf2JARy6m6H0M3Xd867jqFUFrWAub+aj7SmwPvDRvls
        1DHyHII593Q4xvg4Xy2tMprzaDtRY2ZkIFmeWOhKe0+MFXAVSJfxQIEFXjaer0yQ
        41QVqTL3P2wgPbde/8FgEnD/EF/aCeXOQp3Ip8ZxHT8TS21nm9z5kIfGiKZRifau
        JbQgApmxegzLS83kaQkNkL1STmnPP3YkFHu6D8Yvi1Jk0HnSuQvAEAgykmKH5uGX
        oEDZY90QlHxxv9EGEH7kGoNXBg3FNYrTS0NCYQ66bDNivt71VkzjkvDJZg1xa44z
        qc8ULf5+Q02xvSWoh799w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651004546; x=1651090946; bh=U9DAiEYbrUd9t
        FuzbQeFQ00nB7pzlike5TcMqRrzras=; b=j+A319KTz1azrMQcygW79Tcn4Ddw5
        mZulvNtYgdmTUoanzc5l51g0ypyiFKmJbgBQ7jTvgwemimfZhnt+8+M4aNyCPzoh
        BraX414CEZ/UBPmHexd9g75WKbpGdaqCTqJ04YstqKUTpYP3KEMl9Q2adYVRN/sI
        njmyc0Ocdkr448o9YI6pQrRl9u4zPNbbBkZhnOi6bsMS052eJ3JxbY/So1rgNaHG
        y6NqX1+lmlNgO2/oG3bBcLtxWCdaP88KRnJKHgeoR6hzP1K7DAC5lqxc2W4tU31U
        JYeP6V17IpwfNz2Z1c7TNDTrBBAXSoUwDJZSqYZVe4IYh3KIELKkHoT4g==
X-ME-Sender: <xms:glRoYmodjwDNvmGDa35FjUFlQPXq83CoAqUbnSTt96mWpQ_18fpNqg>
    <xme:glRoYkreCiM1QpemYhhbqyZRBp7FQBuvt4L8qd0vqXS4nM6BVbNQCfGVAcv0BS7Lc
    nrTbkSRO4t0anZL9pM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqmhdtreerjeenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpefgveevteefveekteffhfejgfevheetffejgeehgfejfeetledtjeeg
    ffejuefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:glRoYrN5775Q-CR_QU48q5IRHrJ9ByH9CeEY0wHccIgLvtlKC1_Cqg>
    <xmx:glRoYl4PNSOrAJ5wdxdaS7y93-L7fzKw9FZj6KJmdhlJ4TQ_viHWVQ>
    <xmx:glRoYl7DUZRp-zsynnA3WOms__9DpU4DwFH8QBugJFUavUiMyHM0ZA>
    <xmx:glRoYvk3RVBa0YdwTyM7xGUQC8Rc7dB0MBygEbsTkqlEqQrbcFNG9g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 014402740386; Tue, 26 Apr 2022 16:22:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <FCB9C443-0A57-4E8D-AF13-A61F80861A4F@svenpeter.dev>
In-Reply-To: <20220425090826.2532165-1-yangyingliang@huawei.com>
References: <20220425090826.2532165-1-yangyingliang@huawei.com>
Date:   Tue, 26 Apr 2022 22:22:05 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Yang Yingliang" <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        will@kernel.org, joro@8bytes.org, alyssa@rosenzweig.io
Subject: Re: [PATCH] iommu/dart: check return value after calling
 platform_get_resource()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 25. Apr 2022, at 10:56, Yang Yingliang <yangyingliang@huawei.com> w=
rote:
>=20
> =EF=BB=BFIt will cause null-ptr-deref in resource_size(), if platform_=
get_resource()
> returns NULL, move calling resource_size() after devm_ioremap_resource=
() that
> will check 'res' to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
>=20
> Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven

