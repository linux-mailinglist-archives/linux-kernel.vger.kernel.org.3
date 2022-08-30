Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E75A6AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiH3Rel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiH3ReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:34:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49232A99
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:30:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f4so11264829pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YQ8ZcpbXRjUN1AF+PorHGIrk4GnuSWoX8YJ2o7FF8qA=;
        b=e7cMo785PTbK7lQdEBG57/gp/Ipq1BCKVCh1ENIlKVPAr+BYXoS4rDG2wsGGbBey3p
         eNKJLDnb5eg3GNHnV/ST9qvvevVcnoXr1vIIeGVn8USdr0bPIJxl83j3yzK40VNlQnHl
         rzrf58riSAvaYykXGoY6MevmEyT2jHsUfCg2yAddhRE7t2qiuR10DKSK7KPVPC4hbd/w
         9IfFKWUvIbcCEizv+7h4CwiR/2SGHVZTDlyDneaMxhBTflzZhFoMfM163EpS+sneyDAC
         YMNsTJi2sDBUp2VkXt7/EoE1e6P7Gj6fAnc69RbT+XAtYdhiR2F28yNTTIESbHPLD5Z3
         HqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YQ8ZcpbXRjUN1AF+PorHGIrk4GnuSWoX8YJ2o7FF8qA=;
        b=tlUsa18Px5HyTAqyBlee89iG0DqA+2bySTLgFD0m+HT/CBGnAzy5M33E8F14coiYTY
         Evq5XhLXxpZYcmguzd5Ic9w+Lzd2jZIgh5n1A+DOH0Dwgh73SZxue4h4H/CcyRnaBQL6
         0fwRgZbZ4R74Q2VRsbNdNFN+czolqx2uvm7C9cDpIQOx6+2KL4zGj1O7jG7GVBavWOGT
         74Lw1X0pcbkK+L+K/9p+vbaEeYOok0cizCDexT8oamWxDkg7B/we92H6KWccXvt/C1G6
         vXuLhs7WPJGWBuVkQxHK3rUivFJ+KtnSC4TDIJ6OtudWbV+c9QaV+ek8ezs0zLXDKraO
         LFSA==
X-Gm-Message-State: ACgBeo1lYbG2uxlOosTW8VyvSjQji2kP6A7FwaoWVfVaCj79LDIfYYmD
        C4GkuGPKXgsbnDyDOu7KJ8DVQQ==
X-Google-Smtp-Source: AA6agR6ahQC3OgKadAHRpGKGebHE8Y2/JSHi4S1bjD4R//knQWK67U9OFqK0gXSTU9JortNXulmakQ==
X-Received: by 2002:a63:8143:0:b0:42b:9e2f:548e with SMTP id t64-20020a638143000000b0042b9e2f548emr13267763pgd.548.1661880544516;
        Tue, 30 Aug 2022 10:29:04 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a290800b001fb398e5e6esm8754499pjd.55.2022.08.30.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:29:04 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:29:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/8] x86/pmu: Corner cases fixes and
 optimization
Message-ID: <Yw5I3P4Vs5GGBtuJ@google.com>
References: <20220823093221.38075-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823093221.38075-1-likexu@tencent.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022, Like Xu wrote:
> Good well-designed tests can help us find more bugs, especially when
> the test steps differ from the Linux kernel behaviour in terms of the
> timing of access to virtualized hw resources.
> 
> In this patch series, there are three small optimization (006/007/008),
> one hardware surprise (001), and most of these fixes have stepped
> on my little toes.
> 
> Please feel free to run tests, add more or share comments.
> 
> Previous:
> https://lore.kernel.org/kvm/20220721103549.49543-1-likexu@tencent.com/
> https://lore.kernel.org/kvm/20220803130124.72340-1-likexu@tencent.com/
> 
> V2 -> V2 RESEND Changelog:
> - The "pebs_capable" fix has been merged into tip/perf/tree tree;
> - Move the other two AMD vPMU optimization here;

This is not a RESEND.  These things very much matter because I'm sitting here
trying to figure out whether I need to review this "v2", which is really v3, or
whether I can just review the real v2.

  Don't add "RESEND" when you are submitting a modified version of your
  patch or patch series - "RESEND" only applies to resubmission of a
  patch or patch series which have not been modified in any way from the
  previous submission.       
