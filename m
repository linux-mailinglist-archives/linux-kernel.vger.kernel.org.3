Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDAF53B0D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiFBA2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiFBA2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:28:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD22194EB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:28:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd25so4286533edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 17:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McFyTOgd+XHEmlkAqfwIX5SEOFFO1RwY03NA0CSFDzw=;
        b=HKw6+eSMIDccKUrsJReWXBKrh8bC35YUs4ZEaguSquzXiGljGkmcQ6prQaUt7L8r3Z
         JdWdxvUMKB/ZligyUGaIIRb5X2iVF7dHQYxrjUyAIuZJw0Rf+Bfo/QrCGZZjWh/lkDq4
         M94ohT8t9S3lWWtwPGtw3g7ACsCvYY0J+n9L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McFyTOgd+XHEmlkAqfwIX5SEOFFO1RwY03NA0CSFDzw=;
        b=sRZhiWXwbheWAllwlIbjZEeIfumYECJPPCjr6lWOc7ilbg1GbxMNrzzmHMr/464XJK
         R147ddO10aB6RvDVkI7eC7WiKxae+0QxmiFImEPArMoRSm2HXeQ4ApYo1cXDwroiuy03
         dfyoiRJvduLXE9mCsRjgPAucxReyE2sTz5wnUAqTPoNipIwBNq5xP7oEZ+OAc3Loew5I
         lHYouicemmApLwCCivNhm72AjLzeMyCQFs5eZIkis4WJWv6QMhaRgdLEXtX2VTDuNyMh
         4GInD4jYtvsH/0hSGj7SbPTFm30bBhIRejr+ON/qEwplpheRng64lrdqVcxLQ33kd5tj
         PIxg==
X-Gm-Message-State: AOAM532htIjyMsW7dJMVyz/JgnJc0Qls8NF3hOfMeV6xiKKFheUrpcsq
        9xWkn2ei5cnWEUXPwIYLRHVw0fiEu9o+McQQ
X-Google-Smtp-Source: ABdhPJywQvvghtPWZEOBbmhcdI7wKi7D3c1sciQ2t727TXnXZVBPScOb6AixNJoMqDCyn1dzndVw5A==
X-Received: by 2002:a05:6402:528a:b0:42d:e116:fab8 with SMTP id en10-20020a056402528a00b0042de116fab8mr2577346edb.134.1654129696306;
        Wed, 01 Jun 2022 17:28:16 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id w7-20020a056402070700b0042aa153e73esm1675582edx.12.2022.06.01.17.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 17:28:15 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso3959549wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 17:28:15 -0700 (PDT)
X-Received: by 2002:a7b:c4ca:0:b0:397:3bac:9b2a with SMTP id
 g10-20020a7bc4ca000000b003973bac9b2amr30505369wmk.154.1654129695207; Wed, 01
 Jun 2022 17:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220601221431.GG227878@dread.disaster.area>
In-Reply-To: <20220601221431.GG227878@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 17:27:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoUOpeZwTrVzgtKBjR4SLA-rqV4_KDAHEdQ_4JhEQtYw@mail.gmail.com>
Message-ID: <CAHk-=wgoUOpeZwTrVzgtKBjR4SLA-rqV4_KDAHEdQ_4JhEQtYw@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: changes for 5.19-rc1 [2nd set]
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 3:14 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Some of the code in the tree predates that pull request, so there is
> still a couple of empty merge commit messages.

Thanks, this all looks good.

Even the last time I brought up the commit messages for merges your
tree was by no means the worst offender when it comes to merge
messages, and it was more of a nudge to perhaps improve things.

But I appreciate the further improvement.

              Linus
