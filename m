Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14EB586B82
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiHANBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiHANBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:01:44 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFAB65F7;
        Mon,  1 Aug 2022 06:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659358869; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=M2npo+8rvf2mQf9u6Grt4ErfFGR/2ZHMYR8rCOrdB8348R+FuXI2qwKOqsrH5wg81pChgmd/yUZIjgpggaEl21qJDPaDemkWPD6NQQBMbliqzlrZia9SUY66zNTmiWd/zJ09E7HFcZNQ8W5XxP/t0FeB85/MTngZViQetdsZJMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659358869; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=SQ0v85mLbFdTasT7Xfcj7jIsYFQii/2HWb8VZtzXjyM=; 
        b=Eoc/U40ZXnlz6FMuqeRxVjZqLbkWIBczvDc/QkvA2ACTtXyKk2bQt/keZlOgcG48LisE9Llyry9OIBpmUGQqr7B0NRtkZ55x7BmM+XgOpKK2kJAo23ASSF6ZAL3p2VKgBYq/Ip6+HSP8GPtPmIdakiiApnvcN1o9l1YDgu+mvwc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659358869;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=SQ0v85mLbFdTasT7Xfcj7jIsYFQii/2HWb8VZtzXjyM=;
        b=NJZfe/IX8tF8KFHUNwwJfRldlrpua714VbMxQqn+B8og+4rGW33ux2jDIe0di8xB
        C7ORSZ/7CR5NjkF8SzC0O13KI1CxqZAMMjxofVBal/jSLxO0fBaFBspKwFBkOUNnS7v
        Mv2zm0Tn9mqyuDyd6t8eMK0QVHEnzN8DSY9iVMdE=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659358858473203.14224248901678; Mon, 1 Aug 2022 18:30:58 +0530 (IST)
Date:   Mon, 01 Aug 2022 18:30:58 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me>
In-Reply-To: <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me> <Yuepw21SyLbWt9F+@kroah.com> <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
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

On Mon, 01 Aug 2022 18:28:25 +0530  Siddh Raman Pant <code@siddh.me> wrote:
> I now tried the 5.10.y branch of stable (which has v5.10.134), but the
> reproducer isn't triggering the bug for me. 

By this, I mean without the patches. I should have been clear.

Thanks,
Siddh
