Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A9507020
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353248AbiDSOXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353291AbiDSOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:22:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F063B5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 077C7B819DB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41271C385A5;
        Tue, 19 Apr 2022 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650377998;
        bh=pFVocPAAyxNwE+EAgAOFl3aRkOLQgd7KM/MSQo7oSns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUC4esakcVmVf6Lifp1odfO1Kh5p1ZHfE8rXBAhkSrB3L7xkPaoqaXaxqSyb8e8/5
         1g0JtHAE9hplmxTNMdJlBiqb+kHyuM/9wzvqlge6w5OgrDvLBZZ3CwMim1dd9SavEZ
         4pM5mUs9If6XW2itCchuIQSZ92Zoi6Wl2pvIG4GI=
Date:   Tue, 19 Apr 2022 16:19:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <Yl7FC9M0hz7kQM4j@kroah.com>
References: <20220419133616.544255-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133616.544255-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:36:16AM -0400, Tom Rix wrote:
> Smatch reports this issue
> vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init' was not declared. Should it be static?
> 
> vchiq_platform_init is only used in vchiq_arm.c.  Single file variables should
> not be global so change vchiq_platform_init's storage-class specifier to static.

You did not change a variable, you changed a function type.

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2: refomat commit log

Why did you not fix the build breakage?

{sigh}

