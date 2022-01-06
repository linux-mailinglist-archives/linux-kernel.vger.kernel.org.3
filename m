Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7494862DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiAFKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiAFKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:22:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54AC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:22:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r4so3982169lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WWAn60jvAU8+fUt4TyQU6LDH6mvfpEhABYSISoIc7A=;
        b=sn0lzS/nPUwXYJjTjI1l52geusnkl37PbLCwP5F6+7Za6hf7UFkD4pkOArLMtmQr3S
         WAtJqImb8gExFCIRnVJ+pyiJS2hb7eaKgnLfzdk5Yxw/BDOUtKF7QRkivDZgZbvgHqLM
         o2g7+aa+bpIu8NHTIkk3zCaOUbpIJbAY1jZNHWUWX6NQAUXRXlIiGpjto9TRzCRnX8q/
         8ajiR1eH2UvUQNrhMGj69jAYtyxRADV+s1Lw/zGrxqQCwNTz4/oWguVwfDk5cZDdaQnx
         RnVxMaZWaw97RkH/QZu5hmbwvmzn8DbjLkCKuAoEYR98JPGIzz70LZOfWiErDYyvi8Sg
         8/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WWAn60jvAU8+fUt4TyQU6LDH6mvfpEhABYSISoIc7A=;
        b=aXgXms66CtsCszd7tT6MDTgM0HjkzcQ9GypiXW9yi2weEQ/yDJA6/gff38b0dc96f4
         /Ns+UvH2ao9Mb2RRgCu+iQluduEis4TfR+D+kM9nY0clH4D2iguou+q0HpqFzLnaEFXf
         AhyjkKIJ32PWg2cAQQeVfIqiZ4qPqO/AIV8IvWp/TXIywL/VgzmnVH3uU++VhAq+g31k
         ZYIfs4Keb0/P2P6LCfllZ2EUcwdG6rR0KAaTw3blFdO9gw2IQh45ZWjTfVHZgaIxQzYa
         kkHDjWSQQvQHLQuaHT+PJag+k0rlDfDAGnuWWHTLkld3Y0vG4hhejk18GB3T+ynnBIeC
         /B3w==
X-Gm-Message-State: AOAM530F9+pew0nMWTQhAcHYF2GauYv/xFrtcgkUCMOT4czGr5wCjcS1
        NXWr9LaQ3S8TzhHv9bYwgm5yjKqidA/rxfNDM2QUt42vevs=
X-Google-Smtp-Source: ABdhPJw0H2SPqPQR90p6wbxU0Urt+DcUneiWX2ZhgHg2shVfWu1qf9Uhqz317dkZhPYSxWamCB2KwNa6AZ6UQEFY4Ts=
X-Received: by 2002:a05:6512:22c7:: with SMTP id g7mr50847168lfu.315.1641464564846;
 Thu, 06 Jan 2022 02:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106102027.634842-1-jannh@google.com>
In-Reply-To: <20220106102027.634842-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Jan 2022 11:22:18 +0100
Message-ID: <CAG48ez0-GO72FRO3deOKoB7Ubjk_7x4=j-eoD-38cV-HTEyG-A@mail.gmail.com>
Subject: Re: [PATCH v2] mm, oom: OOM sysrq should always kill a process
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 11:21 AM Jann Horn <jannh@google.com> wrote:
> The OOM kill sysrq (alt+sysrq+F) should allow the user to kill the
> process with the highest OOM badness with a single execution.
>
> However, at the moment, the OOM kill can bail out if an OOM notifier
> (e.g. the i915 one) says that it reclaimed a tiny amount of memory
> from somewhere. That's probably not what the user wants.
>
> As documented in struct oom_control, order == -1 means the oom kill is
> required by sysrq. So check for that, and if it's true, don't bail out
> no matter what the OOM notifiers say.

Er, sorry, I just noticed after sending this that the commit message
doesn't make sense anymore... I'll send a new version in a sec.
