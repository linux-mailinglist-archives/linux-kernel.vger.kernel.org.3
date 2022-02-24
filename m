Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF214C2986
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiBXKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiBXKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:32:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F028DDCC;
        Thu, 24 Feb 2022 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QJ61GVuJyclCnz18nFi5Rw74fGs3hl5irEBRqG/1OMo=;
        t=1645698689; x=1646908289; b=md/HCKvYP8ZIxW3TNZBOQdjTNvjQAgjgiAkWpDaZz06/f7H
        2yl16ZEme/I0Pvs6SbkXnu0dhA1JKT9ur8CqVFXZj4CB/pzDO7mqwDA4lMxTQWFzUcbRZnKCn16Bk
        srFqehyjWkpycWV+Avw+HgsgZQSec7bdP/UXqe5PztPnUFTN2U9JdAeGLB+d0X6TD6Zw3rBamFzuG
        OEmbs0JyiMVsuCMRvaunnJNnzK/oWODICSHiEtAZGgY7F6knqV31Chnn9H68NW1Jhpe4l5K/mhawX
        Ij1gt7xuRLTVukOFxC3iJ0lLvRDx15975vXbe5jFdREirCU2J+EdUEu/3XdeV6/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nNBOz-0057ZC-Uj;
        Thu, 24 Feb 2022 11:31:14 +0100
Message-ID: <2fd265ec46a8b582b7c5dea9524185b6fe1b0322.camel@sipsolutions.net>
Subject: Re: Use of void pointer arithmetic?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Francesco Magliocca <franciman12@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, rmanohar@qti.qualcomm.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 24 Feb 2022 11:31:12 +0100
In-Reply-To: <87fso8vb3w.fsf_-_@kernel.org>
References: <20220221122638.7971-1-franciman12@gmail.com>
         <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
         <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
         <87o82wvhtk.fsf@kernel.org> <20220224075346.GL3943@kadam>
         <87fso8vb3w.fsf_-_@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-24 at 11:59 +0200, Kalle Valo wrote:
> 
> A good question. I have always just thought we should avoid void pointer
> arithmetic due to the C standard, but now that you mention it void
> pointers can indeed simplify the code. So I'm not so sure anymore.
> 
> Any opinions? Is there a kernel wide recommendation for this?

The kernel only enables it with W=3, which I guess nobody uses anyway
... Originally it came from commit 4a5838ad9d2d ("kbuild: Add extra gcc
checks") with a pointer to

http://marc.info/?l=kernel-janitors&m=129802065918147&w=2

(which is offline right now due to an expired certificate ...)

but setting back my clock it seems to point to

https://lore.kernel.org/all/20110218091716.GA4384@bicker/

but the thread kind of revolves around -Wconversion.


FreeBSD does enable -Wpointer-arith which is why we've been trying to
keep iwlwifi clean as a courtesy to them, but for really Linux-only code
I dunno if there's much point. Although of course that applies also to
FreeBSD ...

johannes

