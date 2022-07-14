Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8CA574423
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiGNFCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiGNE7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:59:46 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885841EC6C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:56:18 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0558340A56; Thu, 14 Jul 2022 05:56:13 +0100 (BST)
Date:   Thu, 14 Jul 2022 05:56:13 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Manyi Li <limanyi@uniontech.com>, bhelgaas@google.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220714045613.GA8720@srcf.ucam.org>
References: <20220713112612.6935-1-limanyi@uniontech.com>
 <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:20:26AM +0800, Kai-Heng Feng wrote:

> According to commit 387d37577fdd ("PCI: Don't clear ASPM bits when the
> FADT declares it's unsupported"), the bit means "just use the ASPM

Yes, the assumption is that if the BIOS set up ASPM but FADT indicates 
it's unsupported, just trust that the BIOS did the right thing and don't 
interfere. It's been a long time, but when we were clearing the ASPM 
bits in response to this FADT setting, a bunch of machines suddenly 
started consuming a lot more power than when running Windows.
