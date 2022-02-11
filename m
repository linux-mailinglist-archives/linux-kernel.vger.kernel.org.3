Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12344B1D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiBKDvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:51:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbiBKDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:51:09 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1D5F75
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:51:09 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k20-20020a5d91d4000000b0061299fad2fdso5453852ior.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sFibFZ2c7JVpUsxAag24//5YclVikx9mwUhyNlC52lY=;
        b=Eev7XeXLtTWOEes/litwsRj5xkxdxn+4ee8Lmq0VHyqTxTLDZom3MvxZXq5J+Yf96w
         v40SH/SB16B33EPEzJ3YhHYi6fwbRpoUCbcf24mvN2QBLXCF2ww+3qxRpvKrg8TAvDyo
         pfMDeYEASWjaPwQQjm9sEFj4DWNoRVnDSlLQwrP24h3nNjL6c+6M9aXdriuIQhBBvAVV
         iEbMh8WsDXTV4zwNs0wwZTyVf+j76FsXtP+8jO2jmcPm37/ilWVSvRug6UzUbdHje51L
         p+AlBxtzXUndw+U3JYeeZrA2ONvxU4qHDoSuKjb/O3RMrCHXvint9sRHyIVifZddKs9a
         wIVg==
X-Gm-Message-State: AOAM532wuQPCrER3XjOyXHTM+h4vZ3N3ARDqc0lJCCHJT3WnR5lplesx
        ZTV5NA9dwP+zQK95s/lX0lzO76WovHqLOiIk+bGREjxrB8gh
X-Google-Smtp-Source: ABdhPJwxguZj4xhw2cCfO1gXWXSzPnSR1JybjtsjtIDM6ox5o8VarmPoCrQWscPGGU0wYr9BA1bjL/AFgdY8vzL1308DYnV0CtN2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2606:: with SMTP id m6mr5630684jat.93.1644551468636;
 Thu, 10 Feb 2022 19:51:08 -0800 (PST)
Date:   Thu, 10 Feb 2022 19:51:08 -0800
In-Reply-To: <0000000000006e988105d72fbe3f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a5dc005d7b5fab1@google.com>
Subject: Re: [syzbot] general protection fault in i2c_setup_smbus_alert
From:   syzbot <syzbot+0591ccf54ee05344e4eb@syzkaller.appspotmail.com>
To:     akhilrajeev@nvidia.com, andriy.shevchenko@linux.intel.com,
        andy.shevchenko@gmail.com, djrscally@gmail.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        johan@kernel.org, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com, wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a263a84088f689bf0c1552a510b25d0bcc45fcae
Author: Akhil R <akhilrajeev@nvidia.com>
Date:   Fri Jan 28 11:44:27 2022 +0000

    i2c: smbus: Use device_*() functions instead of of_*()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156c8174700000
start commit:   ef6b35306dd8 Add linux-next specific files for 20220204
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176c8174700000
console output: https://syzkaller.appspot.com/x/log.txt?x=136c8174700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
dashboard link: https://syzkaller.appspot.com/bug?extid=0591ccf54ee05344e4eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1105f472700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16492aa4700000

Reported-by: syzbot+0591ccf54ee05344e4eb@syzkaller.appspotmail.com
Fixes: a263a84088f6 ("i2c: smbus: Use device_*() functions instead of of_*()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
