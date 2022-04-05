Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519A4F4922
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390901AbiDEWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456849AbiDEQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:25 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814915D3AA;
        Tue,  5 Apr 2022 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649172298;
        bh=ySu+WdbLhJy7RbHw1+FFBWYzYY6iBwBvKC8kGG4udH8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Qn7HJhLc1YnnJeD1uH+YD8JszCg3jcUfDll4fIeNiJETSxOeOCF7GwBes4YO9K6Ck
         FYTGOyt8SIUswtDPGr4Jv7xDnWcVtExfP2ixKeP+CpFNeks7V33teQzcKPqkGY30rj
         Wlasc6tpicOp/LYhi/VFAnoF35SVwEzgbIjx/CAY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C7C612878FE;
        Tue,  5 Apr 2022 11:24:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GiwgNUSrnlUz; Tue,  5 Apr 2022 11:24:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1649172297;
        bh=ySu+WdbLhJy7RbHw1+FFBWYzYY6iBwBvKC8kGG4udH8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AE5O0qlUuh4PfAJRZm3mQXR58Jv3mXkovnqsVGx8PD23lYOV7eLg1L/JOBhVddg+8
         Yhkji33jf1xqka1UL8d+M+WeQBN2goZetlmA7wK9/u8sZFW2DgRPRp9/RXhTOYweNV
         lAlOAFpVSaEGWclbnyGVT8I1C5DzkNd6CrG4csxQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::3774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5B9CB12878FB;
        Tue,  5 Apr 2022 11:24:57 -0400 (EDT)
Message-ID: <175195a9b7840e883677c6f351ee186089ab2b6d.camel@HansenPartnership.com>
Subject: Re: RIP: 0010:ahd_init.cold+0x96/0x98 [aic79xx] - 5.17.0
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Date:   Tue, 05 Apr 2022 11:24:56 -0400
In-Reply-To: <CA+QYu4qTtXgVegAd7S5bjJQye+kmtPaFau4dg3YPU2tH9faBjg@mail.gmail.com>
References: <CA+QYu4qTtXgVegAd7S5bjJQye+kmtPaFau4dg3YPU2tH9faBjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-05 at 09:14 +0200, Bruno Goncalves wrote:
> Hello,
> 
> We've been hitting the panic below when testing mainline kernel. More
> logs can be found on [1] and CKI tracker [2].

When was the last time this driver passed the test?  I'm asking because
nothing significant has changed in this driver for a while and the
trivial changes all seem to check out.

James


