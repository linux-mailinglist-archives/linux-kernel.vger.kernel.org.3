Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2704F49814A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbiAXNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiAXNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:41:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8FC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:41:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so49337043lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LGwrwCTerX4YCsXuTwLbo404QQhsky/ZXcsIf9jnLVg=;
        b=CCu7teZUiAytG93urgPHTCZVERqkzT0gKLIL+XUGpXEI1cYrhquSIZsNqTDWcomjq2
         Y/rt254s9kIOBrr0oOcr7w0jUlG08YzsZE4+LRR6qUnMR5Pz6UfCKWp+R+qj00lmhgah
         mNqNo9VD0hzh5rOk8e7vODJQmb4jaQoCNjzFz6cRsWggye4C1XR7TuO3Yt5Hw53Gji6I
         Mafi20P7L0x6xZWnqa21494pAGsEBh1FOeTqGuMZsqerGmvj+iooaPwZdqODVtuz5roe
         Gz6G4HaD6BJ2sEAtOykDcxPOqK8FLXVKCmDh1DlFNOk85TyrazVnI6pavxNQySZRvxwK
         QaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=LGwrwCTerX4YCsXuTwLbo404QQhsky/ZXcsIf9jnLVg=;
        b=TZIpu3Su/6fSB1p+Jgnec0zdC7VAHoh+vmKa/px0PvNQ1V1ehMbpGbzCziRTffY4gq
         FEee+1wI3idJtge7W6xjVaWldK5pJ2VauohtQ/t8Hqm1HAVNJ6TnggAnqFVIXjnQPjx3
         yLpPOhtVzLNBMucU9YEaWjqiyzRJI2nfpRKj9TzWjwcfBAnvd2pDsJ6zJpEe7gg3vPsn
         gcDQUORyZtz+mQC7BAWM+3YPpzn66LQwB84EK8dzqgbj6YcL8tS40eo3xl87WoORwXjl
         ZY0ppVMD/6RulgIz6fkuj6xUDaLm3vVYdSJ8nNCh8wj2sS4xWntm9XC/k0avs2TbypH4
         S30g==
X-Gm-Message-State: AOAM531VNkpHC1nzKKVuQkECzuGUx0meFdHYtFRpCqvA9CD1qMzlTFjn
        Wt/xj6yHhi5pPO1wqfKVMbre5I1CMS0=
X-Google-Smtp-Source: ABdhPJwZ7bMIZGLj+D3dzomRMOsDztL7hJEOWm1+ADOgT95Ca0rU37dHWFRInouSdw0l7RSpXNtD8g==
X-Received: by 2002:a2e:9f49:: with SMTP id v9mr3643332ljk.411.1643031687818;
        Mon, 24 Jan 2022 05:41:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q12sm826968lfc.278.2022.01.24.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 05:41:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Selecting MMU page size for an architecture
References: <sq0965$aed$1@ciao.gmane.io>
        <CACCGGCfQp7W3dCPNDh9sWTBCpC-adFwhhDaoHhwx8dyXa3UBeA@mail.gmail.com>
Date:   Mon, 24 Jan 2022 16:41:26 +0300
In-Reply-To: <CACCGGCfQp7W3dCPNDh9sWTBCpC-adFwhhDaoHhwx8dyXa3UBeA@mail.gmail.com>
        (Jon Masters's message of "Sun, 23 Jan 2022 21:05:24 -0500")
Message-ID: <871r0x45fd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Jon Masters <jcm@jonmasters.org> writes:

> Hey Sergey,
>
> On Thu, Dec 23, 2021 at 8:15 AM Sergey Organov <sorganov@gmail.com> wrote:
>
>> We are building custom CPU and have an option to choose either 4K or 16K
>> MMU minimum page size that will then be fixed in the hardware. For
>> reasons unrelated to the Linux kernel we'd prefer 16K, but I have some
>> doubts.
>>
>> What pros and cons for kernel and user-space operation 16K pages will
>> have over more usual 4K pages? Anything we should worry about?
>
> If you want maximum compatibility with existing source written for
> industry at large (e.g. x86/Arm) and even the assumptions in other
> devices (and their firmware) you might connect (PCI, or even on-SoC)
> then you'll want to go with 4K. However, if I were designing a brand
> new architecture today and didn't care about legacy, I would
> definitely consider following Apple into 16K.

I don't think we will have issues with device drivers because of this,
but even if so, I believe we'll be able to fix that, so I get your
advice as +1 in favor of 16K pages.

Thanks for sharing!

-- Sergey Organov
