Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337A4D2292
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350232AbiCHU2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349942AbiCHU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:28:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859037012;
        Tue,  8 Mar 2022 12:27:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 215EEB81670;
        Tue,  8 Mar 2022 20:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31323C340EB;
        Tue,  8 Mar 2022 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646771269;
        bh=VzSyeoZJbdPe2AzD8QPLoUveZcdiFjPQE9WsdiQ7g64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX3bsgkbhYNKFLhW6b9QZsick5aHN2KZXsQ5gWuXEb/Nc5Tl3IsVpdlLy7FRwiTvP
         lQwdd4xStb1vMDfo29yU412Ia/k0g68LSVBZ8lri9ghY23rkjYZcWJTeV6qt08CtTU
         PPhQc0BgNkrZSgPlKdrJYDS70+h7WqR7+o6vOEepQ2Gap/b4qbi8dQb1fc6SwjHb9U
         oPOEQ5yewJWq/f0lMmPM+rAqnefTyFxrKFwOoVfiMYnnkt8Lo+FZbj2qpKDHRpFZT8
         Z1pOyYya6BXFhmsfyKR/fCeTnR/bVQk1GLDqPeO8XLGTBhJ2hpzlseAKtbTKoJXOzA
         8UgUMNNuRwovw==
Date:   Tue, 8 Mar 2022 12:27:47 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01646770901-ext-3299@work.hours>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > Hardware specific features may be able to calculate a crc64, so provide
> > a framework for drivers to register their implementation. If nothing is
> > registered, fallback to the generic table lookup implementation. The
> > implementation is modeled after the crct10dif equivalent.
> 
> Hi Keith,
> 
> this is failing on big-endian systems. I get the following on s390:

Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
action. I'll send an update, thank you for the report.
