Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C058B4F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241461AbiHFKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHFKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:06:01 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892011274E;
        Sat,  6 Aug 2022 03:06:00 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i24so3435276qkg.13;
        Sat, 06 Aug 2022 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yHRj2jxBzVmdqRuMjTnDCE7Ot2HBke77O0JneFoj7pY=;
        b=i1LGlN0nAXw1rigtTV5oZaEXY2bfDQs2E4YTswrc5ipnMNLgXVJQ4k5y52342RhSyb
         WxA20pKz6/vm+Y4wkmoFh9EZQ147bfCTVjow91Pa8D5NmAr3xXOKsLMYzboUBtAnnPSS
         yNtEr2F8GV7X2wBG/6t+b0SngYfc7/fdPa1z7oyfebwExTHH6aQ4jYMjct3uRfyucoMt
         sgfutSAImUBmNKiXXhwFw8sYWVR2uAu1w38eAnsfObuUZgY9gfcqQN9fPCVb1gFYLTje
         GwOfslcEcu4mSF0mPzAbZx5dkZfQt0KnsLQEuYBOpihJqLQWk568E6BTieMlVBq2SXNW
         MueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yHRj2jxBzVmdqRuMjTnDCE7Ot2HBke77O0JneFoj7pY=;
        b=5wFnpcPM7566i+dcZqCVtk3KqZLObkooK39Q0+f2Q8wxPDTDwq1JgP+aPfoo4pwZUR
         riOXqw0BIW2I7DDWgE4I3ExST3/fuVnO1+ijQ86kEcVCAlXGq7vadbK0g94XPKOt7kdK
         oQN474Ar2J6dG2QCh8hkZawI/KvEjXHq8bxSGOd9OAUUSkv6Nj+BxAFbRSJSF777bjIx
         0rFhwMxCNyfkQhOFCUOqwPV/c8WphFeFKz1Tlkvgr2QmVQvGwK8lo7BSRLDVnS/5UaU0
         JkqwZ8/r5tL/o9V1/cLhxqnvKkZuZYFf2L8Tx28HLSa+NdjmvOFpSLb69sSnWtnS8JB9
         0h6g==
X-Gm-Message-State: ACgBeo0T1YGqdKFpWo91tdur3OzxzoayAEIg1fmiq9WptCxW9wKEKHGy
        J0lBZ5uslCj3cOx1OTusQ+x26Qg5fMVIAZ27gPI=
X-Google-Smtp-Source: AA6agR4HSV096e2QAbXkLRZgLSCOw71NDEE8wIsT+oYajrWdE2qE22FTCfIGay1lfs192rpv6uTO1DyCKa3A+5qxZco=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr7860733qkb.320.1659780359624; Sat, 06
 Aug 2022 03:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-6-luke@ljones.dev>
In-Reply-To: <20220805081909.10962-6-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:05:12 +0200
Message-ID: <CAHp75Ve69bEOSiaD_Y6skfsDNc2gZtiUH76yud_X3Xb2b37YZw@mail.gmail.com>
Subject: Re: [PATCH 5/5] asus-wmi: Convert all attr _show to use sysfs_emit
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 10:21 AM Luke D. Jones <luke@ljones.dev> wrote:

Commit message is missing. It's no go.

I recommend reading [1] to make your contribution to the projects
(even close source, if any) better.

> Signed-off-by: Luke D. Jones <luke@ljones.dev>

[1]: https://cbea.ms/git-commit/

-- 
With Best Regards,
Andy Shevchenko
