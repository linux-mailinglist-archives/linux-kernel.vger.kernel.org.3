Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360DA46E229
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhLIFxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhLIFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:53:01 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:49:28 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j17so4397338qtx.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=E0B33T1dP/kOnzZo9k42+8Jf6pOpiUNg/NJ3rKCqDzA=;
        b=fLS7KE+NyR7NSFKwZgFxknGLgPfN2krzjHueESAHdHAzNLTh7IBWI3t4aXCI/jpEZp
         ng2jupSd3T9kdCxarUO+55S8pigRC7982SKT3WuKh12qVHYmvzERPw5SIHiAk0EyTIxs
         4iFBtOzKGyPjEl8jkkd14bfnJBw6HddhRJxEuFKy2pSs3FLxn88EeHJmXuIGUkhO+I0l
         gXx3hLTx2phNvfdcGp+b+97N3FChokoHoRhlA89LtgdRItwZ1y9j4Zad1ocWp5b4tL+j
         +NSMELRp6ocbkdU5So8X3xAJO7ziFA0ZbgwU9Xe5pCGEG8+9u8Hl7+H6FDR6n8YxxI9q
         YtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=E0B33T1dP/kOnzZo9k42+8Jf6pOpiUNg/NJ3rKCqDzA=;
        b=YJVjI6ukzEz1bt9S4mBB5tUwWYxq7zn8x8CrX6GnfztOjKkJq4wDCcc05qm94iWW/y
         oHMSCULyKyKo5wPgxeBCeC9Yjn12kSYUizcT/0/ARJABBXd1rmqCr7hdtReTwd26ORU2
         IPKMxbQ4QaVj8977pqimuNsBcKJDhTocvcDqFtVKZQEEjeEL9Ldt5F0AzA2fm3Wl76aL
         rtYEPFuh3bjksaTn9rpA81JFvQbIHGqeyaJswTBziXw7WpLcaM6iGp6FxJTewGsmyGBT
         FQmWvrluDXXRXelG9ZcFLVcPUnFegvbh+iu/cvN3X9JogEMi8tRJK/Kqi7l9VikgTNTN
         HZVg==
X-Gm-Message-State: AOAM531ByoxHgO4BcyBy+gL9IjDxmAAs7mCG67sMeDvn76709PnbWnIf
        fT7ibRuhAwH4RWtYqrdUS+PVaQ==
X-Google-Smtp-Source: ABdhPJx5KisNBSCJ62vo48H5GOfTM1bApzhKpJ6xJMnuoa33VIDbFdcrKobMneglT6Fl/83H94BHOA==
X-Received: by 2002:a05:622a:95:: with SMTP id o21mr14478633qtw.386.1639028967486;
        Wed, 08 Dec 2021 21:49:27 -0800 (PST)
Received: from [192.168.1.227] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k8sm2553631qko.130.2021.12.08.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:49:26 -0800 (PST)
Date:   Wed, 8 Dec 2021 21:49:24 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@suse.de>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Anjaneya Chagam <anjaneya.chagam@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: 5.16-rc: "x86/boot: Pull up cmdline" breaks mem=
In-Reply-To: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
Message-ID: <e3bc75b-54e-ac84-fcd8-3549aaaf3017@google.com>
References: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo, sorry Anjaneya.

On Wed, 8 Dec 2021, Hugh Dickins wrote:

> Bad news, I'm afraid: I boot with "mem=1G" on the cmdline for testing,
> which worked fine on 5.16-rc1, but does not work on 5.16-rc2 onwards.
> 
> Bisection arrived at 8d48bf8206f7 ("x86/boot: Pull up cmdline preparation
> and early param parsing"); and reverting c0f2077baa41 ("x86/boot: Mark
> prepare_command_line() __init") then 8d48bf820cf7 does fix my "mem=1G".
> 
> I have not tried 5.15-stable, but guess that is likewise afflicted.
> Sympathy, but no suggestions from me: early init ordering is hard!
> 
> Hugh
> 
