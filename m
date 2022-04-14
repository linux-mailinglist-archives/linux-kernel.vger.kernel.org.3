Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED3501A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiDNRwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:52:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D4B62
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:50:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so10371761lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DEbyqe5T1fF6VgFja/FH+cT3MjyU6Qe5ms7Et35C47I=;
        b=enRFJPN2ry3oLW9Nu5JotbGGsHR7ByeR1DibeBcVvutB5c5vKiYOunirRxVMIU6gSP
         8VzrpgJ4KulhydUE1oyN9Kg2vpoufZ90jQ6sdPbZ3YRiC2uaSo5o2bFMGcI/DEOSoyfm
         udgRJWxheBJznlvkIj0zcpZ/xiHnHKIMx8nAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DEbyqe5T1fF6VgFja/FH+cT3MjyU6Qe5ms7Et35C47I=;
        b=bd07gG03pUXM3Nxzv1PvDZXs3N9enDiMbzH4xA/PqaosVY5S/XsRcJeKKIntyippmq
         1SJWkaCZjd7lQuo6CMxYHECJUJrI3YLj0ismepUA1SKDOSj80Cz3bGCR1vb9eMmMCLGv
         P5UuBCzegIexlw3Oog6TkyQal8pw2Frjz+LSGMXsJunOVGivgf+XWjXSgorNfkJVHgul
         HEwJ/O0eyePOAaNJGQ07RGCdCxcMSucfGtuTrOxoEttcp4tGATEIBUlXDgAVLUcmOU5N
         PQ6cZbrxzsTvuU/+huaSyd5YTwdyHz4kgAFhaZM/bjjNLGY/fAQYbUQCOqzCrXJ9AbNI
         m0eg==
X-Gm-Message-State: AOAM533zGFpVN8JYIhkZHwuA1RMAIAnjKpGngVhlsIg3+eStKM/tF8B2
        eWVtSvPPgToJfDumjkmuOuNp9QndjwleNc26
X-Google-Smtp-Source: ABdhPJzDtLf6B+USkRjSLjYqXS2TrjGuEXjmS+9fWTcmCWllDpt+hLZzYj0wfWv6rpyqAnRvX0x5+w==
X-Received: by 2002:a05:6512:33aa:b0:46d:1828:1ca9 with SMTP id i10-20020a05651233aa00b0046d18281ca9mr1527172lfg.51.1649958621770;
        Thu, 14 Apr 2022 10:50:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i28-20020a198c5c000000b0046b99e316f7sm61460lfj.114.2022.04.14.10.50.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 10:50:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u19so10407992lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:50:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr2598700lfv.27.1649958619851; Thu, 14
 Apr 2022 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649705056.git.dsterba@suse.com> <20220414143729.GP3658@twin.jikos.cz>
In-Reply-To: <20220414143729.GP3658@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Apr 2022 10:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5m1uDfeGQ=rRA7Kvz=hQe4p3jVKcXc40-zBKqwTiU0g@mail.gmail.com>
Message-ID: <CAHk-=wg5m1uDfeGQ=rRA7Kvz=hQe4p3jVKcXc40-zBKqwTiU0g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc3
To:     dave@jikos.cz, David Sterba <dsterba@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 14, 2022 at 7:37 AM David Sterba <dave@jikos.cz> wrote:
>
> I'm sending this from a different mail address after 2 days of no reply
> and no merge of the btrfs updates (message body deleted in case it
> triggers the spam filter). The mail is in lore archives at
> https://lore.kernel.org/all/cover.1649705056.git.dsterba@suse.com/

Indeed, I don't see that email in my inbox, and I must have apparently
missed it and deleted it from spam too.

gmail *really* hates email from suse.cz these days, I had multiple
emails from Vlastimil about the page pinning series go into the spam
folder too.

I've explicitly added you as a contact in the hopes that it will help.

Thanks for re-sending,

             Linus
