Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051D146F1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbhLIR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbhLIR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:29:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71CC061353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:25:44 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s139so9545186oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GarxWC/H8UEs+X7kifDd8BNx5YjQa1U5bbkdW7h/soY=;
        b=k1H7iEfLa/547rm6B1GgYwaswmohbzrq9yLLBViNK9agjUjHuvkWbhX+odrZCwXCk0
         9lcuxNVllUFZDuqPSV/+sep6C9tnmYJyKOL/XeGi7pyk6BPWViB175lXtUZF8ygdTd0p
         t6mdJ/qitMxi4i79CmVl91I3mQIyGSpLq6WxVPKb9aR8nRycyyhm7/bDATE/P8z94KlA
         qZRQP1twwWoNbcv3poFj9/ngEVycoFKb12xyLSIj8mQHjKl8i0icowTn8OjHLZOD27+q
         YYENVhUfbMET/ervf4WwgZnhzrBg8yrMEoa1FrSSiCN2TfFHPn7df+ICJByfqbDTc5yw
         Jilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GarxWC/H8UEs+X7kifDd8BNx5YjQa1U5bbkdW7h/soY=;
        b=1L+vESHeBHpNmdXHCgsb+PQFuGwhs3t0ZkL7aexswIrSol+6EAUwqItOZ4ivw0uxbV
         eozVvT+qfragIygurfFxTxxHkG3h74VZC9ioR+qX1YrxgfCyd/VQE+oGNWQ8ZC645M11
         nMf/WN3oTRZi/4v/Qqo/qrc3nIHzuoHUnjZ6KQq6pZXeYY4Qkjc7zhAh30jaDWCQRAwy
         AerDebzaGK4n4W2RSommNgQa63cZRPMyuvE79fY02wv5LkJCC7vX10IiVp0j5Z0znKLw
         /ImZ78o+iozh2vG6XkfXCfYgwREqkIR0qSx8aNPZEUHGFZH2NouZbGb/JunYKXtNg6wr
         qm9g==
X-Gm-Message-State: AOAM530AQdW+ZlRvToGIMI+w/zouGvlrKIV3hl7EDmqdwHieKkYar42Z
        +1Y2Knmq6E47zE/KvHkBZtvL+w==
X-Google-Smtp-Source: ABdhPJwPCKFQ8EeR3O+iqqwiW0hA7SijmBVJwZL3ppwp7WHRa/vK7AMkvycjgsIBszZ6ZWNlX59JWg==
X-Received: by 2002:a05:6808:f01:: with SMTP id m1mr7447300oiw.166.1639070743833;
        Thu, 09 Dec 2021 09:25:43 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e26sm62422oog.46.2021.12.09.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:25:43 -0800 (PST)
Date:   Thu, 9 Dec 2021 09:25:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Borislav Petkov <bp@alien8.de>
cc:     Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Anjaneya Chagam <anjaneya.chagam@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: 5.16-rc: "x86/boot: Pull up cmdline" breaks mem=
In-Reply-To: <YbH7Rlm4/mq0WuTN@zn.tnic>
Message-ID: <788e766-d391-addf-1d96-e27e35fa574d@google.com>
References: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com> <YbHUW1KTfvJtxNwP@zn.tnic> <YbH7Rlm4/mq0WuTN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021, Borislav Petkov wrote:
> 
> Can you pls send me full dmesg and .config of the -rc1 kernel which
> still boots fine. I'd like to try to repro.

I see the action is now happening over in jdorminy's thread, thanks
for the Cc there, I'll look out for developments on that thread.

I judge that you guys understand it better by now, more thought
needed, but my dmesg and config just be noise at this stage; but of
course my testing can help when you've settled on a candidate to try.

So I'll skip sending dmesg and config now: but ask me again if they
would still be useful.

(I see efi issues prompted the failing commit: one of my machines is
legacy booted and CONFIG_EFI is not set, another is UEFI booted and
CONFIG_EFI=y: "mem=1G" is ineffective on both.)

> Next question: does it boot without having supplied "mem=" on the kernel
> cmdline?

No problem with booting whatsoever, mem=1G or not: boots fine, the problem
is just that "mem=1G" is ignored, and I'm given 8G or 16G or whatever the
machine has.

> 
> And just to make sure I understand correctly: this is 64-bit or 32-bit
> kernel?

64-bit kernel.  Until you asked, I assumed 32-bit kernel would behave
the same, but no: I just tried, and the 32-bit kernel respects "mem=1G"
as it should.

Hugh
