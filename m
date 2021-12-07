Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809D946C486
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbhLGU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbhLGU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:13 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE2C0698C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:22:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f125so156042pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuZi8W2JMWBI7OZmmzAsfSQRB8lWtAPFIf9TzyCgjPc=;
        b=pFziUuf9Otzx2mSNKwUIVr9EwMijpHwk1Z4Tpo1BlSaIBQfOtvqmlOG7hX7P8eAnxq
         aA1LwjgSySGu4mBbnhqCO6EHvNveO7QI7fIuqV4wPfWJ2sVSFe8ld11eeZ0aXSfkY/oQ
         kHHNMzmT4B4o5bo77zg+x77WKXsy2+BdVKXRLvf/aBDsI0GGsyB1odZBVC1Hmn5E1zws
         SKmhe1IAN1hq9ZP1F5YqvfBCbxDCx/7q7Jrk92TAry3Y8LRUpL8Vm4XweGhZBKPDyBsY
         Wsauufusk6Gyt9dTzi11uPkQtZkPqlERWkgHiPDMijup7wJDa8cZVDCLcoASTAHNu3Wq
         sCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuZi8W2JMWBI7OZmmzAsfSQRB8lWtAPFIf9TzyCgjPc=;
        b=qxovcE17IOyXnbd3ZhtO8+TUqOw99AmrnY64sSjwtkPehImFX3ttpqKSKZceKHmuEA
         4HlN0ON2tYu0oslpvNFgR+TNmIDaRnELW65v+BnckrgnFmFBZmCLdsLBl+D16k0ZcYfX
         Py2iDKvtY6QVl5c+eRZ48b6G7aGO1XcT2oTijyfDSt4rNMHwlHb70hWsTfQEExOlUZsJ
         9JY8g6XXUyo0d1kNoGhq5WAAp8VeuMZRk13DE4YRj2KEwnZupc0VM6JUGAxaRb2rz3zq
         W/6UJCp8yZcmuoom7cq7YhCXwSpv4LrX6Yn2pimrR6JAExoHhSDJRzWhzOws01lTlT6P
         p7sA==
X-Gm-Message-State: AOAM531KT+fwdLiJCim6mN4faaXnu6wfNC3VAIfQ3RQJ921e7yYF2GSb
        NrLwhYH/XxdP/Zyu5KygMMu5SSaMGccrOw5M270zag==
X-Google-Smtp-Source: ABdhPJz9CFD3Kz++IH5OLNaBYyX1cpvFD5lBRIL1XhMchRv47Ww1lKlRAtJDrB1ZD9Y4yFcFE1n8emIiuo2TuOetVGY=
X-Received: by 2002:a63:f91b:: with SMTP id h27mr25230303pgi.12.1638908556741;
 Tue, 07 Dec 2021 12:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com> <20211102073014.2901870-2-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:22:25 -0500
Message-ID: <CAFd5g46HyBJxnu1=iG-v3Vh6UApajJjo6j13+OJ8K6bS--S+OA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kunit: tool: Report an error if any test has no subtests
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> It's possible for a test to have a subtest header, but zero valid
> subtests. We used to error on this if the test plan had no subtests
> listed, but it's possible to have subtests without a test plan (indeed,
> this is how parameterised tests work).
>
> Tests with 0 subtests now have the result NO_TESTS, and will report an
> error (which does not halt test execution, but is printed in a scary red
> colour and is noted in the results summary).
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
