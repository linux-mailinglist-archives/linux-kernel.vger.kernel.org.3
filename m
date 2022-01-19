Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BE1493913
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbiASK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:58:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39712 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiASK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:58:10 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Jf2g14qkYz1qy4C;
        Wed, 19 Jan 2022 11:58:05 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Jf2g13zWDz1qqkD;
        Wed, 19 Jan 2022 11:58:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ePKFid0XyVGn; Wed, 19 Jan 2022 11:58:04 +0100 (CET)
X-Auth-Info: AdjUvmT+OC81O3UubJny8e2iCqI6sZo2X0NIh+ATrNdwGl8yDZySOQSZeJosN02s
Received: from igel.home (ppp-46-244-165-91.dynamic.mnet-online.de [46.244.165.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 19 Jan 2022 11:58:04 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 24EE62C36ED; Wed, 19 Jan 2022 11:58:04 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
References: <20220117154433.3124-1-changbin.du@gmail.com>
        <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com>
X-Yow:  My DIGITAL WATCH has an automatic SNOOZE FEATURE!!
Date:   Wed, 19 Jan 2022 11:58:04 +0100
In-Reply-To: <C2470F2D-9E45-49D7-A03B-E6A7BB4B9738@jrtc27.com> (Jessica
        Clarke's message of "Mon, 17 Jan 2022 17:33:40 +0000")
Message-ID: <87v8yg6lhf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17 2022, Jessica Clarke wrote:

> Yes, this is a bug, that is always wrong. LLVM gets this right.

Is that an ABI requirement?  In case of a leaf function, gcc saves the
caller's frame pointer in the first slot, not the second (it doesn't
save the return address).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
