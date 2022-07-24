Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BF57F2C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiGXDlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 23:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiGXDll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 23:41:41 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FDD17E2D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 20:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658634083; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bKS/evCdW2aJIs8pkEolA36ARa3dvrkcuD4cOeZ+3e3dmrwX/EV0L5VPlDNp5lx3SOScOFguyJBXKp4IXK9Ad+ljtd8TIJL6+XRnnKT32nyso6LVBWdTD37oDrIS+c7qzJoHtXfjng+M3b+glAiMFHo9IbF8t4tAcWAtxUfpHZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658634083; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=; 
        b=aQHxTskoW7a8pwTZvQWr1u/yHP9hhnIQn59pSure+lhRECNqqXkFZIdOnP58EC53iaYBw8ytvSRbnagmQFI68DG8ooEduN2RYzsPmhaA0fXYhSwgLbw/1tS+G70wMf6JHcE+nLXcknYNfKX/dCIMX6tOaLim25ehmrP9Ae41ahk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658634083;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=;
        b=X3GOFkqxAF75MzI2yyZm8ryjoOm8BgKLlzNbHdX+H6jsxnxPbI1VkETIqbNzQyH4
        dtkSjY+jNFpdCPnBl2PL+AByVZzjz7y/kA1XqYtw3L+wp2stt7biqp1P4xgiIgvPSCf
        BXgrphB4Jp8VCDaNv5avuumH/vss4tIOKl4gfiLc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658634071609624.0482927657043; Sun, 24 Jul 2022 09:11:11 +0530 (IST)
Date:   Sun, 24 Jul 2022 09:11:11 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        "dhowells" <dhowells@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <1822e4b6e21.562f3a5d626157.1197655428248513205@siddh.me>
In-Reply-To: <1822b3971d7.6eb03239234291.5206322384521184060@siddh.me>
References: <000000000000e8a18905e478d258@google.com> <1822b3971d7.6eb03239234291.5206322384521184060@siddh.me>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/siddhpant/linux.git post_one_notification
