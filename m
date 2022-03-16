Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC384DBB01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbiCPX0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbiCPX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA4BC1A;
        Wed, 16 Mar 2022 16:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F21E61559;
        Wed, 16 Mar 2022 23:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D105C340EC;
        Wed, 16 Mar 2022 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647473132;
        bh=9S9n5W4BUCXrhfkoeret8wNFTGcAtJSuqNJJXyYDFh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCscvEHF5ZTfH4kctmXafnLXkuK9nLupUKMANZpudUof4kxqmHl84MCSZbo2LZWF/
         VruUdT2QYyD4aXLc5XQvTRiKWPX0Agj8VD8K1tbo55aNGnPg3GUndZbJY/MMsyKl2v
         tscLuPlVjaT3+jCbMzsHQQbuxnXa95dofucHlKha6KXwbW6UEol2MORjMso7ABGxl4
         pygS1UVyWyDj6fblBAqMjVOoBKuPbCLC31jWDEIVLK6ujEMyb30i/ycS6voqw6k8Gy
         r4oa1pzUUFWQGIdmu1cd6MKi5baS9WzowO2N5rB4WSgIBhGKszWfNaqbwPtAWJXD3a
         s65OkRtucMXwQ==
Date:   Wed, 16 Mar 2022 16:25:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Bill Wendling <morbo@google.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
Message-ID: <YjJx5Q0OUDRzIowG@thelio-3990X>
References: <20220316213118.2352683-1-morbo@google.com>
 <15ebcddf-a84d-7293-f672-0e8ec47537e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ebcddf-a84d-7293-f672-0e8ec47537e8@quicinc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:17:06PM -0700, Trilok Soni wrote:
> On 3/16/2022 2:31 PM, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warnings:
> > 
> 
> I thought we have -Wno-format by default enabled for arm64, isn't it?

Yes, -Wformat is turned off for clang in the default kernel build on all
architectures (see scripts/Makefile.extrawarn). However, it can easily
be enabled with W=1 and we should eventually get this turned on for
clang like gcc so that developers who only use clang can catch instances
of it.

Cheers,
Nathan
