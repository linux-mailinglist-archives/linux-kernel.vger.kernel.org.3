Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2A4AF348
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiBINvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiBINvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:51:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474CFC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:51:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f18so4247920lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ItxbsqqZ51w/D/epSixZzIFV7AmBu7xGRDA55lqryGU=;
        b=XufQ0Oin2rtofkdcAkEcrbMtYdci1rpn0c6i8OorFCd+RiTJ+v1T5TtEECa2OqUkdb
         KUQAl5b5its8PMU/FCG05T6cGB2ge+vpBD8Vn0KEOn/7rBnctwrNG1wrnTN+uylOtVH1
         Ijk6UoxIEMI/tu9mHykERGAp92ASMofxZLbwSkmDf/jBRO3Uz+YSqSJ+i07VKKrZn1ba
         kHf/obdyQB7VYLkG01zet8yB1sRsH3k8q4pqafCoaTM/F1WSEfx3A/dNBSaKbwxU0bKF
         CrXa0tiUILTyVcANms6tDrU8lFGHNTTulC3LA28VQNAoXwx/kHp41wKXAKmPly1HG1Zu
         1VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ItxbsqqZ51w/D/epSixZzIFV7AmBu7xGRDA55lqryGU=;
        b=gNCBOUtUr6ory4EU22gTWBv2acy0KiyFcoNhwhJuPfjgFmqZNbHji1PURlRLXfNinZ
         t+ehj4NOORb5BwTdrKEJxpzuDI/KumHDOeUHIoePFDFKRN15FCY7RglTYNUSqEdmL6TQ
         6BRVRzZNx/AhXBK91gq2BRYF8uWe0xSL98rjOOv2SgfT9oJKiClk3PWA7+7AZDJFwCmM
         aHjynkaq7ogLX7XXvIWQPNvqcdDWShTEQfmTz/a5Y92a6JiZQum6bkHdbcOvpor2mWvd
         tIagC47osWbKMlA6h//4blHE4dlgVNSpROiI1jFAttE+UGA6pjoL5m5TWtB6c2idiFWo
         XtqQ==
X-Gm-Message-State: AOAM532ON67iZGBczj5gN3ue7ST2Pt0hfEaea/sNsdfUUYKIG+bmcvNQ
        BJ25iBawXD2JfqwYurVKeL0=
X-Google-Smtp-Source: ABdhPJxfDS3cnZ1ErsJpiGck1s0ltan6NqDwzuzAR2r7sb2rQ1sHLKwX/BMgIz6CH/aMTumdETtSJA==
X-Received: by 2002:a05:6512:3d0e:: with SMTP id d14mr1579636lfv.165.1644414706446;
        Wed, 09 Feb 2022 05:51:46 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.201])
        by smtp.gmail.com with ESMTPSA id f26sm2367362lfm.251.2022.02.09.05.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:51:46 -0800 (PST)
Message-ID: <250ce1c2-95bf-3067-7bd6-5655038c5e69@gmail.com>
Date:   Wed, 9 Feb 2022 16:51:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] WARNING in component_del
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000016f4ae05d5cec832@google.com>
 <000000000000a17f2305d77f4cb7@google.com>
 <YgPEtCGDlSrqa1fK@kuha.fi.intel.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YgPEtCGDlSrqa1fK@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 2/9/22 16:42, Heikki Krogerus wrote:
> On Tue, Feb 08, 2022 at 02:37:10AM -0800, syzbot wrote:
>> syzbot has bisected this issue to:
>> 
>> commit 8c67d06f3fd9639c44d8147483fb1c132d71388f
>> Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Date:   Thu Dec 23 08:23:49 2021 +0000
>> 
>>     usb: Link the ports to the connectors they are attached to
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14063168700000
>> start commit:   555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
>> git tree:       upstream
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16063168700000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12063168700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
>> dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000
>> 
>> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
>> Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
>> 
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> I'm guessing the component_add() is failing in this case. So I guess
> we need to consider the component_add() failures fatal in
> drivers/usb/core/port.c, which is a bit of a bummer. I'll send the
> fix.
> 

Seems something similar to your approach is already posted

https://lore.kernel.org/linux-usb/20220208170048.24718-1-fmdefrancesco@gmail.com/




With regards,
Pavel Skripkin
