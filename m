Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA984BE524
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377406AbiBUOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:14:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377425AbiBUOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:14:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2822513
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:14:09 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id o8-20020a056e0214c800b002bc2f9cffffso8310586ilk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=biSWFkrHnVh1vX9ZGHcqNFCKItIFRSQQ/GVd7v9WD2A=;
        b=5RdW7Gd6A3sgnoQXbUkxHxC7hb5vt8R44DbUXa2kQC4Z9icGlNGpuX9o7Va7T0rus+
         lSgEK7KWgKy1knqfjvT+6IQyIzqHSOkoJvKGXUQnzQosp1eYTtJBWCnw4emSvQOPjRRC
         Au5uL/OLNfFgId0cduDbWPpx8IrJ21V2KwVvGF0Mq/h5OtYnw1u0qjn5EvqwGiYKwiKF
         d4a6xDu0H3+VCu7eZA3wrISzAmwt9gDmdCQO6UEiGJWW4M0OW4x3V7ITZ0OigVwhAoij
         mySNGtdC6tURZ5oZMkC/h9VdmSOo3dd37NaFwJnTjcNG4UyWOxq5SMgOhWVj8KUPZwgF
         Pkpw==
X-Gm-Message-State: AOAM5306sCYh2QTie4SmpNmaznXy3OEyjK6f3aBN2uDcevMdzHGcCYTb
        iKUZ6UDHuaPrm2DODAa90tqFKWtleqOIdaKNUmqDoOykn+Bq
X-Google-Smtp-Source: ABdhPJyckbjL5vZe+SL5PZw8Care2n4RWM6VWjfOjuYJSZtg7zh+iVidRt9dpk1g9FX/4VRdC331tn6E79/t51uSc+O6E7BBDd3D
MIME-Version: 1.0
X-Received: by 2002:a05:6638:382:b0:30e:3e2e:3227 with SMTP id
 y2-20020a056638038200b0030e3e2e3227mr15670807jap.234.1645452849195; Mon, 21
 Feb 2022 06:14:09 -0800 (PST)
Date:   Mon, 21 Feb 2022 06:14:09 -0800
In-Reply-To: <20220221140558.1618-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000922fa905d887d86e@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to create GCE image: create image operation failed: &{Code:PERMISSIONS_ERROR Location: Message:Required 'read' permission for 'disks/ci-upstream-kasan-gce-test-job-test-job-image.tar.gz' ForceSendFields:[] NullFields:[]}.


Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1296ea64700000

