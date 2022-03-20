Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484294E1E48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbiCTXji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 19:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbiCTXjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 19:39:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9AE80
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:38:12 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso9521876ioo.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 16:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NFh/T4Y8Po52slDxqrE9rD5LOIGCaMXmToExp8xuOjY=;
        b=L25EIfNPlDPQ0JimDSaXQmIbN5WJpb3pe6jU+4EeaTuvEMB214V7Aziiw0nYQJ1CNw
         1i/rn1+bdo9GgqY6JfVh3N1gkLaqnuILvlVXrX57X6Q8jDKjLRkRhCq93gxReHGb2t6V
         Dw911GFFNcI03gIJ8C39eUAAITnYRs89xfMtob5gjwKRCqiuGk7xhGsdgPeP1r6a1jl0
         9B82DiLFuRnmMQvF5Q3H9+1IBjaZ/06IWo0C7MBu9Glmi+YQJ8A3Kve0GpMUZL74mlCF
         jMZ+krZxQu/Ey95d74130Rwwc+jxUmtDqVH3p3HbQaBgTbe+5pXdrxa/eRNRlWZqu8Za
         2/bQ==
X-Gm-Message-State: AOAM530TS2IYUr1F2Lk2+b4Sze7o3teVxnpWHbNbyO95LT3q2SQUmrq/
        kkZN2Z8E1w7sVHtaIpgjW4meMGlHr/85dphu3+PcO6Vnqnwi
X-Google-Smtp-Source: ABdhPJxi/q2zCG6b7Y6gIvgxQjo83QlI44OJ3W5YzIG6waHYmAygzlxiFOXAADBTM5WkUC0wgYvAaHhG5U5oZfhn36nfgSpglEAo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c88:b0:2c8:31b6:531f with SMTP id
 w8-20020a056e021c8800b002c831b6531fmr38025ill.286.1647819491654; Sun, 20 Mar
 2022 16:38:11 -0700 (PDT)
Date:   Sun, 20 Mar 2022 16:38:11 -0700
In-Reply-To: <2238978.ElGaqSPkdT@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007442a005daaedf30@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
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

kernel/watch_queue.c:365:13: error: invalid storage class for function '__put_watch_queue'
kernel/watch_queue.c:390:15: error: non-static declaration of 'put_watch_queue' follows static declaration
kernel/watch_queue.c:392:13: error: invalid storage class for function 'free_watch'
kernel/watch_queue.c:401:13: error: invalid storage class for function '__put_watch'
kernel/watch_queue.c:411:13: error: invalid storage class for function 'put_watch'
kernel/watch_queue.c:473:15: error: non-static declaration of 'add_watch_to_object' follows static declaration
kernel/watch_queue.c:554:15: error: non-static declaration of 'remove_watch_from_object' follows static declaration
kernel/watch_queue.c:644:15: error: non-static declaration of 'get_watch_queue' follows static declaration
kernel/watch_queue.c:664:1: error: expected declaration or statement at end of input
kernel/watch_queue.c:664: error: control reaches end of non-void function [-Werror=return-type]


Tested on:

commit:         f443e374 Linux 5.17
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129f0625700000

