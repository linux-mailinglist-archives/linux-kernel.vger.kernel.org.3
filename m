Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091CB484198
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiADMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:20:55 -0500
Received: from mail.credativ.com ([93.94.130.90]:37930 "EHLO mail.credativ.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbiADMUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:20:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.credativ.com (Postfix) with ESMTP id 41FF72009A;
        Tue,  4 Jan 2022 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=credativ.de; s=email;
        t=1641298849; bh=lORCloxc910E8pJ/4vNuaq0h5KufKbGTbOIBjWzEkLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edIcmO9rjTNd7+FYvWl5d78YE383veV1k+1M6p4QED9KPlqr2bonhlePMl8qrQDaw
         et8vr6ARA3CxJKJbHHDPcjMrER1/BNlnRhQzqbtXX2k4XF6DVBZgxmLKOLBWesOtjY
         8x2lbGjEvJBxzI/ziSmSH+CH4FLbeWn+znBDk+MBeBTjuy1Fa9C8zYVtqZA/xBQ5dH
         klHMtusl0DMuwz+A+czXABk7z67uU6mNsFmvCw0Bg5Gehh3QlOrKm9yvBL3V5qBG0A
         qfblbSBbsokFraHE2jevIdE8k7bs3MtS0+L0xA0zMG3LkTW16PvoS5VHJo07WXXDR6
         7WfJbVKwGgE8Q==
Received: from mail.credativ.com ([127.0.0.1])
        by localhost (mail.credativ.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 36rF6LoypUw6; Tue,  4 Jan 2022 12:20:43 +0000 (UTC)
Received: from softhammer.credativ.de (unknown [IPv6:2003:5b:203b:200::10:16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbl)
        by mail.credativ.com (Postfix) with ESMTPSA id 1DFA820028;
        Tue,  4 Jan 2022 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=credativ.de; s=email;
        t=1641298843; bh=lORCloxc910E8pJ/4vNuaq0h5KufKbGTbOIBjWzEkLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmQfmnk75X+algNubvPO5YJJiC8cCsdH1XxlQ0UoIpqo+lPERR/gL39u48QwMgTOD
         3c9pKU/UWq+7K4AiDD1X/+4PYxUNAoebSkdJaEUM/Co1HWhIlD/TyjAXNX/zIaJuwb
         FgvYS6gfLdw5Cw9tL95JggcgXdXvHoo57wX9RAYcwcIksm4H2R6dpcJQ1qTPAmai0m
         q3Qt1FuzO1e4nHpFDAd2qQ+jENRXlPSIqnrwOMw3cmnOwdtJ3HrvYUQaZiscOLEyFe
         N8asiUnebe3w4aYjHAev0YBHDCZx0wHO5xkLD+Ul+y4ChYCcBmP5W933gkZmTg0gmU
         BG56TrOkOFrmA==
Received: by softhammer.credativ.de (Postfix, from userid 1000)
        id 4JSsCG3np2zB5sQ; Tue,  4 Jan 2022 13:20:42 +0100 (CET)
Date:   Tue, 4 Jan 2022 13:20:42 +0100
From:   Bastian Blank <bastian.blank@credativ.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: SLAB use-after-free with ceph(fs)
Message-ID: <YdQ7msXTCF5kKl4V@softhammer.credativ.lan>
References: <YdQYEF9WCTWTAzOp@softhammer.credativ.lan>
 <22cf685dbf61e09a4e5e7c3a48d1117a769548a8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22cf685dbf61e09a4e5e7c3a48d1117a769548a8.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jan 04, 2022 at 07:00:31AM -0500, Jeff Layton wrote:
> On Tue, 2022-01-04 at 10:49 +0100, Bastian Blank wrote:
> > > [152791.777458] cache_from_obj: Wrong slab cache. jbd2_journal_handle but object is from kmalloc-256

> At first blush, this looks like the same problem as:
>     https://tracker.ceph.com/issues/52283
> ...but that should have been fixed in v5.14.

Nope, does not make sense.  This reported issue tried to free a
"ceph_cap_flush", while mine tries to free "jbd2_journal_handle", which
is far away.

> You may also want to try v5.16-rc8 if you're able to build your own
> kernels. There were some patches that went in to improve how the client
> handles inodes that become inaccessible.

I try to get them to install a 5.16-rc8 or newer, get a new crash dump
and report that to https://tracker.ceph.com/.

Thanks,
Bastian

-- 
Bastian Blank
Berater
Telefon: +49 2166 9901-194
E-Mail: bastian.blank@credativ.de
credativ GmbH, HRB Mönchengladbach 12080, USt-ID-Nummer: DE204566209
Trompeterallee 108, 41189 Mönchengladbach
Geschäftsführung: Dr. Michael Meskes, Geoff Richardson, Peter Lilley
Unser Umgang mit personenbezogenen Daten unterliegt
folgenden Bestimmungen: https://www.credativ.de/datenschutz
