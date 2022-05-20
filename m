Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1B52E51A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbiETGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiETGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192B14CA0C;
        Thu, 19 May 2022 23:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42507B82A54;
        Fri, 20 May 2022 06:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D008EC385A9;
        Fri, 20 May 2022 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653028522;
        bh=XM96//q8lbt5Q1f2WxeOpV1cLLFzDh8DpqoI888z93Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO2+C68Qygl/BD3VJVJ4XfoQweXZt3IJp1Nr8Gi7/KmwfY/pojHXacbVeZdrjTDgl
         g/HdlmJNPXyJwXBwGyFTcavcLWljtHidHWHaWgCg/GtE1KyFeOEffPbMllQiykUR4K
         rtWiolTh1ldGi+u1wY8yHfusD6S9MJpPWsVR8ztoRCB1/aD1fzzx4B1pv2G6R4F2XY
         VnWmfGmZ+jFBgtR36yuqAQE+wRxU6jujoNPFMWOQqTsREiWiWC4LUr+LJqAf3YbIpd
         /27D328i8mvz80hHj4ummK4sG2YmgeTs7G52WAMacYPRbM1G5zspQbWz9gylkHwIYI
         Kx04jLO409G/Q==
Date:   Thu, 19 May 2022 23:35:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the ext4 tree
Message-ID: <Yoc2qBFeU1UoNRpV@sol.localdomain>
References: <20220520110313.48a824c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520110313.48a824c4@canb.auug.org.au>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:03:13AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ext4 tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> fs/ext4/super.c: In function 'ext4_check_test_dummy_encryption':
> fs/ext4/super.c:2677:36: warning: unused variable 'sbi' [-Wunused-variable]
>  2677 |         const struct ext4_sb_info *sbi = EXT4_SB(sb);
>       |                                    ^~~
> 
> Introduced by commit
> 
>   0df27ddf69f3 ("ext4: only allow test_dummy_encryption when supported")
> 

The kernel test robot beat you to it!  This warning happens when
!CONFIG_FS_ENCRYPTION.  v4 of the patch fixes this
(https://lore.kernel.org/r/20220519204437.61645-1-ebiggers@kernel.org).

- Eric
