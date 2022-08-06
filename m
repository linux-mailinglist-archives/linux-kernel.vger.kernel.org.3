Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144FC58B430
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiHFHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiHFHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:24:06 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B5B70
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 00:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659770601; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=CWDQqmcWpGcDP6YaEQwZ0h+sHqHCU2+P+vFhFIddlN6J+D1MoXIholkA6SAOB79wyDLiV3Mj1Qt8Y/mAGR12U+JpQJG55PB0RWxodnwnJiWMftdm/kDf19bU7Vs6Cu+9wyjFoaBmIbAGujFaOIFFWv4PbrGrNIQymW0/i5yZWSo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659770601; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0zU6HW/RiKrlHjgu1JneOctBa6Vp2gRdMfIiJanVlDU=; 
        b=OoPKM/6mAk/M24bJnsy5N5HgNR9PR2UQcVfWJhjDbp/ckQUjYWJIJa6kvJI7I1bLj+sRQBy0HWZI6cY2yzso/nAhEPMidhLLvOp1QJh7MHqDHmxMwnPRjPUkgc51kRE+MIaAmvItX60Na/XvR8rSfCDug1MO6zR91RPLnSlWkus=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659770601;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0zU6HW/RiKrlHjgu1JneOctBa6Vp2gRdMfIiJanVlDU=;
        b=QgufDlEt+Zvvv7bokdo6S0xc41lKFFG+lMeDAFIgDzdejYprRbDhiFKCl6o3dSEG
        WxJsIniqBfr7bwqrxkXfLwAnOLrl9L1ilyEn5G2Ijl8IxgI4Jwd9HzJF3C8VlMzcFhy
        NLiuIg5HF4E5w8MT0VUnzvR81/T3GdrFmlQMSjmo=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659770590975525.568493661557; Sat, 6 Aug 2022 12:53:10 +0530 (IST)
Date:   Sat, 06 Aug 2022 12:53:10 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        "corbet" <corbet@lwn.net>, "dhowells" <dhowells@redhat.com>,
        "edumazet" <edumazet@google.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "mchehab" <mchehab@kernel.org>, "rdunlap" <rdunlap@infradead.org>
Message-ID: <182720956e8.796884ee174572.6157803946196818050@siddh.me>
In-Reply-To: <Yu1icG/o8VcfsQdy@gmail.com>
References: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
 <20220804144152.468916-1-code@siddh.me>
 <YuzFrzrTnTtUHMn/@sol.localdomain>
 <1826d5c4a90.282ac4bf118702.5300662644268737477@siddh.me> <Yu1icG/o8VcfsQdy@gmail.com>
Subject: Re: [PATCH v2 3/3] kernel/watch_queue: Remove wqueue->defunct and
 use pipe for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Aug 2022 00:03:20 +0530  Eric Biggers  wrote:
> wqueue->pipe is only read or written while wqueue->lock is held, so that is not
> an issue at all.
> 
> - Eric

Thanks for explaining. I will send the v2 now.

Thanks,
Siddh
