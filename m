Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD14502BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354426AbiDOObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiDOOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:30:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3CA66C2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:28:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EA765C004D;
        Fri, 15 Apr 2022 10:28:30 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Fri, 15 Apr 2022 10:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1650032910; x=1650119310; bh=5l
        m0diIP9ieTGp9XEJrpPEXmdf/lB1SHrDoovn9aIv8=; b=k0nC3rM1eNEU89aqyn
        6/O8pQom2q3VoLVUxyc0TjxqLbya+e3lItDAuSFw6eXP9dLsBL90ngojHOcsnqWN
        rsIPttNvwTwhujf8ype3CO/7nMwrHYwlmsdHUNK1DGGhP/q4JMMpIT5vVaHYUGtx
        R3Y9Nv0ao7ZlEgrdgWGSVUy7hzP7PVjmtQsjIg6/b0m8qlEOOW4FhXmWOupCRFwL
        eM4WKTrkqj8IVwmJ6nRy6NPYHmJ+3hQe77PXppvdin48JBg9J15iAUsYxikCenhi
        TKDUBUwYegdJdAfWlfKgyYVZjBmVoo0pL6EneLY+OTNuXtSbNN+ND0D7JuEGtpke
        kAuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650032910; x=
        1650119310; bh=5lm0diIP9ieTGp9XEJrpPEXmdf/lB1SHrDoovn9aIv8=; b=e
        ijrk6Wkkk3qcNjTT08Mi2CTCr6PI56SzLkjALzUNWkDDofQKVQsGQ+1WFImpb3yG
        EFSs3KFaUgz5TwFxxk0bBp734qMoJEVoRS2CUsDaP/5HrlHfu+821eW4HyIPy8Zg
        bn+VQ3K/NxhO4wYnuPvulAoyUMUty6DQhfvfCHoV4Cs97bxlBoPuHpQlFnIPrQZb
        NOtVGcKxvQcwNnfATaIWnygEYYoE4CpnhjQS2V31LRj3K+J4RRoHK1hOdBoINpmR
        ShM1fpw86kdFP006oIdVN2qMje/kOq955jQFyklRYQtof5WLZV8emfvEnk6MBdxr
        H9tBStXYuIyf7jj5ovhOQ==
X-ME-Sender: <xms:DIFZYq5lYwIBoRvQ8dSpA-AolTJy5FoSyrjUgWUExfenrMwjcengwg>
    <xme:DIFZYj67Cjr6__H_KakdyYGd6BzLjKiHfoIU0DSPqBJ0Cr_h9wW7MUnpguEyaUGm6
    FvAgTD_pZFIRZPNbBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:DIFZYpfFU7M4PKuXP8zuPPolHy5nsmxeEOLs_OZaq_iolXEvsqaDkg>
    <xmx:DIFZYnI3SPwUOg0yzAhtFFctyL0oHoWwQiuKWlziFp2sAol5yH2NTQ>
    <xmx:DIFZYuLL64GzkvIPiRk4YM6fixhRYIxNbJ66sbQTAZfVeHTxcaNbSQ>
    <xmx:DoFZYgCNKeun78FQd3agXAF3s-f6iWuXExEaevTtWRPXYolhpxrn3A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B8A0E27407D3; Fri, 15 Apr 2022 10:28:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-387-g7ea99c4045-fm-20220413.002-g7ea99c40
Mime-Version: 1.0
Message-Id: <f0c6c688-c3d6-45fa-8b0f-180faa4d1c46@www.fastmail.com>
In-Reply-To: <36df696dacfffd52e79b471572de9893b52ad0d9.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <36df696dacfffd52e79b471572de9893b52ad0d9.1649935679.git.robin.murphy@arm.com>
Date:   Fri, 15 Apr 2022 16:28:08 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>
Cc:     "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        mjrosato@linux.ibm.com, zhang.lyra@gmail.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Yong Wu" <yong.wu@mediatek.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>
Subject: Re: [PATCH 06/13] iommu/dart: Clean up bus_set_iommu()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022, at 14:42, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>

Can't wait until that saga is completed :)


Sven
