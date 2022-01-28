Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3054A04B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350176AbiA1Xzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:55:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47823 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344804AbiA1Xzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:55:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A9315C0130;
        Fri, 28 Jan 2022 18:55:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Jan 2022 18:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IAiBb3iTel7sOiRdw
        6MfRt20zX3HUdwmOXMp6GDvEpU=; b=cig2R3CaUhMoy4WwozeM67nHdEaM5ShHx
        g1kv//Sfm149/LmlIe/2209l+15hFdFO7J9BwhlHxm2Qp1nMX1Gb60tFmG4dkWhX
        tRZ/ZIUsIlax8caE99fRXYMQ720F1Oe0a7XpUKLq//pwuMJNzZ625mkm7yaS419f
        u+kkbymqczUY3j3DK116WRgempc8PhVJtdHupWWeQ0olb+JW3/uvvVtxrXLXdvtf
        PamF+TboD47egkgXrGZijKE64qMsPhTBc5XRTcvZ4tOkndmFdlWflbOps1IV25/2
        AA3gQu+xIeAsAe2q5UE0b9pwd4AiKMRp6ka2lEBI0UTmIrBmiGt2w==
X-ME-Sender: <xms:doL0YXjrRxw-QVyH7H9T3zsawcnnjdcrocMYzVaWyA1PIZLIFBi2qQ>
    <xme:doL0YUAuwxIBgK6L6VOKhvHdLYs8bWpsBpxF9UT3GGHhhsrmEocjmaXARSzYy7o_t
    dFXTSddGiCHqDcuT9Q>
X-ME-Received: <xmr:doL0YXGJCHOLwxHbM2mtZX7I9HW5_5Swr47WuioaEagea4PEiKKpUmc4cdHpjLplb1jAY0ZgLsrG4gzHS6daNiRfmE3L2Gr4bns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:doL0YUR3LZ0Oev1PpD-WOfcEiL8hnJ56AvjAhj47QAKpuBeOF7djUw>
    <xmx:doL0YUykduxY3XKMhGHYYOWaiyFk2ENm8bzdpuZNysxQU_tr9pzSSQ>
    <xmx:doL0Ya7YFiUdxbn5MLYnJYWE-CUOaKNuYGg81e0yCsJXOibNQUzNgA>
    <xmx:d4L0YeuNCJVRFH24Gul8XgjdZLofo3M0OetKkvlJvrDFHsqIXVWv7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 18:55:33 -0500 (EST)
Date:   Sat, 29 Jan 2022 10:55:30 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
In-Reply-To: <b1cd50eb-e476-b4bd-0b2f-b4a8699660f6@gmail.com>
Message-ID: <4d65d2e1-5fb3-456-3cc5-fbd3167d06c@linux-m68k.org>
References: <20220128173006.1713210-1-geert@linux-m68k.org> <b1cd50eb-e476-b4bd-0b2f-b4a8699660f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022, Michael Schmitz wrote:

> Hi Geert,
> 
> for hwregs_present(), the exception fixup will handle any access error 
> (through send_fault_sig()), so this should continue to work.
> 
> Why the special handling of VM_IO pages? Maybe hp300 had marked all IO 
> register pages VM_IO to distinguish IO faults from VM faults...
> 
> The only other area I can imagine this might have an impact is the Mac's 
> pseudo-DMA - FInn might want to give this some testing.
> 

mac_scsi.c and mac_esp.c don't use ioremap(). They rely on head.S:

        mmu_map_eq      #0x50000000,#0x03000000,%d3

Having said that, I will run some tests if you still think it necessary.
