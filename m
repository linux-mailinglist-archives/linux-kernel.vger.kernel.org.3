Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15693518734
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbiECOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiECOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:53:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEDB393C5;
        Tue,  3 May 2022 07:50:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CD385320069B;
        Tue,  3 May 2022 10:49:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 May 2022 10:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651589398; x=1651675798; bh=4wCZd6tNt0
        GFdbI9b6HXPE8Ofc+zrjZS5CX4WMYzeMg=; b=a4GW4wc97v0wpbEaxMrf2p2umE
        EK2gf4eamynZnnJgcp9N0AsaQwglPoWQLImAqecdWQbAHR9WFlP+txH+B/7p6E+R
        IC/l8vaTGjdijku1FDtHDoPghrcIMIWEqzZGuLFW2ELV5ifDbcLoCM0/bIHP9jnf
        240oMfw5/ZxOqky9TA2OEsdzs8oLSXALuBC/kWNqS5d/+duv9bVTugPg7pUOl7MZ
        vsQH/HhAW6RmV3vH2cUCNZU90fECfjzfkWfwJ46H3Dak39lfYU4VVNcKJN6LTOiB
        J2JcViUcwRmp6W9UDr/XVZEzsyptzmVktxISsziNY4dlLKnelf8HNCPN9nbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651589398; x=
        1651675798; bh=4wCZd6tNt0GFdbI9b6HXPE8Ofc+zrjZS5CX4WMYzeMg=; b=L
        1wYd64YRlHfuOQGcsjfwnx7XcilEdPLk8XuzRDc0uwVIjOWp+r5HR0jWkMwoN1wx
        KjESrFRaJH17BcFIJcfQYDe016FluSFY5tiOMSzCwVu3JdUDJFdUg8zaUTm44DNY
        qI1HEckTGNAOgsY5PSAvDqLBisbHqNFmtE5RclGu1MMsN4Rh9B3N/NQX1Iqq4V68
        dfUB7y7idC3PNSkZmKi4egL6JbMXREsq+S/072ILn4TZQ7LFKaEK/spV88hOMkVg
        1jF4rm2IzwTeYS5MqC10eCyYsftVjKGUqWNNCtBsOqdVOi0S/P1+djQxKMh5u1sv
        DcjDs0MsP/vTxYRC/FPug==
X-ME-Sender: <xms:FUFxYmknQGOFZvzVOdW6rFXrCCauCzqTp7r2ZwdjF3sXP3gUMkbl0g>
    <xme:FUFxYt05e5DTZ_rAlJjMyU1PCNHFz_j2gjwH6OTCaswSpk3Xgs_fY1H8YBrMItp6p
    _-A4gVPBHwooQ>
X-ME-Received: <xmr:FUFxYkqJkC-TAERwgVfqc6uv6PW1p9CtMiU_Nwi8c7qvFwQ9TUcS90QrTfQwYC1Mkg-CnGrG5KWWW2F_d0uz-J-b5sUm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:FUFxYqlc_hwYTx-fH1M7nbNj82E4m4Kn2xkDzahR76M7sUM3PUnBWA>
    <xmx:FUFxYk0OnRVJWtigWi5v7OkaxXNFzXorWlYSyaf04Je6Zzvm9MITFA>
    <xmx:FUFxYhvhmsRpCcOcjr_pPDp48nLBuI9LByzNZtdNKwJuyQ7sgC7MMA>
    <xmx:FkFxYlJY_GH_CZmC1VSVczamOK2eeHr_faVGNWNUdKpOh3F5EzUD0g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 May 2022 10:49:57 -0400 (EDT)
Date:   Tue, 3 May 2022 16:49:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YnFBFOrvlLnDwZe9@kroah.com>
References: <20220502210728.0b36f3cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502210728.0b36f3cd@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:07:28PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64
> modules_install) failed like this:
> 
> depmod: ERROR: Cycle detected: usbcore -> onboard_usb_hub -> usbcore
> depmod: ERROR: Found 2 modules in dependency cycles!
> 
> Caused by commit
> 
>   c40b62216c1a ("usb: core: hcd: Create platform devices for onboard hubs in probe()")
> 
> I have reverted that commit for today.

Series is now reverted in my tree, thanks for the report.

greg k-h
