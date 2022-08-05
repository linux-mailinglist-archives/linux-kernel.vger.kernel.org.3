Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01D458A8E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiHEJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiHEJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:36:28 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5329C91
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659692153; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=e8TEMtLGWdvaN+wQZyT3nid9x9H52KceesT4LF/aXprbqVFGvnkFamzRHbUxCXVInKR1sF/J8vHtvD2elNhclA7fU+oEExzjU3jMMUt0QFODZPwJaQelvzYEYbcAnLd66+1UY7keDq6f+JlvGXR9lL/01Xc8sRFOBK1VrdVrusw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659692153; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ljhgzI/UF42hWnfoA4KaadY/VnflCDZrqOXQeik+4k4=; 
        b=YW/6kywpozQh5mHOMfZ6bANCeGZGJBACRGt1QvRdZuDozgR/Q1Go6ps9xugIQ5V92tOB6C6TAYk26mKUJEjU2s5gUd4fjQp2WNlMr8msuU0VTuB0GUaqum5GBpIS5sOfTTYLx3Q30M7xxOMzmNnt5NIg4E4ru2sNDnemFlLFhDY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659692153;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ljhgzI/UF42hWnfoA4KaadY/VnflCDZrqOXQeik+4k4=;
        b=a788DdDnnTYwwNEgkeNo6PlCJubYZK4nrWsaH3b/BshXQbsqkzKY6FzY9kqGT8jL
        UlDeS2Cfg7+KrDRF9NNtnqF1DsA3HPgfKA1B4Jg4DAkCqNtkUSFN4JYYnqUAf+k3GN3
        Djcu6mrZQbsKU1UAR7ET6isvaWDDveebxRlsY44s=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659692141228305.5750996748818; Fri, 5 Aug 2022 15:05:41 +0530 (IST)
Date:   Fri, 05 Aug 2022 15:05:41 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        "corbet" <corbet@lwn.net>, "dhowells" <dhowells@redhat.com>,
        "edumazet" <edumazet@google.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "mchehab" <mchehab@kernel.org>, "rdunlap" <rdunlap@infradead.org>
Message-ID: <1826d5c4a90.282ac4bf118702.5300662644268737477@siddh.me>
In-Reply-To: <YuzFrzrTnTtUHMn/@sol.localdomain>
References: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
 <20220804144152.468916-1-code@siddh.me> <YuzFrzrTnTtUHMn/@sol.localdomain>
Subject: Re: [PATCH v2 3/3] kernel/watch_queue: Remove wqueue->defunct and
 use pipe for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022 12:54:31 +0530  Eric Biggers  wrote:
> Why is the READ_ONCE() needed?  Doesn't wqueue->lock protect wqueue->pipe?

We are changing the pointer while a notification can be potentially waiting to
be posted to the pipe. So a barrier is needed to prevent compiler magic from
reloading the value.

This was remarked by David Howells here:
https://lore.kernel.org/lkml/3558070.1658933200@warthog.procyon.org.uk/

> This isn't the correct block comment format; it should look like:
> 
>      /*
>       * This pipe will get freed by the caller free_pipe_info().
>       * Removing this reference also prevents new notifications.
>       */
> 
> - Eric
> 

Okay, will make the change.

Thanks,
Siddh
