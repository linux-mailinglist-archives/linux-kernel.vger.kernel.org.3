Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70846FB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhLJHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:19:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45398
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237332AbhLJHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:19:56 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72E183F1B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639120580;
        bh=2764l/FzSwXeYJBJfnIJ7mPXfvJ4eSHSnEqn470ay2c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uy8m62a0yq0xcC8tCuc9cE394i/q4m/QkCJsnzo+BKL1Fz9Xngm41JbPTcaI8kyHj
         QV3mdT0uRmLRaxiE7wQvKrj04EbXfYFkU7qbeOvqjK/hDxlOGCzYW5T1hD6oiwh5N9
         BkEJhSJkwXpAeeiKAU7UmwjFmbLNl2v2IeI1jq7iK3T9ytTK5ty+2RKmYDWmggxGFI
         hsmf2/+zY7gZAk1wgY83bhF0V331K5cnFsDXM3fBylB0Ti4s9IHxSzUqRMNLywNxKQ
         5lgZzhQfl2NKnOSZIcrubHWtDxNO2RzW64Y0i+lpoAFUCUbK8OJCtfRgnXmFBTby9Q
         9oRz2D2NRbAFg==
Received: by mail-pl1-f200.google.com with SMTP id k9-20020a170902c40900b001421e921ccaso3665550plk.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2764l/FzSwXeYJBJfnIJ7mPXfvJ4eSHSnEqn470ay2c=;
        b=bA+7TyQCarMcplMNm/9CrWMggXB39JNyTrpMV8we1F50GQLWd5Zs7NWPQKoB49ccxo
         GckoW4rocUH2uijoqjSmzJyLMrlPTZIRVXSpJOiO5PKLEgV+kXmSOZCalYTOw42BI0bq
         2RRJtoFlZK/JJc7l4qADK2cSK2vhn8Pvo/feMgGnp3aP6y8+DjnlquIFhRr/tnZs2aEq
         VXAcnjdXyj8jH9gV/ogcQRFebmWJdBsSEpHPhPz4xyhl82cLFAgqJxs1P6RkvQ3IeLE7
         x3guMK9QBpby5VEY69IUr0NxwQWUaUEoPbDANkt0ZI4BRIBFR3g+VOOPqmng4c83ctt+
         Y9Og==
X-Gm-Message-State: AOAM532T2t3HakyLqo6V4ZgZWCovXrEoIytZX7tQGFdFC7Xq3CjIX/aS
        OIUP0Eq5fcV7WiEHHa3qRisZV4mtkY0bdn8VRse5bz0ziqQYqKU/BhQsbzK9+JjkFJUAt5n/LPh
        VSZVL/im0dF4MzfmGndlbdFHUAlTpVGdL96RTZ4HCkfiNTsc/sDeBuNTB
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr38292562pgt.590.1639120579066;
        Thu, 09 Dec 2021 23:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+s7PFvxrHr53QhbelxbodbgXrBhlzOozGF4llEt9d+qmmZIomlREAXFfGFzaw5ezGmkpkoM79krzcgVfu/AA=
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr38292532pgt.590.1639120578732;
 Thu, 09 Dec 2021 23:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20211208071151.63971-1-po-hsu.lin@canonical.com> <20211209184620.78d02085@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211209184620.78d02085@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 10 Dec 2021 15:16:06 +0800
Message-ID: <CAMy_GT-qqhgHFzW7wuzz__Ly3Eu4oEHx-RrA9KO-mhVqO2AokA@mail.gmail.com>
Subject: Re: [PATCH] selftests: icmp_redirect: pass xfail=0 to log_test() for
 non-xfail cases
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:46 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  8 Dec 2021 15:11:51 +0800 Po-Hsu Lin wrote:
> > If any sub-test in this icmp_redirect.sh is failing but not expected
> > to fail. The script will complain:
> >     ./icmp_redirect.sh: line 72: [: 1: unary operator expected
> >
> > This is because when the sub-test is not expected to fail, we won't
> > pass any value for the xfail local variable in log_test() and thus
> > it's empty. Fix this by passing 0 as the 4th variable to log_test()
> > for non-xfail cases.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Thanks, could you please add a fixes tag (even if the breakage is only
> present in linux-next) and CC David Ahern on v2?

Sure thing,
I will add fixes tag for this commit:
0a36a75c selftests: icmp_redirect: support expected failures

thanks for the feedback.
