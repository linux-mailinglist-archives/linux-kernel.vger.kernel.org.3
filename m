Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4920957F019
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiGWP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiGWP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:28:59 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532A1572F;
        Sat, 23 Jul 2022 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658590106; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Lyjuq3kiDlanKDvP/FngdV62QpvsxmDaU5Bf+c3GbUalfmW6ZEWpY05vprmkOb4UKS1qt9ui3VWDaJHnbOE5c/Ws2a8QSNyl0bCZvnL7e0A3xHSK3iCcY/I81QtLtdZNctgc6wJI/7yZsTiROcQxouOXIsTPTQJvxzSTT+dpVbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658590106; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QUHKy4OgEaxbVLogauALC7ife9v5t5FcKwUzAh8eIRk=; 
        b=d8O36cgk9f1UBst/XKKzVWaBE4ME9VwSVq+41afy41XVED9ZLZrF9mRmn80zvSHR3nK32RNEoDz6j4UPV0Kb3K7Cy0g6aQlmJgKl9zLhl8HGccPL9G27/yLAnMH6ZNgCHtZXgZOtZHG7rIrNuNZs+uPhCO4HQ00IzVifsYwENcI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658590106;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=QUHKy4OgEaxbVLogauALC7ife9v5t5FcKwUzAh8eIRk=;
        b=AX7PeCKipWcL4pk8J9TO01kdzl+FTf3hwvGlt+7TUbONwtwX2oQ4FVcUxIkFRrnp
        95+19S3rjYI8FzxWHoruMEhjExplwoKmgzCItwqK8hXj2lryYStue6oE1zPGifkDdXB
        Nmece5GqZ/d/8lyQkNlSscw9ZzenEB8oS+K38+bk=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658590095403354.57172593740086; Sat, 23 Jul 2022 20:58:15 +0530 (IST)
Date:   Sat, 23 Jul 2022 20:58:15 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "David Howells" <dhowells@redhat.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1822bac680f.53b862f8236953.7679004564726067655@siddh.me>
In-Reply-To: <f58c2c8a157714e1860caee9bb005ec469ddb72e.camel@HansenPartnership.com>
References: <20220723135035.199188-1-code@siddh.me>
         <YtwAHGISvlgXgXZM@kroah.com>
         <1822b7c129a.14411444236159.6380883938307880248@siddh.me> <f58c2c8a157714e1860caee9bb005ec469ddb72e.camel@HansenPartnership.com>
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

On Sat, 23 Jul 2022 20:20:49 +0530  James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> That doesn't apply in this case, does it?  watch and wlist are locally
> allocated and neither has been made externally visible if the error leg
> is taken, so they should just be locally freed, which is what the code
> was doing before this proposed patch.

You are correct.

Sorry for this, I should have looked at it for a tad bit more.

Thanks,
Siddh
