Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BB58B787
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiHFSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiHFSPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380935F63;
        Sat,  6 Aug 2022 11:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF7D6120D;
        Sat,  6 Aug 2022 18:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA87C433C1;
        Sat,  6 Aug 2022 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809719;
        bh=BY4p8tvAesSfXHOIklqi1YqTC0LMDLSpqbPlDu6FZHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFgMuRn+fh47VY2tmn9To+ifXShkp4IqH6Nr90jbeljoYgvrAeWY5UraRRdkghz+e
         xzm5L6LV2uQ0Zt6Tfstd436otgB9fsOpzavtO6V11LJPx8QZjr6yiIwvXe7IfDgPLO
         Hm12d0O2aiv1wK1rCumewu8MU7C7xVVDFRvHFkSPKnYJ0ztW9ayobWb4ThngMMUsG/
         FFmeO0/syPaUu4/1siEHvZuCfZgPvlXtCQIIEUEyD6Tcqf/s3lHkeu1PDZS+9H7KsS
         rZn35vZ1g0y/ErJ7F4HA0CHSe42T168NrIai9tBMkxQZSLP6mUegUdi0WiK0UArnMj
         qpovbcbGeADVw==
Date:   Sat, 6 Aug 2022 21:15:16 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Harald Hoyer <harald@profian.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jarkko Sakkinen <jarkko@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp: Load the firmware twice when SEV API
 version < 1.43
Message-ID: <Yu6vtDLOkwMOjb+v@kernel.org>
References: <20220804010223.3619-1-jarkko@kernel.org>
 <58e8f9dc-a8d3-a2a5-2dd7-0783355e2567@amd.com>
 <de02389f-249d-f565-1136-4af3655fab2a@profian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de02389f-249d-f565-1136-4af3655fab2a@profian.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:37:20PM +0200, Harald Hoyer wrote:
> Am 04.08.22 um 15:13 schrieb Tom Lendacky:
> > On 8/3/22 20:02, Jarkko Sakkinen wrote:
> > > From: Jarkko Sakkinen <jarkko@profian.com>
> > > 
> > > SEV-SNP does not initialize to a legit state, unless the firmware is
> > > loaded twice, when SEP API version < 1.43, and the firmware is updated
> > > to a later version. Because of this user space needs to work around
> > > this with "rmmod && modprobe" combo. Fix this by implementing the
> > > workaround to the driver.
> > 
> > The SNP hypervisor patches are placing a minimum supported version
> > requirement for the SEV firmware that exceeds the specified version
> > above [1] (for the reason above, as well as some others), so this patch
> > is not needed, NAK.
> 
> As described in the "Milan Release Notes.txt" of the AMD firmware update package amd_sev_fam19h_model0xh_1.33.03.zip.
> 
> "If upgrading to 1.33.01 or later from something older (picking up
> CSF-1201), it is required that two Download Firmware commands be run to fix
> the "Committed Version" across the firmware. CSF-1201 fixed a bug where the
> committed version in the attestation report was incorrect. Performing a
> single Download Firmware will upgrade the firmware, but performing a second
> one will correct the committed version. This is a one-time upgrade issue.
> "

Reference should be part of the commit message. I'll
update for the next iteration. Thanks for the remark.

BR, Jarkko
