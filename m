Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3155AA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiFYN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiFYN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:29:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892CE031
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:29:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id g9-20020a056e020d0900b002d958b2a86dso3356781ilj.14
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 06:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=x+Epx1coOg/vJnEueBwxobePEmc4y9ljKo+ccErekWo=;
        b=iW/z44Wm+smZfJk2bpWJgUSViU2eom9WKrJou1JxszuYMtQj8wDkjrLxuSw673kQCH
         RWQGI9UqKfrqDv6DHNOb7tccal1eWnxeXT8K2VKLxljfAPLhoCaoZ5pBq8ok6tvjaHPJ
         3Zof2i4PAN9ANiiuTQzFKnBVXXjQ45S7jxMuwX0pBjEmch7QewPJ2A3hGfFlnIoJB8MP
         veP68tyTT/mVkuu1Szdk9RjvbME66YV79ZL8lG2GCF/CbDY3uCOe+lodfwqO6poB2LUj
         tsjC/kKeo4CnvPP+u6P+oj5QYr29mpFwj48q+pDuCxErDw+LFVvSgeSZQ+czEjeE0vKx
         RrLw==
X-Gm-Message-State: AJIora+0SJIrTv8PhJfklnzllTPaljwZxVwel/ZYCNi5OLxPWXIMOiJA
        RG8n3MQbWZgAjoG3Vxm3bJhKnTiaTltOxUA3ueFFTmCRHTGg
X-Google-Smtp-Source: AGRyM1sTmCr+DrWgD/fOg8RTQ/5jBSZ7rWCNzVIBGQoba1+RjWtnF9B0vPl7lMHktjSrviXDU8gtxiPgjs1RJk7g+EiJRRyAROd6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c7:b0:331:f0ae:3a17 with SMTP id
 y7-20020a05663824c700b00331f0ae3a17mr2521427jat.238.1656163747376; Sat, 25
 Jun 2022 06:29:07 -0700 (PDT)
Date:   Sat, 25 Jun 2022 06:29:07 -0700
In-Reply-To: <00000000000073aa8605e1df6ab9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da315705e245abfa@google.com>
Subject: Re: [syzbot] general protection fault in do_mpage_readpage
From:   syzbot <syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
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

syzbot has bisected this issue to:

commit 4c27dc762d7b60fa23c6eab2309ca6fc625588dd
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Jun 11 02:58:24 2022 +0000

    mpage: Convert do_mpage_readpage() to use a folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d2a888080000
start commit:   34d1d36073ea Add linux-next specific files for 20220621
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d2a888080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d2a888080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b24b62d1c051cfc8
dashboard link: https://syzkaller.appspot.com/bug?extid=dbbd022e608bb122cf4e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1216c174080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14362fd8080000

Reported-by: syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com
Fixes: 4c27dc762d7b ("mpage: Convert do_mpage_readpage() to use a folio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
