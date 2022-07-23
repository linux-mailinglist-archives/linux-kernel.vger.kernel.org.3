Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CD57EF34
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiGWNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:23:16 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021C7671
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658582573; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=EfelWGmpEWqnRw0wupBAB34jHXra7UiXC5eSAkVDS5l0ZB9SOADKE+dN1U8eRURpZTUxAYcniI7Eii9dAZqWswrmprzO3TAGpxz6caRH6wr8Och+bTl2mzQrU64g6KL3QjEtxSQ+g8NUUm42daIyPOqdvUetekUvxNbRed63XXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658582573; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=; 
        b=ICLc2vDiuJD7IggTYHVmM2Z5TVSSDsPKnI9tZYHklpCt+sj6t03XlQ3QY3tYPZF5p+g1zXqQ9DuJ9E0QdkTwBZKVEXq4jM3FETtr1Vo6n4t4xPyXqc1wK2IBeVnEP2WsfghIwyB2mfZwwwD8qBnjJAQaGFRQq6fB6XeVmoqBGSQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658582573;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=;
        b=SDHuRrUb0Uqszb85lrG69r6JnEa5ffOmBEn2i9AXOc/yyyNFnnqQITiPSztPqL2j
        tDvg/BM+XGFnaOoh0nLRUi9e+dFxUujqFXOd9+MUCZ6yEVM+b7q84rQ6PSPFWvePLX2
        iaA+d+GIS6awcPskt3qrzb4JSO/mw0yzs8W+qUdc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658582561286620.9101998432945; Sat, 23 Jul 2022 18:52:41 +0530 (IST)
Date:   Sat, 23 Jul 2022 18:52:41 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        "dhowells" <dhowells@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <1822b3971d7.6eb03239234291.5206322384521184060@siddh.me>
In-Reply-To: <000000000000e8a18905e478d258@google.com>
References: <000000000000e8a18905e478d258@google.com>
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
