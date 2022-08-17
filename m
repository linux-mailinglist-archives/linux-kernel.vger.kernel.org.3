Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7E597958
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbiHQV4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiHQVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:55:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D3A8332
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z2so19222980edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kEu3LoPnwB+E9uQr3yvAY75tc6MJOyqDhxfB70KSfNQ=;
        b=T0msTuPhx1VfnQd74B08rOH2exZjqLNW3BuxKYcVBR5qhseNUY9XMELlXRFDvhrxoJ
         bEafhlfHAxOLps/yKbluH4hwDq0ekhNmANb6lKeJsYf00OMickttnHUIVACROCoCNhBh
         Bm93sJt54QVLsKi/DqcQHvTmze8JXzUNAFb0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kEu3LoPnwB+E9uQr3yvAY75tc6MJOyqDhxfB70KSfNQ=;
        b=8SHNfTT0WMmJJQUTwIqxk1jk0LktkhQK+RbUaVq9D5eOMjyHkBYoH7I6DB0aEY9AaU
         GPcjl0QroM0s/sj91QId5d9/Q8mkSqCGwAucrL1uPBg99F1FVW/iQG6TY3jxuAZHFfI4
         n4lGQnuS4oVXD964lRAq1En7twx7+il1tW4LeoQBVtPDyMHACqTAT9NfQTokoIfncCkj
         BdFfMZ8+yjSfavvobGyDFyTu7giLm1rrS3FS5AlmZxKVI2uQ+r8mZ9b6W/vSk632mTrX
         U1xphXcMKUdv3nrvOiXGrNOl+UI5NJIpyG8zsV/IJ+NIKIdh94znlEW+aMtnAGKuucGV
         rXvw==
X-Gm-Message-State: ACgBeo1YJUtio6BY+MD16VzFgXz0VYfbAuRuZS+3GNmna+KwOv7QvIys
        GBIgIGV5iolgsAxQwBDthIja/ZAB+9S77irv
X-Google-Smtp-Source: AA6agR6imNsDBYcnkLGuB+GbDF/qqtsDGSwar/ai22vR1mN4AgSHsOMseOaSNydG5a2JZdYxkwYW0Q==
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id ez17-20020a056402451100b0043ba1828a0amr71483edb.410.1660773355230;
        Wed, 17 Aug 2022 14:55:55 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id du6-20020a17090772c600b007317f017e64sm7306113ejc.134.2022.08.17.14.55.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 14:55:54 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id a4so5914073wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:54 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr26766wrv.97.1660773354188; Wed, 17 Aug
 2022 14:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <db8cb5d9-56d6-a00a-9cf0-4deec9056433@paragon-software.com>
In-Reply-To: <db8cb5d9-56d6-a00a-9cf0-4deec9056433@paragon-software.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Aug 2022 14:55:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg53xW_ppC5w_tDvWKn3Q7i-hWmd09KM-O1npQHWoBBGw@mail.gmail.com>
Message-ID: <CAHk-=wg53xW_ppC5w_tDvWKn3Q7i-hWmd09KM-O1npQHWoBBGw@mail.gmail.com>
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.0
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 9:43 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Please pull this branch containing ntfs3 code for 6.0.

This really should have come in during the merge window.

Yes, there are clearly several fixes in here, but at least that
FALLOC_FL_INSERT_RANGE is clearly new development. And a lot of it
looks like just refactoring and cleanup, and again that is something
that should come in during the merge window.

But since this all affects only ntfs3, and I consider that still
fairly solidly experimental, I'll let it slide. But please keep this
in mind for next time - new work (whether cleanups or actual new code)
during the merge window, and obvious fixes afterwards.

                Linus
