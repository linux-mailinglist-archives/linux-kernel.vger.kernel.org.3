Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C64937B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353220AbiASJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59516
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353311AbiASJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:46 -0500
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 545363F1C9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642585725;
        bh=+N2rIgHmG/IGWagRrh+DXgXU6rfiJYovNR/tKcy2B4U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mKLS1tse3tNahXOCjh0/tzmgjy7BORmfSMcoBOf4zZn6EgJis5PwnTsDCaam4/dAa
         SmL2rde6xbAGucu1gdMPtf9vcWHxqOvxObgRvxqiXMzsTfkP4qUoQB4SEcoMbT78mD
         mWc0i3w7dsLewnxX5TnSUoMm2SuuuWytT5MnBYKokl+Vk8ylqq8bCcfS2eDXzEAbID
         qElN1HyngUUAoZJeZdfMZJdnMEpLnbUCFWon8eYzaGeHe7EccNhJ+SZHrpOInTY5tv
         7C+qJJ7egQ55O1JFjbPYrb1bgL+uBv7ifIjAfTzhAOUmsqvsh4MP362jDcxjw1xHrI
         ZPOFd+BRP3UDA==
Received: by mail-ua1-f72.google.com with SMTP id w14-20020ab055ce000000b002fedc60272fso1124552uaa.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+N2rIgHmG/IGWagRrh+DXgXU6rfiJYovNR/tKcy2B4U=;
        b=tEGkCZsKucriqpiyiOngPWNcLbOD86oxbmsf/YrR49ZyzMVZe+B1pns0s5Gg1Utm9+
         L8lFXaNzvqZC9wre+u3kZPJAE4IsnxIBaPXj9oI+D3DSsvAPfipu3XpO+ljfk9nX6nzS
         D9AstK2VgonSUf3Gl7orZe+uy874U21HF4J0/8iOqO/wyHxEi/RhR2YQtnDpC6IJCDpV
         eIwlcWjrE6Phj9KoetjeyXhBOtavGozqWjJj7lxlMSqcql0fMeyajx+DnIlQJkIKbka5
         JuqphMkFEzz1bFpcdt5Rwp6roQKYKu0/jxFgSonzoPKFYAU1hmiGPwrAdOF2lcipzn2W
         XEAg==
X-Gm-Message-State: AOAM5336mIfl4CM736cFanT4Vlud9zfmjwV5N4cMxVZUUnicW2fOeEmX
        SMXnqEJF0QLY36EnfhcSHOu5hy0BXiXlb98vhN+IK9Gm5PSa+33Z2o/QVe4jR2qXFiRt2/Y+qmF
        VVcfPl7tFjSlcjS4eAqqwrB5lHrW/Xg6wFVzG5mphxrYire9ywgxCjZoeWQ==
X-Received: by 2002:ab0:3c4a:: with SMTP id u10mr13432733uaw.139.1642585724449;
        Wed, 19 Jan 2022 01:48:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0N80aUIDKwLFxW/lu/XgVf0tE/H/gqLSodx34FZAJN0wBuOCtxF4jgjt9CIcfe/2eEpauuqsrolggVUcS2aY=
X-Received: by 2002:ab0:3c4a:: with SMTP id u10mr13432725uaw.139.1642585724223;
 Wed, 19 Jan 2022 01:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20220119074609.4162747-1-senozhatsky@chromium.org> <a70570a10026203b544e930eb6dbcf6ad0abb2ad.camel@perches.com>
In-Reply-To: <a70570a10026203b544e930eb6dbcf6ad0abb2ad.camel@perches.com>
From:   Andy Whitcroft <apw@canonical.com>
Date:   Wed, 19 Jan 2022 09:48:32 +0000
Message-ID: <CAO=4fJPTiNKvru=+qAasMZYUmsGQe+OBH4A2Dd1v-NFdQ8f-Qw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] checkpatch: make sure fix-up patches have Fixes tag
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 9:42 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2022-01-19 at 16:46 +0900, Sergey Senozhatsky wrote:
> > If a patch contains "commit hash (commit name)", in other words
> > if the patch fixes some particular commit, then require "Fixes:"
> > tag.
>
> I do not like this patch as many commits merely reference a
> previous patch and do not actually fix anything.

Agree.  It would need to be a tighter form of language to be safe to
automatically suggest a Fixes tag.  The point of a Fixes tag is to be
a semantically safe indicator of this relationship not relying on the
vagaries of English for that connection.

You might be ok with something which is a tighter match on like
"fixes <hash> (<name>)" and only suggesting a Fixes.

-apw
