Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2957D545D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbiFJHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245087AbiFJHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3031516
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660C561FE2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCF4C34114;
        Fri, 10 Jun 2022 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654846532;
        bh=uTbaZzKG7C/xctt/sOZ6EpBYH3dQrKSYHH0fK1iFLK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZ5pqO33Ns/B9uSn8GR3qtAfNcd+gbzjbG/Ls3JBJpOHVh3jglilpPPz9xIU/gVUp
         8AvD7t4f9u8Au3yiYBNEsOyh2jhR1p50nVhaeQEpANfpqCkgWRM/N9OTphYgBuS8Mr
         BsBWfcPDeENDI2jliRbaIwxWepYS1b069mEGxw6cOVsrC+ifJhNTeoSkp75EHQKI4E
         fDKAMSmlrhxrTg2DZXy8VR0E8LmgQv/jtKSCWsfUhICcpu2R/o0a9nipk/ElUjOlxS
         F3Dl7WhSUWEib39ncLEQx/2TW/2AClfTKqsrkotx31Mt4mBBzn6+pf3ffY3dVmnTxP
         N8wfWJzPGmZPg==
Received: by pali.im (Postfix)
        id 902131D32; Fri, 10 Jun 2022 09:35:29 +0200 (CEST)
Date:   Fri, 10 Jun 2022 09:35:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Add config option for using OF 'reg' for
 PCI domain
Message-ID: <20220610073529.n263gub3pv7jej7a@pali>
References: <20220504175718.29011-1-pali@kernel.org>
 <87edzxc6r7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edzxc6r7.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 June 2022 17:33:32 Michael Ellerman wrote:
> If you have scripts that are looking for certain devices they can use
> the vendor/device fields in sysfs to find the actual devices they want,
> not just whatever happens to be at 0000:01:00.0.

This does not work if you have more cards with same vendor+device ids in system.
