Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED55576BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFWJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiFWJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:36:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC574969C;
        Thu, 23 Jun 2022 02:36:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06D691FD84;
        Thu, 23 Jun 2022 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655976968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0mbNIM+JB6w795iF5JgVuU7GedW8ezpGnJMdaZLqFc=;
        b=J8QALNxCEW1OJSBo0kJeIxMjIArt6h8Re6hB6BbVQA/4gULvEBrBTNTLe+6MwkNfs3MdhM
        +U2JuSV0CPigje0U5klJwA1qVPVYX2JWk26XVFAjO7P3dCaYeUdQIlAqdQlOJMReUJwNUn
        exQz9aVA+NftUov4Qz+/5SsUaH0d4Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655976968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0mbNIM+JB6w795iF5JgVuU7GedW8ezpGnJMdaZLqFc=;
        b=dBgp1ATEUkJdvyO973sUrTj+pbMGITd6mg1TDpSBc9TVhJc58UU/R0cB06TqI2yvifWQML
        K7sD1WPwEYxPXSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF225133A6;
        Thu, 23 Jun 2022 09:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LrcyLQc0tGLMKgAAMHmgww
        (envelope-from <ykaukab@suse.de>); Thu, 23 Jun 2022 09:36:07 +0000
Date:   Thu, 23 Jun 2022 11:36:06 +0200
From:   Yousaf Kaukab <ykaukab@suse.de>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: tegra: Mark BPMP channels as no-memory-wc
Message-ID: <20220623093606.GA181983@suse.de>
References: <20220622132300.1746201-1-cyndis@kapsi.fi>
 <20220622132300.1746201-2-cyndis@kapsi.fi>
 <9e80da1f-60e9-5528-3636-6443461fb207@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e80da1f-60e9-5528-3636-6443461fb207@kapsi.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:29:03PM +0300, Mikko Perttunen wrote:
> On 22.6.2022 16.23, Mikko Perttunen wrote:
> > From: Mikko Perttunen <mperttunen@nvidia.com>
> > 
> > The Tegra SYSRAM contains regions access to which is restricted to
> > certain hardware blocks on the system, and speculative accesses to
> > those will cause issues.
> > 
> > Patch 'misc: sram: Only map reserved areas in Tegra SYSRAM' attempted
> > to resolve this by only mapping the regions specified in the device
> > tree on the assumption that there are no such restricted areas within
> > the 64K-aligned area of memory that contains the memory we wish to map.
> > 
> > Turns out this assumption is wrong, as there are such areas above the
> > 4K pages described in the device trees. As such, we need to use the
> > bigger hammer that is no-memory-wc, which causes the memory to be
> > mapped as Device memory to which speculative accesses are disallowed.
> > 
> > As such, the previous patch in the series,
> >    'firmware: tegra: bpmp: do only aligned access to IPC memory area',
> > is required with this patch to make the BPMP driver only issue aligned
> > memory accesses as those are also required with Device memory.
> > 
> > Fixes: fec29bf04994 ("misc: sram: Only map reserved areas in Tegra SYSRAM")
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> 
> FWIW, with this, the aforementioned patch to misc/sram is redundant. It
> doesn't hurt, but doesn't really help either. Whether or not it should be
> reverted, I have no opinion.
I am in favor of reverting commit fec29bf04994 ("misc: sram: Only map
reserved areas in Tegra SYSRAM"). Tegra platforms are the only consumer
of this code. I consider it to be redundant after your series.
For both patches:
Reviewed-by: Yousaf Kaukab <ykaukab@suse.de>
> 
> Thanks,
> Mikko
BR,
Yousaf
