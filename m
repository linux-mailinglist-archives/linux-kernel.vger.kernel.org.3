Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F057F018
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiGWP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGWP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:28:54 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3CE6463;
        Sat, 23 Jul 2022 08:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658590104; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=SfXn29km/qJz/tyr1mEVbXFLg9lP11bJxbf9W4N664oeLlxSJXky7g+FNxTWxKTRXBnDKR5ip/ZuLKVkL1VQIKNNxkYuOzwrL0h6EPjABeKK6TpjaxaEgk9TJdZGerKYJYvuFYQRuCJqLBi7wBWX1uFR+FDG2Zj6ZZUMtUQkiDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658590104; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=c1lQAq9l2Vi8XJIR9+FZPadcoaYjnJn9vuGp/Q5uuoE=; 
        b=a9OW8xI5fv1pW1A++gMs6sE9pCgr33942KvaplJ/Mu/4WGKFchUg3nwSmmfGw7lbXurGZZl5ZbOmq+5GbFcFWDenuxf4v93fIfIPtZv2E217/bxQ1TsCfjp0UWPbbBCuyFxGWSnbapDiCeHnUDlea0TS3kp+0pwiBPEJB5pWjVc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658590104;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=c1lQAq9l2Vi8XJIR9+FZPadcoaYjnJn9vuGp/Q5uuoE=;
        b=lwAEDaBcqbpoTMrbx8xU+XgUjI5zEmh8ONCKOEoT+C37vmL0x1s1g+b0XpP6ZKON
        HYRGQOIj0oxNDYVUyds4QpDjYj6nJJbXnOYBnN6qXe5rsEWchmmtcbx8c15nrSOODxJ
        0Y/pjeP6CJJ+5mNFcMbvSL4PDN/fWLPmqN7pEsy8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658590092355322.4350711864895; Sat, 23 Jul 2022 20:58:12 +0530 (IST)
Date:   Sat, 23 Jul 2022 20:58:12 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1822bac5c28.17c2e13a236951.2030393349322231875@siddh.me>
In-Reply-To: <YtwI/3/Qp3lSKuls@kroah.com>
References: <20220723135035.199188-1-code@siddh.me>
 <YtwAHGISvlgXgXZM@kroah.com>
 <1822b7c129a.14411444236159.6380883938307880248@siddh.me> <YtwI/3/Qp3lSKuls@kroah.com>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 20:13:11 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> You need to explain all of this in a changelog text.  Don't say what you
> do, but say why you are doing it.

Okay, I will keep this in mind next time.

> > > And how was this tested?
> > 
> > It compiles locally for me, and I used syzbot on this along with testing the
> > other `watch_queue_clear` patch, which generated no errors.
> 
> How does the watch queue stuff relate to this keyctl logic?
> 
> Again, be specific as to why you are doing things.

It doesn't relate, I just wanted to say that syzbot didn't crash too (I had
this change in the same branch as that patch for testing, and syzbot compiled
it successfully).

Sorry for the confusion.

Though now as James has pointed out, this patch isn't needed.

Apologies,
Siddh
