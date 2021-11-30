Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E4463701
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242347AbhK3Ot5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:49:57 -0500
Received: from phobos.denx.de ([85.214.62.61]:42624 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhK3Otz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:49:55 -0500
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5DACA8305E;
        Tue, 30 Nov 2021 15:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1638283595;
        bh=BZYi9ht2xy65JyC43IPolVUMbyaxhCW/7gh9Gp9ztQE=;
        h=To:cc:From:Subject:In-reply-to:References:Date:From;
        b=wBut36DpGx3qEDMfNoBVNMbRR4lO4jyH1JnQCjRHO3oSsxDKHStFrq/Q6ow10W6EQ
         dZ9TVgOLHNQaHRArc/Q/BOgc66GiyCa4Pk/Lmm/iR9O5iZwSQWhjLzSDadDDD3GrYj
         gAPrgB8zjdmIbbVagcz4sqOu03b/UEBqvThwCpNB8B0MO7PX9BC01q+k8QfmayFI6A
         v/aiwXM7/QOguwjE0oERvWOwhM6JIr7g3FIEl6Lr4ja+sXZArRoQs5I4/VFF/t50GS
         2gk6B7SHKfK9zQG2ExpH8uiDWu86z/RPlfSE6eZt2bKLOjT8C6meAcmTJQ3wMppCjR
         Vil/zNP5GwL1A==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 0D329A0260; Tue, 30 Nov 2021 15:46:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on janitor.denx.de
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=5.0 tests=ALL_TRUSTED,SUSPICIOUS_RECIPS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
Received: from gemini.denx.de (gemini.denx.de [10.4.0.2])
        by janitor.denx.de (Postfix) with ESMTPS id 8D5B6A00AA;
        Tue, 30 Nov 2021 15:46:25 +0100 (CET)
Received: from gemini.denx.de (localhost [IPv6:::1])
        by gemini.denx.de (Postfix) with ESMTP id 253191E0BCB;
        Tue, 30 Nov 2021 15:46:25 +0100 (CET)
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
From:   Wolfgang Denk <wd@denx.de>
Subject: Re: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
References: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
Comments: In-reply-to Paul Menzel <pmenzel@molgen.mpg.de>
   message dated "Tue, 30 Nov 2021 12:58:10 +0100."
Date:   Tue, 30 Nov 2021 15:46:25 +0100
Message-ID: <3846571.1638283585@gemini.denx.de>
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

In message <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de> you wrote:
> 
> I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 
> card and software to use the card for RAID calculations.

I doubt this is an efficient way.

The (IMHO) most efficient solution I have seen so far was the AMCC
PPC440SPe Power Architecture processors.  These we able to calculate
the needed parity information on the fly in the DMA controller while
writing the data to disk.

> Does the Linux kernel already have an API to offload calculations to 
> accelerator cards, so it’s basically plug and play (with AMD graphics 
> cards for example using HSA/KFD)? Entropy sources, like the ChaosKey 
> [3], work like that. If not, would the implementation go under `lib/raid6`?

We implemented Linux driver support for adma/async_tx/raid6 for this
hardware, but that was a long time ago (2008/2009), and I doubt this
has been tested recently.  But at least some code is still in
mainline, see for example arch/powerpc/platforms/44x/ppc440spe_dma_engines.c


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Another megabytes the dust.
