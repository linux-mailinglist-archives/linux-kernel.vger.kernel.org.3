Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1605A18D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiHYSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiHYSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:35:01 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267CFDEE1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661452464; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bGeydnQwUF36e7aRhkJhhscxfUK48YIMKS/ZIxBPIMvSF5Q+Vwr8g3cqEXCI3ZeBwMxdE6XQFgBlICWbNkI2vUnPc6SAR1rN9QVkwH6QkbTxJEjb9P/nHCsb0pT9gQkbZ4dtNTiogbJdDR9Jcm+NXl2jTRvxApPuNC2FmzjVtAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661452464; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Z3K6FipcTLHdyWozbJnUC9QQr6/CxxINyS/VroZ3Lro=; 
        b=HUF0VSZS8uZSCATNJ6uFWIpKstRnEEiMo5p5/w+k1rMjFXkVBh42asjvqTU7bluhVDJ6dnBVhUpTOcFrUX0il3Y98p03XNA7kRIdvatVVhIX1KwY0c15/CtK86lsJwoR85WK0pcI/Dr0Lccznkze6G9nmkrGGNhzXBeOKEnVbQg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661452464;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Z3K6FipcTLHdyWozbJnUC9QQr6/CxxINyS/VroZ3Lro=;
        b=HcZ/b5TYRYlj8pZTh8/6VuLxllT49tece+lvucqYFwCe0saDJx+gC7Y9YUR1fYTx
        1Nxr5dx8yMh2LHgcR/XSIAzqCIChGFdpKcjfIrsJStqvckoXrOBBV5U3cQSbOol9t/7
        O5F01i3e3HGuOssq7i/jZjRrL4Iq92JjUv6ZNbW4=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1661452452642551.8346508100296; Fri, 26 Aug 2022 00:04:12 +0530 (IST)
Date:   Fri, 26 Aug 2022 00:04:12 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com>
Cc:     "akpm" <akpm@linux-foundation.org>, "anton" <anton@tuxera.com>,
        "chenxiaosong2" <chenxiaosong2@huawei.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev" <linux-ntfs-dev@lists.sourceforge.net>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>,
        "yin31149" <yin31149@gmail.com>
Message-ID: <182d6488302.3488c7db67898.4109222238062172240@siddh.me>
In-Reply-To: <182d6469a5e.4e1cc3b067845.2722724258679993431@siddh.me>
References: <0000000000006886bd05e714ec18@google.com> <182d6469a5e.4e1cc3b067845.2722724258679993431@siddh.me>
Subject: Re: [syzbot] KASAN: use-after-free Read in ntfs_attr_find
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 00:02:07 +0530  Siddh Raman Pant  wrote:
> This is incorrect. The issue is caused by:
> 9b75450d6c58 ("fs/ntfs3: Fix memory leak if fill_super failed")
>

Please ignore. I mistook this for another thread.

Extremely sorry,
Siddh
