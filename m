Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0B5B1ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiIHN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiIHNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:25:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB898773
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:25:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 14B625C00E0;
        Thu,  8 Sep 2022 09:25:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 08 Sep 2022 09:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662643541; x=1662729941; bh=gY
        1SWywSbeqL1ZxBzUPSUoPO0D7KLRt+vB7M8GKgOOs=; b=OGzXvNCfi9k5EyTrtc
        5LTPeuoh0+VY/JRG0/PMY/K/ePIMcom92t5S0oVtzFF0XM+z3nE/VIUp51Wq1gEa
        sCVYnY1sVoauz98t/u6fMDgNqG/x81gfQ5IfE3beomc1PV3OM/lt8Xa6Xm/lL0qL
        u/KGzurRLZ+GykVLlejg4g5WSz5jliUivPoNRN4+2neIUejxig8vH6KuJatba/uA
        Ywa9MbpJkkGb9ujVG8oqFBVg5woFEj63NEjxALhByWAKuAswVsybodJF4fHrQXb8
        Pw1Lp0oleVuKzDx50Tp35c9esgoYyrswOXm95Im7D9AOpHPz00gsoKi7nAgAwYmR
        i1Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662643541; x=1662729941; bh=gY1SWywSbeqL1ZxBzUPSUoPO0D7K
        LRt+vB7M8GKgOOs=; b=dM/71gWgQMtuTcsckmy8ldsCTgrc4ije2/ONvgEvSh8W
        ucOOOaNkL27mriN95ZRWwbcihbIVvE7zuedx0J7Z46qOAZzn8h2SCE3H0hpVj3Zx
        mvwETvYkA5PfhhSzFZAAS+kVzHH/6vb2B1BWKZGM8hDdf+zVS/IWJakK45DtyGnh
        vNxEEMZ6i2JpSd9wAv+lda7EpfvmA14DorERJPFlWNlELDk9D7wkM01sqPaGXh2+
        1mBHM+Wl2CtGR1CjN3te/6JiuqU83ISzO8aD8dE5h6NXjziYF7arfRbtLftHiF7o
        AxOMRP+ubxcMRbR9GA2XALWZJ92dSi8XTpVIonVV0Q==
X-ME-Sender: <xms:VO0ZY3TCTYnGPO0pj2nTAGp4-CH0MBwoOmHYGchSHxfmO55E2w3O-A>
    <xme:VO0ZY4wftnWMfTzRFOqzL5dVufKB5mxn0IOe4XtXFa1kO02wDI8i3OCtJ6CuM2KOD
    5HDVkjqCiYzBB1PeG4>
X-ME-Received: <xmr:VO0ZY82OUzP64PDsa66EInXuo_7CO2dNT6O0F3T58eCpbwntvV60evuFQzWBhfhkpm_fzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:VO0ZY3Bnv5yAL1UecmZfXp7tqOdB0tCTE7xFFE4L4qau2rvoyGH9IQ>
    <xmx:VO0ZYwhv8WtF-rD0klCt5V_7PDF-3sC-cXEAzYuUgEAX8cQVF01hEA>
    <xmx:VO0ZY7oS1Ku22ycW_-z2Ar7KPNnYzQ6UxzkIpp6B8GAveL-HFxu__g>
    <xmx:Ve0ZY6Y9xZ4H_A-1B-b7j-8pXiPYT0gXgTriZMAxIWYtG1QPkuoZ8Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 09:25:40 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 376081037A1; Thu,  8 Sep 2022 16:25:38 +0300 (+03)
Date:   Thu, 8 Sep 2022 16:25:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
Message-ID: <20220908132538.kjqas6q2i24mrsug@box.shutemov.name>
References: <20220908035533.2186159-1-liushixin2@huawei.com>
 <20220908123102.rpihrmisv55j3b2o@box.shutemov.name>
 <84a82033-ceb5-d8a2-3bae-a31574a5ff28@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a82033-ceb5-d8a2-3bae-a31574a5ff28@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:07:04PM +0800, Liu Shixin wrote:
> 
> 
> On 2022/9/8 20:31, Kirill A. Shutemov wrote:
> > On Thu, Sep 08, 2022 at 11:55:33AM +0800, Liu Shixin wrote:
> >> If two or more threads call get_huge_zero_page concurrently,
> >> THP_ZERO_PAGE_ALLOC may increased two or more times. But actually,
> >> this should only count as once since the extra zero pages has been
> >> freed. Redefine its meaning to indicate the times a huge zero page
> >> used for thp is successfully allocated.
> > I don't particularly care, but it is not obvoius why the new behaviour is
> > better.
> The user who read the value may be more concerned about the huge zero
> pages that are really allocated using for thp and can indicated the
> times of calling huge_zero_page_shrinker.
> I misunderstood when I first saw it.

Please, explain the motivation in the commit message.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
