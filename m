Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BF5B1C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIHMOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:14:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A201D315
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:14:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so37621837ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PL7Z21/Ly2C+Bp4eRSpaZkiqNQbuppt5aGkuojHobXM=;
        b=N9sMda+Nhf3WqJE4vqboHjiASiuKQ9PH/ytFH6O36VQcL7JC4vwawFnkoMrT7TZXb2
         rEtHM11WmHNtUPJlSIkRrqk8NvUThA0754wy0RIYKH1DZGVgksna8qY0ELhpONKuvDZ5
         7YL3UZQSaRsy92iDhuxiT8OWNimVxoIZMk0rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PL7Z21/Ly2C+Bp4eRSpaZkiqNQbuppt5aGkuojHobXM=;
        b=2tVVN7vtvxHf4MnTrLy6BrYfsUCj4HoMZIUmUboZ0+URHAS06Egic3xKYbh8LFfziV
         RBigK0El+bGEOkJieEmsuJl/I3CYI2jeR7rU0BappzjEpDTVzwlvCQVp3NelyUoWY4eH
         hJrYiT/zuWhPM30i/2M2WR5yjni7bb5+JHpKhbybHGOkHh+sctlltGTRF7lz9/XMmidc
         I40LdoxdVw5Lk3Ws6+caYAUFdC0Ia1EpPHLlU6+O5+BXm9yIk5lGv/TcwDA8hnyW0ovo
         5LYkhcpXW1xRVi7VCAWnF4gxYag7Nu+9X2tzqQ6OREstwbkgIXiUxvHUKSafHr+oWidn
         6bJw==
X-Gm-Message-State: ACgBeo2NJvahlHaDZlHLgNn5pDJuz8ub5iESL5QzD+hA/uB0DV0nxPmk
        n6ZxSbZEafMRVQobdQyjR2VL3hKMniZBbvwB
X-Google-Smtp-Source: AA6agR7ecprAmgvLdUW/SzGggUp9fPZzxDI8X4YbcmETOiGBJjRLJPrC30RwZ61W/f+wfzIXCDToxA==
X-Received: by 2002:a17:906:fe0a:b0:76f:e373:d84b with SMTP id wy10-20020a170906fe0a00b0076fe373d84bmr5860220ejb.297.1662639278426;
        Thu, 08 Sep 2022 05:14:38 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id fi5-20020a056402550500b0043bbb3535d6sm11903043edb.66.2022.09.08.05.14.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:14:36 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id s23so10723507wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:14:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id
 i22-20020a05600c355600b003a6220e6242mr1953598wmq.145.1662639276233; Thu, 08
 Sep 2022 05:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <Yw8L7HTZ/dE2/o9C@xsang-OptiPlex-9020> <CAHk-=wgG=mttS-m2OLcnsTwia2roHR2b-DxXXG-tbDH8_cUNiA@mail.gmail.com>
 <0214b84c-71fe-2133-b69d-1e39a19cc468@intel.com>
In-Reply-To: <0214b84c-71fe-2133-b69d-1e39a19cc468@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Sep 2022 08:14:20 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi0FPu6E9sViTxaSmqxM=go+M+DuJpfdCW9f-1adpXUpQ@mail.gmail.com>
Message-ID: <CAHk-=wi0FPu6E9sViTxaSmqxM=go+M+DuJpfdCW9f-1adpXUpQ@mail.gmail.com>
Subject: Re: [LKP] Re: d4252071b9: fxmark.ssd_ext4_no_jnl_DWTL_54_directio.works/sec
 -26.5% regression
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 4:56 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>
> The test result looks good (only test with 72 process doesn't restore to same level as
> original result).

Thank you. I've committed that fix (with a slight syntax change and a
full commit message).

On an entirely different note, I'll just have to admit to my
ignorance, and didn't know how you prefer your name in the "tested-by"
line. For all I know, you might prefer the family name first, with or
without a comma. But I ended up writing it Westernized as "Fengwei
Yin", which seems to be the most common form in other kernel commit
messages, and in some comments.

Maybe you don't care, or maybe you care deeply. If you do, just let me
know for future reference and I'll try to remember.

(Maybe you don't care deeply, but I remember the mess international
"spelling" of Finnish names used to be when 7-bit US-ASCII was the
norm, so I _try_ to make sure that we at least attempt to get names of
people right in the kernel.)

I only later noticed that you actually signed your email "Yin,
Fengwei", which is what makes me think I screwed up and is the reason
for this note.

              Linus
