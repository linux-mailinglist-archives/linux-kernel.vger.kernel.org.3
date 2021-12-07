Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF246B2BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhLGGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLGGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:15:16 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796BC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 22:11:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so16752932otg.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 22:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrJKHHALcz/cyCShdzef6ZT8iw3TzjjmfqX7+mVaVoY=;
        b=L38dDYRqaQBA41+IB2esUFprJjCgvisLfroIjcjxPLLv43E/Rd8CUHM3/iGTDap2EN
         DcUYcyE+9ZcncxXnoxV2aBUgP3X6kZdmufx0re4ZlC8tIbIXU7qShfP7aOVWDCWQ+Nmr
         2HSVx7N8QJy9n8B8xlUCT7zdVtQ1kETAoTKh9nNoo6Pum7bsnWFeVuOv6QwYVw9nTbzg
         NKIAULHjNsF8g907fIGYmq/ukOfQyPbHcj+HCX2aur9XL4q8rdhXQ+V6lyxew85RNVrw
         49mfCwhjzM697GLSPp5iAUwjKlzbmPVG43fTKqRKuVKijMPGWQQCPkc+yksh9s685Iq7
         AoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrJKHHALcz/cyCShdzef6ZT8iw3TzjjmfqX7+mVaVoY=;
        b=FFcf12HgQxSns+svpFEW8gVw3DlXEyJVBH53e/EBHlNDrHQjobGeUggq/NKnnshWxs
         FMSi3TbkAsq1XAWTJvz2Oa1Se5OFgoKeYOggtcXAGnEobrwgMSVyhBmzTI1CVQHxcNdw
         1aXzZ3FWosmBhqEvyZpxGoF/z3Z0szgptPmvdx4FgXrcF68iLLnw13b9RkbZu3E7Pbtd
         qVYxv1zvDvKNPi2c9p0M/hmuT2xRUts5iz/hdKiq+osY64iira0NGszZ8vo/XA44vZzv
         DWFiuKEjZgsgiuMGhQXsPz4Txs5Jcps+MOCWRfixdViHgPmxCm0IEneYalcFLMqThr5P
         cAeQ==
X-Gm-Message-State: AOAM5304VG6vTxrhqkfnrzPhG8iUvj6+tSkbiXumHESghhTSOZt20OcI
        nh6rMIT+oraepCajLZRcAfVTKlmWeVt12bd3RaYPvfKSK0I=
X-Google-Smtp-Source: ABdhPJwTldqT3yyJfRaS2cu0zM9ctIRRenGtF8Uo08XeNfQl9sak87+bq1IAWxjY+BHvWCaLJZ0XEER6z6qta/lAeDU=
X-Received: by 2002:a9d:7548:: with SMTP id b8mr32817630otl.92.1638857506181;
 Mon, 06 Dec 2021 22:11:46 -0800 (PST)
MIME-Version: 1.0
References: <202112041334.X44uWZXf-lkp@intel.com> <CANpmjNOpoYrgk85hsOroh67TqUPtawWCnbk1GwqdUnGEKrOP+w@mail.gmail.com>
 <78e4a2b0-af5c-d13c-ef33-878f84555b36@intel.com>
In-Reply-To: <78e4a2b0-af5c-d13c-ef33-878f84555b36@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 7 Dec 2021 07:11:33 +0100
Message-ID: <CANpmjNOV8dT94WJFyLZLVdOjsi-0G3EnNxWyTZgU_4FP5G5Gog@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [paulmck-rcu:dev.2021.12.02a 31/43]
 include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used
 in inline function 'pte_offset_kernel' which is not static
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 at 01:32, Rong Chen <rong.a.chen@intel.com> wrote:
[...]
> Hi Marco,
>
> We have added it into our monitor list.
>
> Best Regards,
> Rong Chen

Great, thank you very much!

-- Marco
