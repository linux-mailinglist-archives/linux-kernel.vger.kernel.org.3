Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2A4CDC83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbiCDSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbiCDSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:31:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446B1D3D89;
        Fri,  4 Mar 2022 10:30:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C263B827FA;
        Fri,  4 Mar 2022 18:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA989C340EE;
        Fri,  4 Mar 2022 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646418652;
        bh=C+X/aD4OLdI4XG9yzbc4VuND9rs+OIvUqRV8tAkZSpI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pnxKiSLZgzRT33vPCes9z31ENwlmFQiiaZaecuWomvEVNxLIBfCjR2YJ4aDF5Hkoe
         1Bx+arm+V0dsjHBQBjrzLdfIhia4Ulo5r4JDUzy5+TRxPvfAs2AS7yGjlstRml5349
         SCR6qAroFI8/cYngMDyizjeqlO5yaSfqtHxADABgfb+2iXFPKSMrfJag+l0mGN6oDa
         6sPfjMioiUQO8jzCPiNhCHkkglS+gCm3jbj6Q5xvPqIUQx5KHUlC7QpsElOzXlDe2M
         LrVAlHgPrxwxVPdWG0ZtsNj3SBdUmT7uVT/TskwmAtA8OXy8FPZtaH3YA4L4MZDd+u
         ugilkfIY8ZrnA==
Message-ID: <e7f91d0be0f41320e5a4f38ded1bde166626a17f.camel@kernel.org>
Subject: Re: [PATCH 0/3] ceph: minor fixes and encrypted snapshot names
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Mar 2022 13:30:50 -0500
In-Reply-To: <87fsnx4rb3.fsf@brahms.olymp>
References: <20220304161403.19295-1-lhenriques@suse.de>
         <87fsnx4rb3.fsf@brahms.olymp>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 16:26 +0000, Luís Henriques wrote:
> Luís Henriques <lhenriques@suse.de> writes:
> 
> > Hi!
> > 
> > I'm sending another iteration of the encrypted snapshot names patch.  This
> > patch assumes PR#45224 [1] to be merged as it adds support for the
> > alternate names.
> > 
> > Two notes:
> > 
> > 1. Patch 0001 is just a small fix from another fscrypt patch.  It's
> >    probably better to simply squash it.
> > 
> > 2. I'm not sure how easy it is to hit the UAF fixed by patch 0002.  I can
> >    reproduce it easily by commenting the code that adds the
> >    DCACHE_NOKEY_NAME flag in patch 0003.
> 
> Obviously, immediately after sending this patchset I realized I failed to
> mention a very (*VERY*) important note:
> 
> Snapshot names can not start with a '_'.  I think the reason is related
> with the 'long snapshot names', but I can't really remember the details
> anymore.  The point is that an encrypted snapshot name base64-encoded
> *may* end-up starting with an '_' as we're using the base64-url variant.
> 
> I really don't know if it's possible to fix that.  I guess that in that
> case the user will get an error and fail to create the snapshot but he'll
> be clueless because the reason.  Probably a warning can be added to the
> kernel logs, but maybe there are other ideas.
> 


Ouch. Is that imposed by the MDS? It'd be best if we could remove that
limitation from it altogether if we can.

If we can't, then we might be able to get away with prepending all the
encrypted names with some legal characte. Then when we go to decrypt it
we just strip that off.

We could also consider changing the base64 routine to use something else
in lieu of '_' but that's more of a hassle.
-- 
Jeff Layton <jlayton@kernel.org>
