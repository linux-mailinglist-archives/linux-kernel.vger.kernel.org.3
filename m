Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1358AFC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiHESd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHESdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2D7AC18
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99EBFB829EC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAA3C433C1;
        Fri,  5 Aug 2022 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659724402;
        bh=3f5o70JbYlPCgy6ykT0F1POnBTLd6YMhY5LFfRMH/fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkS9cUj74TflOnU0+bxxreIvQS+BNlIOidVDR/w+/s4epHg8niNzflgQ9Rf6KrYaq
         SwCVQBgZ/r8jlkjw+Oc+oyPCWJsCshWhicmsbI+xiFciiWhY6qID9nYgut46YOZLiv
         rOGJtbLMFbh+jTjlI9SpCxxrU9PLPPwB9WskudvKm4bf09hDYNruZ3PDG13q7/UYtu
         fyzp0/SEscqaSjKVaVoqda1t+cpTk9D88/wuL6kCcvmobCywaMdcA3ooZZalupDd0H
         nSs0FYjnLboOlqig2VSyzdqrZUnSxHEzEh3uXnapUKIe7mHAOnyhX6/i83eAi3EuXB
         0U3k/O+rvOcbg==
Date:   Fri, 5 Aug 2022 18:33:20 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        corbet <corbet@lwn.net>, dhowells <dhowells@redhat.com>,
        edumazet <edumazet@google.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mchehab <mchehab@kernel.org>, rdunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] kernel/watch_queue: Remove wqueue->defunct and
 use pipe for clear check
Message-ID: <Yu1icG/o8VcfsQdy@gmail.com>
References: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
 <20220804144152.468916-1-code@siddh.me>
 <YuzFrzrTnTtUHMn/@sol.localdomain>
 <1826d5c4a90.282ac4bf118702.5300662644268737477@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1826d5c4a90.282ac4bf118702.5300662644268737477@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:05:41PM +0530, Siddh Raman Pant wrote:
> On Fri, 05 Aug 2022 12:54:31 +0530  Eric Biggers  wrote:
> > Why is the READ_ONCE() needed?  Doesn't wqueue->lock protect wqueue->pipe?
> 
> We are changing the pointer while a notification can be potentially waiting to
> be posted to the pipe. So a barrier is needed to prevent compiler magic from
> reloading the value.
> 

wqueue->pipe is only read or written while wqueue->lock is held, so that is not
an issue at all.

- Eric
