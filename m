Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212D5AB7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiIBSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiIBSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:02:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F9FC300
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:02:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so5393500ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QKpkWBalvPcb442osnnmCYBtgf+3QmIQOcwDZjeT1XA=;
        b=dsa1YI4NznjoRJXq3MFUUdbE1YgDGmKLbc0hUoxfmfACIE2so67f0eRAppF+OuzxZd
         4vUsNBd4F7DnG8k2LcpqE8jT5oGli0nX7iEPux7+C5OHWMcBpfk1mk80If8HMYfmI2BO
         BDvMUw1V7EBKxmpPu1bNs+fUqiKtQAu7LKGz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QKpkWBalvPcb442osnnmCYBtgf+3QmIQOcwDZjeT1XA=;
        b=WVbog1IbuJOA3DvbkZpQPim+rXUuEXvFvpuJIC4OoW6PU8FmYK12hSZSBnN6vTyB/r
         h0gE4yzEYHrUZX6UqZqQ0+eIlKGUaXAOqlC4fZGEgX49Rkrqx2EfwSd32uT4znXjXFa9
         SM9BCiyBERMAC/fAtiZHQ+1npWq1j0jOww5cB6+HgdiG95WmWFYl5yoeVhU8Hdm3sOCS
         N4FUvl5SdkTLyeh5dIzALT8RmLzxryh53a/aJ5V772jKmIHNeZ+FohBfxROkGIaZFwtE
         ucOtnvALixSAJS9JyxARH8Nazbv7V73WvS7MlM7R/VFQouTOXiPjfRkR7NNV+ecFRrmH
         wMQg==
X-Gm-Message-State: ACgBeo0RJ4rZCgX5r716z+OMLSMrVFlmvN3G0n2Jak7gAab9k8hMrOzu
        0ejZV3nvrRRTjvRiMow34SdYoZmTPADT9EisNaU=
X-Google-Smtp-Source: AA6agR5IB+G+i9/zhLxm9SFc6bH2aMmmtF5BkEpuMBVtwNTpnYUcT/jwM+ScWKZ+L6q0+H5is0KLDQ==
X-Received: by 2002:a17:907:728d:b0:73d:693c:738 with SMTP id dt13-20020a170907728d00b0073d693c0738mr27838061ejc.134.1662141737871;
        Fri, 02 Sep 2022 11:02:17 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id la8-20020a170907780800b00741383c1c5bsm1548022ejc.196.2022.09.02.11.02.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 11:02:17 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1849824wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:02:16 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr3569551wmm.68.1662141736590; Fri, 02
 Sep 2022 11:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <YxIht+ev+gXsF6ZD@kroah.com>
In-Reply-To: <YxIht+ev+gXsF6ZD@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Sep 2022 11:02:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnNO4T9PHNC1DT35sROGNK_geKL0Q_EjZH=0sLoACPHw@mail.gmail.com>
Message-ID: <CAHk-=whnNO4T9PHNC1DT35sROGNK_geKL0Q_EjZH=0sLoACPHw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 6.0-rc4
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
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

On Fri, Sep 2, 2022 at 8:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc4

Entirely unrelated to this pull request, but since the diffstat made
that "drivers/base/dd.c" file stand out, I tried to look at what the
history of that odd name is.

And it's not obvious to me.

Very strange filename. Should it perhaps be named "device.c" or
"probe.c" or something more descriptive?

Not a huge deal, more of a passing thought inspired by that diffstat.

               Linus
