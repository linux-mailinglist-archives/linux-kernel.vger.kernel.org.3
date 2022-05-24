Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BF532376
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiEXGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiEXGrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D3B8FF86
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653374873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PjipnB6DP6+zCcE6pM2GueHvqOsaRq3Lc/Ylj1XJdc=;
        b=PawVE3mFyJZOxEvDuDUDFNBEWjD2jezxLq34seweoj8u1yrMbNqmGfTAtzL5d7y3LmU+Ny
        TFS4I+6dEXJ2L5X8njIyXOjC08Z5YAyjooRAw5RgrC57PBncJqBs3SydhULk3tpjHuYCRf
        B2N1brIxpncu1kGxIqa5fkmd+pCE2fY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-rBUPGHVYPqiESP6aY13UyQ-1; Tue, 24 May 2022 02:47:51 -0400
X-MC-Unique: rBUPGHVYPqiESP6aY13UyQ-1
Received: by mail-ej1-f70.google.com with SMTP id k7-20020a1709062a4700b006fe92440164so6463261eje.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PjipnB6DP6+zCcE6pM2GueHvqOsaRq3Lc/Ylj1XJdc=;
        b=YADl8QNgv9p7r0ggaQpcVHL71f5FqclpmxCCzglE+MkiG1Fpma0+gCLkrdumwzCYHG
         3YtGWhPu4+ASg8VMxJ7RtThc/DoHWgWN47lD08j0Xz1POWXdlH/WX2pnbOhNxSX+V822
         jHJjV3rEBV1zsEgDXhnwv2zrV62I98vkmeR4LJE5vgDOoXLY7gYnQO7eJQI5NxR+pdRg
         gda/CTvD3pJO+pYZ1avhEJXDw/r1XGnCzx625E6RfH70/BuGVguhz+JEPV3fkh1ZXsNX
         dNGv8ySgyER1IwDHefpWbIdzmMqdv5IR9O71swPNkdd6oiaqxJUTbST1galC9mrSb24Q
         63gQ==
X-Gm-Message-State: AOAM533dPN6E5YqJtnrs3X2HGNHWlShSZ8QKVIN+odKjxgptmrmzD3XJ
        qDROX8voLiHB/BXR3w1pDTDzhawy5XcwvZ2SP7Q69jIeemdE5mzdDwR2zQDEhFR1ClTt8gXU5pJ
        +enX+ELyHj9fDvLmS7vENh/dp
X-Received: by 2002:a05:6402:2996:b0:42b:49a:6d24 with SMTP id eq22-20020a056402299600b0042b049a6d24mr24622834edb.145.1653374870162;
        Mon, 23 May 2022 23:47:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIhnE+7JGgE1N/HB1F3yHUkCpoi13ACGkiJ3C9anF98p9K79UOxF217CnF/8W8RTZlBXbO3g==
X-Received: by 2002:a05:6402:2996:b0:42b:49a:6d24 with SMTP id eq22-20020a056402299600b0042b049a6d24mr24622823edb.145.1653374870004;
        Mon, 23 May 2022 23:47:50 -0700 (PDT)
Received: from [192.168.45.129] ([185.238.219.59])
        by smtp.gmail.com with ESMTPSA id ia16-20020a170907a07000b006f3ef214e16sm6847236ejc.124.2022.05.23.23.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 23:47:49 -0700 (PDT)
Message-ID: <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com>
Date:   Tue, 24 May 2022 08:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
 <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 5/24/22 05:49, Linus Torvalds wrote:
> On Sun, May 22, 2022 at 1:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-1
> 
> Hmm.
> 
> Your diffstat doesn't match what I get, and it seems to be because
> you've generated the diffstat based off v5.18-rc1, but you already
> sent me two pull requests with fixes since.
> 
> So your diffstat contained the diffs from those fixes I had already gotten.
> 
> If  you just do "git fetch origin" (replace 'origin' with whatever you
> call the upstream tree) before doing the pull request, git would have
> figured that out.

I did do a "git remote update origin" recently (recent-ish), but
AFAIK that does not help.

I did read somewhere that in cases like this some maintainers
create a branch with a merge of their for-next branch into
say v5.18 in there and then they do a diffstat between the
merge and v5.18 and manually edit the pull-req to replace
the diffstat.

That makes sense to do if say some files have moved / been renamed
after rc1, but that seems overkill in this case since my fixes
pull-reqs weren't that big and did not include any moves/renames ?

Regards,

Hans

