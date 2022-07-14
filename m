Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386A6574C46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiGNLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiGNLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:36:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA6C5A2EA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:36:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so2879806eju.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAe7CR3aBt//X7F7s83Xjr80zWOsV9ZSFNF9Ucd5AnE=;
        b=qXgK0PLEfR5/frZuyQG2DX0oaYNO+qypV53s8Ikentorkb9v9QpEXBQyoJ29H4nfsx
         6a+VlSP3jZDfGFgpxYrQL49FNTadjrKjcQqJPwxxTNwX6/AkxFjcmtD80Uw7ZA8vl82d
         QwpeDwmbZ3ed1rn6aoDcVwRrdGOa5WlAUQ7p2YPSFkv1FcNA+7W9bpiZ/Dcz9XbRuuld
         4Zfk4W8ODnbfaW1qple+LP1KQmDVrqIsHbhyp3e4XTIxu4kRaKkouVxKG1II6joZmWCV
         3f6Ln8SGTBQwOxUPgvSdHJA6wIHF7giQT0BxMrSV9G5rwh5vCTNSn9OWuJUEk8ze7nBN
         7qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAe7CR3aBt//X7F7s83Xjr80zWOsV9ZSFNF9Ucd5AnE=;
        b=GfzeG6Wc/JAPQIAfH8r4kpKIin/PPvyYJG9/KLMslhfJ1BjlMyBuaZgkWCWOjXdugw
         q/XWz/1c1GrJmj1S+OrKumDofi9R4GUkDQqKlQUyseV61DbH35VZGZ1itJPznIKpqKK2
         oetxj0UJN/O0z1gqrUDyetEGGgBrjig3xDtBkLxahn06hg/AM+hhAN+DJdM1u4AZEuJr
         tvNNLggY7vvlL7efijle0gw67eTMuE229y92umw1rKaS76rtopMqJX4TDaSauRJSAF4u
         GxIaK6XhyF5ISQvkM3iLPGa4GDtvmyt2SU8KhKXiWg3DORfyqMkfDLc2d6wBIf9Kn3oG
         EYMg==
X-Gm-Message-State: AJIora+qQM0E2jJlOaituBPwNBpqSKRGxX0md1Wlt5A1+zOFqSbb8rjn
        1yUNcn177Yh/hdOaU3VsYSq6fwBYpi/Ce3gNBgzqx0Wagiwosw==
X-Google-Smtp-Source: AGRyM1t033JP7+FCHOjb+QVn2mD96BNzK1O7Aw9VCdtpw/AOPa5UhYHhbP6TiyZsQOPpEjs1eErNp5h0ijuIIE/axKc=
X-Received: by 2002:a17:907:7f1a:b0:726:2b37:7b82 with SMTP id
 qf26-20020a1709077f1a00b007262b377b82mr8167769ejc.366.1657798564434; Thu, 14
 Jul 2022 04:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuxp2Ge1JGwuXase633r8_7zPZkxrD6doCKi6aYY3mfPw@mail.gmail.com>
 <ca41951e-e662-c4ba-eb78-68ddc77cba2b@arm.com> <20220714082212.GA30886@lst.de>
In-Reply-To: <20220714082212.GA30886@lst.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jul 2022 17:05:53 +0530
Message-ID: <CA+G9fYvKHDqghKAWy_8MP6+hTXmQqaoTT_STT7v74Oh+G6hKFQ@mail.gmail.com>
Subject: Re: [next] Kernel panic - not syncing: swiotlb_init_remap: nslabs = 0
 too small
To:     Christoph Hellwig <hch@lst.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, conor@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and Anshuman,

On Thu, 14 Jul 2022 at 13:52, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 14, 2022 at 01:50:02PM +0530, Anshuman Khandual wrote:
> > 26ffb91fa5e0fb282e8 ("swiotlb: split up the global swiotlb lock")
>
> This has been replace with 20347fca71a387a3751f7bb270062616ddc5317a
> that should fix the issue.

Thanks for your inputs.
As per your suggestion, I have reverted those two patches on Linux next tree
and built for arm64 and the boot test successfully.

467f49f87d84 Revert "swiotlb: split up the global swiotlb lock"
2706e93f7f8a Revert "swiotlb: fail map correctly with failed io_tlb_default_mem"

Boot pass log link,
https://lkft.validation.linaro.org/scheduler/job/5284375#L583

Best Regards
Naresh Kamboju

--
Linaro LKFT
https://lkft.linaro.org
