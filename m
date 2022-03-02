Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829404C9B69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiCBCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCBCuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB071AA03D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:49:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94E41B81BFB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F263C340F2;
        Wed,  2 Mar 2022 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646189390;
        bh=FysnhgPEa69XwFrDLrSLB1oxl+aL0JbGynml4vaPzbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qrhOglzuZ0rA7h+F3Z34gKOn7cP8FhkgK5DtxfGcudkObGWZ9iu6H7+5IY6P5exCg
         IBuGYtM6Mz6Lj6dpznP0t8yafIwbLLpe6JLzWBK11AdNMuX/YsstFvGXwbv6nY5dcj
         kVtc0KuDLZ0/jBr4LAnXVrNzh1CdHcnN3R3dqDVc5J/2CPfvJ0stRa+wfNOcIFcIfe
         l2NWO26XVed1z5V6U0/cEewjFdPJ0txOXrfEd8xGe+Fl3DzrPkNLESjrFmtvORaeEt
         tmn63mUPdMe4WJuTS+QPdq3q3/VNkMwnAj+8+Y9Fa1RlulGlBfogeGT1LGsqHWlox9
         Cf7vj8KKa9P2g==
Message-ID: <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
Date:   Wed, 2 Mar 2022 10:49:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/22 11:31, Gao Xiang wrote:
> z_idataoff here is an absolute physical offset, so it should use
> erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> cause the decompresion failure.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
