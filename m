Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE61E476F45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhLPKzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhLPKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:55:43 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:55:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kk22so3433817qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrDCPm6/+BD3TmuHng5c6ao9ZVxI0GzI50LE4A+AUMk=;
        b=kIH5AwPh1Jzb2L1vZczLuWHKjaFzVnM87XTRRiaEESJ615BrE9vzr28SyU6+m8xOKP
         xHG6slm0qdH8TrZUj6bb+wjAz1XVe13xmL4E4EUVpOnAmBSA4iN69uU8Hiz2iM1ZmxzT
         gO40Igwoe0Y4fNvCH5wjNLlDakJ86VrjBWsr8Ieb2dpMiCVj9WPUEf+yq7vBcxb1jzHx
         pmBpiXXvj/CexoE37WRwyTLqJ21oXUJN2OGtZY7QzonzAFkPymr1QaCFdbvIxfSy2l1K
         Xai8Cy/JGFY5EMB4VsX1YXYf6qdrC/ZxWr9VBLK9euOILhmxqFJYLJrGTldJn0jdqrd5
         e4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrDCPm6/+BD3TmuHng5c6ao9ZVxI0GzI50LE4A+AUMk=;
        b=d/6FF8iC0zbDR/jNN5WAiKS6bUJOmNH1Ka0d7JdGuh1B9BQgej2No4vAXjfD62m3oZ
         Md9jOAZuCcYWW7CAafkH24RHeUXh16hGiZ75gVOxtfcju3UrAVMkMsmaeVeurybwgvzX
         tKHzDXhQBBUYYP86cf+/cnK7j2bNmMhmLE000Hlr9CcDPNjFjvOEb+YcftkEt10XL4ga
         Y7nNJJZ5sEFnVU/x/ovyQwkt3vOTbkjrZ5W7Ci6FF0gOBArDtOZQ5ILWX1HbDDsW4hnk
         /H0OOYU46Ld87MSQvhKkocDF90U551Ogj2eRiciWUpbqahuTMdPbZaBCwjwO6MxgoyvC
         l33w==
X-Gm-Message-State: AOAM5329/enDD2BLZGhwZkbGaqAnoVAstiL9Xrw0X9OjRKRPTH2Ggjjv
        JQjMXkx/r2TJuDJ0rlet2aZ8zkKVzpNNLGpwze7Sog==
X-Google-Smtp-Source: ABdhPJyeF/DWSW1cUVTmYtBTUBs6LAsdIujY7Y5TWl9a/zYYRsaK5GIZ0VuiCnNbcuKpxfNAwA/td0G/I6sc1WiaeWI=
X-Received: by 2002:a05:6214:411a:: with SMTP id kc26mr5554605qvb.113.1639652142455;
 Thu, 16 Dec 2021 02:55:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <15eeaed5bb807dba36e36d17a1d549df8e2b752e.1639432170.git.andreyknvl@google.com>
In-Reply-To: <15eeaed5bb807dba36e36d17a1d549df8e2b752e.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:55:06 +0100
Message-ID: <CAG_fn=W+FDpjxipKvBjovxzCxodasFD7W0vpv1sUbEM75J3Edg@mail.gmail.com>
Subject: Re: [PATCH mm v3 19/38] kasan: reorder vmalloc hooks
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Group functions that [de]populate shadow memory for vmalloc.
> Group functions that [un]poison memory for vmalloc.
>
> This patch does no functional changes but prepares KASAN code for
> adding vmalloc support to HW_TAGS KASAN.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
